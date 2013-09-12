/**
 * Copyright 2005-2013 The Kuali Foundation
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
package edu.samplu.krad.library.collectionfeatures;

import org.junit.Test;

import edu.samplu.common.Failable;
import edu.samplu.common.ITUtil;
import edu.samplu.common.SmokeTestBase;
import edu.samplu.common.WebDriverLegacyITBase;

/**
 * @author Kuali Rice Team (rice.collab@kuali.org)
 */
public class DemoLibraryCollectionFeaturesRowDetailsSmokeTest extends SmokeTestBase {

    /**
     * /kr-krad/kradsampleapp?viewId=Demo-TableLayoutDetails-View&methodToCall=start
     */
    public static final String BOOKMARK_URL = "/kr-krad/kradsampleapp?viewId=Demo-TableLayoutDetails-View&methodToCall=start";

    @Override
    protected String getBookmarkUrl() {
        return BOOKMARK_URL;
    }

    @Override
    protected void navigate() throws Exception {
        waitAndClickById("Demo-LibraryLink", "");
        waitAndClickByLinkText("Collection Features");
        waitAndClickByLinkText("Row Details");
    }

    protected void testCollectionFeaturesRowDetails() throws Exception {
      if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example1']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
      {
        fail("Row Details Present");
      }
      waitAndClickButtonByText("Open/Close Row Details");
      assertElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example1']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']");
      waitAndClickButtonByText("Open/Close Row Details");
      if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example1']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
      {
        fail("Row Details Present");
      }
      waitAndClickButtonByText("Open/Close Row Details");
    }
    
    protected void testCollectionFeaturesRowDetailsAjaxRetrival() throws Exception {
        selectByName("exampleShown","Ajax Retrieval");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example2']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
          fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section2_detLink_line0']");
        assertElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example2']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']");
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section2_detLink_line0']");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example2']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
          fail("Row Details Present");
        }
    }
    
    protected void testCollectionFeaturesRowDetailsTableSubCollection() throws Exception {
        selectByName("exampleShown","W/ Table SubCollection");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example3']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section3_detLink_line0']");
        assertElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example3']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-disclosure uif-boxLayoutVerticalItem clearfix']/div[@class='uif-disclosureContent']/div[@class='dataTables_wrapper']/table");
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section3_detLink_line0']");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example3']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-disclosure uif-boxLayoutVerticalItem clearfix']/div[@class='uif-disclosureContent']/div[@class='dataTables_wrapper']/table"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section3_detLink_line0']");
    }
    
    protected void testCollectionFeaturesRowDetailsStackedSubCollection() throws Exception {
        selectByName("exampleShown","W/ Stacked SubCollection");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example4']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section4_detLink_line0']");
        waitForElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example4']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-stackedSubCollection uif-boxLayoutVerticalItem clearfix']/div[@class='uif-stackedCollectionLayout']/div/table");
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section4_detLink_line0']");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example4']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-stackedSubCollection uif-boxLayoutVerticalItem clearfix']/div[@class='uif-stackedCollectionLayout']/div/table"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section4_detLink_line0']");
    }
    
    protected void testCollectionFeaturesRowDetailsNestedDetails() throws Exception {
        selectByName("exampleShown","Nested Details");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example5']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section5_detLink_line0']");
        assertElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example5']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-tableSubCollection uif-boxLayoutVerticalItem clearfix']/div[@class='dataTables_wrapper']/table");
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section5_detLink_line0']");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example5']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']/td/div/div[@class='uif-verticalBoxLayout clearfix']/div[@class='uif-tableSubCollection uif-boxLayoutVerticalItem clearfix']/div[@class='dataTables_wrapper']/table"))
        {
            fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section5_detLink_line0']");
    }
    
    protected void testCollectionFeaturesRowDetailsOpenedDetails() throws Exception {
        selectByName("exampleShown","Opened Details");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example6']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
          fail("Row Details Present");
        }
        waitAndClickByXpath("//a[@id='Demo-TableLayoutDetails-Section6_detLink_add']");
        assertElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example6']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']");
        waitAndClickByXpath("//div[@id='Demo-TableLayoutDetails-Section6']/button");
        if(isElementPresentByXpath("//div[@id='Demo-TableLayoutDetails-Example6']/div[@class='uif-verticalBoxLayout clearfix']/div/div[@class='dataTables_wrapper']/table/tbody/tr[@class='detailsRow']"))
        {
          fail("Row Details Present");
        }
      }
    
    @Test
    public void testCollectionFeaturesRowDetailsBookmark() throws Exception {
        testCollectionFeaturesRowDetails();
        testCollectionFeaturesRowDetailsAjaxRetrival();
        testCollectionFeaturesRowDetailsTableSubCollection();
        testCollectionFeaturesRowDetailsStackedSubCollection();
        testCollectionFeaturesRowDetailsNestedDetails();
        testCollectionFeaturesRowDetailsOpenedDetails();
        passed();
    }

    @Test
    public void testCollectionFeaturesRowDetailsNav() throws Exception {
        testCollectionFeaturesRowDetails();
        testCollectionFeaturesRowDetailsAjaxRetrival();
        testCollectionFeaturesRowDetailsTableSubCollection();
        testCollectionFeaturesRowDetailsStackedSubCollection();
        testCollectionFeaturesRowDetailsNestedDetails();
        testCollectionFeaturesRowDetailsOpenedDetails();
        passed();
    }  
}