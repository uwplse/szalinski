/********* BEST VIEWED IN 80 COLUMNS ** BEST VIEWED IN 80 COLUMNS **************
*
* Die Wench
* Benjamen Johnson <workshop.electronsmith.com>
* 20191023
* Version 1
* openSCAD Version: 2019.05
*******************************************************************************/
//Dummy variable to fix Thingiverse Customizer bug
dummy = 1;

//total height of the wrench
total_height = 17;

// Flat to flat width of the bigger die (what wrench size?)
die1_width = 25 ;

// Thickness of the bigger die
die1_thickness = 9.2;

// Flat to flat width of smaller die (what wrench size?)
die2_width = 15.8;

// Thickness of the smaller die
die2_thickness = 6.5;

// Die width adjustment (ex, 1.01 would be 101% of fixed width)
die_width_adj = 1.01;

// Diameter of the finger notches
finger_notch_dia = 25;

// how far the notches are from the center of the wrench 
finger_notch_dist = 19.5;

// add a little bit to cuts to make the model render cleaner
render_offset = 0.01;

/*******************************************************************************
* Calculations
*******************************************************************************/
handle_dia = total_height;

// Calculate the width of dies across the points
die1_width_pt_to_pt = die1_width/sin(60)*die_width_adj;
die2_width_pt_to_pt = die2_width/sin(60)*die_width_adj;

/*******************************************************************************
* Let's make a die wrench
*******************************************************************************/
rotate([180,0,0])
difference() {
    union(){
        // make a toroid that will be the outer part of the handle
        rotate_extrude(convexity = 10,$fn=100)
        translate([18, 0, 0])
        circle(d = handle_dia,$fn=100);
   
        // fill in toroid
        cylinder(d=36,h=total_height,center = true,$fn=100);
    
    }// end union
    
    // cut out die 1
    translate([0,0,-(total_height-die1_thickness)/2])cylinder(d=die1_width_pt_to_pt,h=die1_thickness+render_offset,center=true,$fn=6);
    
    // cut out die 2
    translate([0,0,(total_height-die2_thickness)/2])cylinder(d=die2_width_pt_to_pt,h=die2_thickness+render_offset,center=true,$fn=6);

    // cut out the center hole
    cylinder(d=die2_width,h=total_height+render_offset,center=true,$fn=50);
    
    // cut out the finger notches that make the grip
    for(i=[0:60:360]){
        rotate([0,0,i+30])
        translate([finger_notch_dist+finger_notch_dia/2,0,0])
        cylinder(d=finger_notch_dia,h=total_height,center = true,$fn=100);
    }// end for
}// end difference    