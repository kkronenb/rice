CREATE TABLE EN_ACTN_ITM_T (
	ACTN_ITM_ID 		    NUMBER(14) NOT NULL,
	ACTN_ITM_PRSN_EN_ID     VARCHAR2(30) NOT NULL,
	ACTN_ITM_ASND_DT        DATE NOT NULL,
	ACTN_ITM_RQST_CD        CHAR(1) NOT NULL,
	ACTN_RQST_ID            NUMBER(14) NOT NULL,
	DOC_HDR_ID              NUMBER(14) NOT NULL,
	WRKGRP_ID               NUMBER(14) NULL,
	ROLE_NM 				VARCHAR2(2000) NULL,
	ACTN_ITM_DLGN_PRSN_EN_ID VARCHAR2(30) NULL,
    ACTN_ITM_DLGN_WRKGRP_ID NUMBER(14) NULL,
	DOC_TTL			        VARCHAR2(255) NULL,
	DOC_TYP_LBL_TXT         VARCHAR2(255) NOT NULL,
	DOC_TYP_HDLR_URL_ADDR   VARCHAR2(255) NOT NULL,
	DOC_TYP_NM		        VARCHAR2(255) NOT NULL,
	ACTN_ITM_RESP_ID        NUMBER(14) NOT NULL,
	DLGN_TYP				VARCHAR2(1) NULL,
	DB_LOCK_VER_NBR	        NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_ACTN_ITM_T_PK PRIMARY KEY (ACTN_ITM_ID)  USING INDEX
)
/
CREATE TABLE EN_ACTN_RQST_T (
       ACTN_RQST_ID                   NUMBER(14) NOT NULL,
       ACTN_RQST_PARNT_ID			  NUMBER (14) NULL,
       ACTN_RQST_CD                   CHAR(1) NOT NULL,
       DOC_HDR_ID                     NUMBER(14) NOT NULL,
       RULE_BASE_VALUES_ID            NUMBER(19) NULL,
       ACTN_RQST_STAT_CD              CHAR(1) NOT NULL,
       ACTN_RQST_RESP_ID              NUMBER(14) NOT NULL,
       ACTN_RQST_PRSN_EN_ID           VARCHAR2(30) NULL,
       WRKGRP_ID                      NUMBER(14) NULL,
       ROLE_NM 						  VARCHAR2(2000) NULL,
       QUAL_ROLE_NM 				  VARCHAR2(2000) NULL,
       QUAL_ROLE_NM_LBL_TXT			  VARCHAR2(2000) NULL,
       ACTN_RQST_RECP_TYP_CD	      CHAR(1) NULL,
       ACTN_RQST_PRIO_NBR             NUMBER(8) NOT NULL,
       ACTN_RQST_RTE_TYP_NM           VARCHAR2(255) NULL,
       ACTN_RQST_RTE_LVL_NBR          NUMBER(8) NOT NULL,
       ACTN_RQST_RTE_NODE_INSTN_ID 	  NUMBER(19),
       ACTN_TKN_ID	                  NUMBER(14) NULL,
       DOC_VER_NBR                    NUMBER(8) NOT NULL,
       ACTN_RQST_CRTE_DT              DATE NOT NULL,
       ACTN_RQST_RESP_DESC            VARCHAR2(200) NULL,
       ACTN_RQST_IGN_PREV_ACTN_IND    NUMBER(1) DEFAULT 0,
       ACTN_RQST_ANNOTN_TXT	          VARCHAR2(2000) NULL,
	   DLGN_TYP						  CHAR(1) NULL,
       ACTN_RQST_APPR_PLCY            CHAR(1) NULL,
       ACTN_RQST_CUR_IND              NUMBER(1) DEFAULT 1,
       DB_LOCK_VER_NBR                NUMBER(8) DEFAULT 0,
       CONSTRAINT EN_ACTN_RQST_TEMP_T_PK PRIMARY KEY (ACTN_RQST_ID) USING INDEX
) 
/
CREATE TABLE EN_ACTN_TKN_T (
       ACTN_TKN_ID                   NUMBER(14) NOT NULL,
       DOC_HDR_ID                    NUMBER(14) NOT NULL,
       ACTN_TKN_PRSN_EN_ID           VARCHAR2(30) NOT NULL,
       ACTN_TKN_DLGTR_PRSN_EN_ID     VARCHAR2(30) NULL,
       ACTN_TKN_DLGTR_WRKGRP_ID 	 NUMBER(14) NULL,
       ACTN_TKN_CD                   CHAR(1) NOT NULL,
       ACTN_TKN_DT                   DATE NOT NULL,
       DOC_VER_NBR                   NUMBER(8) NOT NULL,
       ACTN_TKN_ANNOTN_TXT           VARCHAR2(2000) NULL,
       ACTN_TKN_CUR_IND              NUMBER(1) DEFAULT 1,
       DB_LOCK_VER_NBR               NUMBER(8) DEFAULT 0,
       CONSTRAINT EN_ACTN_TKN_T_PK PRIMARY KEY (ACTN_TKN_ID) USING INDEX
)
/
CREATE TABLE EN_APPL_CNST_T (
   APPL_CNST_NM          VARCHAR2(100) NOT NULL,
   APPL_CNST_VAL_TXT     VARCHAR2(2000) NULL,
   DB_LOCK_VER_NBR       NUMERIC(8) DEFAULT 0,
   CONSTRAINT EN_APPL_CNST_T_PK PRIMARY KEY (APPL_CNST_NM) USING INDEX
)
/
CREATE TABLE EN_ATTACHMENT_T (
	ATTACHMENT_ID				   NUMBER(19) NOT NULL,
	NTE_ID	            	   	   NUMBER(19) NOT NULL,
	FILE_NM			               VARCHAR2(255) NOT NULL,
	FILE_LOC					   VARCHAR2(255) NOT NULL,
	MIME_TYP					   VARCHAR2(255) NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_ATTACHMENT_T_PK PRIMARY KEY (ATTACHMENT_ID)
)
/
CREATE TABLE EN_BAM_PARAM_T (
	BAM_PARAM_ID		NUMBER(14) NOT NULL,
	BAM_ID 				NUMBER(14) NOT NULL,
	PARAM				CLOB NOT NULL,
	CONSTRAINT EN_BAM_PARAM_T_PK PRIMARY KEY (BAM_PARAM_ID)
)
/
CREATE TABLE EN_BAM_T (
	BAM_ID 				NUMBER(14) NOT NULL,
	SERVICE_NM			VARCHAR2(255) NOT NULL,
	SERVICE_URL			VARCHAR2(500) NOT NULL,
	METHOD_NM			VARCHAR(2000) NOT NULL,
	THREAD_NM			VARCHAR(500) NOT NULL,
	CALL_DT				DATE NOT NULL,
	TARGET_TO_STRING	VARCHAR2(2000) NOT NULL,
	SRVR_IND_IND		NUMBER(1) NOT NULL,
	EXCEPTION_TO_STRING	VARCHAR2(2000),
	EXCEPTION_MSG		CLOB,
	CONSTRAINT EN_BAM_T_PK PRIMARY KEY (BAM_ID)
)
/
CREATE TABLE en_cache_server_t (
    ip_address              varchar2(250) not null,
    CONSTRAINT en_cache_server_t_PK PRIMARY KEY (ip_address)
)
/
CREATE TABLE en_dirty_cache_t (
    cache_entry_id number(19) not null,
    cache_name varchar2(2000) not null,
    cache_id varchar2(2000) not null,
    ip_address varchar2(2000) not null,
CONSTRAINT en_dirty_cache_t_PK PRIMARY KEY (cache_entry_id) USING INDEX
)
/
CREATE TABLE EN_DLGN_RSP_T (
	DLGN_RULE_ID NUMBER(19) NOT NULL,
	RULE_RSP_ID NUMBER(19) NOT NULL,
	DLGN_RULE_BASE_VAL_ID NUMBER(19) NOT NULL,
	DLGN_TYP VARCHAR2(20) NOT NULL,
	DB_LOCK_VER_NBR NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DLGN_RSP_PK PRIMARY KEY (DLGN_RULE_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_HDR_EXT_DT_T (
	DOC_HDR_EXT_ID			NUMBER(19) NOT NULL,
	DOC_HDR_ID				NUMBER(14) NOT NULL,
	DOC_HDR_EXT_VAL_KEY		VARCHAR2(256) NOT NULL,
	DOC_HDR_EXT_VAL			DATE NULL,
	CONSTRAINT EN_DOC_HDR_EXT_DT_T_PK PRIMARY KEY (DOC_HDR_EXT_ID) USING INDEX
) 
/
CREATE TABLE EN_DOC_HDR_EXT_FLT_T (
	DOC_HDR_EXT_ID			NUMBER(19) NOT NULL,
	DOC_HDR_ID				NUMBER(14) NOT NULL,
	DOC_HDR_EXT_VAL_KEY		VARCHAR2(256) NOT NULL,
	DOC_HDR_EXT_VAL			FLOAT NULL,
	CONSTRAINT EN_DOC_HDR_EXT_FLT_T_PK PRIMARY KEY (DOC_HDR_EXT_ID) USING INDEX
) 
/
CREATE TABLE EN_DOC_HDR_EXT_LONG_T (
	DOC_HDR_EXT_ID			NUMBER(19) NOT NULL,
	DOC_HDR_ID				NUMBER(14) NOT NULL,
	DOC_HDR_EXT_VAL_KEY		VARCHAR2(256) NOT NULL,
	DOC_HDR_EXT_VAL			NUMBER(*,0) NULL,
	CONSTRAINT EN_DOC_HDR_EXT_LONG_T_PK PRIMARY KEY (DOC_HDR_EXT_ID) USING INDEX
) 
/
CREATE TABLE EN_DOC_HDR_EXT_T (
	DOC_HDR_EXT_ID 	    	NUMBER(19) NOT NULL,
	DOC_HDR_ID 			    NUMBER(14) NOT NULL,
	DOC_HDR_EXT_VAL_KEY		VARCHAR2(256) NOT NULL,
	DOC_HDR_EXT_VAL			VARCHAR2(2000) NULL,
	CONSTRAINT EN_DOC_HDR_EXT_T_PK PRIMARY KEY (DOC_HDR_EXT_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_HDR_T (
	DOC_HDR_ID 			    NUMBER(14) NOT NULL,
	DOC_TYP_ID			    NUMBER(19) NULL,
	DOC_RTE_STAT_CD			CHAR(1) NOT NULL,
	DOC_RTE_LVL_NBR 		NUMBER(8) NOT NULL,
	DOC_STAT_MDFN_DT		DATE NOT NULL,
	DOC_CRTE_DT			    DATE NOT NULL,
	DOC_APRV_DT			    DATE NULL,
	DOC_FNL_DT			    DATE NULL,
	DOC_RTE_STAT_MDFN_DT	DATE NULL,
	DOC_RTE_LVL_MDFN_DT		DATE NULL,
	DOC_TTL				    VARCHAR2(255) NULL,
	DOC_APPL_DOC_ID			VARCHAR2(20) NULL,
	DOC_VER_NBR			    NUMBER NOT NULL,
	DOC_INITR_PRSN_EN_ID    VARCHAR2(30) NOT NULL,
	DOC_OVRD_IND			NUMBER(1) DEFAULT 0,
	DOC_LOCK_CD				CHAR(1) NULL,
	DB_LOCK_VER_NBR			NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_HDR_T_PK PRIMARY KEY (DOC_HDR_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_NTE_T (
	DOC_NTE_ID                NUMBER(19) NOT NULL,
	DOC_HDR_ID                NUMBER(14) NOT NULL,
	DOC_NTE_AUTH_PRSN_EN_ID   VARCHAR2(30) NOT NULL,
	DOC_NTE_CRT_DT            DATE NOT NULL,
    DOC_NTE_TXT               VARCHAR2(4000),
	DB_LOCK_VER_NBR	          NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_NTE_T_PK PRIMARY KEY (DOC_NTE_ID)  USING INDEX
)
/
CREATE TABLE EN_DOC_RTE_TYP_T (
   DOC_RTE_TYP_NM                 VARCHAR2(255) NOT NULL,
   DOC_RTE_TYP_LBL_TXT            VARCHAR2(250),
   DOC_RTE_MOD_NM                 VARCHAR2(250),
   DOC_RTE_TYP_DESC               VARCHAR2(250),
   DOC_RTE_TYP_ACTV_IND           NUMBER(1) DEFAULT 0 NOT NULL,
   DOC_RTE_MOD_JNDI_FTRY_CLS_NM   VARCHAR2(200),
   DOC_RTE_MOD_JNDI_URL_ADDR      VARCHAR2(200),
   DB_LOCK_VER_NBR                NUMBER(8) DEFAULT 0,
   CONSTRAINT EN_DOC_RTE_TYP_TEMP_T_PK PRIMARY KEY (DOC_RTE_TYP_NM) USING INDEX
)
/
CREATE TABLE EN_DOC_TYP_ATTRIB_T (
   	DOC_TYP_ATTRIB_ID          	NUMBER(19) NOT NULL,
   	DOC_TYP_ID               	NUMBER(19) NOT NULL,
	RULE_ATTRIB_ID				NUMBER(19) NOT NULL,
	CONSTRAINT EN_DOC_TYP_ATTRIB_T_PK PRIMARY KEY (DOC_TYP_ATTRIB_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_TYP_PLCY_RELN_T (
   	DOC_TYP_ID            NUMBER(19) NOT NULL ENABLE,
	DOC_PLCY_NM           VARCHAR2(255) NOT NULL ENABLE,
	DOC_PLCY_VAL          NUMBER(1) NOT NULL ENABLE,
	DB_LOCK_VER_NBR	      NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_TYP_PLCY_RELN_T_PK PRIMARY KEY (DOC_TYP_ID, DOC_PLCY_NM) USING INDEX
)
/
CREATE TABLE EN_DOC_TYP_PROC_T (
	DOC_TYP_PROC_ID				   NUMBER(19) NOT NULL,
	DOC_TYP_ID	            	   NUMBER(19) NOT NULL,
	INIT_RTE_NODE_ID               NUMBER(19) NOT NULL,
	PROC_NM						   VARCHAR2(255) NOT NULL,
	INIT_IND					   NUMBER(1) DEFAULT 0 NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_TYP_PROC_T_PK PRIMARY KEY (DOC_TYP_PROC_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_TYP_RTE_LVL_T (
	DOC_RTE_LVL_ID                 NUMBER(19) NOT NULL ENABLE,
   	DOC_TYP_ID                     NUMBER(19),
	DOC_RTE_LVL_NM                 VARCHAR2(255),
	DOC_RTE_LVL_PRIO_NBR           NUMBER(10),
	DOC_RTE_MTHD_NM                VARCHAR2(255) NOT NULL,
	DOC_FNL_APRVR_IND              NUMBER(1),
	DOC_MNDTRY_RTE_IND             NUMBER(1),
	WRKGRP_ID                      NUMBER(14),
	DOC_RTE_MTHD_CD                VARCHAR2(2),
    DOC_ACTVN_TYP_TXT              VARCHAR2(250),
    DOC_RTE_LVL_IGN_PREV_ACTN_IND  NUMBER(1) DEFAULT 0,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_TYP_RTE_LVL_T_PK PRIMARY KEY (DOC_RTE_LVL_ID) USING INDEX
)
/
CREATE TABLE EN_DOC_TYP_T (
   	DOC_TYP_ID               	  NUMBER(19) NOT NULL ENABLE,
	DOC_TYP_PARNT_ID         	  NUMBER(19),
	DOC_TYP_NM               	  VARCHAR2(255),
	DOC_TYP_VER_NBR          	  NUMBER(10) DEFAULT 0,
	DOC_TYP_ACTV_IND         	  NUMBER(1),
	DOC_TYP_CUR_IND          	  NUMBER(1),
	DOC_TYP_LBL_TXT          	  VARCHAR2(255),
	DOC_TYP_PREV_VER   		 	  NUMBER(19),
	DOC_HDR_ID               	  NUMBER(14),
	DOC_TYP_DESC             	  VARCHAR2(255),
	DOC_TYP_HDLR_URL_ADDR         VARCHAR2(255),
	DOC_TYP_POST_PRCSR_NM         VARCHAR2(255),
	DOC_TYP_JNDI_URL_ADDR         VARCHAR2(255),
    WRKGRP_ID                     NUMBER(14),
    BLNKT_APPR_WRKGRP_ID          NUMBER(14),
    BLNKT_APPR_PLCY               VARCHAR2(10),
	ADV_DOC_SRCH_URL_ADDR         VARCHAR2(255),
    CSTM_ACTN_LIST_ATTRIB_CLS_NM  VARCHAR2(255),
    CSTM_ACTN_EMAIL_ATTRIB_CLS_NM VARCHAR2(255),
    CSTM_DOC_NTE_ATTRIB_CLS_NM    VARCHAR2(255),
    DOC_TYP_RTE_VER_NBR 		  VARCHAR(2) DEFAULT '1' NOT NULL,
    DOC_TYP_NOTIFY_ADDR 		  VARCHAR2(255),
    MESSAGE_ENTITY_NM			  VARCHAR2(10),
    DOC_TYP_EMAIL_XSL             VARCHAR2(255),
	DB_LOCK_VER_NBR	              NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_DOC_TYP_T_PK PRIMARY KEY (DOC_TYP_ID)
)
/
create table en_edoclt_assoc_t (
  edoclt_assoc_id number(19) not null,
  edoclt_assoc_doctype_nm varchar(200) not null,
  edoclt_assoc_def_nm varchar(200),   
  edoclt_assoc_style_nm varchar(200),
  edoclt_assoc_actv_ind number(1) not null,
  db_lock_ver_nbr number(8) default 0,
  CONSTRAINT en_edoclt_assoc_t PRIMARY KEY (edoclt_assoc_id)
)
/
create table en_edoclt_def_t (
  edoclt_def_id number(19) not null,
  edoclt_def_nm varchar(200) not null,
  edoclt_def_xml clob not null,
  edoclt_def_actv_ind number(1) not null,
  db_lock_ver_nbr number(8) default 0,
  CONSTRAINT en_edoclt_def_t PRIMARY KEY (edoclt_def_id)
)
/
create table en_edoclt_style_t (
  edoclt_style_id number(19) not null,
  edoclt_style_nm varchar(200) not null,
  edoclt_style_xml clob not null,
  edoclt_style_actv_ind number(1) not null,
  db_lock_ver_nbr number(8) default 0,
  CONSTRAINT en_edoclt_style_t PRIMARY KEY (edoclt_style_id)
)
/
CREATE TABLE EN_HLP_T (
	EN_HLP_ID 			NUMBER(19) NOT NULL,
	EN_HLP_NM     		VARCHAR2(500) NOT NULL,
	EN_HLP_KY			VARCHAR2(500) NOT NULL,
	EN_HLP_TXT       	VARCHAR2(4000) NOT NULL,
	DB_LOCK_VER_NBR	    NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_HLP_T_PK PRIMARY KEY (EN_HLP_ID)  USING INDEX
)
/
CREATE TABLE EN_INIT_RTE_NODE_INSTN_T (
	DOC_HDR_ID	            	   	NUMBER(19) NOT NULL,
	RTE_NODE_INSTN_ID             	NUMBER(19) NOT NULL,
	CONSTRAINT EN_INIT_RTE_NODE_INSTN_T_PK PRIMARY KEY (DOC_HDR_ID, RTE_NODE_INSTN_ID) USING INDEX
)
/
CREATE TABLE EN_MESSAGE_QUE_T (
   MESSAGE_QUE_ID			  NUMBER(14) NOT NULL,
   MESSAGE_QUE_DT             DATE NOT NULL,
   MESSAGE_EXP_DT			  DATE NULL,
   MESSAGE_QUE_PRIO_NBR       NUMBER(8) NOT NULL,
   MESSAGE_QUE_STAT_CD        CHAR(1) NOT NULL,
   MESSAGE_QUE_RTRY_CNT       NUMBER(8) NOT NULL,
   MESSAGE_QUE_IP_NBR         VARCHAR2(2000) NOT NULL,
   MESSAGE_PAYLOAD 		      CLOB NOT NULL,
   MESSAGE_SERVICE_NM		  VARCHAR2(255),
   MESSAGE_ENTITY_NM 		  VARCHAR2(10) NOT NULL,
   SERVICE_METHOD_NM		  VARCHAR2(2000) NULL,
   DB_LOCK_VER_NBR	          NUMBER(8) DEFAULT 0,
   CONSTRAINT EN_MESSAGE_QUE_T_PK PRIMARY KEY (MESSAGE_QUE_ID) USING INDEX
)
/
CREATE TABLE EN_ORG_RESP_ID_T (
   ORG_CD                      VARCHAR2(4) NOT NULL,
   FIN_COA_CD                  VARCHAR2(2) NOT NULL,
   ORG_RESP_ID                 NUMBER(14) NOT NULL,
   ORG_RESP_ID_APRVR_TYP_CD    CHAR(1) NOT NULL,
   DB_LOCK_VER_NBR	           NUMBER(8) DEFAULT 0,
   CONSTRAINT EN_ORG_RESP_ID_T_PK PRIMARY KEY (org_cd, fin_coa_cd, ORG_RESP_ID_APRVR_TYP_CD) USING INDEX
)
/
CREATE TABLE EN_RTE_BRCH_PROTO_T (
    RTE_BRCH_PROTO_ID			   NUMBER(19) NOT NULL,
    RTE_BRCH_PROTO_NM			   VARCHAR2(255) NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RTE_BRCH_PROTO_T_PK PRIMARY KEY (RTE_BRCH_PROTO_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_BRCH_ST_T (
	RTE_BRCH_ST_ID				   NUMBER(19) NOT NULL,
    RTE_BRCH_ID			   		   NUMBER(19) NOT NULL,
	ST_KEY						   VARCHAR2(255) NOT NULL,
	ST_VAL_TXT					   VARCHAR2(2000),
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RTE_BRCH_ST_T_PK PRIMARY KEY (RTE_BRCH_ST_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_BRCH_T (
    RTE_BRCH_ID					   NUMBER(19) NOT NULL,
    BRCH_NM						   VARCHAR(255) NOT NULL,
    PARNT_RTE_BRCH_ID			   NUMBER(19),
    INIT_RTE_NODE_INSTN_ID		   NUMBER(19) NULL,
    SPLT_RTE_NODE_INSTN_ID		   NUMBER(19),
    JOIN_RTE_NODE_INSTN_ID		   NUMBER(19),
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RTE_BRCH_T_PK PRIMARY KEY (RTE_BRCH_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_NODE_INSTN_LNK_T (
	FROM_RTE_NODE_INSTN_ID   	   NUMBER(19) NOT NULL,
	TO_RTE_NODE_INSTN_ID    	   NUMBER(19) NOT NULL,
	CONSTRAINT EN_RTE_NODE_INSTN_LNK_T_PK PRIMARY KEY (FROM_RTE_NODE_INSTN_ID, TO_RTE_NODE_INSTN_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_NODE_INSTN_ST_T (
	RTE_NODE_INSTN_ST_ID		   NUMBER(19) NOT NULL,
    RTE_NODE_INSTN_ID   		   NUMBER(19) NOT NULL,
	ST_KEY						   VARCHAR2(255) NOT NULL,
	ST_VAL_TXT					   VARCHAR2(2000),
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RTE_NODE_INSTN_ST_T_PK PRIMARY KEY (RTE_NODE_INSTN_ST_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_NODE_INSTN_T (
	RTE_NODE_INSTN_ID              NUMBER(19) NOT NULL,
	DOC_ID						   NUMBER(19) NOT NULL,
	RTE_NODE_ID                    NUMBER(19) NOT NULL,
	BRCH_ID						   NUMBER(19),
	PROC_RTE_NODE_INSTN_ID		   NUMBER(19),
	ACTV_IND					   NUMBER(1) DEFAULT 0 NOT NULL,
    CMPLT_IND					   NUMBER(1) DEFAULT 0 NOT NULL,
    INIT_IND					   NUMBER(1) DEFAULT 0 NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RTE_NODE_INSTN_T_PK PRIMARY KEY (RTE_NODE_INSTN_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_NODE_LNK_T (
	FROM_RTE_NODE_ID        	   NUMBER(19) NOT NULL,
	TO_RTE_NODE_ID          	   NUMBER(19) NOT NULL,
	CONSTRAINT EN_RTE_NODE_LNK_T_PK PRIMARY KEY (FROM_RTE_NODE_ID, TO_RTE_NODE_ID) USING INDEX
)
/
CREATE TABLE EN_RTE_NODE_T (
	RTE_NODE_ID                    NUMBER(19) NOT NULL,
	DOC_TYP_ID                     NUMBER(19),
	RTE_NODE_NM                    VARCHAR2(255) NOT NULL,
	RTE_NODE_TYP				   VARCHAR2(255) NOT NULL,
	DOC_RTE_MTHD_NM                VARCHAR2(255),
	DOC_RTE_MTHD_CD                VARCHAR2(2),
	DOC_FNL_APRVR_IND              NUMBER(1),
	DOC_MNDTRY_RTE_IND             NUMBER(1),
	WRKGRP_ID                      NUMBER(14),
    DOC_ACTVN_TYP_TXT              VARCHAR2(250),
    BRCH_PROTO_ID				   NUMBER(19),
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
    CONTENT_FRAGMENT               VARCHAR2(4000),
	CONSTRAINT EN_RTE_NODE_T_PK PRIMARY KEY (RTE_NODE_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_ATTRIB_KEY_VAL_T (
	RULE_ATTRIB_KEY_VAL_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_KEY VARCHAR2(2000) NOT NULL,
	DB_LOCK_VER_NBR NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_ATTRIB_KEY_VAL_T PRIMARY KEY (RULE_ATTRIB_KEY_VAL_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_ATTRIB_T (
	RULE_ATTRIB_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_NM VARCHAR2(255) NOT NULL,
	RULE_ATTRIB_LBL_TXT VARCHAR2(2000) NOT NULL,
	RULE_ATTRIB_TYP VARCHAR2(2000) NOT NULL,
	RULE_ATTRIB_DESC VARCHAR2(2000) NULL,
	RULE_ATTRIB_CLS_NM VARCHAR2(2000) NULL,
	RULE_ATTRIB_XML_RTE_TXT CLOB NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	MESSAGE_ENTITY_NM VARCHAR(10) NULL,
	CONSTRAINT EN_RULE_ATTRIB_PK PRIMARY KEY (RULE_ATTRIB_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_ATTRIB_VLD_VAL_T (
	RULE_ATTRIB_VLD_VAL_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_VLD_VAL_NM VARCHAR2(2000) NOT NULL,
	RULE_ATTRIB_VLD_VAL_LBL_TXT VARCHAR2(2000) NOT NULL,
	RULE_ATTRIB_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_VLD_VAL_CUR_IND NUMBER(1) DEFAULT 0,
    RULE_ATTRIB_VLD_VAL_VER_NBR NUMBER(8) DEFAULT 0,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_ATTRIB_VLD_VAL_PK PRIMARY KEY (RULE_ATTRIB_VLD_VAL_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_BASE_VAL_T (
	RULE_BASE_VAL_ID NUMBER(19) NOT NULL,
	RULE_TMPL_ID NUMBER(19) NOT NULL,
	RULE_BASE_VAL_ACTV_IND NUMBER(1) NOT NULL,
	RULE_BASE_VAL_DESC VARCHAR2(2000) NULL,
	RULE_BASE_VAL_IGNR_PRVS NUMBER(1) NOT NULL,
	DOC_TYP_NM VARCHAR2(2000) NOT NULL,
	DOC_HDR_ID NUMBER(14) NULL,
	TMPL_RULE_IND NUMBER(1),
	RULE_BASE_VAL_FRM_DT   DATE NOT NULL,
  RULE_BASE_VAL_TO_DT    DATE NOT NULL,
  RULE_BASE_VAL_DACTVN_DT DATE NULL,
  RULE_BASE_VAL_CUR_IND NUMBER(1) DEFAULT 0,
  RULE_BASE_VAL_VER_NBR NUMBER(8) DEFAULT 0,
  RULE_BASE_VAL_DLGN_IND NUMBER(1),
  RULE_BASE_VAL_PREV_VER NUMBER(19),
  RULE_BASE_VAL_ACTVN_DT DATE NULL,
  DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
  CONSTRAINT EN_RULE_BASE_VAL_PK PRIMARY KEY (RULE_BASE_VAL_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_EXT_T (
	RULE_EXT_ID NUMBER(19) NOT NULL,
	RULE_TMPL_ATTRIB_ID NUMBER(19) NOT NULL,
	RULE_BASE_VAL_ID NUMBER(19) NOT NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_EXT_PK PRIMARY KEY (RULE_EXT_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_EXT_VAL_T (
	RULE_EXT_VAL_ID NUMBER(19) NOT NULL,
	RULE_EXT_ID NUMBER(19) NOT NULL,
	RULE_EXT_VAL VARCHAR2(2000) NOT NULL,
	RULE_EXT_VAL_KEY VARCHAR2(2000) NOT NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_EXT_VAL_PK PRIMARY KEY (RULE_EXT_VAL_ID)  USING INDEX
)
/
CREATE TABLE EN_RULE_RSP_T (
	RULE_RSP_ID NUMBER(19) NOT NULL,
	RSP_ID NUMBER(19) NOT NULL,
	RULE_BASE_VAL_ID NUMBER(19) NOT NULL,
	RULE_RSP_PRIO_NBR NUMBER(5) NULL,
	ACTION_RQST_CD VARCHAR2(2000) NULL,
	RULE_RSP_NM VARCHAR2(200) NULL,
	RULE_RSP_TYP VARCHAR2(1) NULL,
    RULE_RSP_APPR_PLCY CHAR(1) NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_RSP_PK PRIMARY KEY (RULE_RSP_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_TMPL_ATTRIB_T (
	RULE_TMPL_ATTRIB_ID NUMBER(19) NOT NULL,
	RULE_TMPL_ID NUMBER(19) NOT NULL,
	RULE_ATTRIB_ID NUMBER(19) NOT NULL,
	REQ_IND NUMBER(1) NOT NULL,
	DSPL_ORD NUMBER(5) NOT NULL,
	DFLT_VAL VARCHAR2(2000),
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_TMPL_ATTRIB_PK PRIMARY KEY (RULE_TMPL_ATTRIB_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_TMPL_OPTN_T (
	RULE_TMPL_OPTN_ID NUMBER(19) NOT NULL,
	RULE_TMPL_ID NUMBER(19) NULL,
	RULE_TMPL_OPTN_KEY VARCHAR2(250) NULL,
	RULE_TMPL_OPTN_VAL VARCHAR2(2000) NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_TMPL_OPTN_T_PK PRIMARY KEY (RULE_TMPL_OPTN_ID) USING INDEX
)
/
CREATE TABLE EN_RULE_TMPL_T (
	RULE_TMPL_ID NUMBER(19) NOT NULL,
	RULE_TMPL_NM VARCHAR2(250) NOT NULL,
	RULE_TMPL_DESC VARCHAR2(2000) NULL,
	DLGN_RULE_TMPL_ID NUMBER(19) NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_RULE_TMPL_T_PK PRIMARY KEY (RULE_TMPL_ID) USING INDEX
)
/
CREATE TABLE EN_SERVICE_DEF_DUEX_T (
	SERVICE_DEF_ID			   	   NUMBER(14) NOT NULL,
	SERVICE_NM				   	   VARCHAR2(255) NOT NULL,
    SERVICE_URL	            	   VARCHAR2(500) NOT NULL,
	SERVER_IP					   VARCHAR2(40) NOT NULL,
	MESSAGE_ENTITY_NM 		  	   VARCHAR2(10) NOT NULL,
	SERVICE_ALIVE				   NUMBER(1) NOT NULL,
	SERVICE_DEFINITION 		       CLOB NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_SERVICE_DEF_DUEX_T_PK PRIMARY KEY (SERVICE_DEF_ID)
)
/
CREATE TABLE EN_SERVICE_DEF_INTER_T (
	SERVICE_DEF_INTER_ID		NUMBER(14) NOT NULL,
	SERVICE_DEF_ID			   	   NUMBER(14) NOT NULL,
	SERVICE_INTERFACE 			VARCHAR2(500) NOT NULL,
	DB_LOC_VER_NBR			    NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_SERVICE_DEF_INTER_T_PK PRIMARY KEY (SERVICE_DEF_INTER_ID)
)
/
CREATE TABLE EN_SERVICE_DEF_T (
	SERVICE_DEF_ID			   	   NUMBER(14) NOT NULL,
	SERVICE_NM				   	   VARCHAR2(255) NOT NULL,
    SERVICE_URL	            	   VARCHAR2(500) NOT NULL,
    EXCEPTION_HANDLER			   VARCHAR2(500) NULL,
	ASYNC_QUEUE_IND				   NUMBER(1) NULL,
	PRIORITY					   NUMBER(8) NULL,
	RTRY_CNT					   NUMBER(8) NULL,
	MILLIS_TO_LIVE				   NUMBER(14) NULL,
	MESSAGE_ENTITY_NM 		  	   VARCHAR2(10) NOT NULL,
	SERVER_IP					   VARCHAR2(40) NOT NULL,
	SERVICE_ALIVE				   NUMBER(1) NOT NULL,
	DB_LOCK_VER_NBR	               NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_SERVICE_DEF_T_PK PRIMARY KEY (SERVICE_DEF_ID)
)
/
CREATE TABLE EN_TRANSACTION_TST_ADDRS_T (
	ADDRS_ID NUMBER(19) NOT NULL,
	STREET VARCHAR2(2000),
	CITY VARCHAR2(2000),
	STATE VARCHAR2(2),
	ZIP NUMBER(8),
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_TRANSACTION_TST_ADDRS_T_PK PRIMARY KEY (ADDRS_ID)  USING INDEX
)
/
CREATE TABLE EN_TRANSACTION_TST_PRSN_T (
	PRSN_ID NUMBER(19) NOT NULL,
	FRST_NM VARCHAR2(2000) NOT NULL,
	LST_NM VARCHAR2(2000) NOT NULL,
	EMAIL VARCHAR2(2000),
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_TRANSACTION_TST_PRSN_T_PK PRIMARY KEY (PRSN_ID)  USING INDEX
)
/
CREATE TABLE EN_USR_OPTN_T (
   PRSN_EN_ID       VARCHAR2(30) NULL,
   PRSN_OPTN_ID     VARCHAR2(200) NOT NULL,
   PRSN_OPTN_VAL    VARCHAR2(2000) NULL,
   DB_LOCK_VER_NBR  NUMBER(8) DEFAULT 0,
   CONSTRAINT EN_USR_OPTN_T_PK PRIMARY KEY (PRSN_EN_ID, PRSN_OPTN_ID) USING INDEX
)
/
create table EN_USR_T (
	    PRSN_EN_ID                       VARCHAR2(30) NOT NULL,
	    PRSN_UNIV_ID                     VARCHAR2(11) NOT NULL,
        PRSN_NTWRK_ID                    VARCHAR2(30),
        PRSN_UNVL_USR_ID                 VARCHAR2(10),
        PRSN_EMAIL_ADDR                  VARCHAR2(255),
        PRSN_NM                          VARCHAR2(255),
        PRSN_GVN_NM						 VARCHAR2(255),
        PRSN_LST_NM                      VARCHAR2(255),
        USR_CRTE_DT                      DATE,
        USR_LST_UPDT_DT                  DATE,
        PRSN_ID_MSNG_IND                 NUMBER(1) DEFAULT 0,
	    DB_LOCK_VER_NBR	                 NUMBER(8) DEFAULT 0,
  CONSTRAINT EN_USR_T_PK PRIMARY KEY (PRSN_EN_ID) USING INDEX
)
/
CREATE TABLE EN_WRKGRP_EXT_DTA_T (
    WRKGRP_EXT_DTA_ID   NUMBER(19) NOT NULL,
    WRKGRP_EXT_ID       NUMBER(19) NOT NULL,
    EXT_KEY             VARCHAR2(2000) NOT NULL,
	EXT_VAL             VARCHAR2(2000),
	DB_LOCK_VER_NBR     NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_WRKGRP_EXT_DTA_T_PK PRIMARY KEY (WRKGRP_EXT_DTA_ID)
)
/
CREATE TABLE EN_WRKGRP_EXT_T (
    WRKGRP_EXT_ID        NUMBER(19) NOT NULL,
    WRKGRP_ID            NUMBER(19) NOT NULL,
    WRKGRP_VER_NBR       NUMBER(8) NOT NULL,
    WRKGRP_TYP_ATTRIB_ID NUMBER(19) NOT NULL,
    DB_LOCK_VER_NBR      NUMBER(8) DEFAULT 0,
    CONSTRAINT EN_WRKGRP_EXT_T_PK PRIMARY KEY (WRKGRP_EXT_ID)
)
/
CREATE TABLE EN_WRKGRP_MBR_T (
    WRKGRP_MBR_PRSN_EN_ID     VARCHAR2(30) NOT NULL,
    WRKGRP_ID                 NUMBER(14) NOT NULL,
    WRKGRP_MBR_TYP			  CHAR(1) NOT NULL,
    WRKGRP_VER_NBR            NUMBER(8) DEFAULT 0,
    DB_LOCK_VER_NBR           NUMBER(8) DEFAULT 0,
    CONSTRAINT EN_WRKGRP_MBR_T_PK PRIMARY KEY (WRKGRP_MBR_PRSN_EN_ID, WRKGRP_ID, WRKGRP_VER_NBR) USING INDEX
)
/
CREATE TABLE EN_WRKGRP_T (
   WRKGRP_ID            NUMBER(14) NOT NULL,
   WRKGRP_VER_NBR       NUMBER(8) DEFAULT 0,
   WRKGRP_NM            VARCHAR2(70) NOT NULL,
   WRKGRP_ACTV_IND      NUMBER(1) NOT NULL,
   WRKGRP_TYP_CD        VARCHAR2(255) NULL,
   WRKGRP_DESC          VARCHAR2(2000) NULL,
   WRKGRP_CUR_IND       NUMBER(1) DEFAULT 0,
   DOC_HDR_ID           NUMBER(14) NULL,
   DB_LOCK_VER_NBR      NUMBER(8) DEFAULT 0,
   CONSTRAINT EN_WRKGRP_T_PK PRIMARY KEY (WRKGRP_ID, WRKGRP_VER_NBR) USING INDEX
)
/
CREATE TABLE EN_WRKGRP_TYP_ATTRIB_T (
	WRKGRP_TYP_ATTRIB_ID NUMBER(19) NOT NULL,
	WRKGRP_TYP_ID NUMBER(19) NOT NULL,
	ATTRIB_ID NUMBER(19) NOT NULL,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_WRKGRP_TYP_ATTRIB_PK PRIMARY KEY (WRKGRP_TYP_ATTRIB_ID)
)
/
CREATE TABLE EN_WRKGRP_TYP_T (
	WRKGRP_TYP_ID NUMBER(19) NOT NULL,
	WRKGRP_TYP_NM VARCHAR2(250) NOT NULL,
	WRKGRP_TYP_LBL VARCHAR2(2000) NOT NULL,
	WRKGRP_TYP_DESC VARCHAR2(2000) NULL,
	DOC_TYP_NM VARCHAR2(255) NULL,
	ACTV_IND NUMBER(1) DEFAULT 1,
	DB_LOCK_VER_NBR	NUMBER(8) DEFAULT 0,
	CONSTRAINT EN_WRKGRP_TYP_T_PK PRIMARY KEY (WRKGRP_TYP_ID)
)
/
CREATE SEQUENCE BAM_PARAM_SEQ INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE BAM_SEQ INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE DIRTY_CACHE_SEQ INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE EN_SERVICE_DEF_INTERFACE_SEQ INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQUENCE_EN_USR INCREMENT BY 1 START WITH 100000000000
/
CREATE SEQUENCE SEQ_ACTION_LIST_OPTN INCREMENT BY 1 START WITH 1000 MINVALUE 1000 MAXVALUE 2000 CYCLE
/
CREATE SEQUENCE SEQ_ACTION_REQUEST INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_ACTION_TAKEN INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_ACTN_ITM INCREMENT BY 1 START WITH 10000
/
CREATE SEQUENCE SEQ_DOCUMENT_ROUTE_HEADER INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_DOCUMENT_TYPE_ATTRIBUTE INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_DOC_NTE INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE seq_en_edoclt INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_HELP_ENTRY INCREMENT BY 1 START WITH 100
/
CREATE SEQUENCE SEQ_RESPONSIBILITY_ID INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_ROUTE_QUEUE INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_ROUTE_TEMPLATE INCREMENT BY 1 START WITH 1000
/
CREATE SEQUENCE SEQ_RTE_NODE INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_RULE_TMPL_OPTN INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_SEARCHABLE_ATTRIBUTE_VALUE INCREMENT BY 1 START WITH 2000
/
CREATE SEQUENCE SEQ_TRANSACTION_TST INCREMENT BY 1 START WITH 100
/
CREATE SEQUENCE SERVICE_DEF_SEQ INCREMENT BY 1 START WITH 2000
/
CREATE INDEX EN_ACTN_ITM_T1
 ON EN_ACTN_ITM_T (ACTN_ITM_PRSN_EN_ID)
/
CREATE INDEX EN_ACTN_ITM_TI2
 ON EN_ACTN_ITM_T (DOC_HDR_ID)
/
CREATE INDEX EN_ACTN_ITM_TI3
 ON EN_ACTN_ITM_T (ACTN_RQST_ID)
/
CREATE INDEX EN_ACTN_ITM_TI4
	ON EN_ACTN_ITM_T (ACTN_ITM_DLGN_PRSN_EN_ID, ACTN_ITM_DLGN_WRKGRP_ID, ACTN_ITM_PRSN_EN_ID, DLGN_TYP)
/
CREATE INDEX EN_ACTN_RQST_TI1
 ON EN_ACTN_RQST_T (DOC_HDR_ID)
/
CREATE INDEX EN_ACTN_RQST_TI2
 ON EN_ACTN_RQST_T (ACTN_RQST_PRSN_EN_ID)
/
CREATE INDEX EN_ACTN_RQST_T13
 ON EN_ACTN_RQST_T (ACTN_TKN_ID)
/
CREATE INDEX EN_ACTN_RQST_T14
 ON EN_ACTN_RQST_T (ACTN_RQST_PARNT_ID)
/
CREATE INDEX EN_ACTN_RQST_TI5
 ON EN_ACTN_RQST_T (ACTN_RQST_RESP_ID)
/
CREATE INDEX EN_ACTN_RQST_TI6
 ON EN_ACTN_RQST_T (ACTN_RQST_STAT_CD, ACTN_RQST_RESP_ID)
/
CREATE INDEX EN_ACTN_RQST_TI7
 ON EN_ACTN_RQST_T (ACTN_RQST_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_ACTN_RQST_TI8
 ON EN_ACTN_RQST_T (WRKGRP_ID)
/
CREATE INDEX EN_ACTN_RQST_TI9 
 ON EN_ACTN_RQST_T (ACTN_RQST_STAT_CD, DOC_HDR_ID)
/
CREATE INDEX EN_ACTN_TKN_TI1
 ON EN_ACTN_TKN_T (DOC_HDR_ID, ACTN_TKN_PRSN_EN_ID)
/
CREATE INDEX EN_ACTN_TKN_TI2
 ON EN_ACTN_TKN_T (DOC_HDR_ID, ACTN_TKN_PRSN_EN_ID, ACTN_TKN_CD)
/
CREATE INDEX EN_ACTN_TKN_TI3
 ON EN_ACTN_TKN_T (ACTN_TKN_PRSN_EN_ID)
/
CREATE INDEX EN_ACTN_TKN_TI4
 ON EN_ACTN_TKN_T (ACTN_TKN_DLGTR_PRSN_EN_ID)
/
CREATE INDEX EN_ACTN_TKN_TI5
 ON EN_ACTN_TKN_T (DOC_HDR_ID)
/
CREATE INDEX EN_BAM_PARAM_TI1 ON EN_BAM_PARAM_T (BAM_ID)
/
CREATE INDEX EN_BAM_TI1 ON EN_BAM_T (SERVICE_NM, METHOD_NM)
/
CREATE INDEX EN_BAM_TI2 ON EN_BAM_T (SERVICE_NM)
/
CREATE INDEX EN_DOC_HDR_EXT_DT_TI1 ON EN_DOC_HDR_EXT_DT_T (DOC_HDR_EXT_VAL_KEY, DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_DT_TI2 ON EN_DOC_HDR_EXT_DT_T (DOC_HDR_ID)
/
CREATE INDEX EN_DOC_HDR_EXT_DT_TI3 ON EN_DOC_HDR_EXT_DT_T (DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_FLT_TI1 ON EN_DOC_HDR_EXT_FLT_T (DOC_HDR_EXT_VAL_KEY, DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_FLT_TI2 ON EN_DOC_HDR_EXT_FLT_T (DOC_HDR_ID)
/
CREATE INDEX EN_DOC_HDR_EXT_FLT_TI3 ON EN_DOC_HDR_EXT_FLT_T (DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_LONG_TI1 ON EN_DOC_HDR_EXT_LONG_T (DOC_HDR_EXT_VAL_KEY, DOC_HDR_EXT_VAL)
/  
CREATE INDEX EN_DOC_HDR_EXT_LONG_TI2 ON EN_DOC_HDR_EXT_LONG_T (DOC_HDR_ID)
/
CREATE INDEX EN_DOC_HDR_EXT_LONG_TI3 ON EN_DOC_HDR_EXT_LONG_T (DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_TI1 ON EN_DOC_HDR_EXT_T (DOC_HDR_EXT_VAL_KEY, DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_EXT_TI2 ON EN_DOC_HDR_EXT_T (DOC_HDR_ID)
/
CREATE INDEX EN_DOC_HDR_EXT_TI3 ON EN_DOC_HDR_EXT_T (DOC_HDR_EXT_VAL)
/
CREATE INDEX EN_DOC_HDR_TI1
 ON EN_DOC_HDR_T (DOC_TYP_ID)
/
CREATE INDEX EN_DOC_HDR_TI2
 ON EN_DOC_HDR_T (DOC_INITR_PRSN_EN_ID)
/
CREATE INDEX EN_DOC_HDR_TI3
 ON EN_DOC_HDR_T (DOC_RTE_STAT_CD)
/
CREATE INDEX EN_DOC_HDR_TI4
 ON EN_DOC_HDR_T (DOC_TTL)
/
CREATE INDEX EN_DOC_HDR_TI5
 ON EN_DOC_HDR_T (DOC_CRTE_DT)
/
CREATE INDEX EN_DOC_HDR_TI6
 ON EN_DOC_HDR_T (DOC_RTE_STAT_MDFN_DT)
/
CREATE INDEX EN_DOC_HDR_TI7
 ON EN_DOC_HDR_T (DOC_APRV_DT)
/
CREATE INDEX EN_DOC_HDR_TI8
 ON EN_DOC_HDR_T (DOC_FNL_DT)
/
CREATE INDEX EN_DOC_HDR_TI9
 ON EN_DOC_HDR_T (DOC_APPL_DOC_ID)
 /
 
CREATE INDEX EN_DOC_NTE_TI1
 ON EN_DOC_NTE_T (DOC_HDR_ID)
/
CREATE INDEX EN_DOC_TYP_ATTRIB_TI1 ON EN_DOC_TYP_ATTRIB_T (DOC_TYP_ID)
/
CREATE INDEX EN_DOC_TYP_PROC_TI1 ON EN_DOC_TYP_PROC_T (DOC_TYP_ID)
/
CREATE INDEX EN_DOC_TYP_PROC_TI2 ON EN_DOC_TYP_PROC_T (INIT_RTE_NODE_ID)
/
CREATE INDEX EN_DOC_TYP_PROC_TI3 ON EN_DOC_TYP_PROC_T (PROC_NM)
/
CREATE INDEX EN_DOC_TYP_RTE_LVL_TI1
      ON EN_DOC_TYP_RTE_LVL_T (DOC_TYP_ID)
/
CREATE UNIQUE INDEX EN_DOC_TYP_TI1
      ON EN_DOC_TYP_T (DOC_TYP_NM, DOC_TYP_VER_NBR)
/
CREATE INDEX EN_DOC_TYP_TI2
      ON EN_DOC_TYP_T (DOC_TYP_PARNT_ID)
/
CREATE INDEX EN_DOC_TYP_TI3
      ON EN_DOC_TYP_T (DOC_TYP_ID, DOC_TYP_PARNT_ID)
/
CREATE INDEX EN_DOC_TYP_TI4
      ON EN_DOC_TYP_T (DOC_TYP_PREV_VER)
/
CREATE INDEX EN_DOC_TYP_TI5
      ON EN_DOC_TYP_T (DOC_TYP_CUR_IND)
/
CREATE INDEX EN_HLP_TI1
 ON EN_HLP_T (EN_HLP_KY)
/
CREATE INDEX EN_INIT_RTE_NODE_INSTN_TI1 on EN_INIT_RTE_NODE_INSTN_T(DOC_HDR_ID)
/
CREATE INDEX EN_INIT_RTE_NODE_INSTN_TI2 on EN_INIT_RTE_NODE_INSTN_T(RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_MESSAGE_QUE_TI1 ON EN_MESSAGE_QUE_T (MESSAGE_SERVICE_NM, SERVICE_METHOD_NM)
/
CREATE INDEX EN_MESSAGE_QUE_TI2 ON EN_MESSAGE_QUE_T (MESSAGE_ENTITY_NM, MESSAGE_QUE_STAT_CD, MESSAGE_QUE_IP_NBR, MESSAGE_QUE_DT)
/
CREATE INDEX EN_RTE_BRCH_PROTO_TI1 ON EN_RTE_BRCH_PROTO_T (RTE_BRCH_PROTO_NM)
/
CREATE INDEX EN_RTE_BRCH_ST_TI1 ON EN_RTE_BRCH_ST_T (RTE_BRCH_ID, ST_KEY)
/
CREATE INDEX EN_RTE_BRCH_ST_TI2 ON EN_RTE_BRCH_ST_T (RTE_BRCH_ID)
/
CREATE INDEX EN_RTE_BRCH_ST_TI3 ON EN_RTE_BRCH_ST_T (ST_KEY, ST_VAL_TXT)
/
CREATE INDEX EN_RTE_BRCH_TI1 ON EN_RTE_BRCH_T (BRCH_NM)
/
CREATE INDEX EN_RTE_BRCH_TI2 ON EN_RTE_BRCH_T (PARNT_RTE_BRCH_ID)
/
CREATE INDEX EN_RTE_BRCH_TI3 ON EN_RTE_BRCH_T (INIT_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_BRCH_TI4 ON EN_RTE_BRCH_T (SPLT_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_BRCH_TI5 ON EN_RTE_BRCH_T (JOIN_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_LNK_TI1 ON EN_RTE_NODE_INSTN_LNK_T (FROM_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_LNK_TI2 ON EN_RTE_NODE_INSTN_LNK_T (TO_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_ST_TI1 ON EN_RTE_NODE_INSTN_ST_T (RTE_NODE_INSTN_ID, ST_KEY)
/
CREATE INDEX EN_RTE_NODE_INSTN_ST_TI2 ON EN_RTE_NODE_INSTN_ST_T (RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_ST_TI3 ON EN_RTE_NODE_INSTN_ST_T (ST_KEY, ST_VAL_TXT)
/
CREATE INDEX EN_RTE_NODE_INSTN_TI1 ON EN_RTE_NODE_INSTN_T (DOC_ID, ACTV_IND, CMPLT_IND)
/
CREATE INDEX EN_RTE_NODE_INSTN_TI2 ON EN_RTE_NODE_INSTN_T (RTE_NODE_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_TI3 ON EN_RTE_NODE_INSTN_T (BRCH_ID)
/
CREATE INDEX EN_RTE_NODE_INSTN_TI4 ON EN_RTE_NODE_INSTN_T (PROC_RTE_NODE_INSTN_ID)
/
CREATE INDEX EN_RTE_NODE_LNK_TI1 ON EN_RTE_NODE_LNK_T (FROM_RTE_NODE_ID)
/
CREATE INDEX EN_RTE_NODE_LNK_TI2 ON EN_RTE_NODE_LNK_T (TO_RTE_NODE_ID)
/
CREATE INDEX EN_RTE_NODE_TI1 ON EN_RTE_NODE_T (RTE_NODE_NM, DOC_TYP_ID)
/
CREATE INDEX EN_RTE_NODE_TI2 ON EN_RTE_NODE_T (DOC_TYP_ID, DOC_FNL_APRVR_IND)
/
CREATE INDEX EN_RTE_NODE_TI3 ON EN_RTE_NODE_T (BRCH_PROTO_ID)
/
CREATE INDEX EN_RTE_NODE_TI4 ON EN_RTE_NODE_T (DOC_TYP_ID)
/
CREATE INDEX EN_RULE_EXT_T1
 ON EN_RULE_EXT_T (RULE_BASE_VAL_ID)
/
CREATE INDEX EN_RULE_EXT_VAL_T1
 ON EN_RULE_EXT_VAL_T (RULE_EXT_ID)
/
CREATE INDEX EN_RULE_EXT_VAL_T2 ON EN_RULE_EXT_VAL_T (RULE_EXT_VAL_ID, RULE_EXT_VAL_KEY)
/
CREATE INDEX EN_RULE_RSP_TI1 ON EN_RULE_RSP_T (RULE_BASE_VAL_ID)
/
CREATE INDEX EN_RULE_TMPL_ATTRIB_TI1 ON EN_RULE_TMPL_ATTRIB_T (RULE_TMPL_ID)
/
CREATE INDEX EN_RULE_TMPL_ATTRIB_TI2 ON EN_RULE_TMPL_ATTRIB_T (RULE_ATTRIB_ID)
/
CREATE UNIQUE INDEX EN_RULE_TMPL_TI1 ON EN_RULE_TMPL_T (RULE_TMPL_NM)
/
CREATE INDEX EN_SERVICE_DEF_DUEX_TI1 ON EN_SERVICE_DEF_DUEX_T (SERVER_IP, MESSAGE_ENTITY_NM)
/
CREATE INDEX EN_SERVICE_DEF_INTER_TI1 ON EN_SERVICE_DEF_INTER_T (SERVICE_DEF_ID)
/
CREATE INDEX EN_SERVICE_DEF_TI1 ON EN_SERVICE_DEF_T (SERVER_IP, MESSAGE_ENTITY_NM)
/
CREATE INDEX EN_USR_OPTN_TI1
 ON EN_USR_OPTN_T(PRSN_EN_ID)
/
CREATE UNIQUE INDEX EN_USR_TI1
 ON EN_USR_T (PRSN_UNIV_ID)
/
CREATE UNIQUE INDEX EN_USR_TI2
 ON EN_USR_T (PRSN_NTWRK_ID)
/
CREATE UNIQUE INDEX EN_USR_TI3
 ON EN_USR_T (PRSN_UNVL_USR_ID)
 /
 
CREATE INDEX EN_WRKGRP_MBR_TI1
 ON EN_WRKGRP_MBR_T(WRKGRP_MBR_PRSN_EN_ID)
/
CREATE INDEX EN_WRKGRP_TI1
 ON EN_WRKGRP_T (WRKGRP_NM)
/
CREATE UNIQUE INDEX EN_WRKGRP_TYP_TI1 ON EN_WRKGRP_TYP_T (WRKGRP_TYP_NM)
/
