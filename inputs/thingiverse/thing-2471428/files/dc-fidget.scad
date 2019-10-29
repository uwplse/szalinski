// dc-fidget-spinner
// Configurable DIY fidget spinner design
// Copyright 2014-2017 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick

$fn=50;
// thickness of spnner body.  most bearings are 7-8mm
body_thickness = 7.5;
//diameter of center hole.  typical bearings are 22mm
body_hole_diameter = 22;
//dimater of body surrounding center hole, should be larger than hole diameter
body_diameter = 38;

// number of arms, supports 2, 3, or 4.
arms = 3; //[2-4]
//length of each arm
arm_length = 30;
//diameter of the hole in each arm.  22 for a bearing, or less for other weights, etc.  if using a hex nut, measure widest part from point to point
arm_hole_diameter = 22;
//sides for arm holes, set to 6 in order to weight them with hex nuts
arm_hole_sides = 0;
//thickness of material around each arm hole
arm_thickness = 3.5;
// size of center part to hull each arm against, adjust how thick each arm is.
arm_hull_center = 30;

ahs = (arm_hole_sides==0) ? 96 : arm_hole_sides;
arm_diam = arm_hole_diameter + arm_thickness;

difference(){
    union(){
        if(arms==4){
            difference(){
                hull(){
                    translate([0,arm_length,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([0,arm_length,-.01])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
            difference(){
                hull(){
                    translate([0,-arm_length,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([0,-arm_length,-.01])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }

        if(arms==4 || arms==2){
            difference(){
                hull(){
                    translate([arm_length,0,0])
                    rotate([0,0,30])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([arm_length,0,-.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }
        difference(){
            hull(){
                translate([-arm_length,0,0])
                rotate([0,0,30])
                cylinder(d=arm_diam, h=body_thickness);
                cylinder(d=arm_hull_center, h=body_thickness);
            }
            translate([-arm_length,0,-.01])
            rotate([0,0,30])
            cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
         }
         
         if(arms==3){
             difference(){
                hull(){
                    translate([arm_length*.5,arm_length*.87,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([arm_length*.5,arm_length*.87,-0.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
            difference(){
                 hull(){
                    translate([arm_length*.5,-arm_length*.87,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }   
                translate([arm_length*.5,-arm_length*.87,-0.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }  
        
        //main body
        cylinder(d=body_diameter, h=body_thickness);
    }    

    //center hole
    translate([0,0,-1])
    cylinder(d=body_hole_diameter, h=body_thickness*2);
}