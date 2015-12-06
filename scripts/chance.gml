///chance(prob1,outcome,prob2,outcome,...)
var _rand = random(1),_sum=0,_tr,_ti=0;
for (var i=0; i<argument_count/2; ++i){
    if argument[i*2] <> -1{
        _sum += argument[i*2];
        if (_sum>=_rand) return argument[(i*2)+1]
    } else { //auto chance
        _tr[_ti++] = argument[(i*2)+1];
    }
}
//deal with auto chance
if is_array(_tr){
    return _tr[irandom(array_length_1d(_tr)-1)];
}
