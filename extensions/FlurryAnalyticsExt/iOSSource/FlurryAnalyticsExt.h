//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//

@interface FlurryAnalyticsExt:NSObject
{
	NSString*	appId;
	bool		initCalled;
}
-(void)FlurryAnalytics_Init:(char*)_apiKey;
-(double)FlurryAnalytics_SendEvent:(char*)_eventName;
-(double)FlurryAnalytics_SendEventExt:(char*)_eventName Arg2:(char*)_keyValuePairs;
-(bool)FlurryAnalytics_HasSession;

@end
