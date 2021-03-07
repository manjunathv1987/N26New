/*******************************************************************************************
* @Name         ContactsProdInfoRestServiceTest
* @Author       Manjunath Vittal Rao
* @Date         03/07/2021
* @Group        Service Group
* @Description  This the test class for both ContactsProdInfoRestService and 
				ShowProductCostforContactControllerClass 
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/07/2021              Initial Creation                                                      
*******************************************************************************************/

@isTest
public class ContactsProdInfoRestServiceTest {
    
    @testSetup static void methodName() {
		insert TestClassHelper.getContact('test','abc@cd.com', '1234');
        insert TestClassHelper.getProd('Standard','1.7','DE','6','45');
        insert TestClassHelper.createCustSet('IsActive__c = true','select Product__r.Name,Product__r.ATMFOC__c, Product__r.Country__c, Product__r.Currency_Symbol__c,Product__r.CPCM__c, Product__r.CRC__c,Product__r.CurrencyIsoCode from ServiceContract','Contact.External_Id__c =:');
	}
    // to cover the catch block of record not found.
    public static testmethod void testGetProdServwoServContProd(){
        
        Test.startTest();
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/existingProdInfo/1234'; 
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        ContactsProdInfoRestService.doGetProd();
        list<ServiceSalesforceError> errorMes = new list<ServiceSalesforceError>();
        JSONParser parser = JSON.createParser(RestContext.response.responseBody.toString());
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        ServiceSalesforceError sc =(ServiceSalesforceError) parser.readValueAs(ServiceSalesforceError.class);
                        errorMes.add(sc);
                    }
                }
            }
            
        }
        system.assert(!errorMes.isEmpty()); // To check the error scenario
        Test.stopTest();     
    }
    // to cover the positive scenario
    public static testmethod void testGetProdServ(){
        
        Test.startTest();
        Product2 prod = new Product2();
        Contact conRec = new Contact();
        for(Product2 pr : [select name from Product2 limit 1]){
            prod = pr;
        }
        for(Contact con : [select LastName from Contact limit 1]){
            conRec = con;
        }
        
        insert TestClassHelper.getServContract('contract', conRec.Id, prod.Id, 'EUR');
        system.debug('SContract - '+[select Name from ServiceContract]);
        RestRequest req = new RestRequest();  
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/existingProdInfo/1234'; 
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        system.debug('Bef Service Call :'+res);
        ContactsProdInfoRestService.doGetProd();
        system.debug('Aft Service Call :'+RestContext.response.responseBody.toString());
        //Map<String, Object> cObjMap = (Map<String, Object>) JSON.deserializeUntyped(RestContext.response.responseBody.toString());
        List<Object> result =(List<Object>) JSON.deserializeUntyped(RestContext.response.responseBody.toString());
        list<ServiceContract> servContractLst = new list<ServiceContract>();
        JSONParser parser = JSON.createParser(RestContext.response.responseBody.toString());
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        ServiceContract sc =(ServiceContract) parser.readValueAs(ServiceContract.class);
                        servContractLst.add(sc);
                    }
                }
            }
            
        }
        system.assert(!servContractLst.isEmpty()); // To check the Success Scenario.
        Test.stopTest();     
    }
    
    public static testMethod void ShowProductCostforContactControllerClasstest(){
        list<ServiceContract> ServContrProdLst = new list<ServiceContract>();
        Test.startTest();
        Product2 prod = new Product2();
        Contact conRec = new Contact();
        for(Product2 pr : [select name from Product2 limit 1]){
            prod = pr;
        }
        for(Contact con : [select LastName from Contact limit 1]){
            conRec = con;
        }
        Case caseRec = TestClassHelper.getCase(conRec.Id);
        insert caseRec;
        ServContrProdLst = ShowProductCostforContactControllerClass.getAllRelatedProd(caseRec.Id); // To cover Catch Block (Negative)
        system.assert(ServContrProdLst.isEmpty());
        insert TestClassHelper.getServContract('contract', conRec.Id, prod.Id, 'EUR');
        
        ServContrProdLst = ShowProductCostforContactControllerClass.getAllRelatedProd(caseRec.Id); // To cover actual scenario (Positive)
        system.assert(!ServContrProdLst.isEmpty());
        Test.stopTest();
    }
}