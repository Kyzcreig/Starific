///chance_list(listID)
var _rand = random(1),_sum=0,_tr,_ti=0;
for (var i=0; i<ds_list_size(argument0)/2; ++i){
    if ds_list_find_value(argument0,(i*2)) <> -1{
        _sum += ds_list_find_value(argument0,(i*2));
        if (_sum>=_rand) return ds_list_find_value(argument0,(i*2)+1)
    } else { //auto chance
        _tr[_ti++] = ds_list_find_value(argument0,(i*2)+1);
    }
}
//deal with auto chance
if is_array(_tr){
    return _tr[irandom(array_length_1d(_tr)-1)];
}
