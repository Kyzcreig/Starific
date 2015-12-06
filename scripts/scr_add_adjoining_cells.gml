///scr_add_adjoining_cells(gX,gY,checkedList,checkList, unoccupied, recursions)
//Find thes the adjoining cells and adds them to the
//checklist

var gX = argument[0]
var gY = argument[1]
var checkedList = argument[2]
var checkList = argument[3]
var emptiesOnly = argument[4]
var recursions, checkX, checkY;
if argument_count > 5 {
    recursions = argument[5];
}
else {
    recursions = 0;
}


//Check all adjacent cells for validity
for (var i=-1;i<=1;i++)
{
    for (var j=-1;j<=1;j++)
    {
        //If cell = origin, skip
        if i==0 and j==0{ continue}
        checkX = gX+i; 
        checkY = gY+j;
        

        if gamecell_is_on_grid(checkX,checkY){
        
            //If already checked, skip
            if scr_field_list_find(checkX, checkY, checkedList) != -1 {continue}
            
            //If already flagged to check, skip
            if scr_field_list_find(checkX, checkY, checkList) != -1 {continue}
            
            //If not valid cell skip but check neighbors
            if !gamecell_is_valid(checkX,checkY){
                
                ds_list_add(checkedList,scr_create_array(checkX,checkY));
                //var newEmpties = (emptiesOnly==0)*emptiesOnly + (emptiesOnly!=0)*(emptiesOnly+1)
                               //if empties is 0, we keep it zero.  else we add 1 to it to denote recursion level.
                //if emptiesOnly <= 0{ //< 6
                scr_add_adjoining_cells(checkX,checkY,checkedList,checkList,emptiesOnly,recursions+1);//newEmpties);
                //}
                
                continue;
            }
            //If empties flag and not empty cell, skip but add proxy cells to check
            else if emptiesOnly and !scr_isEmptyCell(checkX,checkY){
            
                ds_list_add(checkedList,scr_create_array(checkX,checkY));
                
                //max # of recursions
                if recursions < 2{//NB: Any higher than this really lags bad on mobile
                    //or ds_list_size(checkList) < 5{
                    scr_add_adjoining_cells(checkX,checkY,checkedList,checkList,emptiesOnly,recursions+1);
                }
                
                continue;
            }
            
            //Add valid cell to checkList
            ds_list_add(checkList,scr_create_array(checkX,checkY));

        }
    }
}

//If all else fails ignore emptiesOnly restriction
if emptiesOnly and recursions == 0 and ds_list_empty(checkList){

   ds_list_clear(checkedList); //reset checkedList so we can check it again
   ds_list_add(checkList,scr_create_array(gX,gY)); //since we normally skip this cell
   scr_add_adjoining_cells(gX,gY,checkedList,checkList,0);
   
}











