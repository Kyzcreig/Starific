//
//  HeyZapExt.mm
//  iOS Extension
//
//  Created by Vitaliy Sidorov on 10/10/2015.
//
//

#import "HeyZapExt.h"
#import <HeyzapAds/HeyzapAds.h>
#import <UIKit/UIKit.h>

@interface HeyZapExt ()<HZAdsDelegate, HZIncentivizedAdDelegate>
@end

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
	[HeyzapAds startWithPublisherID: g_AppId];
	if (_istest == 1) {
		[HeyzapAds presentMediationDebugViewController];
	}
	[HZInterstitialAd setDelegate:self];
	[HZVideoAd setDelegate:self];
	[HZIncentivizedAd setDelegate:self];
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
	
- (void)didReceiveAdWithTag:(NSString *)tag {
    [self sendCallbacks:(char *)"heyzap_ad_loaded" Arg2:1];
}

- (void)didFailToReceiveAdWithTag:(NSString *)tag {
    [self sendCallbacks:(char *)"heyzap_ad_loaded" Arg2:0];
}

- (void) didCompleteAdWithTag: (NSString *)tag {
	[self sendCallbacks:(char *)"heyzap_reward" Arg2:1];
}
 
- (void) didFailToCompleteAdWithTag: (NSString *)tag {
	[self sendCallbacks:(char *)"heyzap_reward" Arg2:0];
}


@end
