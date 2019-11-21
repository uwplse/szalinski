/*
Version 1.0 - 2017-02-11
Released under Creative Commons - Attribution 
Contains rcylinder module from Thingiverse thing:58478
*/

$fn = 100;

bearing_dia = 22.5;       // Bearing Diameter
bearing_rim = 3;        // Width of rim around bearing
bearing_height = 7;     // Thickness of bearing

weight_dia = 38.0;        // Weight Diameter
weight_rim = 2;         // Width of rim around weight
weight_height = 7;      // Thickness of weights

num_lobes = 2;          // Number of lobes in spinner
edge_radius = 1;        // Corner radius
extra_spacing = 0;      // Extra spacing for adding more/larger weights

hole_dia = 6;           // Diameter of holes - set 0 for no holes
hole_offset = 0;         // Positive value moves holes away from bearing

weight_spacing = bearing_dia/2 + weight_dia/2 + bearing_rim + extra_spacing;

difference(){
    for(angle = [0:360/num_lobes:360]){
        lobe(angle);} // main body
        
     for(angle = [0:360/num_lobes:360]){
        rotate(v = [0, 0, 1], a = angle){
            translate([bearing_dia/2 + hole_offset, bearing_dia/2 + hole_offset, -(5+bearing_height/2)])
                cylinder(h = bearing_height +10, d = hole_dia);
            translate([bearing_dia/2 + hole_offset, -(bearing_dia/2 + hole_offset), -(5+bearing_height/2)])
                cylinder(h = bearing_height +10, d = hole_dia);
        }
    } //holes
}

module lobe(angle){
    x_dist = cos(angle)*weight_spacing;
    y_dist = sin(angle)*weight_spacing;
    
    difference(){
        hull(){
            rcylinder((bearing_dia+2*bearing_rim)/2, (bearing_dia+2*bearing_rim)/2, bearing_height, edge_radius);
            translate([x_dist, y_dist, 0])
                rcylinder((weight_dia+2*weight_rim)/2, (weight_dia+2*weight_rim)/2, weight_height, edge_radius);
        } //hull
        
        translate([0, 0, -(10+ weight_height/2)])
            cylinder(h = bearing_height + 20, d = bearing_dia);
        translate([x_dist, y_dist, -(10+weight_height/2)])
                cylinder(h = weight_height+20, d = weight_dia);
    
    } //difference   
} // lobe

module rcylinder(r1=10,r2=10,h=10,b=2){
    translate([0,0,-h/2]) 
        hull(){
            rotate_extrude() 
                translate([r1-b,b,0]) 
                    circle(r = b); 
            rotate_extrude() 
                translate([r2-b, h-b, 0]) 
                    circle(r = b);
        } // hull
} // rcylinder