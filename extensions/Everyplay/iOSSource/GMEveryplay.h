//
//  GMEveryplay.mm
//  GMEveryplay
//
//  Created by Benoît Rouleau and Alex Gierczyk.
//
//

#import <Everyplay/Everyplay.h>

@interface GMEveryplay : NSObject <EveryplayDelegate>

- (void)everyplay_init:(NSString *)clientId :(NSString *)clientSecret;
- (void)everyplay_start_recording;
- (void)everyplay_stop_recording;
- (int)everyplay_is_recording;
- (void)everyplay_play_last_recording;
- (void)everyplay_set_metadata:(NSString *)key :(NSString *)value;
- (void)everyplay_show_everyplay;
- (void)everyplay_show_share_modal;


@end