package org.kuali.rice.kew.docsearch;

import org.apache.commons.collections.CollectionUtils;
import org.kuali.rice.core.api.uif.RemotableAttributeError;
import org.kuali.rice.kew.api.WorkflowRuntimeException;
import org.kuali.rice.kew.framework.document.search.AttributeFields;
import org.kuali.rice.kew.framework.document.search.DocumentSearchCriteriaConfiguration;
import org.kuali.rice.kew.api.document.lookup.DocumentLookupCriteria;
import org.kuali.rice.kew.framework.document.search.DocumentSearchResultSetConfiguration;
import org.kuali.rice.kew.framework.document.search.DocumentSearchResultValues;
import org.kuali.rice.kew.api.document.lookup.DocumentLookupResults;
import org.kuali.rice.kew.doctype.DocumentTypeAttribute;
import org.kuali.rice.kew.doctype.bo.DocumentType;
import org.kuali.rice.kew.framework.KewFrameworkServiceLocator;
import org.kuali.rice.kew.framework.document.search.DocumentSearchCustomization;
import org.kuali.rice.kew.framework.document.search.DocumentSearchCustomizationHandlerService;
import org.kuali.rice.kew.rule.bo.RuleAttribute;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Reference implementation of {@code DocumentSearchCustomizationMediator}.
 *
 * @author Kuali Rice Team (rice.collab@kuali.org)
 */
public class DocumentLookupCustomizationMediatorImpl implements DocumentLookupCustomizationMediator {

    @Override
    public DocumentSearchCriteriaConfiguration getDocumentLookupCriteriaConfiguration(DocumentType documentType) {

        List<DocumentTypeAttribute> searchableAttributes = documentType.getSearchableAttributes();

        // This first map is used to partition our attributes by application id.  It maps an application id to the
        // list of searchable attribute names that are associated with that application id.  Note that 'null' is a
        // valid key in this map for those attributes that have no application id.
        LinkedHashMap<String, List<String>> applicationIdToAttributeNameMap = new LinkedHashMap<String, List<String>>();

        // This second map is used to map the searchable attribute name to the List of RemotableAttributeFields
        // that are returned by invocations of it's getSearchFields method.  This is a LinkedHashMap because it
        // preserves the order of the keys as they are entered.  This allows us to return attribute fields in the
        // proper order as defined by the order of searchable attributes on the doc type, despite the partitioning
        // of our attributes by application id.
        LinkedHashMap<String, AttributeFields> orderedSearchFieldMap = new LinkedHashMap<String, AttributeFields>();
        LinkedHashMap<String, AttributeFields> orderedResultSetFieldMap = new LinkedHashMap<String, AttributeFields>();

        for (DocumentTypeAttribute searchableAttribute : searchableAttributes) {
            RuleAttribute ruleAttribute = searchableAttribute.getRuleAttribute();
            String attributeName = ruleAttribute.getName();
            String applicationId = ruleAttribute.getApplicationId();
            if (!applicationIdToAttributeNameMap.containsKey(applicationId)) {
                applicationIdToAttributeNameMap.put(applicationId, new ArrayList<String>());
            }
            applicationIdToAttributeNameMap.get(applicationId).add(attributeName);
            // reserve a spot in the field map
            orderedSearchFieldMap.put(attributeName, null);
        }

        for (String applicationId : applicationIdToAttributeNameMap.keySet()) {
            DocumentSearchCustomizationHandlerService documentSearchCustomizationService = loadCustomizationService(
                    applicationId);
            List<String> searchableAttributeNames = applicationIdToAttributeNameMap.get(applicationId);
            DocumentSearchCriteriaConfiguration documentSearchConfiguration = documentSearchCustomizationService.getDocumentLookupConfiguration(
                    documentType.getName(), searchableAttributeNames);
            mergeAttributeFields(documentSearchConfiguration.getSearchAttributeFields(), orderedSearchFieldMap);
        }

        DocumentSearchCriteriaConfiguration.Builder configBuilder = DocumentSearchCriteriaConfiguration.Builder.create();
        configBuilder.setSearchAttributeFields(flattenOrderedFieldMap(orderedSearchFieldMap));
        return configBuilder.build();
    }

    @Override
    public List<RemotableAttributeError> validateLookupFieldParameters(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria) {

        List<DocumentTypeAttribute> searchableAttributes = documentType.getSearchableAttributes();
        LinkedHashMap<String, List<String>> applicationIdToAttributeNameMap = new LinkedHashMap<String, List<String>>();

        for (DocumentTypeAttribute searchableAttribute : searchableAttributes) {
            RuleAttribute ruleAttribute = searchableAttribute.getRuleAttribute();
            String attributeName = ruleAttribute.getName();
            String applicationId = ruleAttribute.getApplicationId();
            if (!applicationIdToAttributeNameMap.containsKey(applicationId)) {
                applicationIdToAttributeNameMap.put(applicationId, new ArrayList<String>());
            }
            applicationIdToAttributeNameMap.get(applicationId).add(attributeName);
        }

        List<RemotableAttributeError> errors = new ArrayList<RemotableAttributeError>();
        for (String applicationId : applicationIdToAttributeNameMap.keySet()) {
            DocumentSearchCustomizationHandlerService documentSearchCustomizationService = loadCustomizationService(applicationId);
            List<String> searchableAttributeNames = applicationIdToAttributeNameMap.get(applicationId);
            List<RemotableAttributeError> searchErrors = documentSearchCustomizationService.validateCriteria(
                    documentLookupCriteria, searchableAttributeNames);
            if (!CollectionUtils.isEmpty(searchErrors)) {
                errors.addAll(searchErrors);
            }
        }

        return errors;
    }

    @Override
    public DocumentLookupCriteria customizeCriteria(DocumentType documentType, DocumentLookupCriteria documentLookupCriteria) {
        DocumentTypeAttribute customizerAttribute = documentType.getCustomizerAttribute();
        if (customizerAttribute != null) {
            DocumentSearchCustomizationHandlerService service = loadCustomizationService(customizerAttribute.getRuleAttribute().getApplicationId());
            if (service.getEnabledCustomizations(documentType.getName(), customizerAttribute.getRuleAttribute().getName()).contains(
                    DocumentSearchCustomization.CRITERIA)) {
                DocumentLookupCriteria customizedCriteria = service.customizeCriteria(documentLookupCriteria, customizerAttribute.getRuleAttribute().getName());
                if (customizedCriteria != null) {
                    return customizedCriteria;
                }
            }
        }
        return null;
    }

    @Override
    public DocumentLookupCriteria customizeClearCriteria(DocumentType documentType, DocumentLookupCriteria documentLookupCriteria) {
        DocumentTypeAttribute customizerAttribute = documentType.getCustomizerAttribute();
        if (customizerAttribute != null) {
            DocumentSearchCustomizationHandlerService service = loadCustomizationService(customizerAttribute.getRuleAttribute().getApplicationId());
            if (service.getEnabledCustomizations(documentType.getName(), customizerAttribute.getRuleAttribute().getName()).contains(
                    DocumentSearchCustomization.CLEAR_CRITERIA)) {
                DocumentLookupCriteria customizedCriteria = service.customizeClearCriteria(documentLookupCriteria, customizerAttribute.getRuleAttribute().getName());
                if (customizedCriteria != null) {
                    return customizedCriteria;
                }
            }
        }
        return documentLookupCriteria;
    }

    @Override
    public DocumentSearchResultValues customizeResults(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria, DocumentLookupResults results) {
        DocumentTypeAttribute customizerAttribute = documentType.getCustomizerAttribute();
        if (customizerAttribute != null) {
            DocumentSearchCustomizationHandlerService service = loadCustomizationService(customizerAttribute.getRuleAttribute().getApplicationId());
            if (service.getEnabledCustomizations(documentType.getName(), customizerAttribute.getRuleAttribute().getName()).contains(
                    DocumentSearchCustomization.RESULTS)) {
                DocumentSearchResultValues customizedResults = service.customizeResults(documentLookupCriteria, results.getLookupResults(), customizerAttribute.getRuleAttribute().getName());
                if (customizedResults != null) {
                    return customizedResults;
                }
            }
        }
        return null;
    }

    @Override
    public DocumentSearchResultSetConfiguration customizeResultSetConfiguration(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria) {
        DocumentTypeAttribute customizerAttribute = documentType.getCustomizerAttribute();
        if (customizerAttribute != null) {
            DocumentSearchCustomizationHandlerService service = loadCustomizationService(customizerAttribute.getRuleAttribute().getApplicationId());
            if (service.getEnabledCustomizations(documentType.getName(), customizerAttribute.getRuleAttribute().getName()).contains(
                    DocumentSearchCustomization.RESULT_SET_FIELDS)) {
                DocumentSearchResultSetConfiguration resultSetConfiguration = service.customizeResultSetConfiguration(
                        documentLookupCriteria, customizerAttribute.getRuleAttribute().getName());
                if (resultSetConfiguration != null) {
                    return resultSetConfiguration;
                }
            }
        }
        return null;
    }

    protected DocumentSearchCustomizationHandlerService loadCustomizationService(String applicationId) {
        DocumentSearchCustomizationHandlerService service = KewFrameworkServiceLocator.getDocumentLookupCustomizationHandlerService(
                applicationId);
        if (service == null) {
            throw new WorkflowRuntimeException("Failed to locate DocumentSearchCustomizationService for applicationId: " + applicationId);
        }
        return service;
    }

    protected void mergeAttributeFields(List<AttributeFields> attributeFieldsList, LinkedHashMap<String, AttributeFields> orderedFieldMap) {
        if (attributeFieldsList == null) {
            return;
        }
        for (AttributeFields attributeFields : attributeFieldsList) {
            orderedFieldMap.put(attributeFields.getAttributeName(), attributeFields);
        }
    }

    protected List<AttributeFields> flattenOrderedFieldMap(LinkedHashMap<String, AttributeFields> orderedFieldMap) {
        return new ArrayList<AttributeFields>(orderedFieldMap.values());
    }

}
