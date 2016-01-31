///scr_menu_draw_set_easers_simple();


// SubEasers
if true {//TweenExists(mainTween) {//and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = clamp(mainEase[0]-0.5,0,1)
    subEase[2] = EaseOutBack(clamp(mainEase[0]-1.0,0,1), 0, 1, 1);
}

