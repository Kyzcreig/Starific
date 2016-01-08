///tutorial_set_frameCount()


frameCount = 0;
if MODE == MODES.ARCADE{
   frameCount = 7;
}
else if MODE == MODES.MOVES{
   frameCount = 5;
}
else if MODE == MODES.TIME{
   frameCount = 3;
}
else if MODE == MODES.SANDBOX{
   frameCount = 1;
}
