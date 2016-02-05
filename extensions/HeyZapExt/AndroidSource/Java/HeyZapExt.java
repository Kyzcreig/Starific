//
//  HeyZap Extension for GameMaker: Studio
//  ver 1.0
//
//  Released by Vitaliy Sidorov on 14/01/2016
//  Copyright SilenGames, 2016.
//
//  For support please e-mail at contact@silengames.com
//

package ${YYAndroidPackageName};

import android.util.Log;
import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.String;

import com.heyzap.sdk.ads.HeyzapAds;
import com.heyzap.sdk.ads.InterstitialAd;
import com.heyzap.sdk.ads.VideoAd;
import com.heyzap.sdk.ads.IncentivizedAd;
import com.heyzap.sdk.ads.BannerAd;
import com.heyzap.sdk.ads.BannerAdView;
import com.heyzap.sdk.ads.HeyzapAds.BannerListener;
import com.heyzap.sdk.ads.HeyzapAds.BannerError;
import com.heyzap.sdk.ads.HeyzapAds.OnStatusListener;

import android.view.ViewGroup;
import android.view.View;
import android.widget.AbsoluteLayout;
import android.widget.FrameLayout;

import android.annotation.TargetApi;
import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.MotionEvent;
import android.view.View;
import android.view.Gravity;

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;
//import android.support.multidex.MultiDexApplication;


public class HeyZapExt extends Activity {

private static final int EVENT_OTHER_SOCIAL = 70;
private String app_id;
private BannerAdView bannerAdView = null;

	public void HeyZap_Init(String _app_id, double istest) {
		app_id = _app_id;
		Log.i("yoyo","Calling HeyZap with "+_app_id);
		if (istest == 1) {
			HeyzapAds.start(app_id, RunnerActivity.CurrentActivity);
			HeyzapAds.startTestActivity(RunnerActivity.CurrentActivity);
			Log.i("yoyo","HeyZap Test Mode Enabled");
		} else if (istest == 2) {
			HeyzapAds.start(app_id, RunnerActivity.CurrentActivity, HeyzapAds.DISABLE_AUTOMATIC_FETCH);
			Log.i("yoyo","HeyZap Auto Fetch Disabled");
		} else if (istest == 3) {
			HeyzapAds.start(app_id, RunnerActivity.CurrentActivity, HeyzapAds.AMAZON);
			Log.i("yoyo","HeyZap Amazon Enabled");
		} else {
			HeyzapAds.start(app_id, RunnerActivity.CurrentActivity);
		}						
		Log.i("yoyo","HeyZap Init Success!");
		setupCallbacks();
	}
	
	public void HeyZap_AddBanner(double _pos) {
		final int BannerVPos = (int)_pos;
		if (BannerVPos == 1) {
			BannerAd.display(RunnerActivity.CurrentActivity, Gravity.TOP);
			Log.i("yoyo","HeyZap Show Banner TOP!");
		} else {
			BannerAd.display(RunnerActivity.CurrentActivity, Gravity.BOTTOM);
			Log.i("yoyo","HeyZap Show Banner BOTTOM!");
		}
		bannerAdView = BannerAd.getCurrentBannerAdView();
		BannerAd.setBannerListener(new BannerListener() {
			@Override
			public void onAdClicked(BannerAdView b) {
				sendCallbacks("heyzap_banner_clicked", 1);
				Log.i("yoyo","HeyZap Banner CLICK!");
			}
	 
			@Override
			public void onAdLoaded(BannerAdView b) {
				sendCallbacks("heyzap_banner_loaded", 1);
				Log.i("yoyo","HeyZap Banner LOADED!");
			}
	 
			@Override
			public void onAdError(BannerAdView b, BannerError bannerError) {
				sendCallbacks("heyzap_banner_loaded", 0);
				Log.i("yoyo","HeyZap Banner NOT LOADED!");
			}
		});
	}
	
	public void HeyZap_RemoveBanner() {
		BannerAd.hide();
	}
	
	public double HeyZap_BannerGetWidth() {
		Log.i("yoyo","Banner Height - "+bannerAdView.getMeasuredWidth());
		return bannerAdView.getMeasuredWidth();
	}
	
	public double HeyZap_BannerGetHeight() {
		Log.i("yoyo","Banner Height - "+bannerAdView.getMeasuredHeight());
		return bannerAdView.getMeasuredHeight();
	}
	
	public void HeyZap_LoadInterstitial() {
		RunnerActivity.ViewHandler.post( new Runnable() {
			public void run() {
				InterstitialAd.fetch();
			}
		});
    }

    public void HeyZap_ShowInterstitial() {
        InterstitialAd.display(RunnerActivity.CurrentActivity); 
    }

	public double HeyZap_InterstitialStatus() {
        if (InterstitialAd.isAvailable()) {
			return 1;
		} else {
			return 0;
		}
    }

    public void HeyZap_LoadVideo() {
		RunnerActivity.ViewHandler.post( new Runnable() {
			public void run() {
				VideoAd.fetch();
			}
		});
    }

    public void HeyZap_ShowVideo() {
        VideoAd.display(RunnerActivity.CurrentActivity);
    }

	public double HeyZap_VideoStatus() {
        if (VideoAd.isAvailable()) {
			return 1;
		} else {
			return 0;
		}
    }
	
    public void HeyZap_LoadReward() {
		RunnerActivity.ViewHandler.post( new Runnable() {
			public void run() {
				IncentivizedAd.fetch();
			}
		});
    }

    public void HeyZap_ShowReward() {
        IncentivizedAd.display(RunnerActivity.CurrentActivity);
    }
	
	public double HeyZap_RewardStatus() {
        if (IncentivizedAd.isAvailable()) {
			return 1;
		} else {
			return 0;
		}
    }
	
	//CALLBACKS
	
	protected void sendCallbacks(String _type, double _value) {
		int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
		RunnerJNILib.DsMapAddString( dsMapIndex, "type", _type);
		RunnerJNILib.DsMapAddDouble( dsMapIndex, "value", _value);
		RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
	}
	
	protected void setupCallbacks() {

		InterstitialAd.setOnStatusListener(new HeyzapAds.OnStatusListener() {
		
            @Override
            public void onAvailable(String tag) {
                Log.i("yoyo","HeyZap Ad Loaded!");
				sendCallbacks("heyzap_ad_loaded", 1);
            }
			
            @Override
            public void onShow(String tag) {
                Log.i("yoyo","HeyZap Ad Shown!");
				sendCallbacks("heyzap_ad_shown", 1);
            }
			
            @Override
            public void onClick(String tag) {
                Log.i("yoyo","HeyZap Ad Clicked!");
				sendCallbacks("heyzap_ad_clicked", 1);
            }

            @Override
            public void onHide(String tag) {
                Log.i("yoyo","HeyZap Ad Hidden!");
				sendCallbacks("heyzap_ad_hidden", 1);
            }

            @Override
            public void onFailedToFetch(String tag) {
                Log.i("yoyo","HeyZap Ad Failed To Load!");
				sendCallbacks("heyzap_ad_loaded", 0);
            }

            @Override
            public void onFailedToShow(String tag) {
                Log.i("yoyo","HeyZap Ad Failed To Show!");
				sendCallbacks("heyzap_ad_shown", 0);
            }
			
			@Override
			public void onAudioStarted() {
				Log.i("yoyo","HeyZap Ad Audio Started!");
			}
		 
			@Override
			public void onAudioFinished() {
				Log.i("yoyo","HeyZap Ad Audio Finished!");
			}

        });

		VideoAd.setOnStatusListener(new HeyzapAds.OnStatusListener() {
		
            @Override
            public void onAvailable(String tag) {
                Log.i("yoyo","HeyZap Video Loaded!");
				sendCallbacks("heyzap_video_loaded", 1);
            }
			
            @Override
            public void onShow(String tag) {
                Log.i("yoyo","HeyZap Video Shown!");
				sendCallbacks("heyzap_video_shown", 1);
            }
			
            @Override
            public void onClick(String tag) {
                Log.i("yoyo","HeyZap Video Clicked!");
				sendCallbacks("heyzap_video_clicked", 1);
            }

            @Override
            public void onHide(String tag) {
                Log.i("yoyo","HeyZap Video Hidden!");
				sendCallbacks("heyzap_video_hidden", 1);
            }

            @Override
            public void onFailedToFetch(String tag) {
                Log.i("yoyo","HeyZap Video Failed To Load!");
				sendCallbacks("heyzap_video_loaded", 0);
            }

            @Override
            public void onFailedToShow(String tag) {
                Log.i("yoyo","HeyZap Video Failed To Show!");
				sendCallbacks("heyzap_video_shown", 0);
            }

			@Override
			public void onAudioStarted() {
				Log.i("yoyo","HeyZap Video Audio Started!");
			}
		 
			@Override
			public void onAudioFinished() {
				Log.i("yoyo","HeyZap Video Audio Finished!");
			}
        });
		
		IncentivizedAd.setOnStatusListener(new HeyzapAds.OnStatusListener() {
		
            @Override
            public void onAvailable(String tag) {
                Log.i("yoyo","HeyZap Reward Loaded!");
				sendCallbacks("heyzap_reward_loaded", 1);
            }
			
            @Override
            public void onShow(String tag) {
                Log.i("yoyo","HeyZap Reward Shown!");
				sendCallbacks("heyzap_reward_shown", 1);
            }
			
            @Override
            public void onClick(String tag) {
                Log.i("yoyo","HeyZap Reward Clicked!");
				sendCallbacks("heyzap_reward_clicked", 1);
            }

            @Override
            public void onHide(String tag) {
                Log.i("yoyo","HeyZap Reward Hidden!");
				sendCallbacks("heyzap_reward_hidden", 1);
            }

            @Override
            public void onFailedToFetch(String tag) {
                Log.i("yoyo","HeyZap Reward Failed To Load!");
				sendCallbacks("heyzap_reward_loaded", 0);
            }

            @Override
            public void onFailedToShow(String tag) {
                Log.i("yoyo","HeyZap Reward Failed To Show!");
				sendCallbacks("heyzap_reward_shown", 0);
            }

			@Override
			public void onAudioStarted() {
				Log.i("yoyo","HeyZap Reward Audio Started!");
			}
		 
			@Override
			public void onAudioFinished() {
				Log.i("yoyo","HeyZap Reward Audio Finished!");
			}
        });

        HeyzapAds.OnIncentiveResultListener incentiveResultListener = new HeyzapAds.OnIncentiveResultListener() {

            @Override
            public void onComplete(String tag) {
                Log.i("yoyo","HeyZap Give Reward!");
				sendCallbacks("heyzap_reward", 1);
            }

            @Override
            public void onIncomplete(String tag) {
				Log.i("yoyo","HeyZap No Reward!");
				sendCallbacks("heyzap_reward", 0);
            }
        };

        IncentivizedAd.setOnIncentiveResultListener(incentiveResultListener);
    }
	
	@Override
	public void onBackPressed() {
		Log.i("yoyo","BACK BACK BACK");
		if(HeyzapAds.onBackPressed()) {
			return;
		}
	}

}

