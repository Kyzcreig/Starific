*************************
*** DispatchGMS 1.0.0 ***
*************************

Stephen Loney
stephen@8bitwarrior.com

------
[NOTE]
------

Please see the included [Demo Project] and [Script Reference] for additional help.


-------------
[Dispatchers]
-------------

Dispatchers can be created using DispatcherCreate().
	
	dispatcher = DispatcherCreate();

It is your responsibility to ensure that dispatchers are destroyed when
you are finished with them. Otherwise, memory leaks will occur.

It is suggested to call DispatcherDestroy() in an objects Destroy and Room Event events

	/// Destroy and Room End Events
	if (DispatcherExists(dispatcher))
	{
		DispatcherDestroy(dispatcher);
	}

Script callbacks can be added to dispatchers by using DispatcherAdd() or DispatcherInsert().
Callback id handles are returned. Up to 13 arguments can be passed to the script.

	cb1 = DispatcherAdd(dispatcher, id, ShootBullet);
	cb2 = DispatcherInsert(dispatcher, id, AddAmmo, 15);

When dispatchers are destroyed, all callbacks associated with it will also be destroyed.
However, during the life of the dispatcher, it is your responsibility to remove any callbacks
when they are no longer needed. A failure to do so can result in unwanted memory usage
and potentially slow performance in the extreme case that many callbacks are added and never removed.
Callbacks can be removed by calling DispatcherRemove()

	if (DispatcherCallbackExists(callback))
	{
		DispatcherRemove(dispatcher, callback);
	}

Dispatcher callbacks can be executed by calling DispatcherInvoke() or DispatcherInvokeExt()

	DispatcherAdd(dispatcher, id, ShowMessage, "Hello");
	DispatcherInvoke(dispatcher);
	DispatcherInvokeExt(dispatcher, "Bye") // Override argument passed to script


----------------
[Dynamic Events]
----------------

Dynamic event scripts are a convenient way to easily associate dispatchers with existing object events.

Objects must declare that they will use dynamic events by calling DynamicEventsRegister();

	/// Create Event
	DynamicEventsRegister(id);

Like regular dispatchers, it is up to you to clear dynamic events when finished with them.
This can be done by calling DyanmicEventsUnregister().

	/// Destroy Event
	DynamicEventsUnregister(id);

	/// Room End Event
	if (persistent == false && room_persistent == false)
	{
    		DynamicEventsUnregister(id);
	}

Any event you want to be dynamic must call DynamicEventCall() from an object's specified event.

	/// Release Key Enter
	DynamicEventCall(ev_keyrelease, vk_enter);

To call the dynamic event of a different object, use with().

	with(obj_Player) DynamicEventCall(ev_mouse, ev_left_button);

It is up to extend dynamic events as needed for each object.














