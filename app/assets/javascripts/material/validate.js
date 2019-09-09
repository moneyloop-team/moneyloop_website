// Form validations for applyform

// Valid input CSS style
function valid($result){
    $result.css("outline", "none");
    $result.css("border-color", "green");
    $result.css("border-style", "solid");
    $result.css("border-width", "2px");
}

// Invalid input CSS style
function invalid($result){
    $result.css("outline", "none");
    $result.css("border-color", "red");
    $result.css("border-style", "solid");
    $result.css("border-width", "2px");
}

// Validate an input
// Params: 
//  event.data.item - item to be validated
//  event.data.re - regex to use to validate item
function validate(event) {
    var re = event.data.re;
    var $result = $(event.data.item);
    var email = $(event.data.item).val();

    if (re.test(email)) { // Valid email, turn green
        valid($result);
        $result[0].setCustomValidity("");
        return true;
    } else { // Invalid email, turn red
        invalid($result);
        $result[0].setCustomValidity(event.data.msg);
        return false;
    }
}

// Check if a form item is filled or not
function isFilled(event){
    var item = event.data.item;
    if($(item).val()){
        valid($(item));
    } else {
        invalid($(item));
    }
}

$(document).ready(function(){
    // Validate email
    $("#email").on("input",  { 
        item: "#email", 
        re: /\S+@\S+\.\S+/, // anything@anything.anything
        msg: "Please enter a valid email"
    }, validate);

    // Validate phone number
    $("#number").on("input",  { 
        item: "#number", 
        re: /^(?:\+?61)?(?:\(0\)[23478]|\(?0?[23478]\)?)\d{8}$/, // (+61/0)[2,3,4,7,8]xxxxxxxx
        msg: "Phone number should start with +61 or 0 and have no spaces"
    }, validate);

    // TODO - surely there is a better way to do this! See https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/Form_validation
    // TODO - make '#address' valid only if it's been completed by Google place autocomplete
    // Make sure required items are filled
    $("#first_name").on("input", {item: "#first_name"}, isFilled);
    $("#last_name").on("input", {item: "#last_name"}, isFilled);
    $("#dobday").on("input", {item: "#dobday"}, isFilled);
    $("#dobmonth").on("input", {item: "#dobmonth"}, isFilled);
    $("#dobyear").on("input", {item: "#dobyear"}, isFilled);
    $("#address").on("input", {item: "#address"}, isFilled);
    $("#Employer").on("input", {item: "#Employer"}, isFilled);
    $("#Employment_Type").on("input", {item: "#Employment_Type"}, isFilled);
    $("#salary").on("input", {item: "#salary"}, isFilled);
});