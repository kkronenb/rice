/*
 * Copyright 2005-2006 The Kuali Foundation.
 *
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
package org.kuali.rice.kew.actions;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.MDC;
import org.kuali.rice.kew.actionrequest.ActionRequestValue;
import org.kuali.rice.kew.actionrequest.Recipient;
import org.kuali.rice.kew.actions.asyncservices.MoveDocumentService;
import org.kuali.rice.kew.actiontaken.ActionTakenValue;
import org.kuali.rice.kew.engine.BlanketApproveEngine;
import org.kuali.rice.kew.engine.OrchestrationConfig;
import org.kuali.rice.kew.engine.node.RouteNode;
import org.kuali.rice.kew.engine.node.RouteNodeInstance;
import org.kuali.rice.kew.exception.InvalidActionTakenException;
import org.kuali.rice.kew.messaging.MessageServiceNames;
import org.kuali.rice.kew.routeheader.DocumentRouteHeaderValue;
import org.kuali.rice.kew.service.KEWServiceLocator;
import org.kuali.rice.kew.util.KEWConstants;
import org.kuali.rice.kew.util.Utilities;
import org.kuali.rice.kim.bo.entity.KimPrincipal;


/**
 * Returns a document to a previous node in the route.
 *
 * Current implementation only supports returning to a node on the main branch of the
 * document.
 *
 * @author Kuali Rice Team (kuali-rice@googlegroups.com)
 */
public class MoveDocumentAction extends ActionTakenEvent {

    protected final org.apache.log4j.Logger LOG = org.apache.log4j.Logger.getLogger(getClass());

    private MovePoint movePoint;

    public MoveDocumentAction(DocumentRouteHeaderValue routeHeader, KimPrincipal principal) {
        super(KEWConstants.ACTION_TAKEN_MOVE_CD, routeHeader, principal);
    }

    public MoveDocumentAction(DocumentRouteHeaderValue routeHeader, KimPrincipal principal, String annotation, MovePoint movePoint) {
        super(KEWConstants.ACTION_TAKEN_MOVE_CD, routeHeader, principal, annotation);
        this.movePoint = movePoint;
    }

    /* (non-Javadoc)
     * @see org.kuali.rice.kew.actions.ActionTakenEvent#isActionCompatibleRequest(java.util.List)
     */
    @Override
    public String validateActionRules() {
        return validateActionRules(getActionRequestService().findAllValidRequests(getPrincipal().getPrincipalId(), routeHeader.getRouteHeaderId(),
                KEWConstants.ACTION_REQUEST_COMPLETE_REQ), KEWServiceLocator.getRouteNodeService().getActiveNodeInstances(getRouteHeader().getRouteHeaderId()));
    }

    private String validateActionRules(List<ActionRequestValue> actionRequests, Collection activeNodes) {
        if (!getRouteHeader().isValidActionToTake(getActionPerformedCode())) {
            return "Document is not in a state to be moved";
        }
        if (activeNodes.isEmpty()) {
            return "Document has no active nodes.";
        }
        if (!isActionCompatibleRequest(actionRequests)) {
            return "No request for the user is compatible with the MOVE action";
        }
        return "";
    }


    /* (non-Javadoc)
     * @see org.kuali.rice.kew.actions.ActionTakenEvent#isActionCompatibleRequest(java.util.List)
     */
    public boolean isActionCompatibleRequest(List<ActionRequestValue> requests) {
        //Move is always correct because the client application has authorized it
        return true;
    }

    public void recordAction() throws InvalidActionTakenException {
        MDC.put("docId", getRouteHeader().getRouteHeaderId());
        updateSearchableAttributesIfPossible();
        LOG.debug("Moving document " + getRouteHeader().getRouteHeaderId() + " to point: " + displayMovePoint(movePoint) + ", annotation: " + annotation);

        List actionRequests = getActionRequestService().findAllValidRequests(getPrincipal().getPrincipalId(), getRouteHeaderId(), KEWConstants.ACTION_REQUEST_COMPLETE_REQ);
        Collection activeNodes = KEWServiceLocator.getRouteNodeService().getActiveNodeInstances(getRouteHeader().getRouteHeaderId());
        String errorMessage = validateActionRules(actionRequests,activeNodes);
        if (!Utilities.isEmpty(errorMessage)) {
            throw new InvalidActionTakenException(errorMessage);
        }

            RouteNodeInstance startNodeInstance = determineStartNode(activeNodes, movePoint);

            LOG.debug("Record the move action");
            Recipient delegator = findDelegatorForActionRequests(actionRequests);
            ActionTakenValue actionTaken = saveActionTaken(delegator);
            getActionRequestService().deactivateRequests(actionTaken, actionRequests);
            notifyActionTaken(actionTaken);

            // TODO this whole bit is a bit hacky at the moment
            if (movePoint.getStepsToMove() > 0) {
                Set<String> targetNodeNames = new HashSet<String>();
                targetNodeNames.add(determineFutureNodeName(startNodeInstance, movePoint));

                MoveDocumentService moveDocumentProcessor = MessageServiceNames.getMoveDocumentProcessorService(getRouteHeader());
                moveDocumentProcessor.moveDocument(getPrincipal().getPrincipalId(), getRouteHeader(), actionTaken, targetNodeNames);

            } else {
                String targetNodeName = determineReturnNodeName(startNodeInstance, movePoint);
                ReturnToPreviousNodeAction returnAction = new ReturnToPreviousNodeAction(KEWConstants.ACTION_TAKEN_MOVE_CD, getRouteHeader(), getPrincipal(), annotation, targetNodeName, false);
                
                returnAction.recordAction();
            }
    }

    public void performDeferredMoveDocumentWork(ActionTakenValue actionTaken, Set nodeNames) throws Exception {

        if (getRouteHeader().isInException()) {
            LOG.debug("Moving document back to Enroute from Exception");

            String oldStatus = getRouteHeader().getDocRouteStatus();
            getRouteHeader().markDocumentEnroute();

            String newStatus = getRouteHeader().getDocRouteStatus();
            notifyStatusChange(newStatus, oldStatus);
        }
        OrchestrationConfig config = new OrchestrationConfig();
        config.setCause(actionTaken);
        config.setDestinationNodeNames(nodeNames);
        config.setSendNotifications(false);
        new BlanketApproveEngine(config).process(getRouteHeader().getRouteHeaderId(), null);
        
        queueDocumentProcessing();
    }

    private RouteNodeInstance determineStartNode(Collection activeNodes, MovePoint movePoint) throws InvalidActionTakenException {
        RouteNodeInstance startNodeInstance = null;
        for (Iterator iterator = activeNodes.iterator(); iterator.hasNext();) {
            RouteNodeInstance nodeInstance = (RouteNodeInstance) iterator.next();
            if (nodeInstance.getName().equals(movePoint.getStartNodeName())) {
                if (startNodeInstance != null) {
                    throw new InvalidActionTakenException("More than one active node exists with the given name:  " + movePoint.getStartNodeName());
                }
                startNodeInstance = nodeInstance;
            }
        }
        if (startNodeInstance == null) {
            throw new InvalidActionTakenException("Could not locate an active node with the given name: " + movePoint.getStartNodeName());
        }
        return startNodeInstance;
    }

    private String determineFutureNodeName(RouteNodeInstance startNodeInstance, MovePoint movePoint) throws InvalidActionTakenException {
        return determineFutureNodeName(startNodeInstance.getRouteNode(), movePoint, 0, new HashSet());
    }

    private String determineFutureNodeName(RouteNode node, MovePoint movePoint, int currentStep, Set nodesProcessed) throws InvalidActionTakenException {
        if (nodesProcessed.contains(node.getRouteNodeId())) {
            throw new InvalidActionTakenException("Detected a cycle at node " + node.getRouteNodeName() + " when attempting to move document.");
        }
        nodesProcessed.add(node.getRouteNodeId());
        if (currentStep == movePoint.getStepsToMove()) {
            return node.getRouteNodeName();
        }
        List nextNodes = node.getNextNodes();
        if (nextNodes.size() == 0) {
            throw new InvalidActionTakenException("Could not proceed forward, there are no more nodes in the route.  Halted on step " + currentStep);
        }
        if (nextNodes.size() != 1) {
            throw new InvalidActionTakenException("Cannot move forward in a multi-branch path.  Located "+nextNodes.size()+" branches.  Halted on step " + currentStep);
        }
        return determineFutureNodeName((RouteNode)nextNodes.get(0), movePoint, currentStep+1, nodesProcessed);
    }

    private String determineReturnNodeName(RouteNodeInstance startNodeInstance, MovePoint movePoint) throws InvalidActionTakenException {
        return determineReturnNodeName(startNodeInstance.getRouteNode(), movePoint, 0);
    }

    private String determineReturnNodeName(RouteNode node, MovePoint movePoint, int currentStep) throws InvalidActionTakenException {
        if (currentStep == movePoint.getStepsToMove()) {
            return node.getRouteNodeName();
        }
        List previousNodes = node.getPreviousNodes();
        if (previousNodes.size() == 0) {
            throw new InvalidActionTakenException("Could not locate the named target node in the document's past route.  Halted on step " + currentStep);
        }
        if (previousNodes.size() != 1) {
            throw new InvalidActionTakenException("Located a multi-branch path, could not proceed backward past this point.  Halted on step " + currentStep);
        }
        return determineReturnNodeName((RouteNode)previousNodes.get(0), movePoint, currentStep-1);
    }

    private String displayMovePoint(MovePoint movePoint) {
        return "fromNode="+movePoint.getStartNodeName()+", stepsToMove="+movePoint.getStepsToMove();
    }

}