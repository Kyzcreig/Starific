//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//

#import "FlurryAnalyticsExt.h"
#import "Flurry.h"
@implementation FlurryAnalyticsExt

-(bool)FlurryAnalytics_HasSession
{
	if (!initCalled) {
        NSLog(@"Flurry session not active: You need to call FlurryAnalytics_Init(\"<APP_ID>\")");
		return false;
	}
	
	if (([Flurry activeSessionExists]==false) || ([Flurry getSessionID]==0)) {
        NSLog(@"Flurry session not active: Attempting to start a new session");
		[Flurry startSession:appId];
		return false;
	}
	return true;
}

-(void)FlurryAnalytics_Init:(char*)_apiKey
{
    appId = [NSString stringWithUTF8String:_apiKey];
	initCalled = true;
    NSLog(@"---FlurryAnalytics_Init---");
    //[Flurry setDebugLogEnabled:YES]
    //[Flurry setLogLevel:FlurryLogLevelDebug];
    [Flurry startSession:appId];
}

-(double)FlurryAnalytics_SendEvent:(char*)_eventName
{
    NSString* nsEventName = [NSString stringWithUTF8String:_eventName];
    NSLog(@"---FlurryAnalytics_SendEvent: Event: %@---",nsEventName );
    if ([self FlurryAnalytics_HasSession]) {
        [Flurry logEvent:nsEventName];
        return 1;
    }
    return 0;
}

-(double)FlurryAnalytics_SendEventExt:(char*)_eventName Arg2:(char*)_keyValuePairs
{
	//extract params from dsMap...
	NSString* nsEventName = [NSString stringWithUTF8String:_eventName];
	NSString* params = [NSString stringWithUTF8String:_keyValuePairs];
	NSArray* kvp = [params componentsSeparatedByString:@","];
	int count = [kvp count] / 2;
	
	NSMutableDictionary* dict = [NSMutableDictionary dictionary];
	for( int n=0; n < count*2; n+=2)
	{
		NSString* key = kvp[n];
		NSString* val = kvp[n+1];
		NSLog(@"Adding kvp %@:%@", key,val);
		dict[key] = val;
	}
    
    NSLog(@"---FlurryAnalytics_SendEventExt:event:%@ params:%@---",nsEventName, dict );
    if ([self FlurryAnalytics_HasSession]) {
        [Flurry logEvent:nsEventName withParameters:dict];
        return 1;
    }
    return 0;
}

@end