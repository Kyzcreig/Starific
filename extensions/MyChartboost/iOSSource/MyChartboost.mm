/*

  Developer: Algene Pulido
  Organization: Geneal Games
  
  This code is sole created by the developer. 
  Any libraries are registered to their respective owners.
  You cannot modify this code and redistribute or resale.
  
  This is published only in yoyo games marketplace.
*/
#import "MyChartboost.h"
#include <asl.h>
#include <stdio.h>


@implementation MyChartboost

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);

- (void) Init:(NSString *)arg0 Arg2:(NSString *)arg1
{
    // Initialize the Chartboost library
    [Chartboost startWithAppId:arg0
                  appSignature:arg1
                      delegate:self];
					  
}

- (void) showInterstitial
{
	[Chartboost showInterstitial:CBLocationDefault];
	
	//[self ReturnAsync:0 Arg2:didDisplayInterstitial];
}

- (void) cacheInterstitial
{
	[Chartboost cacheInterstitial:CBLocationDefault];
}

- (void) showMoreApps
{
	[Chartboost showMoreApps:CBLocationDefault];
	
	//[self ReturnAsync:1 Arg2:didDisplayMoreApps];
}

- (void) cacheMoreApps
{
	[Chartboost cacheMoreApps:CBLocationDefault];
}

- (void) showRewardedVideo
{
	[Chartboost showRewardedVideo:CBLocationDefault];
	
	//[self ReturnAsync:2 Arg2:didDisplayRewardedVideo];
}

- (void )cacheRewardedVideo
{
	[Chartboost cacheRewardedVideo:CBLocationDefault];
}

//INTERSTITIAL DELEGATE METHODS
// Called before requesting an interstitial via the Chartboost API server.
- (BOOL)shouldRequestInterstitial:(CBLocation)location
{
	[self ReturnAsync:0 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: shouldRequestInterstitial");
    return true;
}

// Called before an interstitial will be displayed on the screen.
- (BOOL)shouldDisplayInterstitial:(CBLocation)location
{
	[self ReturnAsync:1 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: shouldDisplayInterstitial");
    return true;
}

// Called after an interstitial has been displayed on the screen.
- (void)didDisplayInterstitial:(CBLocation)location
{
	[self ReturnAsync:2 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDisplayInterstitial");
}

// Called after an interstitial has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheInterstitial:(CBLocation)location
{
	[self ReturnAsync:3 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCacheInterstitial");
}

// Called after an interstitial has attempted to load from the Chartboost API
// servers but failed.
 - (void)didFailToLoadInterstitial:(CBLocation)location
                         withError:(CBLoadError)error
{
	[self ReturnAsync:4 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didFailToLoadInterstitial");
}

// Called after a click is registered, but the user is not forwarded to the App Store.
- (void)didFailToRecordClick:(CBLocation)location
                   withError:(CBClickError)error
{
	[self ReturnAsync:5 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didFailToRecordClick");
}

// Called after an interstitial has been dismissed.
- (void)didDismissInterstitial:(CBLocation)location
{
	[self ReturnAsync:6 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDismissInterstitial");
}

// Called after an interstitial has been closed.
- (void)didCloseInterstitial:(CBLocation)location
{
	[self ReturnAsync:7 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCloseInterstitial");
}

// Called after an interstitial has been clicked.
- (void)didClickInterstitial:(CBLocation)location
{
	[self ReturnAsync:8 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didClickInterstitial");
}


//MORE APPS DELEGATE METHODS
// Called before a MoreApps page will be displayed on the screen.
- (BOOL)shouldDisplayMoreApps:(CBLocation)location
{
	[self ReturnAsync:9 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: shouldDisplayMoreApps");
    return true;
}

// Called after a MoreApps page has been displayed on the screen.
- (void)didDisplayMoreApps:(CBLocation)location;
{
	[self ReturnAsync:10 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDisplayMoreApps");
}

// Called after a MoreApps page has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheMoreApps:(CBLocation)location
{
	[self ReturnAsync:11 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCacheMoreApps");
}

// Called after a MoreApps page has been dismissed.
- (void)didDismissMoreApps:(CBLocation)location
{
	[self ReturnAsync:12 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDismissMoreApps");
}

// Called after a MoreApps page has been closed.
- (void)didCloseMoreApps:(CBLocation)location
{
	[self ReturnAsync:13 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCloseMoreApps");
}

// Called after a MoreApps page has been clicked.
- (void)didClickMoreApps:(CBLocation)location
{
	[self ReturnAsync:14 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didClickMoreApps");
}

// Called after a MoreApps page attempted to load from the Chartboost API
// servers but failed.
- (void)didFailToLoadMoreApps:(CBLocation)location
                    withError:(CBLoadError)error
{
	[self ReturnAsync:15 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didFailToLoadMoreApps");
}

//REWARDED VIDEO DELEGATE
// Called before a rewarded video will be displayed on the screen.
- (BOOL)shouldDisplayRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:16 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: shouldDisplayRewardedVideo");
    return true;
}

// Called after a rewarded video has been displayed on the screen.
- (void)didDisplayRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:17 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDisplayRewardedVideo");
}

// Called after a rewarded video has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:18 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCacheRewardedVideo");
}

// Called after a rewarded video has attempted to load from the Chartboost API
// servers but failed.
- (void)didFailToLoadRewardedVideo:(CBLocation)location
                         withError:(CBLoadError)error
{
	[self ReturnAsync:19 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didFailToLoadRewardedVideo");
}

// Called after a rewarded video has been dismissed.
- (void)didDismissRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:20 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didDismissRewardedVideo");
}

// Called after a rewarded video has been closed.
- (void)didCloseRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:21 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCloseRewardedVideo");
}

// Called after a rewarded video has been clicked.
- (void)didClickRewardedVideo:(CBLocation)location
{
	[self ReturnAsync:22 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didClickRewardedVideo");
}

// Called after a rewarded video has been viewed completely and user is eligible for reward.
- (void)didCompleteRewardedVideo:(CBLocation)location
                      withReward:(int)reward
{
	[self ReturnAsync:23 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: didCompleteRewardedVideo");
}

// Implement to be notified of when a video will be displayed on the screen for 
// a given CBLocation. You can then do things like mute effects and sounds.
- (void)willDisplayVideo:(CBLocation)location
{
	[self ReturnAsync:24 Arg2:1];
	NSLog(@"yoyo: %@",@"ReturnAsync: willDisplayVideo");
}


- (void)ReturnAsync:(int)arg0 Arg2:(double)arg1
{
	int dsMapIndex=0;
	
	switch(arg0)
	{
		case 0:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "shouldRequestInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 1:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "shouldDisplayInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 2:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDisplayInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 3:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCacheInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 4:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didFailToLoadInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 5:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didFailToRecordClick",
			"value", arg1, (void*)NULL);
		break;
		case 6:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDismissInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 7:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCloseInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 8:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didClickInterstitial",
			"value", arg1, (void*)NULL);
		break;
		case 9:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "shouldDisplayMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 10:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDisplayMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 11:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCacheMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 12:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDismissMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 13:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCloseMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 14:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didClickMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 15:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didFailToLoadMoreApps",
			"value", arg1, (void*)NULL);
		break;
		case 16:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "shouldDisplayRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 17:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDisplayRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 18:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCacheRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 19:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didFailToLoadRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 20:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didDismissRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 21:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCloseRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 22:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didClickRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 23:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "didCompleteRewardedVideo",
			"value", arg1, (void*)NULL);
		break;
		case 24:
			dsMapIndex = CreateDsMap(2,
			"type", 0.0, "willDisplayVideo",
			"value", arg1, (void*)NULL);
		break;
		
	}
	CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);

}

- (void) dealloc
{
    [super dealloc];
}

@end
