//
//  GMEveryplay.mm
//  GMEveryplay
//
//  Created by Benoît Rouleau and Alex Gierczyk.
//
//

#import "GMEveryplay.h"

static UIViewController *gmeveryplay_rootViewController = nil;


@implementation GMEveryplay


- (void)everyplay_init:(NSString *)clientId :(NSString *)clientSecret {
    //NSLog(@"everyplay_init");
    gmeveryplay_rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [Everyplay setClientId:clientId clientSecret:clientSecret redirectURI:@"https://m.everyplay.com/auth"];
    [Everyplay initWithDelegate:self andParentViewController:gmeveryplay_rootViewController];
}




- (void)everyplay_start_recording {
    //NSLog(@"everyplay_start_recording");
    if (![self everyplay_is_recording]) {
        [[[Everyplay sharedInstance] capture] startRecording];
    }
}

- (void)everyplay_stop_recording {
    //NSLog(@"everyplay_stop_recording");
    if ([self everyplay_is_recording]) {
        [[[Everyplay sharedInstance] capture] stopRecording];
    }
}

- (int)everyplay_is_recording {
    //NSLog(@"everyplay_is_recording");
    if ([[[Everyplay sharedInstance] capture] isRecording]) {
        return 1;
    }
    return 0;
}

- (void)everyplay_play_last_recording {
    //NSLog(@"everyplay_play_last_recording");
    [[Everyplay sharedInstance] playLastRecording];
}

- (void)everyplay_set_metadata:(NSString *)key :(NSString *)value {
    //[[Everyplay sharedInstance] mergeSessionDeveloperData:@{@key : @value}];
    [[Everyplay sharedInstance] mergeSessionDeveloperData:@{key : value}];
}


- (void)everyplay_show_everyplay {
    //NSLog(@"everyplay_show_everyplay");
    [[Everyplay sharedInstance] showEveryplay];
}

- (void)everyplay_show_share_modal {
    //NSLog(@"everyplay_show_share_modal");
    [[Everyplay sharedInstance] showEveryplaySharingModal];
}

- (void)everyplayShown {
}

- (void)everyplayHidden {
}

- (void)everyplayRecordingStarted {
}

- (void)everyplayRecordingStopped {

}

- (void)everyplayFaceCamSessionStarted {
}

- (void)everyplayFaceCamSessionStopped {
}

@end