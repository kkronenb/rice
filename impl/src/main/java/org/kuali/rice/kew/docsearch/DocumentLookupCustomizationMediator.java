package org.kuali.rice.kew.docsearch;

import org.kuali.rice.core.api.uif.RemotableAttributeError;
import org.kuali.rice.kew.framework.document.search.DocumentSearchCriteriaConfiguration;
import org.kuali.rice.kew.api.document.lookup.DocumentLookupCriteria;
import org.kuali.rice.kew.framework.document.search.DocumentSearchResultSetConfiguration;
import org.kuali.rice.kew.framework.document.search.DocumentSearchResultValues;
import org.kuali.rice.kew.api.document.lookup.DocumentLookupResults;
import org.kuali.rice.kew.doctype.bo.DocumentType;

import java.util.List;

/**
 * Handles communication between {@link org.kuali.rice.kew.framework.document.search.DocumentSearchCustomizationHandlerService}
 * endpoints in order to invoke document lookup customizations which might be hosted from various applications.
 *
 * @author Kuali Rice Team (rice.collab@kuali.org)
 */
public interface DocumentLookupCustomizationMediator {

    /**
     * Retrieves the document lookup criteria configuration for the given document type.  This should include attribute
     * fields that should be included in the document lookup user interface when displaying criteria by which a user
     * can search for documents.  If this method returns null then no additional criteria should be presented on the
     * search screen.
     *
     * @param documentType the document type for which to find document lookup criteria configuration, must not be null
     *
     * @return configuration information containing additional criteria (beyond the default set) which should be
     * displayed to the user when performing a search against documents of the given type, if null is returned this
     * indicates that the default document lookup criteria configuration should be used
     */
    DocumentSearchCriteriaConfiguration getDocumentLookupCriteriaConfiguration(DocumentType documentType);

    /**
     * Performs optional validation of document lookup criteria prior to execution of the search.
     *
     * @param documentType the document type against which the lookup is being performed
     * @param documentLookupCriteria the criteria representing the submission of the document lookup
     *
     * @return a list of error messages generated by the validation, may an empty list in which case the calling code
     * may safely ignore the response and assume that the given criteria validated successfully
     */
    List<RemotableAttributeError> validateLookupFieldParameters(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria);

    /**
     * Optionally performs customization of the given document lookup criteria in the cases where the document type
     * implements criteria customization.  If this method returns a non-null value, then the calling code should use
     * the returned criteria in order to execute the search.  If this method returns a null value, it means the criteria
     * that was given did not require any customization.  In this case, the calling code should proceed with search
     * execution using the originally provided criteria.
     *
     * @param documentType the document type against which to perform the criteria customization, should never be null
     * @param documentLookupCriteria the criteria to use as the starting point for customization
     * 
     * @return a customized version of the given criteria, or null if the criteria was not customized
     */
    DocumentLookupCriteria customizeCriteria(DocumentType documentType, DocumentLookupCriteria documentLookupCriteria);

    /**
     * Optionally performs a custom clearing of the given document lookup criteria if the given document type
     * implements a customized clear algorithm.  If this method returns a non-null value, then the value returned
     * should be instated by the calling code as the "cleared" version of the criteria.  If null is returned, then the
     * default implementation of criteria clearing should be used.
     *
     * @param documentType the document type against which to check for a custom implementation of criteria clearing
     * @param documentLookupCriteria the current criteria of the document lookup prior to being cleared
     *
     * @return the result of clearing the criteria, if this returns null it means the given document type does not
     * implement custom clearing and the default behavior should be used
     */
    DocumentLookupCriteria customizeClearCriteria(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria);

    /**
     * Optionally performs customization on the given set of document lookup results.  This could include changing
     * existing document values or synthesizing new ones.  The results of this method include a list of
     * {@link org.kuali.rice.kew.framework.document.search.DocumentSearchResultValue} objects, each of which are mapped to a
     * specific document id from the results and include additional key-value pairs for customized or synthesized
     * values for that document.  This method can return a null value if no customization was performed.
     *
     * @param documentType the document type to use when determining what customization logic (if any) should be invoked
     * @param documentLookupCriteria the criteria of the document lookup which produced the supplied results
     * @param results the results of the document lookup which are being considered for customization
     *
     * @return the customized result values, or null if not result customization was performed
     */
    DocumentSearchResultValues customizeResults(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria,
            DocumentLookupResults results);

    /**
     * Optionally provides configuration information that allows for document lookup result set customization to occur.
     * The resulting {@code DocumentLookupResultSetConfiguration} can be used by the calling code to determine how best
     * to render the lookup results.
     *
     * @param documentType the document type for which to customize result set configuration
     * @param documentLookupCriteria the criteria that was used to perform the lookup
     *
     * @return the customized document lookup result set configuration, or null if no result set customization was
     * performed
     */
    DocumentSearchResultSetConfiguration customizeResultSetConfiguration(DocumentType documentType,
            DocumentLookupCriteria documentLookupCriteria);

}


