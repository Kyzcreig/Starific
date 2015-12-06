///string_abbrev_real_mag(real,decimals,max_magnitude)
///Returns argument0 abbreviated with a k, m etc
///eg 1344003 might become 1.34m
///Works up to quadrillions
///Created by Andrew McCluskey
var Rea=floor(real(argument0)); 
var Dec=floor(real(argument1));
var ReaMag = log10(Rea) 
var Mag = (ReaMag - argument2) >= 0 ; //power of 10
var Add=""; Div=0; Eva=0;
var Div = 1;


if Mag {
    if( ReaMag >= 15  ) 
    {
        Add="q";
        Div=power(10,15);
    }
    else if( ReaMag >= 12  ) 
    {
        Add="t";
        Div=power(10,12);
    }
    else if( ReaMag >= 9  ) 
    {
        Add="b";
        Div=power(10,9);
    }
    else if( ReaMag >= 6  ) 
    {
        Add="m";
        Div=power(10,6);
    }
    else if( ReaMag >= 3 ) 
    {
        Add="k";
        Div=power(10,3);
    }
}

Rea/=Div;
//Floor Decimal if abbreviation is integer
if frac(Rea) == 0{ 
    Dec = 0;
}
Eva=string_format(Rea,string_length(string(floor(Rea))),Dec);

return string(Eva)+Add; 
