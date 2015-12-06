///scr_exit_page(duration)

var tDur = argument0;

// Exit Tween
mainTween = TweenFire(id, mainEase,EaseLinear,
                TWEEN_MODE_ONCE,1,0,tDur,mainEase[0],0);
//Destroy Page On Tween Finish
TweenAddCallback(mainTween,TWEEN_EV_FINISH, id, ScheduleScript,id, 0, 1, Destroy, id);
    //This was needed for some reason, because calling destroy on itself 
    //without a delay caused issues
