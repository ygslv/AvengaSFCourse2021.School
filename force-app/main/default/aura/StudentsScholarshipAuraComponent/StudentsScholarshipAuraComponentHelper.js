({
    getStudentsHelper : function(component, event, helper) {

        component.set('v.columns', [
            {label:'Student Name', fieldName:'linkName', type:'url', 
            typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label:'Scholarship', fieldName:'Scholarship__c', type:'text'}
        ]);

        var action = component.get('c.getStudentsWithScholarship');

        action.setCallback(this, function(response){
            
            if (response.getState() === 'SUCCESS') {

                var records = response.getReturnValue();

                records.forEach(function(record){
                    
                    record.linkName = '/'+record.Id;
                });

                console.log(records);
                component.set('v.stList', records);
            }
        })

        $A.enqueueAction(action);
    }
})