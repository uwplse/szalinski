/*
*  Created by: Anhtien Nguyen
*  Date:  June 11, 2018
*  Description:  an electrical box with the dimension
*/


// Choose, which part you want to see!
part = "all_parts__";  //[all_parts__:All Parts,bottom_part__:Bottom,top_part__:Top]


// Length is fixed at 104mm,  width default 69.33mm 
width=69.33; //[51:85]
// Height default 41mm
height=41;  // [37:70]

// Adjust for clearance, thickness
gap = 0.5; 
thickness = 2; // [1:4]
// screw diameter (mm) for the holes at 2 ends
hole_diag = 3; // [3:6]
// radius of hole to run the AC wires (mm)
wires_hole_radius = 10; // [8:12]

// Program Section //
if(part == "bottom_part__") {
    box();
} else if(part == "top_part__") {
    cover();
} else if(part == "all_parts__") {
    all_parts();
} else {
    all_parts();
}

module all_parts() {
// call the function for the bottom part
//
translate([0,0,(height+gap+thickness)/2]) box();
//
// call the function for the top part
//
translate([width+gap+(thickness*2)+10,0,thickness/2]) cover();
//    translate([0,0,(height+gap+thickness)+1]) cover();  // this displacement puts the cover on top
}
// Fixed data
length = 104;
hole_depth=10; // how far down those 2 holes go
screw_rad = 2.5; // radius of 4 holes on the plate
rad = 7; // radius of the half columns at the 2 ends
rad=hole_diag*2+1;

module cover(width = width, length = length, height = 41,  screw_pos = 3) {
    difference() {
        // define plate
         cube([width, length, thickness],center=true);

        rotate([0,0,90]) 
        translate([-length/2+11,0,0])
        union() {
            translate([height + 19.3915,0,0]) 
            {
            difference() {
                cylinder(r=17.4625, h=15, center = true);
                translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
                translate([14.2875,-15,-2]) cube([10,37,15], center = false);
                }
            }
            translate([height - 19.3915,0,0]){
                difference(){
                cylinder(r=17.4625, h=15, center = true);
                translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
                translate([14.2875,-15,-2]) cube([10,37,15], center = false);
                }
            }
            translate([height,0,-1]) cylinder(r=2, h=10,$fn=12);
            translate([height,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
            
        } // union

        // define holes at 2 ends
        translate([0,-length/2+1+screw_pos,-thickness]) cylinder(r=hole_diag/2,h=thickness*2,$fn=60);
        translate([0, length/2-1-screw_pos,-thickness]) cylinder(r=hole_diag/2,h=thickness*2,$fn=60);
    }
}
                        
/*
 * Function box()
 * Draw the box 
 */
module box(width = width+gap, length = length+gap , height = height +gap, screw_pos = 3) {
    ow_width = width + thickness;
    ow_length= length + thickness;
    ow_height= height  + thickness;

    // fixed values
   eye_diag = 33.6 + gap;
    eye_rad = eye_diag/2;
   eye_width = 28 + gap;
   
    difference() {
        // define the box without the top
        difference() {
            // outside wall
            intersection() {
                cube([ow_width, ow_length, ow_height],center=true);
            }
            // inside wall
             translate([0,0,thickness]) intersection() {
               cube([width, length, height],center=true);
             }
        } 

        // four corner holes
        for (a = [0:90:359]) 
        {
            rotate([0, 0, a]) translate([20, 20, -ow_height/2])
            cylinder(r=screw_rad+.25, h=10, center=true, $fn=12);
        } // for (a =
            
        // hot wires hole
        rotate([0,-90,0]) translate([-(wires_hole_radius/2+1),-(ow_width/2-5),-length/2]) cylinder(r=wires_hole_radius,h=50,$fn=60,center=true);

    } //difference box without top
    
    // screw hole left
    translate([0, -length/2+1,-ow_height/2])
    difference(){
        cylinder(ow_height-(thickness+2), rad,rad,$fn=60);
        translate([-rad,-rad*2-1,-1])cube([rad*2,rad*2,ow_height+2-thickness]);
        translate([0,screw_pos,ow_height-hole_depth+1]) cylinder(r=hole_diag/2,h=hole_depth,$fn=60);
    }
    // screw hole the other left :-)
        rotate([0,0,180])  translate([0, -length/2+1,-ow_height/2])
    difference(){
        cylinder(ow_height-(thickness+2), rad,rad,$fn=60);
        translate([-rad,-rad*2-1,-1])cube([rad*2,rad*2,ow_height+2-thickness]);
        translate([0,screw_pos,ow_height-hole_depth+1]) cylinder(r=hole_diag/2,h=hole_depth,$fn=60);
    }

    // support front
    rotate([0,0,90]) translate([0, -(ow_width/2-thickness),-ow_height/2])
    difference(){
        cylinder(ow_height-(thickness+2), rad,rad,$fn=60);
        translate([-rad,-rad*2-1,-1])cube([rad*2,rad*2,ow_height+2-thickness]);
    }
    
    // support back
    rotate([0,0,-90]) translate([0, -ow_width/2+thickness,-ow_height/2])
    difference(){
        cylinder(ow_height-(thickness+2), rad,rad,$fn=60);
        translate([-rad,-rad*2-1,-1])cube([rad*2,rad*2,ow_height+2-thickness]);
    }
}