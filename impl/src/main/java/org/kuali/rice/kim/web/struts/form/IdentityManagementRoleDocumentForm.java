/*
 * Copyright 2007 The Kuali Foundation
 *
 * Licensed under the Educational Community License, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.opensource.org/licenses/ecl1.php
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.rice.kim.web.struts.form;

import java.util.List;

import org.kuali.rice.kim.bo.impl.GroupImpl;
import org.kuali.rice.kim.bo.impl.PersonImpl;
import org.kuali.rice.kim.bo.impl.RoleImpl;
import org.kuali.rice.kim.bo.types.impl.KimTypeImpl;
import org.kuali.rice.kim.bo.ui.KimDocumentRoleMember;
import org.kuali.rice.kim.bo.ui.KimDocumentRolePermission;
import org.kuali.rice.kim.bo.ui.KimDocumentRoleQualifier;
import org.kuali.rice.kim.bo.ui.KimDocumentRoleResponsibility;
import org.kuali.rice.kim.bo.ui.RoleDocumentDelegationMember;
import org.kuali.rice.kim.bo.ui.RoleDocumentDelegationMemberQualifier;
import org.kuali.rice.kim.document.IdentityManagementRoleDocument;
import org.kuali.rice.kim.util.KimConstants;

/**
 * This is a description of what this class does - shyu don't forget to fill this in. 
 * 
 * @author Kuali Rice Team (kuali-rice@googlegroups.com)
 *
 */
public class IdentityManagementRoleDocumentForm extends IdentityManagementDocumentFormBase {
	private static final long serialVersionUID = 7099079353241080483L;
	{
		requiredNonEditableProperties.add("methodToCall");
		requiredNonEditableProperties.add("roleCommand");
	}
	
	protected String delegationMemberRoleMemberId;
	protected String roleCommand;
	protected boolean canAssignRole = true;
	protected boolean canModifyAssignees = true;
	protected KimTypeImpl kimType;
	protected KimDocumentRoleMember member;
	{
		member = new KimDocumentRoleMember();
		member.getQualifiers().add(new KimDocumentRoleQualifier());
	}
	protected KimDocumentRolePermission permission;
	protected KimDocumentRoleResponsibility responsibility;
	protected RoleDocumentDelegationMember delegationMember;
	{
		delegationMember = new RoleDocumentDelegationMember();
		delegationMember.getQualifiers().add(new RoleDocumentDelegationMemberQualifier());
	}
	protected String roleId;
    
    /**
	 * @return the delegationMember
	 */
	public RoleDocumentDelegationMember getDelegationMember() {
		return this.delegationMember;
	}

	/**
	 * @param delegationMember the delegationMember to set
	 */
	public void setDelegationMember(RoleDocumentDelegationMember delegationMember) {
		this.delegationMember = delegationMember;
	}

	public IdentityManagementRoleDocumentForm() {
        super();
        this.setDocument(new IdentityManagementRoleDocument());
    }


	public IdentityManagementRoleDocument getRoleDocument() {
        return (IdentityManagementRoleDocument) this.getDocument();
    }

	/**
	 * @return the member
	 */
	public KimDocumentRoleMember getMember() {
		return this.member;
	}

	/**
	 * @param member the member to set
	 */
	public void setMember(KimDocumentRoleMember member) {
		this.member = member;
	}

	/**
	 * @return the permission
	 */
	public KimDocumentRolePermission getPermission() {
		return this.permission;
	}

	/**
	 * @param permission the permission to set
	 */
	public void setPermission(KimDocumentRolePermission permission) {
		this.permission = permission;
	}

	/**
	 * @return the responsibility
	 */
	public KimDocumentRoleResponsibility getResponsibility() {
		return this.responsibility;
	}

	/**
	 * @param responsibility the responsibility to set
	 */
	public void setResponsibility(KimDocumentRoleResponsibility responsibility) {
		this.responsibility = responsibility;
	}

	public String getMemberFieldConversions(){
		if(member==null)
			return "";
		return getMemberFieldConversions(member.getMemberTypeCode());
	}

	public String getMemberBusinessObjectName(){
		if(member==null)
			return "";
		return getMemberBusinessObjectName(member.getMemberTypeCode());
	}

	public String getDelegationMemberFieldConversions(){
		if(getDelegationMember()==null)
			return "";
		String memberTypeCode = getDelegationMember().getMemberTypeCode();
		if(KimConstants.KimUIConstants.MEMBER_TYPE_PRINCIPAL_CODE.equals(memberTypeCode))
			return "principalId:delegationMember.memberId,principalName:delegationMember.memberName";
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_ROLE_CODE.equals(memberTypeCode))
			return "roleId:delegationMember.memberId,roleName:delegationMember.memberName,namespaceCode:delegationMember.memberNamespaceCode";
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_GROUP_CODE.equals(memberTypeCode))
			return "groupId:delegationMember.memberId,groupName:delegationMember.memberName,namespaceCode:delegationMember.memberNamespaceCode";
		return "";
	}

	public String getDelegationMemberBusinessObjectName(){
		if(getDelegationMember()==null)
			return "";
		return getMemberBusinessObjectName(getDelegationMember().getMemberTypeCode());
	}

	private String getMemberFieldConversions(String memberTypeCode){
		if(KimConstants.KimUIConstants.MEMBER_TYPE_PRINCIPAL_CODE.equals(memberTypeCode))
			return "principalId:member.memberId,principalName:member.memberName";
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_ROLE_CODE.equals(memberTypeCode))
			return "roleId:member.memberId,roleName:member.memberName,namespaceCode:member.memberNamespaceCode";
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_GROUP_CODE.equals(memberTypeCode))
			return "groupId:member.memberId,groupName:member.memberName,namespaceCode:member.memberNamespaceCode";
		return "";
	}

	private String getMemberBusinessObjectName(String memberTypeCode){
		if(KimConstants.KimUIConstants.MEMBER_TYPE_PRINCIPAL_CODE.equals(memberTypeCode))
			return PersonImpl.class.getName();
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_ROLE_CODE.equals(memberTypeCode))
			return RoleImpl.class.getName();
		else if(KimConstants.KimUIConstants.MEMBER_TYPE_GROUP_CODE.equals(memberTypeCode))
			return GroupImpl.class.getName();
		return "";
	}

	/**
	 * @return the kimType
	 */
	public KimTypeImpl getKimType() {
		return this.kimType;
	}

	/**
	 * @param kimType the kimType to set
	 */
	public void setKimType(KimTypeImpl kimType) {
		this.kimType = kimType;
		if ( kimType != null && getRoleDocument() != null ) {
			getRoleDocument().setKimType(kimType);
		}
	}

	/**
	 * @return the canAssignRole
	 */
	public boolean isCanAssignRole() {
		return this.canAssignRole;
	}

	/**
	 * @param canAssignRole the canAssignRole to set
	 */
	public void setCanAssignRole(boolean canAssignRole) {
		this.canAssignRole = canAssignRole;
	}

	/**
	 * @return the canModifyAssignees
	 */
	public boolean isCanModifyAssignees() {
		return this.canModifyAssignees;
	}

	/**
	 * @param canModifyAssignees the canModifyAssignees to set
	 */
	public void setCanModifyAssignees(boolean canModifyAssignees) {
		this.canModifyAssignees = canModifyAssignees;
	}
	
	public List<KimDocumentRoleMember> getMemberRows() {
		return getRoleDocument().getMembers();
	}

	/**
	 * @return the roleId
	 */
	public String getRoleId() {
		return this.roleId;
	}

	/**
	 * @param roleId the roleId to set
	 */
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	/**
	 * @return the roleCommand
	 */
	public String getRoleCommand() {
		return this.roleCommand;
	}

	/**
	 * @param roleCommand the roleCommand to set
	 */
	public void setRoleCommand(String roleCommand) {
		this.roleCommand = roleCommand;
	}

	/**
	 * @return the delegationMemberRoleMemberId
	 */
	public String getDelegationMemberRoleMemberId() {
		return this.delegationMemberRoleMemberId;
	}

	/**
	 * @param delegationMemberRoleMemberId the delegationMemberRoleMemberId to set
	 */
	public void setDelegationMemberRoleMemberId(String delegationMemberRoleMemberId) {
		this.delegationMemberRoleMemberId = delegationMemberRoleMemberId;
		getDelegationMember().setRoleMemberId(delegationMemberRoleMemberId);
		KimDocumentRoleMember roleMember = getRoleDocument().getMember(delegationMemberRoleMemberId);
		if(roleMember!=null){
			RoleDocumentDelegationMemberQualifier delegationMemberQualifier;
			for(KimDocumentRoleQualifier roleQualifier: roleMember.getQualifiers()){
				delegationMemberQualifier = getDelegationMember().getQualifier(roleQualifier.getKimAttrDefnId());
				delegationMemberQualifier.setAttrVal(roleQualifier.getAttrVal());
			}
		}
	}

}