/*******************************************************************************************
* @Name         Utilities 
* @Author       Manjunath Vittal Rao
* @Date         03/07/2021
* @Group        Utilities
* @Description  This class is used as a support class for all the apex in this Org.
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/07/2021              Initial Creation                                                      
*******************************************************************************************/
public class Utilities {
    public static list<ServiceContract> getSerContractProdDetails(boolean isActiveReq, String extenId){
        String queryString = '';
        DynamicQueryHelper__c queryStrCS = DynamicQueryHelper__c.getOrgDefaults();
        queryString = queryStrCS.ServiceContact_Query__c;
        queryString += ' where '+queryStrCS.Without_Active_Product_Condition__c+' extenId';
        if(isActiveReq){
            queryString += ' and '+queryStrCS.Active_Products_Condition__c;
        }
        system.debug('extenId - '+extenId);
        system.debug('Query - '+queryString);
        return Database.query(queryString);
    }
}