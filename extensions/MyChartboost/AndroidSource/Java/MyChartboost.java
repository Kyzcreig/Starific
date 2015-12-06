/*

  Developer: Algene Pulido
  Organization: Geneal Games
  
  This code is sole created by the developer. 
  Any libraries are registered to their respective owners.
  You cannot modify this code and redistribute or resale.
  
  This is published only in yoyo games marketplace.
*/
package ${YYAndroidPackageName};

import android.util.Log;
import java.lang.String;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.view.Menu;

import com.chartboost.sdk.*;
import com.chartboost.sdk.Model.CBError.*;
import com.chartboost.sdk.Libraries.CBLogging.Level;

import com.yoyogames.runner.RunnerJNILib;
import ${YYAndroidPackageName}.R;
import ${YYAndroidPackageName}.RunnerActivity;

public class MyChartboost extends ChartboostActivity {
	
	public void Init(String appId,String appSignature){
		final String _appId = appId;
		final String _appSignature = appSignature;
		
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				
				Chartboost.startWithAppId(RunnerActivity.CurrentActivity, _appId,_appSignature);
				Chartboost.onCreate(RunnerActivity.CurrentActivity);
				Chartboost.setDelegate(new ChartboostDelegate(){
				
				
				
				
		private String TAG="yoyo";
		
		private final int EVENT_OTHER_SOCIAL = 70;
		
		private boolean debug = true;
		
		
		void ReturnAsync(String event, double val) {
			int dsMapIndex=RunnerJNILib.jCreateDsMap(null, null, null);
			RunnerJNILib.DsMapAddString( dsMapIndex, "type", event );
			RunnerJNILib.DsMapAddDouble( dsMapIndex, "value", val);
			RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
		}
		
		@Override
		public boolean shouldRequestInterstitial(String location) {
			if (debug)
				Log.i(TAG, "SHOULD REQUEST INTERSTITIAL '"+ (location != null ? location : "null"));   
			
			ReturnAsync("shouldRequestInterstitial",1);
				
			return true;
		}
	
		@Override
		public boolean shouldDisplayInterstitial(String location) {
			if (debug)
				Log.i(TAG, "SHOULD DISPLAY INTERSTITIAL '"+ (location != null ? location : "null"));
				
			ReturnAsync("shouldDisplayInterstitial",1);
			return true;
		}
	
		@Override
		public void didCacheInterstitial(String location) {
			if (debug)
				Log.i(TAG, "DID CACHE INTERSTITIAL '"+ (location != null ? location : "null"));
			ReturnAsync("didCacheInterstitial",1);
		}
	
		@Override
		public void didFailToLoadInterstitial(String location, CBImpressionError error) {
			if (debug)
				Log.i(TAG, "DID FAIL TO LOAD INTERSTITIAL '"+ (location != null ? location : "null")+ " Error: " + error.name());
			ReturnAsync("didFailToLoadInterstitial",1);
			
		}
	
		@Override
		public void didDismissInterstitial(String location) {
			if (debug)
				Log.i(TAG, "DID DISMISS INTERSTITIAL: "+ (location != null ? location : "null"));
			ReturnAsync("didDismissInterstitial",1);
		}
	
		@Override
		public void didCloseInterstitial(String location) {
			if (debug)
				Log.i(TAG, "DID CLOSE INTERSTITIAL: "+ (location != null ? location : "null"));
			ReturnAsync("didCloseInterstitial",1);
		}
	
		@Override
		public void didClickInterstitial(String location) {
			if (debug)
				Log.i(TAG, "DID CLICK INTERSTITIAL: "+ (location != null ? location : "null"));
			ReturnAsync("didClickInterstitial",1);
		}
		
		@Override
        public void didDisplayInterstitial(String location) {
			if (debug)
				Log.i("yoyo", "DID DISPLAY INTERSTITIAL: " +  (location != null ? location : "null"));
			if (location!=null){
				ReturnAsync("didDisplayInterstitial",1);
			} else {
				ReturnAsync("didDisplayInterstitial",0);
			}
        }
		
		@Override
		public boolean shouldRequestMoreApps(String location) {
			if (debug)
				Log.i(TAG, "SHOULD REQUEST MORE APPS: " +  (location != null ? location : "null"));
			
			ReturnAsync("shouldRequestMoreApps",1);
				
			return true;
		}
	
		@Override
		public boolean shouldDisplayMoreApps(String location) {
			if (debug)
				Log.i(TAG, "SHOULD DISPLAY MORE APPS: " +  (location != null ? location : "null"));
			ReturnAsync("shouldDisplayMoreApps",1);
			return true;
		}
	
		@Override
		public void didFailToLoadMoreApps(String location, CBImpressionError error) {
			if (debug)
				Log.i(TAG, "DID FAIL TO LOAD MOREAPPS " +  (location != null ? location : "null")+ " Error: "+ error.name());
			ReturnAsync("didFailToLoadMoreApps",1);
		}
	
		@Override
		public void didCacheMoreApps(String location) {
			if (debug)
				Log.i(TAG, "DID CACHE MORE APPS: " +  (location != null ? location : "null"));
			ReturnAsync("didCacheMoreApps",1);
		}
	
		@Override
		public void didDismissMoreApps(String location) {
			if (debug)
				Log.i(TAG, "DID DISMISS MORE APPS " +  (location != null ? location : "null"));
			ReturnAsync("didDismissMoreApps",1);
		}
	
		@Override
		public void didCloseMoreApps(String location) {
			if (debug)
				Log.i(TAG, "DID CLOSE MORE APPS: "+  (location != null ? location : "null"));
			ReturnAsync("didCloseMoreApps",1);
		}
	
		@Override
		public void didClickMoreApps(String location) {
			if (debug)
				Log.i(TAG, "DID CLICK MORE APPS: "+  (location != null ? location : "null"));
			ReturnAsync("didClickMoreApps",1);
		}
	
		@Override
		public void didDisplayMoreApps(String location) {
			if (debug)
				Log.i(TAG, "DID DISPLAY MORE APPS: " +  (location != null ? location : "null"));
				
			if (location!=null){
				ReturnAsync("didDisplayMoreApps",1);
			} else {
				ReturnAsync("didDisplayMoreApps",0);
			}

		}
	
		@Override
		public void didFailToRecordClick(String uri, CBClickError error) {
			if (debug)
				Log.i(TAG, "DID FAILED TO RECORD CLICK " + (uri != null ? uri : "null") + ", error: " + error.name());
			ReturnAsync("didFailToRecordClick",1);
		}
	
		@Override
		public boolean shouldDisplayRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("SHOULD DISPLAY REWARDED VIDEO: '%s'",  (location != null ? location : "null")));
				
				ReturnAsync("shouldDisplayRewardedVideo",1);
			return true;
		}
	
		@Override
		public void didCacheRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("DID CACHE REWARDED VIDEO: '%s'",  (location != null ? location : "null")));
			ReturnAsync("didCacheRewardedVideo",1);
		}
	
		@Override
		public void didFailToLoadRewardedVideo(String location,
				CBImpressionError error) {
			if (debug)
				Log.i(TAG, String.format("DID FAIL TO LOAD REWARDED VIDEO: '%s', Error:  %s",  (location != null ? location : "null"), error.name()));
		   ReturnAsync("didFailToLoadRewardedVideo",1);
		   
		}
	
		@Override
		public void didDismissRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("DID DISMISS REWARDED VIDEO '%s'",  (location != null ? location : "null")));
			ReturnAsync("didDismissRewardedVideo",1);
		}
	
		@Override
		public void didCloseRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("DID CLOSE REWARDED VIDEO '%s'",  (location != null ? location : "null")));
			ReturnAsync("didCloseRewardedVideo",1);
		}
	
		@Override
		public void didClickRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("DID CLICK REWARDED VIDEO '%s'",  (location != null ? location : "null")));
			ReturnAsync("didClickRewardedVideo",1);
		}
	
		@Override
		public void didCompleteRewardedVideo(String location, int reward) {
			if (debug)
				Log.i(TAG, String.format("DID COMPLETE REWARDED VIDEO '%s' FOR REWARD %d",  (location != null ? location : "null"), reward));
			ReturnAsync("didCompleteRewardedVideo",1);
		}
		
		@Override
		public void didDisplayRewardedVideo(String location) {
			if (debug)
				Log.i(TAG, String.format("DID DISPLAY REWARDED VIDEO: '%s'",  (location != null ? location : "null")));
			if (location!=null){
				ReturnAsync("didDisplayRewardedVideo",1);
			} else {
				ReturnAsync("didDisplayRewardedVideo",0);
			}
		}
				
				});
				
				
				
				Chartboost.onStart(RunnerActivity.CurrentActivity);
				
				Log.i("yoyo","ChartboostExt Init Success!");
			}
		});	
	}
	
	public void showInterstitial(){
		//final String tmpLocation=location;
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
			
				Chartboost.showInterstitial(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
	
	public void showMoreApps(){
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				
				Chartboost.showMoreApps(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
	
	public void showRewardedVideo(){
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				
				Chartboost.showRewardedVideo(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
	
	public void cacheInterstitial()
	{
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				Chartboost.cacheInterstitial(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
	
	public void cacheMoreApps()
	{
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				Chartboost.cacheMoreApps(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
	
	public void cacheRewardedVideo()
	{
		RunnerActivity.ViewHandler.post(new Runnable(){
		
			public void run(){
				Chartboost.cacheRewardedVideo(CBLocation.LOCATION_DEFAULT);
			}
		});
	}
}