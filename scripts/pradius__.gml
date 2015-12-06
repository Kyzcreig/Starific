///pradius__(value)
/* NB: We could probably factor this out as the paddle no longer draws on the easing rail...


*/


//RAIL_ANGLES[0] = 90 * ((fieldH - (corner * 1.5)) / fieldH)
//RAIL_ANGLES[1] = 90 - RAIL_ANGLES[0]


pradiusx = pradius*argument[0]
pradiusy = pradius*argument[0]

startangle = RAIL_ANGLES[0]/2////22.5
angle = startangle
for (i=0;i<8;i++){
    vertx[i] = argument[0]*pradiusx*dcos((angle));
    verty[i] = argument[0]*pradiusy*dsin((angle));
    tvertx[i] = argument[0]*(pradiusx+PADDLE_H/2)*dcos((angle));
    tverty[i] = argument[0]*(pradiusy+PADDLE_H/2)*dsin((angle));
    angle+=RAIL_ANGLES[(i+1) mod 2];
}
