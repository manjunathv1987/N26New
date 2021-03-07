/*******************************************************************************************
* @Name         ContactsProdInfoRestService 
* @Author       Manjunath Vittal Rao
* @Date         03/07/2021
* @Group        Service Group
* @Description  This is a service to get all the products for a Contact
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/07/2021              Initial Creation                                                      
*******************************************************************************************/
@RestResource(urlMapping='/existingProdInfo/*')
global with sharing class ContactsProdInfoRestService {

    @HttpGet
    global static void doGetProd() {
        list<ServiceContract> serContProdLst = new list<ServiceContract>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        try{
            String extId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            serContProdLst = Utilities.getSerContractProdDetails(false,extId); // building the query without the isActive Contacts for the service exposed
            if(!serContProdLst.isEmpty())
                RestContext.response.responseBody = Blob.valueOf(JSON.serialize(serContProdLst)); 
            else
                throw new Exception.QueryException();
            
        }catch(System.QueryException e){
            RestContext.response.statusCode = 404;
            ServiceSalesforceError[] errs = new ServiceSalesforceError[]{new ServiceSalesforceError('NOT_FOUND', System.Label.Prod_Not_Found)};
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(errs));
            // ErrorLog record can be created here If it is maintained in org.
        }catch(Exception ex){
            RestContext.response.statusCode = 505;
            list<ServiceSalesforceError> errs = new list<ServiceSalesforceError>{new ServiceSalesforceError('BAD_REQUEST', ex.getMessage())};
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(errs));   
            // ErrorLog record can be created here If it is maintained in org.
        }
    }
}