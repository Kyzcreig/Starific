table_id=scr_bm_gj_get_table_id(argument1,argument2);
score_val=argument0;
level_val=argument3;
if table_id!=""
{
    http_highscore=gj_scores_get_user(table_id,1); 
} else
{
// gametype and gridsize passed wrong. Do something if you need
}
