//
//  HeyZapExt.h
//  iOS Extension
//
//  Created by Vitaliy Sidorov on 10/10/2015.
//
//

#import <HeyzapAds/HeyzapAds.h>

@interface HeyZapExt : NSObject 
{
}

- (void) HeyZap_Init:(char *)_app_id Arg2:(double)istest;
- (void) HeyZap_AddBanner:(double)_pos;
- (void) HeyZap_RemoveBanner;
- (double) HeyZap_BannerGetWidth;
- (double) HeyZap_BannerGetHeight;
- (void) HeyZap_ShowInterstitial;
- (void) HeyZap_LoadInterstitial;
- (double) HeyZap_InterstitialStatus;
- (void) HeyZap_ShowVideo;
- (void) HeyZap_LoadVideo;
- (double) HeyZap_VideoStatus;
- (void) HeyZap_ShowReward;
- (void) HeyZap_LoadReward;
- (double) HeyZap_RewardStatus;
- (void) sendCallbacks:(char *)type Arg2:(double)value;

@end