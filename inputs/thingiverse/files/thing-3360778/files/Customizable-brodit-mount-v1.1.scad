// Customizable brodit mount by Cees Moerkerken
// v1.1 - 13-01-2019
// preview[view:north, tilt:top]

//CUSTOMIZER VARIABLES

/* [Phone_dimensions] */
// Width of the phone
phone_width=80; // min/max: [40:200]

// Thickness of the phone
phone_thickness=11; // min/max: [5:20]

// Height of the side support bracket
phone_height=70; // min/max: [45:200]

/* [Other_dimensions] */
// Thickness of the bracket in mm
thickness=3; // min/max: [2:5]

// Width of the bezels
bezel=6; // min/max: [1:9] 

// Width of the connector opening
connector_width = 35; // min/max: [10:100] 

//CUSTOMIZER VARIABLES END

// Added +1 to ignore the variables in customizer
$fn=100+1;

distance_between_screws=37+1;
screw_head = 6+1;
screw_hole = 2+1;
center_screw_hole = 6+1;

module backplate(height, width, thickness){
    difference(){
        //base cube
        //Curved edges
        translate([0,thickness/2,thickness*1.4]) {
            minkowski(){
                cube([height-thickness*2, width-thickness, phone_thickness-thickness]);
                cylinder(r=thickness,h=0.1);
                rotate(a=90,v=[1,0,0])cylinder(r=thickness,h=0.1);
                rotate(a=90,v=[0,1,0])cylinder(r=thickness,h=0.1);
            }
        }
        //remove center hole
        translate([height/2, width/2,-thickness]) {
            cylinder(r=center_screw_hole/2,h=thickness*2+1);
        }
        //remove screw holes
        translate([height/2+distance_between_screws/2, width/2,-thickness]) {
            cylinder(r=screw_hole/2,h=thickness*2+1);
        }
        translate([height/2+distance_between_screws/2, width/2,thickness-2]) {
            cylinder(r=screw_head/2,h=3);
        }

        translate([height/2-distance_between_screws/2, width/2,-thickness]) {
            cylinder(r=screw_hole/2,h=thickness*2+1);
        }
        translate([height/2-distance_between_screws/2, width/2,thickness-2]) {
            cylinder(r=screw_head/2,h=3);
        }

        //remove a flattened cylinder to get inner curve
        translate([0, width/2,thickness*2]) {
            resize(newsize=[height+thickness+.1,width,thickness*2]){
                rotate(a=90, v=[0,1,0]){
                    cylinder(h=height,r=width);
                }
            }
        }

        //remove a concave cube to get inner curve
        translate([-thickness*2,thickness*-2,1]) {
            difference(){
                translate([0,0,phone_thickness*-1]) {
                    cube([height+thickness*2, width+thickness*4, phone_thickness]);
                }
                translate([0,width/2+thickness*2,0]) {
                    resize(newsize=[height+thickness*2,width+thickness*4,thickness*2]){
                        rotate(a=90, v=[0,1,0]){
                            cylinder(h=height,r=width);
                        }
                    }
                }
            }
        }
        
        //remove the phone shape
        translate([0,0,thickness*1.5]){
            cube([height+thickness+.1, width, phone_thickness]);
        }
        //remove the front opening
        translate([thickness+bezel,bezel,phone_thickness+thickness*1.49]){
            cube([height-bezel+.1, width-bezel*2, thickness]);
        }
        //remove the front connector
        translate([-10,width/2-connector_width/2,thickness+2]){
            cube([20, connector_width, phone_thickness*2]);
        }
        //remove the eccess bezel
        translate([bezel,-thickness-2,phone_thickness+thickness*1.49]){
            cube([height/1.5, width+thickness*4, thickness]);
        }

    }
}
backplate(phone_height, phone_width, thickness);


//phone demo
//translate([thickness+10,0,thickness*1.5]) color("red") cube([phone_height*2, phone_width, phone_thickness]);
