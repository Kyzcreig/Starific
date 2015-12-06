//scr_cash_chance()
var cash_chance = noone;
var slope = 1;

switch RIGOR{ //-10, -20, -40, -80

case 0:
    var slope = 4;
    
break;

case 1:
    var slope = 3.5;

break;

case 2:
    var slope = 3;

break;

case 3:
    var slope = 2.5;

break;



}

cash_chance[0] = 1;
cash_chance[1] = 1/slope;
cash_chance[2] = 1/slope/slope;
cash_chance[3] = 1/slope/slope/slope;

return cash_chance;
