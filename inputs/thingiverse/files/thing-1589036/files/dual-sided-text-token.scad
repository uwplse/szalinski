//Customizable Double Sided Token

/*Token Variables*/
token_width = 40;
token_rim_size = 4;
token_thickness = 4;
token_recess = 1;

// A global overlap variable (to prevent printing glitches)
o = .1;

perfect_circle_factor = 1000;

/*Text Varibles*/
font = "Impact";
letter_size = 7;
letter_height = 1;
letter_line_space = 3;
letter_text_line1 = "Je suis";
letter_text_line2 = "Charlie";

x=-5;
y=0;


module multiLine(){
  union(){
    for (i = [0 : $children-1])
      translate([0 , -i * (letter_size+letter_line_space), 0 ]) children(i);
  }
}

module drawtext() {

    color("red")
        linear_extrude(height = letter_height){
            rotate([0,0,90]) translate([0,0,5]) 
            
            multiLine() {
                text(letter_text_line1, font=font, valign="center", halign="center", size=letter_size);
                text(letter_text_line2, font=font, valign="center", halign="center", size=letter_size);
            }
        }
}

union() {
    difference() {
        
        //create token
        cylinder(h=token_thickness, d=token_width, $fn = perfect_circle_factor);

         //recess top
        translate([0,0,token_thickness-token_recess]){
            color("blue") cylinder(h=token_thickness+token_recess, d=token_width-token_rim_size, $fn = perfect_circle_factor);
           
        }
        
             //recess bottom
        translate([0,0,-o]){
            color("blue") cylinder(h=token_recess+o, d=token_width-token_rim_size, $fn = perfect_circle_factor);
           
        }
        
    }
    
    translate([x,y,(token_thickness-token_recess)]) drawtext();
    
    translate([-x,y,token_recess]) rotate(a=180, v=[0,1,0]) drawtext();

}