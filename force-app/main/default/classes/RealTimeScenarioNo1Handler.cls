/**
 * @description       : 
 * @author            : Shantanu Rajurkar
 * @group             : 
 * @last modified on  : 02-25-2025
 * @last modified by  : Shantanu Rajurkar
**/
public class RealTimeScenarioNo1Handler {
	public static void duplicateManagement(List<Lead> leadList){
        Map<String,Lead> masterLeadMap = RealTimeScenarioNo1Helper.getMasterLead(leadList);
        for(Lead ld:leadList){
            if(masterLeadMap.containsKey(ld.Email)){
                Lead masterLead = masterLeadMap.get(ld.Email);
                ld.Original_Lead__c = masterLead.Id;
                ld.status = 'Duplicate';
            }
            
        }
    }
}