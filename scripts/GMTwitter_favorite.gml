///GMTwitter_favorite(string tweet_id)
/*
Prompts the user to favorite a Tweet.
Ex. Tweet ID https://twitter.com/IndieDevAustin/status/492362888456048640 <-This last number is the tweet_id
Ex. GMTwitter_favorite("492362888456048640")
*/
var link;
link="http://twitter.com/intent/favorite?tweet_id="+string(argument0)
url_open_ext(link,URL_TARGET)//"_blank")
