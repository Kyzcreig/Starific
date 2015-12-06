//---------------------------------------------------
// Version 1.0.3 -- December 13, 2014
// Stephen Loney
// stephen@8bitwarrior.com
//---------------------------------------------------

------------------
 Important Notes
------------------

--
#0
--
A demo project can be found at [Extensions] -> [ScheduleGMS] -> Demo_Project.gmz


--
#1
--
DO NOT create an instance of obj_SharedTweener.
This object will be automatically created when needed.


--
#2
--
There are 5 main scheduling types. Their corresponding script calls are:

	ScheduleAlarm() -- Overrides the built-in alarm timer and calls the specified alarm event (0-11)

	ScheduleScript() -- Schedules a script with optional arguments (script,arg0,arg1,...)

	ScheduleEventUser() -- Schedules a target's user event (0-15)

	ScheduleEvent() -- Schedules any specified event of the target (type,numb)

	ScheduleEventObject() -- Schedules any event of a specified object index (obj,type,numb)
	** Uses the target's environment when calling object event**

There are 5 additional scheduling types:

	SchedulePath()
	
	ScheduleTimeLine()
	
	ScheduleSound()

	ScheduleSoundOn()

	ScheduleSoundAt()


--
#3
--
By default, schedule timers will not count down if their target becomes deactivated by using
one of GameMaker's deactivation functions. However, you can override this by calling:

	TweenSetForceCount()

Note, however, that callbacks will NOT be executed if the timer finishes while the target is still deactivated.

You can set the default behaviour of new schedules by calling:

	TweenDefaultSetForceCount()

All schedule calls after this will use the indicated default value.


--
#4
--
Schedule targets can be an instance id or an object index.
Supplying an object index will have the script or event called for each instance of the type.

	// Schedule only for one instance
	player = instance_create(0, 0, obj_Player);
	ScheduleScript(player, true, 3, DoDance, DANCE_SWING);

	// Schedule script call for all instances of a type
	ScheduleScript(obj_Torch, true, 3, SetVisible, true);

Please understand this and be aware of how it can greatly affect desired results.


--
#5
--
You can tell a schedule to repeat a set number of times using:

	ScheduleSetRepeat()

Supplying the repeat value as '-1' will have the schedule repeat endlessly.
	





