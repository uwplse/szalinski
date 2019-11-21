////////////////////////////////////////////////////////
// Created by Paul Tibble - 18/7/19                   //
// https://www.thingiverse.com/Paul_Tibble/about      //
// Please consider tipping, if you find this useful.  //
////////////////////////////////////////////////////////

$fn = 100*1;

// Outer Diameter (bottom)
outer_diameter_1 = 15;
// Wall Thickness (bottom)
wall_thickness_1 = 2;
// Rib Thickness (bottom), set to Zero to remove
barb_size_1 = 0.5;
// Length (bottom)
length_1 = 15;
// Outer Diameter (top), should be smaller than or equal to Outer Diameter (bottom)
outer_diameter_2 = 12;
// Wall Thickness (top)
wall_thickness_2 = 1;
// Rib Thickness (top), set to Zero to remove
barb_size_2 = 0.5;
// Length (top)
length_2 = 15;
// Middle Diameter
mid_diameter = 17;
// Middle Length
mid_length = 5;


//do not change these
inner_diameter_1 = outer_diameter_1 - (wall_thickness_1*2);
inner_diameter_2 = outer_diameter_2 - (wall_thickness_2*2);

module create_profile() {
    ////////
    // Middle
    ///////
    polygon(points=[[inner_diameter_1/2,length_1],[mid_diameter/2,length_1],[mid_diameter/2,length_1+mid_length],[inner_diameter_2/2,length_1+mid_length]]);
    //////
    //length 1
    /////
    translate([inner_diameter_1/2,0,0])square([wall_thickness_1,length_1]);
    //barb 1
    translate([outer_diameter_1/2,0,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
    //barb 2
    translate([outer_diameter_1/2,length_1*0.25,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
    //barb 3
    translate([outer_diameter_1/2,length_1*0.5,0])polygon(points=[[0,0],[0,(length_1/5)],[barb_size_1,(length_1/5)]]);
    //////
    //length 2
    /////
    translate([inner_diameter_2/2,length_1+mid_length,0])square([wall_thickness_2,length_2]);
    //rib 1
    translate([outer_diameter_2/2,(length_1+mid_length+length_2),0])polygon(points=[[0,0],[0,-1*(length_2/5)],[barb_size_2,-1*(length_2/5)]]);
    //rib 2
    translate([outer_diameter_2/2,(length_1+mid_length+length_2)-length_2*0.25,0])polygon(points=[[0,0],[0,-1*(length_2/5)],[barb_size_2,-1*(length_2/5)]]);
    //rib 3
    translate([outer_diameter_2/2,(length_1+mid_length+length_2)-length_2*0.5,0])polygon(points=[[0,0],[0,-1*(length_2/5)],[barb_size_2,-1*(length_2/5)]]);
}

rotate_extrude(angle = 360, convexity = 10) create_profile();
//create_profile();