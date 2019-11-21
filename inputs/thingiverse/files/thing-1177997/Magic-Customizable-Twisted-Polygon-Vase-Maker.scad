// Magic Customizable Twisted Polygon Vase Maker
// This started as.. 
// Customizable Twisted Polygon Vase - http://www.thingiverse.com/thing:270130/#files

use <MCAD/regular_shapes.scad>;

// Approximate Height of Vase(mm)
vase_height = 90;
//Approximate Radius of Vase (mm)
bottom_radius = 25;

// The Vase is an extruded regular polygon - polygon type in the regular_shapes funciton
// - Side of extruded regular polygon (Best < 12)
number_of_sides = 6;

// USE THIS ONE WITH CUSTOMIZER
// Comment this out if using OpenSCAD, and uncomment OpenSCAD section below.
// - Use the slider to choose a value for NA
Random_Na = 9168; // [1:1:9999]

// Manually Define a Na Value
// - Overrides the slider above unless set to 0
Manual_Na = 0;

// Some Favorites
//6Side: 7065, 9503, 9168, 1418
//Side: 6354, 2062, 2448, 6171, 7222

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
for ( i = [1 : (vase_height/slice_layers) : vase_height] ){
    rotate([0, 0, i]) {
        
        translate([0,0,i]) {
            hull() {     
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
            } //hull
        } // translate
    } // rotate
}; // for i

// Doing something in the reverse of the loop above
for ( j = [vase_height : -(vase_height/slice_layers2) : 0] ){
    rotate([0, 0, j]) {    
        translate([0,0,j]) {
            hull() { 
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
            } //hull
        } // translate
    } // rotate
}; // for j
