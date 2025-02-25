/**
 * @description       : 
 * @author            : Shantanu Rajurkar
 * @group             : 
 * @last modified on  : 02-25-2025
 * @last modified by  : Shantanu Rajurkar
**/

/*
Problem Statement:- 
When inserting new Leads, the system needed to identify duplicates based on the Email field. If a duplicate was found, 
the new Lead had to be marked as "Duplicate" and linked to the Original Lead. This should also work for Converted Leads too.
Note:- the oldest Lead in the system (based on the CreatedDate) should be identified as Original Lead. 
*/

trigger RealTimeScenarioNo1 on Lead (before insert) {
	if(Trigger.isBefore){        
        if(Trigger.isInsert){
          	RealTimeScenarioNo1Handler.duplicateManagement(Trigger.new);
      	}        
    }
}