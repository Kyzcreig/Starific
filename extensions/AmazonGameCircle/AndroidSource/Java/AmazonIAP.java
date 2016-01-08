//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//


package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.RunnerActivity;
import com.yoyogames.runner.RunnerJNILib;
import java.util.Set;
import java.util.HashSet;
import android.util.Log;
import com.yoyogames.runner.RunnerJNILib;
import com.amazon.ags.*;
import com.amazon.ags.api.*;
import com.yoyogames.runner.RunnerJNILib;
import com.amazon.device.iap.PurchasingListener;
import com.amazon.device.iap.PurchasingService;
import com.amazon.device.iap.model.ProductDataResponse;
import com.amazon.device.iap.model.PurchaseResponse;
import com.amazon.device.iap.model.PurchaseUpdatesResponse;
import com.amazon.device.iap.model.Receipt;
import com.amazon.device.iap.model.UserDataResponse;

public class AmazonIAP implements PurchasingListener 
{
	int EVENT_OTHER_SOCIAL = 70;
 
	int e_achievement_our_info=1002;
	int e_achievement_friends_info=1003;
	int e_achievement_msg_result=1014;
	int e_achievement_leaderboard_info=1004;
	int e_achievement_achievement_info=1005;
	private static final String TAG = "yoyo";
	
	  /**
     * This is the callback for {@link PurchasingService#getUserData}. For
     * successful case, get the current user from {@link UserDataResponse} and
     * call {@link SampleIAPManager#setAmazonUserId} method to load the Amazon
     * user and related purchase information
     * 
     * @param response
     */
    @Override
    public void onUserDataResponse(final UserDataResponse response) {
        Log.d(TAG, "onGetUserDataResponse: requestId (" + response.getRequestId()
                   + ") userIdRequestStatus: "
                   + response.getRequestStatus()
                   + ")");

        final UserDataResponse.RequestStatus status = response.getRequestStatus();
        switch (status) {
        case SUCCESSFUL:
            Log.d(TAG, "onUserDataResponse: get user id (" + response.getUserData().getUserId()
                       + ", marketplace ("
                       + response.getUserData().getMarketplace()
                       + ") ");
          //  iapManager.setAmazonUserId(response.getUserData().getUserId(), response.getUserData().getMarketplace());
            break;

        case FAILED:
        case NOT_SUPPORTED:
            Log.d(TAG, "onUserDataResponse failed, status code is " + status);
         //   iapManager.setAmazonUserId(null, null);
            break;
        }
    }

    /**
     * This is the callback for {@link PurchasingService#getProductData}. After
     * SDK sends the product details and availability to this method, it will
     * call {@link SampleIAPManager#enablePurchaseForSkus}
     * {@link SampleIAPManager#disablePurchaseForSkus} or
     * {@link SampleIAPManager#disableAllPurchases} method to set the purchase
     * status accordingly.
     */
    @Override
    public void onProductDataResponse(final ProductDataResponse response) {
        final ProductDataResponse.RequestStatus status = response.getRequestStatus();
        Log.d(TAG, "onProductDataResponse: RequestStatus (" + status + ")");

        switch (status) {
        case SUCCESSFUL:
            Log.d(TAG, "onProductDataResponse: successful.  The item data map in this response includes the valid SKUs");
            final Set<String> unavailableSkus = response.getUnavailableSkus();
            Log.d(TAG, "onProductDataResponse: " + unavailableSkus.size() + " unavailable skus");
       //     iapManager.enablePurchaseForSkus(response.getProductData());
       //     iapManager.disablePurchaseForSkus(response.getUnavailableSkus());
            break;
        case FAILED:
        case NOT_SUPPORTED:
            Log.d(TAG, "onProductDataResponse: failed, should retry request");
      //      iapManager.disableAllPurchases();
            break;
        }
    }

    /**
     * This is the callback for {@link PurchasingService#getPurchaseUpdates}.
     * 
     * We will receive Consumable receipts from this callback if the consumable
     * receipts are not marked as "FULFILLED" in Amazon Appstore. So for every
     * single Consumable receipts in the response, we need to call
     * {@link SampleIAPManager#handleReceipt} to fulfill the purchase.
     * 
     */
    @Override
    public void onPurchaseUpdatesResponse(final PurchaseUpdatesResponse response) {
        Log.d(TAG, "onPurchaseUpdatesResponse: requestId (" + response.getRequestId()
                   + ") purchaseUpdatesResponseStatus ("
                   + response.getRequestStatus()
                   + ") userId ("
                   + response.getUserData().getUserId()
                   + ")"
				   +response.toString()
				   );
        final PurchaseUpdatesResponse.RequestStatus status = response.getRequestStatus();
        switch (status) {
        case SUCCESSFUL:
        //    iapManager.setAmazonUserId(response.getUserData().getUserId(), response.getUserData().getMarketplace());
			
			
		
            for (final Receipt receipt : response.getReceipts()) {
      //          iapManager.handleReceipt(receipt, response.getUserData());
	  
				String [] keys ={"id"};
				double [] dvals ={(double)2001};

				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
				RunnerJNILib.DsMapAddString(dsmapindex,"receipt_type",receipt.getProductType().toString());
				RunnerJNILib.DsMapAddString(dsmapindex,"receipt_id",receipt.getReceiptId());
				RunnerJNILib.DsMapAddString(dsmapindex,"receipt_sku",receipt.getSku());
				RunnerJNILib.DsMapAddDouble(dsmapindex,"receipt_cancelled",receipt.isCanceled()?1:0);
				RunnerJNILib.DsMapAddString(dsmapindex,"receipt_full",receipt.toString());
				
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
	  
	  
	  
            }
            if (response.hasMore()) {
                PurchasingService.getPurchaseUpdates(false);
            }
      //      iapManager.refreshOranges();
            break;
        case FAILED:
        case NOT_SUPPORTED:
            Log.d(TAG, "onProductDataResponse: failed, should retry request");
     //       iapManager.disableAllPurchases();
            break;
        }

    }

    /**
     * This is the callback for {@link PurchasingService#purchase}. For each
     * time the application sends a purchase request
     * {@link PurchasingService#purchase}, Amazon Appstore will call this
     * callback when the purchase request is completed. If the RequestStatus is
     * Successful or AlreadyPurchased then application needs to call
     * {@link SampleIAPManager#handleReceipt} to handle the purchase
     * fulfillment. If the RequestStatus is INVALID_SKU, NOT_SUPPORTED, or
     * FAILED, notify corresponding method of {@link SampleIAPManager} .
     */
    @Override
    public void onPurchaseResponse(final PurchaseResponse response) {
        final String requestId = response.getRequestId().toString();
        final String userId = response.getUserData().getUserId();
        final PurchaseResponse.RequestStatus status = response.getRequestStatus();
        Log.d(TAG, "onPurchaseResponse: requestId (" + requestId
                   + ") userId ("
                   + userId
                   + ") purchaseRequestStatus ("
                   + status
                   + ")");

        switch (status) {
        case SUCCESSFUL:
            final Receipt receipt = response.getReceipt();
  //          iapManager.setAmazonUserId(response.getUserData().getUserId(), response.getUserData().getMarketplace());
            Log.d(TAG, "onPurchaseResponse: receipt json:" + receipt.toJSON());
			
			String [] keys ={"id"};
			double [] dvals ={(double)2001};

			int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
			RunnerJNILib.DsMapAddString(dsmapindex,"receipt_type",receipt.getProductType().toString());
			RunnerJNILib.DsMapAddString(dsmapindex,"receipt_id",receipt.getReceiptId());
			RunnerJNILib.DsMapAddString(dsmapindex,"receipt_sku",receipt.getSku());
			RunnerJNILib.DsMapAddDouble(dsmapindex,"receipt_cancelled",receipt.isCanceled()?1:0);
			RunnerJNILib.DsMapAddString(dsmapindex,"receipt_full",receipt.toString());
			
			
			RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
			
			return;
   //        iapManager.handleReceipt(receipt, response.getUserData());
   //         iapManager.refreshOranges();
        case ALREADY_PURCHASED:
            Log.d(TAG, "onPurchaseResponse: already purchased, should never get here for a consumable.");
			
			
            // This is not applicable for consumable item. It is only
            // application for entitlement and subscription.
            // check related samples for more details.
            break;
        case INVALID_SKU:
            Log.d(TAG,
                  "onPurchaseResponse: invalid SKU!  onProductDataResponse should have disabled buy button already.");
            final Set<String> unavailableSkus = new HashSet<String>();
            unavailableSkus.add(response.getReceipt().getSku());
  //          iapManager.disablePurchaseForSkus(unavailableSkus);
            break;
        case FAILED:
        case NOT_SUPPORTED:
            Log.d(TAG, "onPurchaseResponse: failed so remove purchase request from local storage");
   //         iapManager.purchaseFailed(response.getReceipt().getSku());
            break;
        }

		String [] keys ={"id"};
		double [] dvals ={(double)2002};

		int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
		RunnerJNILib.DsMapAddString(dsmapindex,"purchase_status",status.toString());
		RunnerJNILib.DsMapAddDouble(dsmapindex,"request_hash",(double)(requestId.hashCode()));
		RunnerJNILib.DsMapAddString(dsmapindex,"request_user",userId.toString());
		RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
		
    }
	
	
}


