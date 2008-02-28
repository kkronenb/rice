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
package org.kuali.rice.kcb.services.impl;

import java.util.Collection;

import junit.framework.Assert;

import org.apache.commons.lang.RandomStringUtils;
import org.junit.Test;
import org.kuali.bus.services.KSBServiceLocator;
import org.kuali.rice.kcb.bo.MessageDelivery;
import org.kuali.rice.kcb.bo.MessageDeliveryStatus;
import org.kuali.rice.kcb.quartz.MessageProcessingJob;
import org.kuali.rice.kcb.test.ClearDatabaseKCBTestCase;
import org.kuali.rice.kcb.vo.MessageVO;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerException;
import org.quartz.listeners.JobListenerSupport;
import org.springframework.transaction.support.TransactionSynchronizationManager;

/**
 * Tests MessagingService 
 * 
 * @author Kuali Rice Team (kuali-rice@googlegroups.com)
 */
public class MessagingServiceTest extends ClearDatabaseKCBTestCase {
    private Object lock = new Object();
  
    @Override
    public void setUp() throws Exception {
        super.setUp();
    
        services.getRecipientPreferenceService().saveRecipientDelivererConfig("user1", "mock", new String[] { "channel1" });
        services.getRecipientPreferenceService().saveRecipientDelivererConfig("user1", "sms", new String[] { "channel1" });
    }

    protected long deliver() throws Exception {
        MessageVO message = new MessageVO();
        message.setContent("test content 1");
        message.setChannel("channel1");
        message.setContentType("test content type 1");
        message.setDeliveryType("test delivery type 1");
        message.setRecipient("user1");
        message.setTitle("test title 1");

        registerJobListener();

        long id = services.getMessagingService().deliver(message);

        waitForNextJobCompletion();

        Collection<MessageDelivery> deliveries = services.getMessageDeliveryService().getAllMessageDeliveries();
        assertNotNull(deliveries);
        // HACK: for now our impl just creates deliveries for all deliverer types because we don't have preferences yet
        // so there should be exactly as many deliveries as deliverer types
        int delivCount = services.getRecipientPreferenceService().getDeliverersForRecipientAndChannel("user1", "channel1").size();
        assertEquals(delivCount, deliveries.size());
        assertTrue(deliveries.size() > 0);
        for (MessageDelivery delivery: deliveries) {
            assertEquals(MessageDeliveryStatus.DELIVERED.name(), delivery.getDeliveryStatus());
        }
        
        return id;
    }

    @Test
    public void testDeliver() throws Exception {
        Assert.assertFalse(TransactionSynchronizationManager.isActualTransactionActive());

        deliver();
    }
    
    @Test
    public void testDismiss() throws Exception {
        Assert.assertFalse(TransactionSynchronizationManager.isActualTransactionActive());

        long id = deliver();

        registerJobListener();

        services.getMessagingService().remove(id, "a user", "a cause");
        
        waitForNextJobCompletion();

        Collection<MessageDelivery> deliveries = services.getMessageDeliveryService().getAllMessageDeliveries();
        assertNotNull(deliveries);
        // should be all gone
        assertEquals(0, deliveries.size());
    }
    
    protected void registerJobListener() throws SchedulerException {
        KSBServiceLocator.getScheduler().addGlobalJobListener(new JobListenerSupport() {
            @Override
            public void jobWasExecuted(JobExecutionContext context, JobExecutionException jobException) {
                log.debug("Job was executed: " + context);
                if (MessageProcessingJob.NAME.equals(context.getJobDetail().getName())) {
                    log.debug("Obtaining lock");
                    synchronized (lock) {
                        log.debug("Notifying on lock");    
                        lock.notifyAll();
                    }
                }
                
            }
            public String getName() {
                return System.currentTimeMillis() + RandomStringUtils.randomAlphanumeric(10);
            }
            
        });
    }

    protected void waitForNextJobCompletion() throws InterruptedException {
        log.debug("Waiting for job to complete...");
        synchronized (lock) {
            lock.wait();
        }
        log.debug("Job completed...");
    }
}