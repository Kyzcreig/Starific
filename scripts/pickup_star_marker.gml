///pickup_star_marker(bool)


//Unspawn tween/effect
part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_unspawn,marker_col,1);
TweenMarker = TweenFire(id,markerTween,EaseLinear,
                        TWEEN_MODE_ONCE,1,0,.5, 1,0)

//Restore Star invetory
with(Creator_ID){
    //Reselect Star
    if argument0 {
        TweenAddCallback(other.TweenMarker,TWEEN_EV_FINISH,id,array_set_index_1d,bMSelected,0,bMStarIndex);
    }
    TweenAddCallback(other.TweenMarker,TWEEN_EV_FINISH,id,array_set_index_2d,boardMixers,bMStarIndex,0,boardMixers[bMStarIndex,0] + 1);
    //bMSelected[0] = bMStarIndex;
    //boardMixers[bMStarIndex,0] += 1;
}
TweenAddCallback(TweenMarker,TWEEN_EV_FINISH,id,Destroy, id);
ParticleDeath = false;
