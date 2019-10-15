// Height [mm]
height = 60; // [10:1:100]
// Wall strength [mm]
wall = 3; // [1:0.2:10]
// Width [mm]
width = 14; // [10:0.2:40]
// Length [mm]
length = 40; // [10:1:80]
// Clamp height [mm]
clamb_height = 45; // [10:1:100]
// Top Length [mm]
top_length = 38; // [10:1:80]

// Number of screw holes [mm]
num_holes = 2; // [1:1:10]
// Small hole radius [mm]
radius = 2; // [1:0.2:4]

rotate([0,90,0])
difference(){
    union() {
        translate([0,length/2-wall/2,-height/2+clamb_height/2+wall/2])
        cube([width, wall, clamb_height], center=true);
        translate([0,0,-height/2+wall/2])
        cube([width, length, wall], center=true);
        translate([0,-length/2+wall/2,0])
        cube([width, wall, height], center=true);
        translate([0,-length/2+top_length/2,height/2-wall/2])
        cube([width, top_length, wall], center=true);
    }
    
    for(i = [0:(num_holes-1)]){
        translate([0,top_length/num_holes*i-length/2+top_length/num_holes/2+wall/2,height/2-(wall+2)/2-1])
        cylinder(r=radius, h=wall+2, $fn=32);
        translate([0,top_length/num_holes*i-length/2+top_length/num_holes/2+wall/2,-height/2-(wall+2)/2+1])
        cylinder(r=radius+2, h=wall+2, $fn=32);
    }
}