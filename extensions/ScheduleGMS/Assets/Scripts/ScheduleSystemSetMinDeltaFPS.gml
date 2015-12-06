/// ScheduleSystemSetMinDeltaFPS(fps)

with(SharedScheduler())
{
    global.SGMS_MinDeltaFPS = argument0;
    minDeltaFPS = argument0; // The lowest framerate before delta schedules will begin to lag behind (Ideally, 10-25)
    maxDelta = 1/minDeltaFPS; // Cache delta cap
}