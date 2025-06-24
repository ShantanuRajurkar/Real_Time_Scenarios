/**
 * @description       : 
 * @author            : Shantanu Rajurkar
 * @group             : 
 * @last modified on  : 06-22-2025
 * @last modified by  : Shantanu Rajurkar
**/
public class ApexToAgentforceConnect {
    @AuraEnabled
    public static AgentResponse invoke(String userMessage, String sessionId, String accountId) {
        String agentResponse = '';
        AgentResponse resp = new AgentResponse();
        try {
            Invocable.Action action = Invocable.Action.createCustomAction('generateAiAgentResponse', '<your_agents_api_name>');
            
            action.setInvocationParameter('userMessage', userMessage);
            action.setInvocationParameter('accIds', accountId);
            action.setInvocationParameter('sessionId', sessionId);
            // Execute the action
            List<Invocable.Action.Result> results = action.invoke();
            Invocable.Action.Result result = results[0];
            
            // Handle the response
            if (result.isSuccess()) {
                // Retrieve the Session id and Agent Response
                String customResp = String.valueOf(result.getOutputParameters().get('agentResponse'));
                Map<String, Object> agentOutput = (Map<String, Object>) JSON.deserializeUntyped(customResp);
                resp.agentResponse = JSON.serialize(String.valueOf(agentOutput.get('value')));
                resp.sessionId = String.valueOf(result.getOutputParameters().get('sessionId'));
            } else {
                System.debug('Java action execution failed: ' + result.getErrors());
            }
        } catch (Exception e) {
            System.debug('Error invoking Java action: ' + e.getMessage());
        }
        return resp;
    }
    public class AgentResponse{
        @AuraEnabled
        public String sessionId;
        @AuraEnabled
        public String agentResponse;
    }
}