<#--

    Copyright 2005-2017 The Kuali Foundation

    Licensed under the Educational Community License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.opensource.org/licenses/ecl2.php

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<#include "group.ftl" parse=true/>
<#assign inline_groupWrapOpen = "org.kuali.rice.krad.uif.freemarker.OpenGroupWrapDirective"?new()>
<#assign inline_groupWrapClose = "org.kuali.rice.krad.uif.freemarker.CloseGroupWrapDirective"?new()>

<#macro uif_groupContentWrap group>

    <@krad.wrap component=group renderAs="${group.wrapperTag}">

        <@inline_groupWrapOpen group=group/>

            <div class="${view.contentContainerClassesAsString}">
                <#if !group.renderLoading>
                    <#-- invoke layout manager -->
                    <#local templateName=".main.${group.layoutManager.templateName}"/>
                    <#local templateParams="items=group.items manager=group.layoutManager container=group"/>

                    <@krad.dyncall templateName=templateName templateParams=templateParams group=group/>
                </#if>
            </div>

        <@inline_groupWrapClose group=group/>

    </@krad.wrap>

</#macro>