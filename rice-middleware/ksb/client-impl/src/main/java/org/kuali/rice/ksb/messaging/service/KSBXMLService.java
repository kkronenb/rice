/**
 * Copyright 2005-2017 The Kuali Foundation
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
package org.kuali.rice.ksb.messaging.service;

import org.kuali.rice.core.api.exception.RiceIllegalArgumentException;

/**
 * A service which can be invoked with a String message that contains
 * XML content.
 *
 * @author Kuali Rice Team (rice.collab@kuali.org)
 */
public interface KSBXMLService {
	void invoke(String message) throws RiceIllegalArgumentException;
	
}
