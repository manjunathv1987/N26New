({
	helperMethod : function(component) {
		var caseId = component.get("v.recordId");
        var spinner = component.find("spnr");
		var action = component.get('c.getAllRelatedProd');	
        console.log('Case Id - '+caseId);
        action.setParams({
            recordId:caseId
        });
        

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                //get account and respective contact list, and initialize with items
                component.set('v.ProdList', response.getReturnValue());
                //hide spinner after getting data
                $A.util.toggleClass(spinner, "slds-hide");
            }else{
                $A.util.toggleClass(spinner, "slds-hide");
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
	}
})