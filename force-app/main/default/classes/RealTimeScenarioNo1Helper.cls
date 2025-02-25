public class RealTimeScenarioNo1Helper {
    public static Map<String,Lead> getMasterLead(List<Lead> leadList){
        Set<String> emailSet = new Set<String>();
        Map<Id, Lead> leadMap = new Map<Id, Lead>();
        Map<String,List<Lead>> emailLeadListMap = new Map<String,List<Lead>>();
        Map<String,Lead> masterLeadMap = new Map<String,Lead>();
        List<Lead> ldList = new List<Lead>();
        for(Lead ld:leadList){
            emailSet.add(ld.Email);
            leadMap.put(ld.Id, ld);
        }
        List<Lead> existingLeads = [Select Id, Email,Createddate from Lead where Email IN:emailSet and Id NOT IN :leadMap.keySet() and Original_Lead__c = null];
        //null check for existingLeads
        if(!existingLeads.isEmpty()){
            for(Lead ld:existingLeads){
                ldList.clear();
                if(emailLeadListMap.containsKey(ld.Email)){
                    emailLeadListMap.get(ld.Email).add(ld);
                }else{
                    
                    ldList.add(ld);
                    emailLeadListMap.put(ld.Email,ldList);
                    
                }
            }
        }
        for(String email:emailLeadListMap.keySet()){
            List<Lead> existingLeadList = emailLeadListMap.get(email);
            if(existingLeadList != null){
                Lead masterLead = existingLeadList[0];
                for(Lead ld:existingLeadList){
                    if(ld.Createddate < masterLead.CreatedDate){
                        masterLead = ld;
                    }
                    
                    masterLeadMap.put(masterLead.Email,masterLead);
                }
            }
            
        }
        
        return masterLeadMap;
    }
}