//
//  Released by YoYo Games Ltd. on ??/09/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//

package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.RunnerActivity;
import com.yoyogames.runner.RunnerJNILib;
import android.util.Log;
import java.util.Map;
import java.util.HashMap;

import com.flurry.android.FlurryAgent;

public class FlurryAnalyticsExt extends ExtensionBase
{
	private String m_apiKey=null;
	private boolean m_bSessionActive = false;

	public void FlurryAnalytics_Init(String _apiKey )
	{
		m_apiKey = _apiKey;
		Log.i("yoyo", "FlurryAnalytics_Init: apiKey:" + m_apiKey );
		int version = FlurryAgent.getAgentVersion();
   		Log.i("yoyo", "Flurry Agent Version = " + version );
		
		//enable logging if you wish
		FlurryAgent.setLogEnabled(true);
		FlurryAgent.setLogLevel(Log.VERBOSE);
		
		//start the session
		FlurryAgent.setLogEvents(true);
		FlurryAgent.onStartSession( RunnerActivity.CurrentActivity, m_apiKey );
		m_bSessionActive = true;
	}
	
	public void FlurryAnalytics_SendEvent(String _eventName)
	{
		if( m_bSessionActive )
		{
			Log.i("yoyo", "Flurry SendEvent: " + _eventName );
			FlurryAgent.logEvent( _eventName );
		}
	}
	
	public void FlurryAnalytics_SendEventExt(String _eventName, String _keyValuePairs )
	{
		if( m_bSessionActive )
		{
			String[] kvp = _keyValuePairs.split( ",");
			Map<String, String> params = new HashMap<String, String>();
			for( int n=0; n < (kvp.length/2)*2; n+=2)
			{
				params.put( kvp[n], kvp[n+1]);
			}

			Log.i("yoyo", "Flurry SendEventExt: eventName:" + _eventName + " params:" + params);
			FlurryAgent.logEvent( _eventName, params );
		}
	}
	
	//lifecycle methods
	@Override
	public void onStart()
	{
		//restart the session
		if( !m_bSessionActive && m_apiKey != null)
		{
			//start the session
			Log.i("yoyo", "FlurryExt: restarting session for key:" + m_apiKey );
			FlurryAgent.onStartSession( RunnerActivity.CurrentActivity, m_apiKey );
			m_bSessionActive = true;
		}
	}		
	
	@Override
	public void onStop()
	{
		//stop the session 
		if( m_bSessionActive )
		{
			Log.i("yoyo", "FlurryExt: ending session for key:" + m_apiKey );
			FlurryAgent.onEndSession( RunnerActivity.CurrentActivity );
			m_bSessionActive = false;
		}
	}		
	
	
	

}


