///scr_prompt_feedback_text(promptTextType)

promptTextType = argument0;

// Intro
var promptText = "#Hi there, this game was made by a single indie developer, Alex.##";
// Mention Locked Modes
if promptTextType == 1 {
    promptText += "Extra modes were going to be paid but I've made them free for you.#";
}
// Text for HTML/Mobile
if touchPad != 0 {
    //promptText += "If you like it and want us to make more, toss us a review!##";
    promptText += "If you like it and want to help us make more, give us a review!##";
}else {
    promptText += "If you like it and want to help us make more, check out the app!##";
}
// Text for Music
if promptTextType == 0 {
    promptText += "If you love the soundtrack you can download it here!##";
}
//promptText += "If you have any problems or suggestions, you can send me a message directly.";
//promptText += "If you have any questions or suggestions, you can send me a message directly.";
promptText += "If you have any problems, questions or suggestions, send Alex a message directly.";

return promptText;
