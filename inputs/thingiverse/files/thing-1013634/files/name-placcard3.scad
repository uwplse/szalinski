text="Your Name";
font="Times";
height=70;
thickness=15;
rim_width=7;
xadj=.85;
yadj=1;

module name_plate(string, font, height, thk, rim, xadj, yadj){
    strlen=len(string);
    
    // Base
    translate([0,height,0]){       
        color("Red")
        difference(){
            cube([height*strlen*xadj, height*yadj*1.2, thk*2/3], 
                    center=true);
                
            // Lettering  inset
            translate([0,0,-1/6*thk])
            linear_extrude(height=thk*2/3)
            text(string, font=font,
                halign="center", valign="center", 
                $fn=100, size=height);    
        }
    }
    
     // Rim
    translate([0,-height,0]){
        color("Green")
        difference(){
            cube([height*strlen*xadj+rim, height*yadj*1.2+rim, thk],            center=true);
            translate([0,0,0])
            cube([height*strlen*xadj, height*yadj*1.2, thk], 
                    center=true);
        }
    }
    
    // Letters
    translate([0,-height,0]){
         // Lettering
        color("Blue")
        translate([0,0,-1/6*thk])
        linear_extrude(height=thk*2/3)
        text(string, font=font,
            halign="center", valign="center", 
            $fn=100, size=height);
    }
}


// Change "Your Name"
// font is the font, see Help Menu::Font List for installed options
// height is the height (in the y axis)
// thk is the thickness of the name plate when assembled
// rim is the width of the rim
// xadj and yadj are factors for adjustment depending on the font you are using.

// Assembles without glue, snaps together.

text="Your Name";
font="Times";
height=70;
thickness=15;
rim_width=7;
xadj=.85;
yadj=1;


name_plate(text, font=font,
    height=height, thk=thickness, rim=rim_width,
    xadj=xadj, yadj=yadj
);