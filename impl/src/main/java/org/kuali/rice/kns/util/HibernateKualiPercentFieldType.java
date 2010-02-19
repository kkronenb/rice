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
package org.kuali.rice.kns.util;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.hibernate.HibernateException;

/**
 * Creates a KualiPercent object from the data field. Field is stored as a percentage.
 * 
 * @author Kuali Rice Team (rice.collab@kuali.org)
 *
 */
public class HibernateKualiPercentFieldType extends HibernateImmutableValueUserType {

	/**
	 * This overridden method ...
	 * 
	 * @see org.kuali.rice.kns.util.HibernateImmutableValueUserType#nullSafeGet(java.sql.ResultSet, java.lang.String[], java.lang.Object)
	 */
	@Override
	public Object nullSafeGet(ResultSet rs, String[] names, Object owner)
			throws HibernateException, SQLException {
		
		BigDecimal source = rs.getBigDecimal(names[0]);
		
        // Check for null, and verify object type.
        // Do conversion if our type is correct (BigDecimal).
        if (source != null && source instanceof BigDecimal) {
            BigDecimal converted = (BigDecimal) source;

            // Once we have converted, we need to convert again to KualiPercent.
            KualiPercent percentConverted = new KualiPercent((BigDecimal) converted);

            return percentConverted;

        }
        else {
            return null;
        }
	}

	/**
	 * This overridden method ...
	 * 
	 * @see org.kuali.rice.kns.util.HibernateImmutableValueUserType#nullSafeSet(java.sql.PreparedStatement, java.lang.Object, int)
	 */
	@Override
	public void nullSafeSet(PreparedStatement st, Object source, int index)
			throws HibernateException, SQLException {
	       Object converted = source;

	        if (source instanceof KualiPercent) {
	            converted = ((KualiPercent) source).bigDecimalValue();
	        }

	        if (converted == null) {
	        	st.setNull(index, Types.DECIMAL); 
	        } else {
	        	st.setBigDecimal(index, ((BigDecimal)converted));
	        }
	}

	/**
	 * This overridden method ...
	 * 
	 * @see org.kuali.rice.kns.util.HibernateImmutableValueUserType#returnedClass()
	 */
	public Class returnedClass() {
		return BigDecimal.class;
	}

	/**
	 * Returns an array with the SQL VARCHAR type as the single member
	 * 
	 * @see org.hibernate.usertype.UserType#sqlTypes()
	 */
	public int[] sqlTypes() {
		return new int[] { Types.DECIMAL };
	}

}
