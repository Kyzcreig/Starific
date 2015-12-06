#define CreateInstance
///CreateInstance(x,y,instance)

instance_create(argument0,argument1,argument2)

#define CreateInstanceIfNone
///CreateInstanceIfNone(x,y,instance)



if !instance_exists(argument2) {
    instance_create(argument0,argument1,argument2);
}