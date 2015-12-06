//
//  GMEveryplay.mm
//  GMEveryplay
//
//  Created by Benoît Rouleau and Alex Gierczyk.
//
//

#import "GMEveryplay.h"

static UIViewController *gmeveryplay_rootViewController = nil;
//static BOOL recordingPermissionGranted = NO;


@implementation GMEveryplay

/*
{
@private
    BOOL recordingPermissionGranted;
}*/

- (void)everyplay_init:(NSString *)clientId :(NSString *)clientSecret {
    //NSLog(@"everyplay_init");
    gmeveryplay_rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [Everyplay setClientId:clientId clientSecret:clientSecret redirectURI:@"https://m.everyplay.com/auth"];
    [Everyplay initWithDelegate:self andParentViewController:gmeveryplay_rootViewController];
    //recordingPermissionGranted = NO;
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
/*
- (void)everyplay_facecam_start_recording {
    //NSLog(@"everyplay_facecam_start_recording");
    //TO DO
   
    EveryplayFaceCam *faceCam = [[Everyplay sharedInstance] faceCam];
    if (![self everyplay_facecam_is_recording]) {
        if(recordingPermissionGranted) {
            [faceCam setPreviewOrigin: EVERYPLAY_FACECAM_PREVIEW_ORIGIN_BOTTOM_RIGHT];
            [faceCam setPreviewPositionX: 16];
            [faceCam setPreviewPositionY: 16];
            [faceCam setPreviewBorderWidth: 4.0f];
            [faceCam setPreviewSideWidth: 128.0f];
            [faceCam setPreviewScaleRetina: YES];

            EveryplayFaceCamColor color;
            color.r = 1;
            color.g = 0.3;
            color.b = 1;

            [faceCam setPreviewBorderColor:color];

            // [faceCam setPreviewVisible: NO];
            // [faceCam setAudioOnly: YES];

        	[faceCam startSession];
        }
        else {
            [faceCam requestRecordingPermission];
        }
    }
}

- (void)everyplay_facecam_stop_recording {
    //NSLog(@"everyplay_facecam_stop_recording");
    if ([self everyplay_facecam_is_recording]) {
        [[[Everyplay sharedInstance] faceCam] stopSession];
    }
}

- (int)everyplay_facecam_is_recording {
    //NSLog(@"everyplay_facecam_is_recording");
    if ([[Everyplay sharedInstance] faceCam].isSessionRunning == YES) {
        return 1;
    }
    return 0;

    EveryplayFaceCam *faceCam = [[Everyplay sharedInstance] faceCam];
}

- (void)everyplayFaceCamRecordingPermission: (NSNumber *) granted {
    if([granted intValue] > 0) {
        NSLog(@"Microphone access was granted");
        recordingPermissionGranted = [granted boolValue];
        // * HERE YOU CAN SAFELY START FACECAM * //
    }
    else {
        NSLog(@"Microphone access was DENIED");
    }
}

*/


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