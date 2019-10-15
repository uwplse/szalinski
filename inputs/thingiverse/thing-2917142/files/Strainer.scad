////////////////////////////////////////////////////////
// Created by Paul Tibble - 11/5/18                   //
// https://www.thingiverse.com/Paul_Tibble/about      //
// Please consider tipping, if you find this useful.  //
////////////////////////////////////////////////////////

$fn = 50*1;

//- outer diameter
diameter = 60;
//- size of square holes
hole_size = 2;
//- thickness of grid
grid_size = 1;
//- overall height
thickness = 2;
//- width of lip around outer
lip = 4;


num_blocks = ceil(diameter/(hole_size+grid_size));

union(){
    difference(){
        cylinder(thickness-0.01,diameter/2,diameter/2,true);
        union(){
            for (a =[0:num_blocks]){
                for (b =[0:num_blocks]){
                    translate([-(diameter/2)+((hole_size+grid_size)*a),-(diameter/2)+((hole_size+grid_size)*b),0]) cube([hole_size,hole_size,thickness*2],true);
                }
            }
        }
    }
    difference(){
        cylinder(thickness,diameter/2,diameter/2,true);
        cylinder(thickness,(diameter/2)-lip,(diameter/2)-lip,true);
    }
}