({
    getStudents: function(component) {
        component.set('v.columns', [
            {label:'Student Name', fieldName:'Name', type:'text'},
            {label:'Scholarship', fieldName:'Scholarship__c', type:'text'}
        ]);

        var action = component.get('c.getStudentsWithScholarship');

        action.setCallback(this, function(response){
            if (response.getState() === 'SUCCESS') {

                console.log(response.getReturnValue());
                component.set('v.stList', response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    }
})