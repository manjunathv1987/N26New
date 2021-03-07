/*******************************************************************************************
* @Name         ServiceSalesforceError 
* @Author       Manjunath Vittal Rao
* @Date         03/07/2021
* @Group        Wrapper Group
* @Description  This is error response wrapper for all the service.
*******************************************************************************************/
/* MODIFICATION LOG
* Version          Developer                    Date               Description
*-------------------------------------------------------------------------------------------
*  1.0            Manjunath Vittal Rao       03/07/2021              Initial Creation                                                      
*******************************************************************************************/
public class ServiceSalesforceError {
	public String errorCode;
    public String message;
    public ServiceSalesforceError(String errorCode, string message){
        this.errorCode = errorCode;
        this.message = message;
    }
}