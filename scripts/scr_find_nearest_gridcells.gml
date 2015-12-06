///scr_find_nearest_gridcells(grid x, grid y, count, list, unoccupied only) 

var originX = argument[0];
var originY = argument[1];
var findCount = argument[2];
var foundList = argument[3]; //list of confirmed nearest cells
var emptiesOnly = argument[4];

//Adjust origin to be within gamegrid
var spotX = clamp(round(originX),0,fieldW-1);
var spotY = clamp(round(originY),0,fieldH-1);
//We will use the pqueue heap to track valid cells
//and each iteration add the min to the valid list
//and add its adjacent cells not in the done list to the queue
var pQueue = ds_priority_create(); //heap holding cells and euclidean distances
var checkList = ds_list_create(); //cells to check
var checkedList = ds_list_create(); //cells already checked

//If spot/origin cell is valid, add to lists and decrement
if gamecell_is_valid(spotX,spotY) and (!emptiesOnly or scr_isEmptyCell(spotX,spotY)) {
    ds_list_add(foundList,scr_create_array(spotX, spotY));
    ds_list_add(checkedList,scr_create_array(spotX, spotY));
    findCount -= 1
}
//Add all cells adjacent to spot/origin to checklist
scr_add_adjoining_cells(spotX,spotY,checkedList,checkList,emptiesOnly);

//Loop through check list until enough found
while findCount > 0{ 
    //Check euclidean distance of each cell in toCheckList
    for (var i=ds_list_size(checkList)-1;i>=0;i--){
        var gridXY = checkList[| i];
        var dist = point_distance(originX,originY,gridXY[0], gridXY[1]);
        //add to priority queue by distance
        ds_priority_add(pQueue,gridXY,dist)
        ds_list_add(checkedList,gridXY)
        ds_list_delete(checkList,i)
    }
    //Add nearest cell to the foundlist
    var found;
    if ds_priority_size(pQueue) > 0{
        foundXY = ds_priority_delete_min(pQueue);
        ds_list_add(foundList,foundXY);
        findCount -= 1;
        scr_add_adjoining_cells(foundXY[0], foundXY[1], checkedList,checkList,emptiesOnly);
    }
    //If no valid cell found, return error
    else show_message('finding error in board mixer')
}



//Garbage Collect
ds_priority_destroy(pQueue)
ds_list_destroy(checkedList)
ds_list_destroy(checkList)
