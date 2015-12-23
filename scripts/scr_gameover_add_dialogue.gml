#define scr_gameover_add_dialogue
///scr_gameover_add_dialogue(dialogue_index)




ds_list_add(go_dialogue_txt, scr_go_create_dialogue(argument[0]));


#define scr_go_create_dialogue
///scr_go_create_dialogue(dialogue_id)



var newDialogue = noone;

switch argument[0] {

case 0:

break;

// Quest Progressing
case 1:
    newDialogue[0] = string_lower(scr_quest_text(1))//text
    newDialogue[1] = 0// styling (0=none)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = QUEST_DATA[0]// subtype
break;

// Quest Complete
case 2:
    newDialogue[0] = string_lower(scr_quest_text(1))//text
    newDialogue[1] = 1// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = QUEST_DATA[0]// subtype

break;

// Prize Progressing
case 3:
    newDialogue[0] = CASH_STR+string(STAR_CASH)+"/"+string(PRIZE_WHEEL_COST) 
                    + " to go for prize" //text
    newDialogue[1] = 0// styling (0=none)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;

// Unlock Text
case 4:
    newDialogue[0] = data[5]+" "+data[6]+ " unlocked"//!"//text
    newDialogue[1] = 0// styling (0=none)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = data[0]// subtype
break;


// Quest Reward Earned
case 5:
    newDialogue[0] = "earned reward +"+CASH_STR+ string(rewardValue)//text
    newDialogue[1] = 0// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;

// Gift Update Placeholder
case 6:
    newDialogue[0] = ""//text
    newDialogue[1] = 0// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;

// Gift Next Time
case 7:
    var minuteSpan = round(date_minute_span(giftNextTime,date_current_datetime()));
    var hrs = minuteSpan div 60;
    var mins = minuteSpan mod 60;
    //var hourSpan = floor(date_hour_span(giftNextTime,date_current_datetime()));
    //var minSpan = floor(date_minute_span(giftNextTime,date_current_datetime())) mod 60;

    newDialogue[0] = "free gift in "+string_zeroes(hrs,1)+"h "
                        +string(string_zeroes(mins,2))+"m";//text
    newDialogue[1] = 0// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;

// Quest Next Time
case 8:
    var minuteSpan = round(date_minute_span(questNextTime,date_current_datetime()));
    var hrs = minuteSpan div 60;
    var mins = minuteSpan mod 60;
    //var hourSpan = floor(date_hour_span(giftNextTime,date_current_datetime()));
    //var minSpan = floor(date_minute_span(giftNextTime,date_current_datetime())) mod 60;

    newDialogue[0] = "new quest in "+string_zeroes(hrs,1)+"h "
                        +string(string_zeroes(mins,2))+"m";//text
    newDialogue[1] = 0// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;


// Deflector Discovered Codex Text
case 9:
    //newDialogue[0] = "deflectors added to codex"//text
    newDialogue[0] = "new codex discovered"//text
    newDialogue[1] = 0// styling (1=strike)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype

break;

default:
    newDialogue[0] = "Not implemented"//text
    newDialogue[1] = 0// styling (0=none)
    newDialogue[2] = argument[0]// type id
    newDialogue[3] = 0// subtype
break;

}

return newDialogue;

#define scr_go_is_dialogue
///scr_go_is_dialogue(dialogue_id)
var _len = ds_list_size(go_dialogue_txt)
for (var b = 0; b < _len; b++) {
    var _button = go_dialogue_txt[| b];
    if _button[2] == argument0{
        return b;
    }
}

return -1;

#define scr_go_set_dialogue
///scr_go_set_dialogue(dialogue_id, data)

var dialoguePos = scr_go_is_dialogue(argument0)
var newDialogueData = argument1;

dialogueData = go_dialogue_txt[| dialoguePos];
dialogueData[@ 0] =  newDialogueData[0];
dialogueData[@ 1] =  newDialogueData[1];
dialogueData[@ 3] =  newDialogueData[3];
#define scr_go_replace_dialogue
///scr_go_replace_dialogue(old_dialogue_id, new_dialogue_id)
var oldID_Pos = scr_go_is_dialogue(argument0);
var newID_Obj = scr_go_create_dialogue(argument1);


ds_list_replace(go_dialogue_txt, oldID_Pos, newID_Obj);
#define scr_go_set_style_dialogue
///scr_go_set_style_dialogue(dialogue_ID, style_index)

dialogueIndex = scr_go_is_dialogue(argument0);

dialogueData = go_dialogue_txt[|dialogueIndex];
//Set Style
dialogueData[@ 1] = argument1;