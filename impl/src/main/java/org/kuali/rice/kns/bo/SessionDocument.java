/*
 * Copyright 2005-2008 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl2.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.rice.kns.bo;

import java.sql.Timestamp;
import java.util.LinkedHashMap;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.apache.ojb.broker.PersistenceBroker;
import org.apache.ojb.broker.PersistenceBrokerException;
import org.hibernate.annotations.Type;


/*
 * Defines methods a business object should implement.
 */
@IdClass(org.kuali.rice.kns.bo.SessionDocumentId.class)
@Entity
@Table(name="KRNS_SESN_DOC_T")
public class SessionDocument extends PersistableBusinessObjectBase{
    
	private static final long serialVersionUID = 2866566562262830639L;
	
	@Id
	protected String documentNumber;
	@Id
	protected String sessionId;
	@Column(name="LAST_UPDT_DT")
	protected Timestamp lastUpdatedDate;
	@Lob
	@Column(name="SERIALZD_DOC_FRM")
	protected byte[] serializedDocumentForm;
	//private KualiDocumentFormBase serializedDocumentForm;
	@Type(type="yes_no")
	@Column(name="CONTENT_ENCRYPTED_IND")
	protected boolean encrypted = false;
	@Id
	protected String principalId;
	@Id
	protected String ipAddress;
	
	
	/**
	 * @return the serializedDocumentForm
	 */
	public byte[] getSerializedDocumentForm() {
		return this.serializedDocumentForm;
	}

	/**
	 * @param serializedDocumentForm the serializedDocumentForm to set
	 */
	public void setSerializedDocumentForm(byte[] serializedDocumentForm) {
		this.serializedDocumentForm = serializedDocumentForm;
	}


	/**
	 * @return the sessionId
	 */
	public String getSessionId() {
		return this.sessionId;
	}

	/**
	 * @param sessionId the sessionId to set
	 */
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	
	/**
	 * @return the lastUpdatedDate
	 */
	public Timestamp getLastUpdatedDate() {
		return this.lastUpdatedDate;
	}

	/**
	 * @param lastUpdatedDate the lastUpdatedDate to set
	 */
	public void setLastUpdatedDate(Timestamp lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}

	/**
	 * @return the documentNumber
	 */
	public String getDocumentNumber() {
		return this.documentNumber;
	}

	/**
	 * @param documentNumber the documentNumber to set
	 */
	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	
	
	/**
	 * @return the principalId
	 */
	public String getPrincipalId() {
		return this.principalId;
	}

	/**
	 * @param principalId the principalId to set
	 */
	public void setPrincipalId(String principalId) {
		this.principalId = principalId;
	}

	/**
	 * @return the ipAddress
	 */
	public String getIpAddress() {
		return this.ipAddress;
	}

	/**
	 * @param ipAddress the ipAddress to set
	 */
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	@SuppressWarnings("unchecked")
	protected LinkedHashMap toStringMapper() {
		LinkedHashMap m = new LinkedHashMap();
		m.put("documentNumber", this.documentNumber);
		m.put("sessionId", this.sessionId);
		m.put("principalId", this.principalId);
		m.put("ipAddress", this.ipAddress);
		return m;
	}

	public boolean isEncrypted() {
		return this.encrypted;
	}

	public void setEncrypted(boolean encrypted) {
		this.encrypted = encrypted;
	}

	public void beforeInsert() {
		// TODO kellerj - THIS METHOD NEEDS JAVADOCS
		super.beforeInsert();
	}
	
	/**
	 * This overridden method ...
	 * 
	 * @see org.kuali.rice.kns.bo.PersistableBusinessObjectBase#beforeInsert(org.apache.ojb.broker.PersistenceBroker)
	 */
	@Override
	public void beforeInsert(PersistenceBroker persistenceBroker)
			throws PersistenceBrokerException {
		// TODO kellerj - THIS METHOD NEEDS JAVADOCS
		super.beforeInsert(persistenceBroker);
	}
	
	/**
	 * This overridden method ...
	 * 
	 * @see org.kuali.rice.kns.bo.PersistableBusinessObjectBase#afterLookup(org.apache.ojb.broker.PersistenceBroker)
	 */
	@Override
	public void afterLookup(PersistenceBroker persistenceBroker)
			throws PersistenceBrokerException {
		// TODO kellerj - THIS METHOD NEEDS JAVADOCS
		super.afterLookup(persistenceBroker);
	}
}
