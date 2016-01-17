//
//  HeyZap Extension for GameMaker: Studio
//  ver 1.0
//
//  Released by Vitaliy Sidorov on 14/01/2016
//  Copyright SilenGames, 2016.
//
//  For support please e-mail at contact@silengames.com
//

#import "HeyZapExt.h"
#import <HeyzapAds/HeyzapAds.h>
#import <UIKit/UIKit.h>

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIView *g_glView;
HZBannerAd *Adbanner;
NSString *g_AppId;
double g_BannerWidth = 0;
double g_BannerHeight = 0;

@implementation HeyZapExt

- (void) HeyZap_Init:(char *)_app_id Arg2:(double)_istest
{
	g_AppId  = [NSString stringWithCString:_app_id encoding:NSUTF8StringEncoding];
	if (_istest == 2) {
		[HeyzapAds startWithPublisherID: g_AppId andOptions: HZAdOptionsDisableAutoPrefetching];
	} else {
		[HeyzapAds startWithPublisherID: g_AppId];
	}
	if (_istest == 1) {
		[HeyzapAds presentMediationDebugViewController];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAdNotificationStatic:) name:HZMediationDidReceiveAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAdNotificationVideo:) name:HZMediationDidReceiveAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAdNotificationReward:) name:HZMediationDidReceiveAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToReceiveAdNotificationStatic:) name:HZMediationDidFailToReceiveAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToReceiveAdNotificationVideo:) name:HZMediationDidFailToReceiveAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToReceiveAdNotificationReward:) name:HZMediationDidFailToReceiveAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowAdNotificationStatic:) name:HZMediationDidShowAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowAdNotificationVideo:) name:HZMediationDidShowAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowAdNotificationReward:) name:HZMediationDidShowAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToShowAdNotificationStatic:) name:HZMediationDidFailToShowAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToShowAdNotificationVideo:) name:HZMediationDidFailToShowAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToShowAdNotificationReward:) name:HZMediationDidFailToShowAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickAdNotificationStatic:) name:HZMediationDidClickAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickAdNotificationVideo:) name:HZMediationDidClickAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickAdNotificationReward:) name:HZMediationDidClickAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideAdNotificationStatic:) name:HZMediationDidHideAdNotification object:[HZInterstitialAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideAdNotificationVideo:) name:HZMediationDidHideAdNotification object:[HZVideoAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideAdNotificationReward:) name:HZMediationDidHideAdNotification object:[HZIncentivizedAd class]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCompleteIncentivizedAdNotification:) name:HZMediationDidCompleteIncentivizedAdNotification object:[HZIncentivizedAd class]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToCompleteIncentivizedAdNotification:) name:HZMediationDidFailToCompleteIncentivizedAdNotification object:[HZIncentivizedAd class]];

}

- (void) HeyZap_AddBanner:(double)_pos
{
	if (Adbanner != nil) {
		[Adbanner removeFromSuperview];
		Adbanner = nil;
	}
	HZBannerPosition BannerVPos;
	if (_pos == 1) {
		BannerVPos = HZBannerPositionTop;
	} else {
		BannerVPos = HZBannerPositionBottom;
	}
	HZBannerAdOptions *options = [[HZBannerAdOptions alloc] init];
	[HZBannerAd placeBannerInView:g_glView
		position:BannerVPos
		options:options
		success:^(HZBannerAd *banner) {
			Adbanner = banner;
			[self sendCallbacks:(char *)"heyzap_banner_loaded" Arg2:1];
			NSLog(@"Banner Shown");
			NSString *BannerSizes = [Adbanner dimensionsDescription];
			NSArray *BannerSizesArray = [BannerSizes componentsSeparatedByString:@" "];
			g_BannerWidth = [BannerSizesArray[2] doubleValue];
			g_BannerHeight = [BannerSizesArray[3] doubleValue];
		}
		failure:^(NSError *error) {
			[self sendCallbacks:(char *)"heyzap_banner_loaded" Arg2:0];
			NSLog(@"Error = %@",error);
		}
	];
}

- (void) HeyZap_RemoveBanner
{
	if (Adbanner != nil) {
		[Adbanner removeFromSuperview];
		Adbanner = nil;
	}
}

-(double) HeyZap_BannerGetWidth
{
	return g_BannerWidth;
}

-(double) HeyZap_BannerGetHeight
{
	return g_BannerHeight;
}

- (void) HeyZap_ShowInterstitial
{
	[HZInterstitialAd show];
}

- (void) HeyZap_LoadInterstitial
{
	[HZInterstitialAd fetch];
}

- (double) HeyZap_InterstitialStatus
{
	if ([HZInterstitialAd isAvailable]) {
		return 1;
	} else {
		return 0;
	}
}

- (void) HeyZap_ShowVideo
{
	[HZVideoAd show];
}

- (void) HeyZap_LoadVideo
{
	[HZVideoAd fetch];
}

- (double) HeyZap_VideoStatus
{
	if ([HZVideoAd isAvailable]) {
		return 1;
	} else {
		return 0;
	}
}

- (void) HeyZap_ShowReward
{
	[HZIncentivizedAd  show];
}

- (void) HeyZap_LoadReward
{
	[HZIncentivizedAd  fetch];
}

- (double) HeyZap_RewardStatus
{
	if ([HZIncentivizedAd isAvailable]) {
		return 1;
	} else {
		return 0;
	}
}

- (void) sendCallbacks:(char *)type Arg2:(double)value
{
	int dsMapIndex = CreateDsMap(2,
		"type", 0.0, type,
		"value", value, (void*)NULL);
	CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
}


- (void) didReceiveAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_loaded" Arg2:1];
}
- (void) didReceiveAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_loaded" Arg2:1];
}
- (void) didReceiveAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_loaded" Arg2:1];
}


- (void) didFailToReceiveAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_loaded" Arg2:0];
}
- (void) didFailToReceiveAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_loaded" Arg2:0];
}
- (void) didFailToReceiveAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_loaded" Arg2:0];
}


- (void) didShowAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_shown" Arg2:1];
}
- (void) didShowAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_shown" Arg2:1];
}
- (void) didShowAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_shown" Arg2:1];
}


- (void) didFailToShowAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_shown" Arg2:0];
}
- (void) didFailToShowAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_shown" Arg2:0];
}
- (void) didFailToShowAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_shown" Arg2:0];
}


- (void) didClickAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_clicked" Arg2:1];
}
- (void) didClickAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_clicked" Arg2:1];
}
- (void) didClickAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_clicked" Arg2:1];
}


- (void) didHideAdNotificationStatic: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_ad_hidden" Arg2:1];
}
- (void) didHideAdNotificationVideo: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_video_hidden" Arg2:1];
}
- (void) didHideAdNotificationReward: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward_hidden" Arg2:1];
}


- (void) didCompleteIncentivizedAdNotification: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward" Arg2:1];
}
- (void) didFailToCompleteIncentivizedAdNotification: (NSNotification *)notification {
	[self sendCallbacks:(char *)"heyzap_reward" Arg2:0];
}

- (void) dealloc
{
    [super dealloc];
}

@end
