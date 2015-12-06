#import <Chartboost/Chartboost.h>
#import <Chartboost/CBNewsfeed.h>
//#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>


@interface MyChartboost : NSObject <ChartboostDelegate, CBNewsfeedDelegate>
{
}

- (void) Init:(NSString *)arg0 Arg2:(NSString *)arg1;
- (void) showInterstitial;
- (void) showMoreApps;
- (void) showRewardedVideo;
- (void) cacheInterstitial;
- (void) cacheMoreApps;
- (void) cacheRewardedVideo;
- (void) ReturnAsync:(int)arg0 Arg2:(double)arg1;

@end
