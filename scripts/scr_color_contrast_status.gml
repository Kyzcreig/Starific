#define scr_color_contrast_status
///scr_color_contrast_status(col 1, col 2)

var dR, dG, dB, sD;

dR = abs(colour_get_red(argument0) - colour_get_red(argument1))
dG = abs(colour_get_green(argument0) - colour_get_green(argument1))
dB = abs(colour_get_blue(argument0) - colour_get_blue(argument1))

sD = dR + dG + dB;

if sD >= 500{
    return true;
}
else{
    return false;
}

#define scr_color_luminance_status
///scr_color_luminance_status(color1,color2)



/*
http://www.w3.org/TR/WCAG20-TECHS/G17.html 
Procedure

Measure the relative luminance of each letter (unless they are all uniform) using the formula:
L = 0.2126 * R + 0.7152 * G + 0.0722 * B where R, G and B are defined as:
if R sRGB <= 0.03928 then R = R sRGB /12.92 else R = ((R sRGB +0.055)/1.055) ^ 2.4
if G sRGB <= 0.03928 then G = G sRGB /12.92 else G = ((G sRGB +0.055)/1.055) ^ 2.4
if B sRGB <= 0.03928 then B = B sRGB /12.92 else B = ((B sRGB +0.055)/1.055) ^ 2.4
and R sRGB, G sRGB, and B sRGB are defined as:

R sRGB = R 8bit /255
G sRGB = G 8bit /255
B sRGB = B 8bit /255
The "^" character is the exponentiation operator.

Note: For aliased letters, use the relative luminance value found two pixels in from the edge of the letter.

Measure the relative luminance of the background pixels immediately next to the letter using same formula.
Calculate the contrast ratio using the following formula.
(L1 + 0.05) / (L2 + 0.05), where
L1 is the relative luminance of the lighter of the foreground or background colors, and
L2 is the relative luminance of the darker of the foreground or background colors.
Check that the contrast ratio is equal to or greater than 7:1

/*
var dR, dG, dB, sD;

dR = abs(colour_get_red(argument0) - colour_get_red(argument1))
dG = abs(colour_get_green(argument0) - colour_get_green(argument1))
dB = abs(colour_get_blue(argument0) - colour_get_blue(argument1))

sD = dR + dG + dB;

if sD >= 500{
    return true;
}
else{
    return false;
}