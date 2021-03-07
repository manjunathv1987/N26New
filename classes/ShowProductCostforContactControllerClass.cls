/*******************************************************************************************
* @Name         ShowProductCostforContactControllerClass 
* @Author       Manjunath Vittal Rao
* @Date         03/06/2021
* @Group        Aura Component Controller Group
* @Description  This class is to return the required data to the aura component from salesforce side.
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/06/2021              Initial Creation                                                      
*******************************************************************************************/
public class ShowProductCostforContactControllerClass {
    
    @AuraEnabled
    public static list<ServiceContract> getAllRelatedProd(Id recordId){
        list<ServiceContract> servContProdLst = new list<ServiceContract>();
        try{
            Case caseRec = [SELECT Id, CaseNumber, ContactId,Contact.External_Id__c FROM Case where Id=:recordId limit 1];
            servContProdLst = Utilities.getSerContractProdDetails(true,caseRec.Contact.External_Id__c);// get all the active product for a Particular contact
             if(servContProdLst.isEmpty())
                 throw new AuraHandledException(System.Label.Prod_Not_Found);
        }catch (Exception e){
            // ErrorLog record can be created here If it is maintained in org.
        }
        return servContProdLst; 
    }
}