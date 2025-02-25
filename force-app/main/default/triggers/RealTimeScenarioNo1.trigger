/**
 * @description       : 
 * @author            : Shantanu Rajurkar
 * @group             : 
 * @last modified on  : 02-25-2025
 * @last modified by  : Shantanu Rajurkar
**/
trigger RealTimeScenarioNo1 on Lead (before insert) {
	if(Trigger.isBefore){        
        if(Trigger.isInsert){
          	RealTimeScenarioNo1Handler.duplicateManagement(Trigger.new);
      	}        
    }
}