trigger RealTimeScenarioNo1 on Lead (before insert) {
	if(Trigger.isBefore){        
        if(Trigger.isInsert){
          	RealTimeScenarioNo1Handler.duplicateManagement(Trigger.new);
      	}        
    }
}