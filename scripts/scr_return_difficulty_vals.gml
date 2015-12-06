#define scr_return_difficulty_vals
///scr_return_difficulty_vals(difficulty)

var diffArray = noone;

switch argument0{ //-10, -20, -40, -80
    case 0:
        diffArray[0] = -10*power(2,argument0)//paddle size adjustment (lower is harder)
        //diffArray[1] = 10//speed_divisor (higher is easier)
        break;
    case 1:
        diffArray[0] = -10*power(2,argument0)//paddle size adjustment (lower is harder)
        //diffArray[1] = 10//speed_divisor (higher is easier)
    
        break;
    case 2:
        diffArray[0] = -10*power(2,argument0)//paddle size adjustment (lower is harder)
        //diffArray[1] = 10//speed_divisor (higher is easier)
    
        break;
    case 3:
        diffArray[0] = -10*power(2,argument0)//paddle size adjustment (lower is harder)
        //diffArray[1] = 10//speed_divisor (higher is easier)
    
        break;



}

return diffArray;

#define scr_rigor_paddle_adjustment
///scr_rigor_paddle_adjustment()


var padRigors = noone;
/*
padRigors[0] = 0;
padRigors[1] = 20;
padRigors[2] = 40;
padRigors[3] = 80;
*/
padRigors[0] = 1;
padRigors[1] = .9;
padRigors[2] = .8;
padRigors[3] = .7;


return padRigors[RIGOR];

//return 10*power(2,RIGOR)//paddle size adjustment (lower is harder)