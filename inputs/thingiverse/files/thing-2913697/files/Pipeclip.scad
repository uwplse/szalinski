////////////////////////////////////////////////////////
// Created by Paul Tibble - 11/5/18                   //
// https://www.thingiverse.com/Paul_Tibble/about      //
// Please consider tipping, if you find this useful.  //
////////////////////////////////////////////////////////

$fn = 100*1;

// - Pipe/Cable Diameter
diameter = 20;
// - Make this greater than Hole Diameter
width = 10;
//
thickness = 3;
// - Make this less than Width
hole_diameter = 3;
//Holes - 0 = not counter sunk, 1 = counter sunk
counter_sunk = 0; //[0,1]



//do not change these
fillet_radius = thickness/2;
tab_length = width+thickness;
radius = diameter/2;

module create_profile() {
    translate([radius+thickness-(fillet_radius/2),0,0])square([fillet_radius,width-(2*fillet_radius)],true);
    translate([radius+(thickness-fillet_radius),((width/2)-fillet_radius),0])circle(fillet_radius);
    translate([radius+(thickness-fillet_radius),-((width/2)-fillet_radius),0])circle(fillet_radius);
    translate([radius+((thickness-fillet_radius)/2),0,0])square([thickness-fillet_radius,width],true);
}

module create_tab() {
    union(){
        translate([diameter/2,-diameter,0]) rotate (a=[90,0,90]) linear_extrude(height = tab_length,center = false,convexity = 10,twist = 0) create_profile();
        
        translate([radius+tab_length,(thickness-fillet_radius)-radius,(width/2)-fillet_radius]) sphere(fillet_radius);
        translate([radius+tab_length,((thickness-fillet_radius)/2)-radius,(width/2)-fillet_radius]) rotate([90,0,0]) cylinder(h=thickness-fillet_radius,r=fillet_radius,center=true);
        
        translate([radius+tab_length,(thickness-fillet_radius)-radius,fillet_radius-(width/2)]) sphere(fillet_radius);
        translate([radius+tab_length,((thickness-fillet_radius)/2)-radius,fillet_radius-(width/2)]) rotate([90,0,0]) cylinder(h=thickness-fillet_radius,r=fillet_radius,center=true);
        
        translate([radius+tab_length,(thickness-fillet_radius)-radius,0]) cylinder(h=width-(2*fillet_radius),r=fillet_radius,center=true);
        
        translate([radius+tab_length+(fillet_radius/2),((thickness-fillet_radius)/2)-radius,0]) cube([fillet_radius,thickness-fillet_radius,width-(2*fillet_radius)],true);
    }
}

difference(){
    union(){
        difference(){
            rotate_extrude(angle = 90, convexity = 10) create_profile();
            translate([0,-diameter,0]) cube([2*diameter,2*diameter,2*width],center = true);
        }
        mirror([1,0,0]) translate([0,0-(radius/2)]) rotate(a=[90,0,0]) linear_extrude(height = radius,center = true ,convexity = 10,twist = 0) create_profile();
        translate([0,0-(radius/2)]) rotate(a=[90,0,0]) linear_extrude(height = radius,center = true ,convexity = 10,twist = 0) create_profile();
        create_tab();
        mirror([1,0,0]) create_tab();
    }

    translate([((tab_length-thickness)/2)+thickness+radius,(thickness/2)-radius,0])rotate([90,0,0])cylinder(thickness*2,hole_diameter/2,hole_diameter/2,true);
    translate([-(((tab_length-thickness)/2)+thickness+radius),(thickness/2)-radius,0])rotate([90,0,0])cylinder(thickness*2,hole_diameter/2,hole_diameter/2,true);
    if (counter_sunk){
        translate([-(((tab_length-thickness)/2)+thickness+radius),(thickness -(hole_diameter*0.24))-radius,0])rotate([90,0,0]) cylinder(hole_diameter/2,hole_diameter,hole_diameter/2,true);
        translate([(((tab_length-thickness)/2)+thickness+radius),(thickness -(hole_diameter*0.24))-radius,0])rotate([90,0,0]) cylinder(hole_diameter/2,hole_diameter,hole_diameter/2,true);
    }
}