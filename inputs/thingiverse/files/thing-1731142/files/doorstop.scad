text = "SMITH";
font = "Arial Black"; // [Arial, Baloo Paaji, Candal, Cinzel, Londrina Outline,Roboto]
// Default: 9
angle = 9; // [5:45]
// Default: 135
length = 135; // [0:1000]
// Default: 35
width = 35; // [0:1000]
// Default: 25
height = 25; // [0:1000]
// Default: 1.8
text_height = 1.6; // [0:0.1:100]
// Default: 25
text_size = 25; // [0:1000]
// Default: 0.1
wall_thickness = 0.1; // [0:0.1:1]
// ignore this variable!
thickness = 1-wall_thickness;
// Innie or Outie (text)
outie = "Innie"; // [Outie, Innie]

if (outie=="Outie") {
    //outie
    difference(){
        union() {
            difference(){
                cube([length,width,height],center=true);
                rotate([0,angle,0]) translate([0,0,(height/2)-1]) cube([length*2,width*2,height],center=true);
            }
            
            rotate([0,angle,0]) translate([0,0,-2]) linear_extrude(height=text_height) {
                text(text=text,font=font,size=text_size,halign="center",valign="center");
            }
        }
        
        //bottom
        scale([thickness+.06,thickness,thickness]) translate([0,0,-4.5]) difference(){
                cube([length,width,height],center=true);
                rotate([0,angle,0]) translate([0,0,(height/2)-2]) cube([length*2,width*2,height],center=true);
        }
    }
} else {
//innie
    difference(){
        difference() {
            difference(){
                cube([length,width,height],center=true);
                rotate([0,angle,0]) translate([0,0,(height/2)-1]) cube([length*2,width*2,height],center=true);
            }
            
            rotate([0,angle,0]) translate([0,0,-(0.9+text_height)]) linear_extrude(height=text_height) {
                text(text=text,font=font,size=text_size,halign="center",valign="center");
            }
        }
        
        //bottom
        scale([thickness+.06,thickness,thickness]) translate([0,0,-4.5]) difference(){
                cube([length,width,height],center=true);
                rotate([0,angle,0]) translate([0,0,(height/2)-2]) cube([length*2,width*2,height],center=true);
        }
    }
}