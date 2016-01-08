//
//  GMEveryplay.mm
//  GMEveryplay
//
//  Created by Benoît Rouleau and Alex Gierczyk.
//
//


package ${YYAndroidPackageName};

import com.everyplay.Everyplay.Everyplay;
import com.everyplay.Everyplay.EveryplayFaceCamPreviewOrigin;
import com.everyplay.Everyplay.EveryplayFaceCamColor;
import com.everyplay.Everyplay.IEveryplayListener;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.util.Log;
import android.view.View;




public class GMEveryplay implements IEveryplayListener {
	
	public static int sdk = 0;
	public static Activity activity = null;
	public static View rootView = null;
	public static Handler viewHandler = null;

    public void everyplay_init(String clientId, String clientSecret) {
        Log.i("yoyo", "everyplay_init");
        sdk = android.os.Build.VERSION.SDK_INT;
        activity = RunnerActivity.CurrentActivity;
        rootView = activity.findViewById(android.R.id.content);
        viewHandler = RunnerActivity.ViewHandler;
        Everyplay.configureEveryplay(clientId, clientSecret, "https://m.everyplay.com/auth");
        Everyplay.initEveryplay(this, activity);
    }

    public void everyplay_set_metadata(String key, String value) {
        Log.i("yoyo", "everyplay_set_metadata");

        JSONObject data = new JSONObject();
        try {
            data.put(key, value);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        Everyplay.mergeSessionDeveloperData(data);
    }
    
    public void everyplay_start_recording() {
        Log.i("yoyo", "everyplay_start_recording");
        if (everyplay_is_recording() == 0) {
            Everyplay.startRecording();
        }
    }

    public void everyplay_stop_recording() {
        Log.i("yoyo", "everyplay_stop_recording");
        if (everyplay_is_recording() == 1) {
            Everyplay.stopRecording();
        }
    }

    public double everyplay_is_recording() {
        //Log.i("yoyo", "everyplay_is_recording");
        if (Everyplay.isRecording()) {
            return 1;
        }
        return 0;
    }
	public void everyplay_play_last_recording() {
		Log.i("yoyo", "everyplay_play_last_recording");
		Everyplay.playLastRecording();
	}

    /*
    public void everyplay_facecam_start_recording() {
        Log.i("yoyo", "everyplay_facecam_start_recording");
        //TO DO
        if (everyplay_facecam_is_recording() == 0) {
            if (Everyplay.FaceCam.isRecordingPermissionGranted()) {
                Everyplay.setMaxRecordingMinutesLength(1); //maybe increase this
                Everyplay.FaceCam.setPreviewPositionX(16);
                Everyplay.FaceCam.setPreviewPositionY(16);
                Everyplay.FaceCam.setPreviewSideWidth(128);
                Everyplay.FaceCam.setPreviewBorderWidth(4);
                Everyplay.FaceCam.setPreviewBorderColor(new EveryplayFaceCamColor(1, 0.3f, 1, 1.0f));
                // Everyplay.FaceCam.setAudioOnly(true);
                Everyplay.FaceCam.setPreviewOrigin(EveryplayFaceCamPreviewOrigin.BOTTOM_RIGHT);
                Log.i("yoyo", "everyplay_facecam_start_recording: started");
                Everyplay.FaceCam.startSession();
            } else {
                Everyplay.FaceCam.requestRecordingPermission();
                Log.i("yoyo", "everyplay_facecam_start_recording: permission requested");
            }
        }
    }
    

    public void everyplay_facecam_stop_recording() {
        Log.i("yoyo", "everyplay_facecam_stop_recording");
        if (everyplay_facecam_is_recording() == 1) {
            Everyplay.FaceCam.stopSession();
        }
    }

    public double everyplay_facecam_is_recording() {
        //Log.i("yoyo", "everyplay_is_recording");
        if (Everyplay.FaceCam.isSessionRunning()) {
            return 1;
        }
        return 0;
    }
    */

	public void everyplay_show_everyplay() {
		Log.i("yoyo", "everyplay_show_everyplay");
		Everyplay.showEveryplay();
	}


    public void everyplay_show_share_modal() {
        Log.i("yoyo", "everyplay_show_everyplay");
        Everyplay.showEveryplaySharingModal();
    }

    @Override
    public void onEveryplayShown() {
        Log.i("yoyo", "onEveryplayShown");
    }

    @Override
    public void onEveryplayHidden() {
        Log.i("yoyo", "onEveryplayHidden");
    }

    @Override
    public void onEveryplayReadyForRecording(int enabled) {
        Log.i("yoyo", "onEveryplayReadyForRecording: " + enabled);
    }

    @Override
    public void onEveryplayRecordingStarted() {
        Log.i("yoyo", "onEveryplayRecordingStarted");
    }

    @Override
    public void onEveryplayRecordingStopped() {
        Log.i("yoyo", "onEveryplayRecordingStopped");
    }

    @Override
    public void onEveryplayFaceCamSessionStarted() {
        Log.i("yoyo", "onEveryplayFaceCamSessionStarted");
    }

    @Override
    public void onEveryplayFaceCamRecordingPermission(int granted) {
        Log.i("yoyo", "onEveryplayFaceCamRecordingPermission: " + granted);
    }

    @Override
    public void onEveryplayFaceCamSessionStopped() {
        Log.i("yoyo", "onEveryplayFaceCamSessionStopped");
    }

    @Override
    public void onEveryplayUploadDidStart(int videoId) {
        Log.i("yoyo", "onEveryplayUploadDidStart: " + videoId);
    }

    @Override
    public void onEveryplayUploadDidProgress(int videoId, double progress) {
    }

    @Override
    public void onEveryplayUploadDidComplete(int videoId) {
        Log.i("yoyo", "onEveryplayUploadDidComplete: " + videoId);
    }

    @Override
    public void onEveryplayThumbnailReadyAtTextureId(int textureId, int portraitMode) {
        Log.i("yoyo", "onEveryplayThumbnailReadyAtTextureId: " + textureId + " portraitMode: " + portraitMode);
    }

    @Override
    public void onEveryplayAccountDidChange() {
    	Log.i("yoyo", "onEveryplayAccountDidChange");
    }
	
}