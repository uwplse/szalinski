use <write/Write.scad>
// preview[view:south, tilt:bottom]

/* [Option Set 1] */
first_character = "W"; 
second_character = "S";
text_depth = 1.5; // [0.5, 1.0, 1.5, 2.0, 2.5]
text_angle = 3.5; // [3.5:Angled Letters, 0:Horizontal Letters]

/* [Option Set 2] */
show_border = "No"; // [No, Yes]
border_type = 0; // [0: Circles, 1: Squares]
border_depth = 0.3; // [0.3, 0.4, 0.5] 

/* [Hidden] */
preview_tab = "";
stamp_imprint();

module stamp_imprint() {                
    difference() {
        // The stamp (with handle) and letter(s) removed
        union() {
            translate([0, 0, 3 + 6]) cylinder(12, d=10, center = true); // The handle
            
            difference() { 
                translate([0, 0, 1.5]) cylinder(3, d=27.5, center=true); // The full face
                if (first_character != "" && second_character != ""){ //Extract two letters
                    translate([0, 0, -.1])
                    linear_extrude(height = text_depth+.1){
                        translate([-5, text_angle, 0])
                        text(first_character[0], halign = "center", valign = "center", 
                        size=9, font = "Liberation Sans:style=Bold");
                    }
                    translate([0, 0, -.1])
                    linear_extrude(height = text_depth+.1){
                        translate([5, -1*text_angle, 0])
                        text(second_character[0], halign = "center", valign = "center", 
                        size=9, font = "Liberation Sans:style=Bold");
                    }
                    
                    write(".", t = 0, h = 0, center = true);
                }
                else if (first_character != "") { // If only one letter, extract it
                        translate([0, 0, -.1])
                        linear_extrude(height = text_depth+.1){
                        text(first_character[0], halign = "center", valign = "center", 
                        size=15, font = "Liberation Sans:style=Bold");
                    }
                    
                    write(".", t = 0, h = 0, center = true);
                }
                else { // If only one letter, extract it
                    translate([0, 0, -.1])
                    linear_extrude(height = text_depth+.1){
                        text(second_character[0], halign = "center", valign = "center", 
                        size=15, font = "Liberation Sans:style=Bold");
                    }
                    
                    write(".", t = 0, h = 0, center = true);
                }
            }
                 
        }
        
        // The stamp (with handle) and border removed
        if (show_border == "Yes"){
            if (border_type == 0){ // Extract the circle border
                for (i = [0:1:9]) {
                    translate([sin(i*36)*12, cos(i*36)*12, border_depth/2-.1]) 
                    cylinder(border_depth, d=2.5, center=true);
                }
            }
            else{
                for (i = [0:1:9]) { // Extract the square border
                    translate([sin(i*36)*12, cos(i*36)*12, border_depth/2-.1]) 
                    rotate([0, 0, -i*36])
                    cube([2, 2, border_depth], center=true);
                }
            }
                
            
        }
    }
}