// Magic Customizable Twisted Polygon Vase Maker V2
// This started as.. 
// Customizable Twisted Polygon Vase - http://www.thingiverse.com/thing:270130/#files

use <MCAD/regular_shapes.scad>;

// Approximate Height of Vase(mm)
vase_height = 185;
//Approximate Radius of Vase (mm)
bottom_radius =50;

// The Vase is an extruded regular polygon - polygon type in the regular_shapes funciton
// - Side of extruded regular polygon (Best < 12)
number_of_sides = 5;

// USE THIS ONE WITH CUSTOMIZER
// Comment this out if using OpenSCAD, and uncomment OpenSCAD section below.
// - Use the slider to choose a value for NA
Random_Na = 8473; // [1:1:9999]

// Manually Define a Na Value
// - Overrides the slider above unless set to 0
Manual_Na = 0;

// New v2 Favorites - [May Print With Holes]
//@vase_height = 185;
//@bottom_radius = 50;
//4Side: 8459, 6639, 8980
//5Side: 7782, [7799] 244, [536], [2561], 587.5, 8473, 7728, 9332   
//6Side: 4568, 9168, [7978], 4600, 5294, 6501.4
//7Side: 5423, 5423.3



// USE THIS ONE WITH OPENSCAD
// comment this out if using Customizer
// OpenSCAD chooses a random value for Na
//Random_Na = floor(rands(1,9999,1)[0]);

/* Start the Magic */
// set Na according to Value used above
Na = (Manual_Na==0) ? Random_Na : Manual_Na;
echo(Na);

// Top and bottom radius need be be equal for vase to work!
// Bottom circumradius (mm from center to corner)
// Top circumradius (mm from center to corner)
top_radius = bottom_radius;
// These also need to be equal, for the Magic to work :-)
Nb = Na;
number_of_sides2 = number_of_sides;

// This was all created at random, i can't follow the logic
slice_layers = (.5*number_of_sides)*((Na + Nb)/Nb);
slice_layers2 = (.5*number_of_sides)*((Na + Nb)/Na);

// Could have something to do with twist of top surface relative to bottom.
top_rotation = (.5*number_of_sides)*number_of_sides * (Nb/(.5*number_of_sides)) * slice_layers ;

// Could have something to do with twist of top surface relative to bottom. 
bottom_rotation = (.5*number_of_sides)*number_of_sides2 * (Na/(.5*number_of_sides)) * slice_layers2;

top_scale = top_radius / bottom_radius;

// making a vase top to bottom
for ( k = [1 : (vase_height/slice_layers) : vase_height] ){
for ( i = [1 : (vase_height/slice_layers) : vase_height] ){
    rotate([0, 0, i]) {  
        translate([0,0,i]) {
            hull() {
                mirror([i,i,0]) {
                    linear_extrude(
                            height = (vase_height/slice_layers),
                            twist  = top_rotation/(vase_height/slice_layers),
                            slices = slice_layers,
                            scale  = top_scale)
                    union() {
                        reg_polygon(
                                sides  = number_of_sides,
                                radius = bottom_radius);
                        reg_polygon(
                                sides  = number_of_sides2,
                                radius = bottom_radius);  
                    } //union  
                } //mirror
            } //hull
        } // translate
    } // rotate
    
}; // for i

// Doing something in the reverse of the loop above
//for ( j = [vase_height : -(vase_height/slice_layers2) : 0] ){
for ( j = [1 : (vase_height/slice_layers) : vase_height] ){
    rotate([0, 0, j]) {  
        translate([0,0,j]) {   
            hull() { 
                mirror([0,j,0]) { 
                    linear_extrude(
                            height = (vase_height/slice_layers2),
                            twist  = bottom_rotation/(vase_height/slice_layers2),
                            slices = slice_layers2,
                            scale  = top_scale)
                    union() { 
                        reg_polygon(
                                sides  = number_of_sides2,
                                radius = bottom_radius);
                        reg_polygon(
                                sides  = number_of_sides,
                                radius = bottom_radius);
                    } //union
                } //mirror
            } //hull
        } // translate
    } // rotate  
}; // for j
}; // for k
