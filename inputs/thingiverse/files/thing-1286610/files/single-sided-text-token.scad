//Customizable Double Sided Token

/*Token Variables*/
token_width = 40;
token_rim_size = 4;
token_thickness = 4;
token_recess = 1;

/*Text Varibles*/
font = "Impact";
letter_size = 15;
letter_height = 1;
letter_text = "text";

x=0;
y=0;


module void() {}




difference() {
    
    //create token
    cylinder(h=token_thickness, d=token_width);

     //recess top
    translate([0,0,token_thickness-token_recess]){
        color("blue") cylinder(h=token_thickness+token_recess, d=token_width-token_rim_size);
       
    }


    
}


union() {
    color("red")
    translate([x,y,(token_thickness-token_recess)]){
        linear_extrude(height = letter_height){
            rotate([0,0,90]) translate([0,0,5]) text(letter_text, font=font, valign="center", halign="center", size=letter_size);
        }
    }
}
        