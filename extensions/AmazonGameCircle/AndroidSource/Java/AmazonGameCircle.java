//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//


package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.RunnerActivity;
import com.yoyogames.runner.RunnerJNILib;

import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import com.amazon.ags.*;
import com.amazon.ags.api.*;
import com.amazon.ags.api.achievements.*;
import com.amazon.ags.api.leaderboards.*;
import com.amazon.ags.api.player.*;
import com.amazon.ags.api.whispersync.*;
import com.amazon.ags.api.whispersync.model.*;
import com.amazon.device.iap.PurchasingListener;
import com.amazon.device.iap.PurchasingService;
import com.amazon.device.iap.model.RequestId;
import com.amazon.device.iap.model.FulfillmentResult;
import com.amazon.ags.api.overlay.PopUpLocation;
import com.amazon.device.ads.AdRegistration;
import com.amazon.device.ads.InterstitialAd;
import com.amazon.device.ads.AdLayout;
import com.amazon.device.ads.AdProperties.AdType;
import com.amazon.device.ads.AdProperties;
import com.amazon.device.ads.AdSize;
import java.util.EnumSet;
import java.util.List;
import java.util.Date;
import android.content.Intent;
import java.util.Set;
import java.util.HashSet;
import android.widget.AbsoluteLayout;
import android.widget.LinearLayout;
import com.amazon.device.ads.AdTargetingOptions;
import com.amazon.device.ads.*;
import com.amazon.ags.api.RequestResponse;

import java.text.DateFormat;
import com.amazon.ags.constants.LeaderboardFilter;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;

public class AmazonGameCircle extends RunnerSocial
{
	int EVENT_OTHER_SOCIAL = 70;
 
	int e_achievement_our_info=1002;
	int e_achievement_friends_info=1003;
	int e_achievement_msg_result=1014;
	int e_achievement_leaderboard_info=1004;
	int e_achievement_achievement_info=1005;
	
	
	int AmazonGameCircle_Achievements=1;
	int AmazonGameCircle_Leaderboards=2;
	int AmazonGameCircle_Whispersync=4;
	int AmazonGameCircle_Progress=8;
	int AmazonGameCircle_IAP=16;
	
	
	Set<String> ourSkus=new HashSet<String>();;
	
	private AdLayout adView=null;
	private InterstitialAd interstitialAd=null;
	//private String BannerId;
	private String InterstitialId;
	private String InterstitialStatus = "Not Ready";
	private String TestDeviceId;
	private boolean bUseTestAds=false;
	private AdProperties.AdType BannerSize;
	private int BannerXPos;
	private int BannerYPos;
	
	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		Log.i("yoyo","onActivityResult called in AmazonGameCircle extension");
	
	}
	
	AmazonGamesClient agsClient;
	AGSignedInListener signInListener = new AGSignedInListener()
	{
		@Override
		public void onSignedInStateChange(boolean isSignedIn)
		{
			Log.i("yoyo","onSignedInStateChange called with isSignedIn=" + isSignedIn);
			
			if(isSignedIn)
			{
				PlayerClient pClient = agsClient.getPlayerClient();
		
				if(pClient!=null)
				{	
					AGResponseHandle<RequestPlayerResponse> handle = pClient.getLocalPlayer();
					handle.setCallback(playercallback);	
				}
			}
			else
			{
				//Ping an async message with not signed in details
				
				String [] keys ={"id"};
				double [] dvals ={(double)e_achievement_our_info};

				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
				RunnerJNILib.DsMapAddString(dsmapindex,"name","");
				RunnerJNILib.DsMapAddString(dsmapindex,"playerid","-1");
				RunnerJNILib.DsMapAddString(dsmapindex,"avatar_url","");
				
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
			}
			
		}
	};
	
	AmazonGamesCallback callback = new AmazonGamesCallback() 
	{
		@Override
		public void onServiceNotReady(AmazonGamesStatus status) 
		{
			//unable to use service
			Log.i("yoyo","Unable to initialise AmazonGamesClient - service not ready. Status="+status);
		}
		@Override
		public void onServiceReady(AmazonGamesClient amazonGamesClient) 
		{
			agsClient = amazonGamesClient;
			Log.i("yoyo","Service Ready callback called");
			
			agsClient.getPlayerClient().setSignedInListener(signInListener);
			
			PlayerClient pClient = agsClient.getPlayerClient();
		
			if(pClient!=null)
			{	
				AGResponseHandle<RequestPlayerResponse> handle = pClient.getLocalPlayer();
				handle.setCallback(playercallback);	
				Log.i("yoyo","Requested our info callback");
			}
			
			agsClient.setPopUpLocation(PopUpLocation.TOP_CENTER); //Can go BOTTOM_CENTER BOTTOM_LEFT BOTTOM_RIGHT TOP_CENTER TOP_LEFT TOP_RIGHT
            //ready to use GameCircle
		}
	};
	
	
	
	
	AGResponseCallback scorecallback = new AGResponseCallback<SubmitScoreResponse>() 
	{
	
		@Override
		public void onComplete(SubmitScoreResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error updating score " + result);
			}
			else
			{
			   // Continue game flow.
			   Log.i("yoyo","Successfully updated leaderboard score " + result);
			}
		}
	
	};
	
	
	AGResponseCallback playercallback = new AGResponseCallback<RequestPlayerResponse>()
	{	
		@Override
		public void onComplete(RequestPlayerResponse result)
		{
			if(result.isError())
			{
				Log.i("yoyo","Error retrieving GameCircle player information");
			}
			else
			{
				Log.i("yoyo","GameCircle player information retrieved");
				Player p = result.getPlayer();
				
				String [] keys ={"id"};
				double [] dvals ={(double)e_achievement_our_info};

				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
				RunnerJNILib.DsMapAddString(dsmapindex,"name",p.getAlias());
				RunnerJNILib.DsMapAddString(dsmapindex,"playerid",p.getPlayerId());
				RunnerJNILib.DsMapAddString(dsmapindex,"avatar_url",p.getAvatarUrl());
				
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
			
			}
		}			
	};
	
	AGResponseCallback showcallback = new AGResponseCallback<RequestResponse>()
	{
		@Override 
		public void onComplete(RequestResponse result)
		{
			if(result.isError())
			{
				Log.i("yoyo","Show Dialog response is error");
				Log.i("yoyo","Error returns as " + result.getError());
			}
			
			Log.i("yoyo","Show Dialog callback with response " + result.toString());
		}
		
		
	};
	AGResponseCallback achcallback = new AGResponseCallback<UpdateProgressResponse>() 
	{
	
		@Override
		public void onComplete(UpdateProgressResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error updating achievement progress " + result);
			}
			else
			{
			   // Continue game flow.
			   Log.i("yoyo","Successfully updated achievement progress " + result);
			}
		}
	
	};
	
	EnumSet<AmazonGamesFeature> myGameFeatures=EnumSet.noneOf(AmazonGamesFeature.class);
	
	public void AmazonGameCircle_ShowLoginDialog()
	{
		Log.i("yoyo","Calling to show sign in page");
		if(agsClient!=null)
			agsClient.showSignInPage();
	}
	
	public void AmazonGameCircle_Show()
	{
		Log.i("yoyo","Calling to show ui");
		
		RunnerActivity.ViewHandler.post( new Runnable() {
		public void run() 
		{
		
			if(agsClient!=null)
			{
				AGResponseHandle<RequestResponse> handle = agsClient.showGameCircle();
				handle.setCallback(showcallback);	
				
			}
		}});
	}
	
	@Override
	public void onResume()
	{
		Log.i("yoyo","Attempting to re-initialize Amazon Game Circle in onResume call");
//		if(agsClient==null)
			AmazonGamesClient.initialize(RunnerActivity.CurrentActivity, callback, myGameFeatures);
	
	}
	
	public void AmazonGameCircle_SetAppKey(String appid)
	{
		AdRegistration.setAppKey(appid);
	}
	
	@Override
	public void onPause()
	{
		if(agsClient!=null)
		{
			agsClient.release();
		}
	}
	
	
	public void AmazonGameCircle_InitFeatures(double dfeatures)
	{
		int features = (int)dfeatures;
	
		Log.i("yoyo","Initialising GameCircle feature set " + features);
		
		myGameFeatures.clear();
		if((features & AmazonGameCircle_Achievements) >0)
			myGameFeatures.add(AmazonGamesFeature.Achievements);
	
		if((features & AmazonGameCircle_Leaderboards)>0)
			myGameFeatures.add(AmazonGamesFeature.Leaderboards);
		
		if((features & AmazonGameCircle_Whispersync)>0)
			myGameFeatures.add(AmazonGamesFeature.Whispersync);
		
		if((features & AmazonGameCircle_Progress)>0)
			myGameFeatures.add(AmazonGamesFeature.Progress);
		
		Log.i("yoyo","Attempting to initialize Amazon Game Circle via extension");
		AmazonGamesClient.initialize(RunnerActivity.CurrentActivity, callback, myGameFeatures);
		
	
		if((features & AmazonGameCircle_Whispersync)>0)
		{
			AmazonGamesClient.getWhispersyncClient().setWhispersyncEventListener(wsEventListener);
		}		
		
		if((features & AmazonGameCircle_IAP)>0)
		{
			final AmazonIAP iap_listener = new AmazonIAP();
			PurchasingService.registerListener(RunnerJNILib.ms_context,iap_listener);
			Log.i("yoyo", "IS_SANDBOX_MODE:" + PurchasingService.IS_SANDBOX_MODE);
		}
			
		Log.i("yoyo", "Done init features");
	}
	
	@Override
	public void Init()
	{
	}
	
	public void AmazonGameCircle_GetPurchasesData()
	{
		PurchasingService.getUserData();
		PurchasingService.getPurchaseUpdates(false);
	}
	
	public void AmazonGameCircle_Login()
	{
		Log.i("yoyo","Login to Amazon Game Circle is now done at initialisation");
	}

	public void AmazonGameCircle_AchievementProgress(String achid, double progress)
	{
		// Replace YOUR_ACHIEVEMENT_ID with an actual achievement ID from your game.
		if(agsClient!=null)
		{
			AchievementsClient acClient = agsClient.getAchievementsClient();
			AGResponseHandle<UpdateProgressResponse> handle = acClient.updateProgress(achid, (float)progress);
	 
			// Optional callback to receive notification of success/failure.
			handle.setCallback(achcallback);	
		}
		
	}
	
	public void AmazonGameCircle_ShowAchievements()
	{
		if(agsClient!=null)
		{
			AchievementsClient acClient = agsClient.getAchievementsClient();
			acClient.showAchievementsOverlay();
		}
	}
	
	
	public void AmazonGameCircle_PostLeaderboardScore(String leaderboard_id, double score)
	{
		if(agsClient!=null)
		{
			LeaderboardsClient lbClient = agsClient.getLeaderboardsClient();
			AGResponseHandle<SubmitScoreResponse> handle = lbClient.submitScore(leaderboard_id, (long)score);
 
			// Optional callback to receive notification of success/failure.
			handle.setCallback(scorecallback);
		}
	}
	
	
	
	
	public void AmazonGameCircle_ShowLeaderboards()
	{
		if(agsClient!=null)
		{
			LeaderboardsClient lbClient = agsClient.getLeaderboardsClient();
			lbClient.showLeaderboardsOverlay();   
		}
	}
	
	
	public double AmazonGameCircle_IsSignedIn()
	{
		if(agsClient==null)
			return 0;
	
		PlayerClient pClient = agsClient.getPlayerClient();
		
		if(pClient!=null)
			if(pClient.isSignedIn())
				return 1.0;
		return 0;
	}
	
	AGResponseCallback friendsdatacallback = new AGResponseCallback<RequestFriendsResponse>() 
	{
	
		@Override
		public void onComplete(RequestFriendsResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error retrieving friend data " + result);
			}
			else
			{
			   // Continue game flow.
			   Log.i("yoyo","Successfully received friend data " + result);
			   List<Player> friends = result.getFriends();
			   int numfriends = friends.size();
			   
			 	
				String [] keys ={"id"};
				double [] dvals ={(double)e_achievement_friends_info};

				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
				RunnerJNILib.DsMapAddDouble(dsmapindex,"friends_num",numfriends);
							
					
				for(int i=0;i<numfriends;i++)
				{
					Player p = friends.get(i);
					RunnerJNILib.DsMapAddString(dsmapindex,"friend_alias"+i,p.getAlias());
					RunnerJNILib.DsMapAddString(dsmapindex,"friend_player_id"+i,p.getPlayerId());
					RunnerJNILib.DsMapAddString(dsmapindex,"friend_player_avatarurl"+i,p.getAvatarUrl());
				
				}
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
			   
			  
			   
			}
		}
	
	};
	
	
	AGResponseCallback friendsidscallback = new AGResponseCallback<RequestFriendIdsResponse>() 
	{
	
		@Override
		public void onComplete(RequestFriendIdsResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error retrieving friend ids " + result);
			}
			else
			{
			   // Continue game flow.
			   Log.i("yoyo","Successfully received friend ids, about to request player structures " + result);
			   PlayerClient pClient = agsClient.getPlayerClient();
			   List<String> friendids = result.getFriends();
			   
			   if(friendids.size()==0)
			   {
					String [] keys ={"id"};
					double [] dvals ={(double)e_achievement_friends_info};

					int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
					RunnerJNILib.DsMapAddDouble(dsmapindex,"friends_num",0);
					RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
			   }
			   else
			   { 
					AGResponseHandle<RequestFriendsResponse> handle = pClient.getBatchFriends(friendids);
					handle.setCallback(friendsdatacallback);
			   }
			   
			}
		}
	
	};
	
	
	public void AmazonGameCircle_GetFriends()
	{
		if(agsClient!=null)
		{
			PlayerClient pClient = agsClient.getPlayerClient();
			AGResponseHandle<RequestFriendIdsResponse> handle = pClient.getFriendIds();
			handle.setCallback(friendsidscallback);
		}
 
	
	}
	
	
	AGResponseCallback scorescallback = new AGResponseCallback<GetScoresResponse>() 
	{
	
		@Override
		public void onComplete(GetScoresResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error retrieving leaderboard scores " + result);
			}
			else
			{
				Leaderboard lb = result.getLeaderboard();
				double numscores = (double)result.getNumScores();
				List<Score> scorelist = result.getScores();
				
				String [] keys ={"id"};
				double [] dvals ={(double)e_achievement_leaderboard_info};

				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
				RunnerJNILib.DsMapAddString(dsmapindex,"lb_name",lb.getName());
				RunnerJNILib.DsMapAddString(dsmapindex,"lb_text",lb.getDisplayText());
				RunnerJNILib.DsMapAddString(dsmapindex,"lb_id",lb.getId());
				RunnerJNILib.DsMapAddString(dsmapindex,"lb_url",lb.getImageURL());
				RunnerJNILib.DsMapAddDouble(dsmapindex,"lb_numscores",numscores);
		//		RunnerJNILib.DsMapAddDouble(dsmapindex,"lb_scoreformat",(double)(lb.getScoreFormat())); //Doesn't seem to be documented?
				
				Log.i("yoyo","About to add leaderboard data for " + numscores+ " scores.");
				
				for(int i=0;i<numscores;i++)
				{
					Score s = scorelist.get(i);
					RunnerJNILib.DsMapAddString(dsmapindex,"lb_score"+i,s.getScoreString());
					RunnerJNILib.DsMapAddDouble(dsmapindex,"lb_rank"+i,s.getRank());
					RunnerJNILib.DsMapAddString(dsmapindex,"lb_player_alias"+i,s.getPlayer().getAlias());
					RunnerJNILib.DsMapAddString(dsmapindex,"lb_player_id"+i,s.getPlayer().getPlayerId());
					RunnerJNILib.DsMapAddString(dsmapindex,"lb_player_avatarurl"+i,s.getPlayer().getAvatarUrl());
				
				}
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
				
			}
		}
	
	};
	public void AmazonGameCircle_LoadLeaderboard(String leaderboard_id,double startindex,double endindex)
	{
		if(agsClient!=null)
		{
			LeaderboardsClient lbClient = agsClient.getLeaderboardsClient();
			
			// Options for filter are GLOBAL_ALL_TIME=0, GLOBAL_WEEK,   GLOBAL_DAY, FRIENDS_ALL_TIME
			
			AGResponseHandle<GetScoresResponse> handle = lbClient.getScores(leaderboard_id, LeaderboardFilter.GLOBAL_ALL_TIME);
			handle.setCallback(scorescallback);
		}
	}
	
	AGResponseCallback achievementscallback = new AGResponseCallback<GetAchievementsResponse>() 
	{
	
		@Override
		public void onComplete(GetAchievementsResponse result) 
		{
			if (result.isError()) 
			{
			   // Add optional error handling here.  Not strictly required
			   // since retries and on-device request caching are automatic.
			   Log.i("yoyo","Error retrieving achievements " + result);
			}
			else
			{
				
				List<Achievement> achlist = result.getAchievementsList();
				
				String [] keys ={"id"};
				double [] dvals ={(double)e_achievement_achievement_info};

				int numachs = result.getNumVisibleAchievements();
				
				int dsmapindex = RunnerJNILib.jCreateDsMap(keys,null,dvals);
						
				RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_num",numachs);
					
				
					
				for(int i=0;i<numachs;i++)
				{
					Achievement a = achlist.get(i);
					
					DateFormat df = DateFormat.getDateTimeInstance();
					Date d = a.getDateUnlocked();
					String ds;
					if(d!=null)
						ds = df.format(d);
					else
						ds= "locked";
					
					
					
					
					RunnerJNILib.DsMapAddString(dsmapindex,"ach_dateunlocked"+i,ds);
					RunnerJNILib.DsMapAddString(dsmapindex,"ach_description"+i,a.getDescription());
					RunnerJNILib.DsMapAddString(dsmapindex,"ach_id"+i,a.getId());
					RunnerJNILib.DsMapAddString(dsmapindex,"ach_imageurl"+i,a.getImageURL());
					RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_pointvalue"+i,(double)a.getPointValue());
					RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_position"+i,(double)a.getPosition());
					RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_progress"+i,(double)a.getProgress());
					RunnerJNILib.DsMapAddString(dsmapindex,"ach_title"+i,a.getTitle());
					if(a.isHidden())
					{
						RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_is_hidden"+i,1);
					}
					else
					{
						RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_is_hidden"+i,0);
					}
					if(a.isUnlocked())
					{
						RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_is_unlocked"+i,1);
					}
					else
					{
						RunnerJNILib.DsMapAddDouble(dsmapindex,"ach_is_unlocked"+i,0);
					}
				
				}
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsmapindex,EVENT_OTHER_SOCIAL);
				
			}
		}
	
	};
	public void AmazonGameCircle_LoadAchievements()
	{
		AchievementsClient acClient = agsClient.getAchievementsClient();
		
		AGResponseHandle<GetAchievementsResponse> handle = acClient.getAchievements();
		handle.setCallback(achievementscallback);
	
	}
	
	WhispersyncEventListener wsEventListener = new WhispersyncEventListener() {

		public void onNewCloudData() {
			// refresh visible game data
			Log.i("yoyo","New CloudData received");
		}
 
		// The following three methods are mainly useful for debugging purposes and don't have to be overridden
 
		public void onDataUploadedToCloud() {
			Log.i("yoyo","New CloudData uploaded");
		}
 
		public void onThrottled() {
			Log.i("yoyo","WhisperSync throttle detected");
		}
 
		public void onDiskWriteComplete() {
			Log.i("yoyo","WhisperSync diskwrite complete");
		}
	};
	
	public void AmazonGameCircle_CloudSynchronize()
	{
		AmazonGamesClient.getWhispersyncClient().synchronize();
	}
	
	public void AmazonGameCircle_CloudStringSet( String string_key,String string_to_save)
	{		
		GameDataMap gameDataMap = AmazonGamesClient.getWhispersyncClient().getGameData();
		
		SyncableString curData = gameDataMap.getLatestString(string_key);
		curData.set(string_to_save);
		Log.i("yoyo","Saving data " +string_to_save+ " for key " + string_key);
	}
	
	public String AmazonGameCircle_CloudStringGet(String string_key)
	{
		GameDataMap gameDataMap = AmazonGamesClient.getWhispersyncClient().getGameData();
		SyncableString curData = gameDataMap.getLatestString(string_key);
		Log.i("yoyo","Got " + curData.getValue() + " for key " + string_key);
		return curData.getValue();
	}
	
	public void AmazonGameCircle_CloudNumberSet(String number_key,double value)
	{
		GameDataMap gameDataMap = AmazonGamesClient.getWhispersyncClient().getGameData();
		SyncableNumber curNum = gameDataMap.getLatestNumber(number_key);
		curNum.set(value);
	}
	
	public double AmazonGameCircle_CloudNumberGet(String number_key)
	{
		GameDataMap gameDataMap = AmazonGamesClient.getWhispersyncClient().getGameData();
		SyncableNumber curNum = gameDataMap.getLatestNumber(number_key);
		return curNum.asDouble();
	}
	
	public double AmazonGameCircle_AddIAP_SKU(String sku)
	{
		if(ourSkus.contains(sku))
		{
			return -2;
		}
		if(ourSkus.size()>=100)
			return -3; //Max limit = 100 skus
			
		if(ourSkus.add(sku))
			return 1;
		else
			return -1;
		
	}
	
	public double AmazonGameCircle_GetProductData()
	{
	
		if(ourSkus.size()<=0)
			return -1;
			
		PurchasingService.getProductData(ourSkus);
		
		return 1;
	}
	
	public double AmazonGameCircle_BuyIAP_SKU(String sku)
	{
		final RequestId requestId = PurchasingService.purchase(sku);
        Log.i("yoyo", "AmazonGameCircle_BuyIAP_SKU attempting to buy " + sku + " : requestId (" + requestId + ")");
		
		return (double)requestId.hashCode();
	}
	
	
	public void AmazonGameCircle_NotifyFulfillment(String receipt_id)
	{
		PurchasingService.notifyFulfillment(receipt_id, FulfillmentResult.FULFILLED);
	}
	
	
	public void AmazonGameCircle_Init(String _Arg1)
	{
	
		InterstitialId = _Arg1;	
	}
	
	public void AmazonGameCircle_ShowInterstitial()
	{
		if(interstitialAd!=null)
		{
	
			RunnerActivity.ViewHandler.post( new Runnable() {
    		public void run() 
    		{
				Log.i("yoyo","agc showinterstitial called");
				if (!interstitialAd.isLoading()) 
				{
					RunnerActivity.CurrentActivity.runOnUiThread(new Runnable() {
						public void run() {
							interstitialAd.showAd();
						}
					});
				} 
				else
				{
					Log.i("yoyo", "Interstitial ad was not ready to be shown.");
				}
    		}});
		}
		else
			Log.i("yoyo","Show interstitial called with null interstitial");
    	
	}
	
	class InterstitialAdListener extends DefaultAdListener
    {
		@Override
        public void onAdLoaded(Ad ad, AdProperties adProperties)
        {
			Log.i("yoyo","Ad Loaded");
			InterstitialStatus="Ready";
			sendInterstitialLoadedEvent(true);
        }
 
        @Override
        public void onAdFailedToLoad(Ad ad, AdError error)
        {
            // Call backup ad network.
			Log.i("yoyo","Ad Failed to load");
			InterstitialStatus="Not Ready";
			sendInterstitialLoadedEvent(false);
        }
 
        @Override
        public void onAdDismissed(Ad ad)
        {
            // Start the level once the interstitial has disappeared.
            //startNextLevel();
			Log.i("yoyo","Ad Dismissed");
			InterstitialStatus="Not Ready";
        }
	}
	
	InterstitialAdListener adlistener;

	
	 /**
     * This class is for an event listener that tracks ad lifecycle events.
     * It extends DefaultAdListener, so you can override only the methods that you need.
     */
    class BannerAdListener extends DefaultAdListener {
        /**
         * This event is called once an ad loads successfully.
         */
        @Override
        public void onAdLoaded(final Ad ad, final AdProperties adProperties) {
           Log.i("yoyo","Banner Ad Loaded");	
			sendBannerLoadedEvent(true);
        }
    
        /**
         * This event is called if an ad fails to load.
         */
        @Override
        public void onAdFailedToLoad(final Ad ad, final AdError error) {
			 Log.i("yoyo","Banner Ad failed to load-"+error.getCode() + ":" + error.getMessage());	
			sendBannerLoadedEvent(false);
        }
    
        /**
         * This event is called after a rich media ad expands.
         */
        @Override
        public void onAdExpanded(final Ad ad) {
            Log.i("yoyo", "Ad expanded.");
            // You may want to pause your activity here.
        }
    
        /**
         * This event is called after a rich media ad has collapsed from an expanded state.
         */
        @Override
        public void onAdCollapsed(final Ad ad) {
            Log.i("yoyo", "Ad collapsed.");
            // Resume your activity here, if it was paused in onAdExpanded.
        }
    }
	
	BannerAdListener banneradlistener;
	
	private void initInterstitial()
	{
	
		interstitialAd = new InterstitialAd(RunnerActivity.CurrentActivity);
		//interstitialAd.setAdUnitId(InterstitialId);
		adlistener = new InterstitialAdListener();	
		interstitialAd.setListener(adlistener);
	}
	
	public void AmazonGameCircle_LoadInterstitial()
	{
		RunnerActivity.ViewHandler.post( new Runnable() {
    	public void run() 
    	{
			if(interstitialAd==null)
				initInterstitial();
			
			if(interstitialAd!=null)
			{
				interstitialAd.loadAd();
			}
		}});
		
	}
	
	private void sendBannerLoadedEvent( boolean _bLoaded )
	{
		
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "id", 4001 );
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "banner_load" );
		double loaded = (_bLoaded) ? 1 : 0;
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "loaded", loaded);
		
		if( _bLoaded)
		{
		
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "width",  AmazonGameCircle_BannerGetWidth());
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "height",  AmazonGameCircle_BannerGetHeight());
		}
		
		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}
	
	private void sendInterstitialLoadedEvent( boolean _bLoaded )
	{
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "id", 4002 );
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", "interstitial_load" );
		double loaded = (_bLoaded) ? 1 : 0;
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "loaded", loaded);
		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}
	
	public void AmazonGameCircle_AddBanner()
	{
		AmazonGameCircle_AddBannerAt(  0, 0);
	}
	
	public void AmazonGameCircle_AddBannerAt( double _x, double _y)
	{
		//Should possibly check appkey has been set?
		
		BannerXPos = (int)_x;
		BannerYPos = (int)_y;

		
		
		RunnerActivity.ViewHandler.post( new Runnable() {
    	public void run() 
    	{
    		AbsoluteLayout layout = (AbsoluteLayout)RunnerActivity.CurrentActivity.findViewById(R.id.ad);
			ViewGroup vg = (ViewGroup)layout;
			
			//remove existing banner
			if( adView != null )
			{
				if(vg!=null)
				{
					vg.removeView( adView );
				}
				adView.destroy();
				adView = null;
			}
			
    		//create new banner
			adView = new AdLayout(RunnerActivity.CurrentActivity);

			final LayoutParams layoutParams = new FrameLayout.LayoutParams(LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL);
       	
			adView.setLayoutParams(layoutParams);
			layout.addView(adView);

			if(banneradlistener==null)
				banneradlistener = new BannerAdListener();
			
			if(banneradlistener!=null)
				adView.setListener(banneradlistener);

			
			 AdTargetingOptions adOptions = new AdTargetingOptions();
			// Optional: Set ad targeting options here.
			
			adView.loadAd(adOptions); // Retrieves an ad on background thread

		}});
		
	}
	@Override
	public void onDestroy()
	{
		super.onDestroy();
		if(this.adView!=null)
			this.adView.destroy();
	}
	
	public void AmazonGameCircle_RemoveBanner()
	{
		if( adView != null )
		{
			RunnerActivity.ViewHandler.post( new Runnable() {
			public void run() 
		    {
				AbsoluteLayout layout = (AbsoluteLayout)RunnerActivity.CurrentActivity.findViewById(R.id.ad);
				ViewGroup vg = (ViewGroup)layout;
				if(vg!=null)
				{
					vg.removeView( adView );
				}
				adView.destroy();
				adView = null;
				
		    }});
		}
		
	}
	
	public double AmazonGameCircle_BannerGetWidth()
	{
		if( adView !=null )
		{
			int w =adView.getWidth(); 
			return w;
		}
		return 0;
	}
	
	public double AmazonGameCircle_BannerGetHeight()
	{
		if( adView !=null )
		{
			int w =adView.getHeight(); 
			return w;
		}
		return 0;
	}
	

	
	public void AmazonGameCircle_UseTestAds(  )
	{
		AdRegistration.enableTesting(true);
		AdRegistration.enableLogging(true);
	
	}
	
	public String AmazonGameCircle_InterstitialStatus()
	{
		return InterstitialStatus;
	}
	
	
	
}


