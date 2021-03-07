/*******************************************************************************************
* @Name         TestClassHelper
* @Author       Manjunath Vittal Rao
* @Date         03/07/2021
* @Group        Test Class helper
* @Description  This class create the records which is required for the all the test class 
				in this Org.
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/07/2021              Initial Creation                                                      
*******************************************************************************************/

public class TestClassHelper {
   
    public static DynamicQueryHelper__c createCustSet(string activeProdCond, string servContQuery, string woActProdCond){
        DynamicQueryHelper__c queryCusSett = new DynamicQueryHelper__c();
        queryCusSett.Active_Products_Condition__c = activeProdCond;
        queryCusSett.ServiceContact_Query__c = servContQuery;
        queryCusSett.Without_Active_Product_Condition__c = woActProdCond;
        return queryCusSett;
    }
    public static Contact getContact(string lName, string email, string extId){
        Contact con = new Contact(
            LastName = lName,
            Email = email,
            External_Id__c = extId
        );
        return con;
    }
    
    public static Product2 getProd(string name, string atmfoc, string country, string cpcm, string crc){
        Product2 prod = new Product2(
            IsActive = true,
            CurrencyIsoCode = 'EUR',
            Name = name,
            ATMFOC__c = Decimal.valueOf(atmfoc),
            Country__c = country,
            CPCM__c = Decimal.valueOf(cpcm),
            CRC__c = Decimal.valueOf(crc)
        );
        return prod;
    } 
    
    public static ServiceContract getServContract(string name, Id conId, Id prodId, string curCode ){
        ServiceContract servContr = new ServiceContract(
            Name = name,
        	ContactId = conId,
            Product__c = prodId,
            StartDate = system.today(),
            EndDate = system.today().addDays(10),
            CurrencyIsoCode = curCode
        );
        return servContr;
    }
    
    public static Case getCase(Id conId){
        Case caseRec = new Case(
        	ContactId = conId
        );
        return caseRec;
    }
}