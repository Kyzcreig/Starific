/**
 * initialize HTML5 mouse
 */
function HTML5_mouse_init() {
    HTML5_mouse_xy_init();
    HTML5_mouse_check_button_init();
}


/**
 * keeps track of the current active mouse button.
 */
function HTML5_mouse_check_button_init() {

    // create variable to store button states.
    var _activeButton = -1,
        activeButton = 0;

    // function to set the current active button.
    function updateMouseState(e) {

        // update active button.
        activeButton = typeof e.buttons === "number" ? e.buttons : e.which;

        // store the last state in order to be able to tell if the state has changed.
        _activeButton = activeButton;
    }

    // function to get the current active button.
    function getButtonState() {
        return activeButton;
    }

    // update the button state when the mouse is moved
    // or an item is dragged into the window.
    window.addEventListener("mousedown", updateMouseState, false);
    window.addEventListener("mouseup", updateMouseState, false);
    window.addEventListener("mousemove", updateMouseState, false);
    window.addEventListener("dragover", function() {
        updateMouseState({
            which: 1
        });
    }, false);
    window.addEventListener("dragleave", function() {
        updateMouseState({
            which: 0
        });
    }, false);

    // expose the getter on the global object.
    window.getButtonState = getButtonState;
}



/**
 * Returns mouse button state
 */
function HTML5_mouse_check_button(n) {

    switch (n) {

        case "mb_left":
            if (getButtonState() == 1) {
                return true;
            } else {
                return false;
            }
            break;

        case "mb_right":
            if (getButtonState() == 3) {
                return true;
            } else {
                return false;
            }
            break;

        case "mb_middle":
            if (getButtonState() == 2 || getButtonState() == 4) {
                return true;
            } else {
                return false;
            }
            break;

        case "mb_any":
            if (getButtonState() !== 0) {
                return true;
            } else {
                return false;
            }
            break;
    }
}




/**
 * Initialize mouse position
 */
function HTML5_mouse_xy_init() {

    // create almost any element this way...
    var el = document.createElement("div");
    // add some text to the element...
    el.innerHTML = '<div style="width:0px;height:0px;position:absolute;"><form name="mouse_form"><input type="hidden" name="absolute_mouse_x" value="0" size="4"><input type="hidden" name="absolute_mouse_y" value="0" size="4"></form></div>';
    // "document.body" can be any element on the page.
    document.body.appendChild(el);

    window.IE__ = document.all ? true : false;
    if (!IE__) {
        document.captureEvents(Event.MOUSEMOVE);
    }

    document.onmousemove = HTML5_mouse_get_xy;
    window.tempX = 0;
    window.tempY = 0;

    HTML5_mouse_get_xy();
}

/*
 * Calculate Canvas Offset
 */
function HTML5_canvas_get_xy(canvas_element) {
    var left, top;
    left = top = 0;
    if (canvas_element.offsetParent) {
        do {
            left += canvas_element.offsetLeft;
            top += canvas_element.offsetTop;
        } while (canvas_element = canvas_element.offsetParent);
    }
    return {
        x: left,
        y: top
    };
}

/*
 * Calculate HTML5 Mouse X
 */
function HTML5_mouse_x(relative) {

    relative = typeof(relative) !== 'undefined' ? relative : 1;

    var docvalue = document.mouse_form.absolute_mouse_x.value;

    var canvas_element = new HTML5_canvas_get_xy(document.getElementById('canvas'));

    if (relative) {
        return docvalue - canvas_element.x;
    } else {
        return docvalue;
    }
}

/*
 * Calculate HTML5 Mouse Y
 */
function HTML5_mouse_y(relative) {

    relative = typeof(relative) !== 'undefined' ? relative : 1;

    var docvalue = document.mouse_form.absolute_mouse_y.value;

    var canvas_element = new HTML5_canvas_get_xy(document.getElementById('canvas'));

    if (relative) {
        return docvalue - canvas_element.y;
    } else {
        return docvalue;
    }
}

/*
 * Update Mouse Position
 */
function HTML5_mouse_get_xy(event_ding) {
    if (IE__) {
        tempX = event.clientX + document.body.scrollLeft;
        tempY = event.clientY + document.body.scrollTop;
    } else {
        tempX = event_ding.pageX;
        tempY = event_ding.pageY;
    }
    if (tempX < 0) {
        tempX = 0;
    }
    if (tempY < 0) {
        tempY = 0;
    }

    document.mouse_form.absolute_mouse_x.value = tempX;
    document.mouse_form.absolute_mouse_y.value = tempY;

    canvas_mouse_x = HTML5_mouse_x(1);
    document_mouse_x = HTML5_mouse_x(0);

    canvas_mouse_y = HTML5_mouse_y(1);
    document_mouse_y = HTML5_mouse_y(0);

    return true;
}