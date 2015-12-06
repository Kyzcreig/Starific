///GMTwitter_retweet(string tweet_id)
/*
Prompts the user to retweet a Tweet.
The Tweet ID can be found in the URL of the Tweet's permalink.
Ex. Tweet ID https://twitter.com/IndieDevAustin/status/492362888456048640 <-This last number is the tweet_id
Ex. GMTwitter_retweet("492362888456048640")
*/
var link;
link="http://twitter.com/intent/retweet?tweet_id="+string(argument0)
url_open_ext(link,URL_TARGET)//"_blank")
