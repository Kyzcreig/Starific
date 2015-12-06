#define make_color_hsl
/// make_color_hsl(h, s, l, use_gm_range [optional])

var h, s, l;

if argument_count = 4 and argument[3] = true
    {
    h = argument[0]/239;
    s = argument[1]/240;
    l = argument[2]/240;
    }
    else
    {
    h = argument[0]/360;
    s = argument[1]/100;
    l = argument[2]/100;
    }
    

var r, g, b;
 
if (s = 0) 
    {r = l; g = l; b = l}
    else
    { 
    var q;
    if l < 0.5
        {q = l * (1 + s)}
        else
        {q = l + s - l * s}   

    var p = 2 * l - q;
 
    r = hue_to_rgb(p, q, h + 1/3);
    g = hue_to_rgb(p, q, h);
    b = hue_to_rgb(p, q, h - 1/3);
    }

  
return make_color_rgb(round(r * 255),round(g * 255),round(b * 255))

#define color_get_hsl_hue
///color_get_hsl_hue(color, use_gm_range [optional])

var _hsl;
var use_gm_range;

if argument_count = 2 and argument[1] = true
    {use_gm_range = true}
    else
    {use_gm_range = false}
    
_hsl = rgb_to_hsl(argument[0],use_gm_range)

return _hsl[0]

/// color_get_hsl_saturation(color, use_gm_range [optional])

var _hsl;
var use_gm_range;

if argument_count = 2 and argument[1] = true
    {use_gm_range = true}
    else
    {use_gm_range = false}

_hsl = rgb_to_hsl(argument[0], use_gm_range)

return _hsl[1]



#define color_get_hsl_lightness
/// color_get_hsl_lightness(color, use_gm_range [optional])

var _hsl;
var use_gm_range;

if argument_count = 2 and argument[1] = true
    {use_gm_range = true}
    else
    {use_gm_range = false}

_hsl = rgb_to_hsl(argument[0], use_gm_range)

return _hsl[2]


#define color_change_lightness
/// color_change_lightness(color, amount, use_gm_range [optional])

/// amount: value from 0 - 100 [or 0 - 240]

var _rgb, _hsl;
var use_gm_range, _max;

if argument_count = 3 and argument[2] = true
    {use_gm_range = true
    _max = 240}
    else
    {use_gm_range = false
    _max = 100}

_hsl = rgb_to_hsl(argument[0], use_gm_range)

_hsl[2] = clamp(_hsl[2] + argument[1],0,_max)

_rgb = make_color_hsl(_hsl[0],_hsl[1],_hsl[2], use_gm_range)

return _rgb


#define color_set_lightness
/// color_set_lightness(color, amount, use_gm_range [optional])

/// amount: value from 0 - 100 [or 0 - 240]

var _rgb, _hsl;
var use_gm_range, _max;

if argument_count = 3 and argument[2] = true
    {use_gm_range = true
    _max = 240}
    else
    {use_gm_range = false
    _max = 100}

_hsl = rgb_to_hsl(argument[0], use_gm_range)

_hsl[2] = clamp(argument[1],0,_max)

_rgb = make_color_hsl(_hsl[0],_hsl[1],_hsl[2], use_gm_range)

return _rgb


#define rgb_to_hsl
/// rgb_to_hsl(color, use_gm_range [optional])
 
var r = color_get_red(argument[0])/255
var g = color_get_green(argument[0])/255
var b = color_get_blue(argument[0])/255

var _max = max(r, g, b), _min = min(r, g, b);
var h, s, l = (_max + _min) / 2;

if (_max = _min) 
    {h = 0; s = 0}
    else
    {
    var d = _max - _min;
    
    if l > 0.5
        {s = d / (2 - _max - _min)}
        else
        {s = d / (_max + _min)}
    
      switch (_max) 
      {
        case r: 
            h = (g - b) / d
            if g < b {h += 6} ; break;
        case g:
            h = (b - r) / d + 2; break;
        case b:
            h = (r - g) / d + 4; break;
      }

    h /= 6;
    }

var hsl;
    
if argument_count = 2 and argument[1] = true
    {
    hsl[0] = round(h*239)
    hsl[1] = round(s*240)
    hsl[2] = round(l*240)
    }
    else
    {  
    hsl[0] = round(h*360)
    hsl[1] = round(s*100)
    hsl[2] = round(l*100)
    }

return hsl


#define hue_to_rgb
/// hue_to_rgb(p, q, t)

var p = argument0;
var q = argument1;
var t = argument2;

if (t < 0) t += 1;
if (t > 1) t -= 1;
if (t < 1/6) return (p + (q - p) * 6 * t);
if (t < 1/2) return q;
if (t < 2/3) return (p + (q - p) * (2/3 - t) * 6);

return p;