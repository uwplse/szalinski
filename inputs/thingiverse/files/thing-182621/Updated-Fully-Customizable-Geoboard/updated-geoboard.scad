//This creates a customizable square geoboard. Everything I could think of is customizable.

//Size of base
base_size = 100; // [10:500]

//Thickness of base
base_thickness = 5;

//Peg thickness
peg_thickness = 3; // [1:10]

//Peg height
peg_height = 20; // [10:50]

//Number of pegs on X axis
X_pegs = 4;

//Number of pegs on Y axis
Y_pegs = 4;

//Width of step on top of peg
step_width = 2; // [0:5]

//% of peg height for step
step_percent = 15; // [5:90]

module peg()
{
translate([0,0,(peg_height+base_thickness)-peg_height*(step_percent/100)])cylinder(peg_height*(step_percent/100),peg_thickness,peg_thickness+step_width);
translate([0,0,base_thickness])cylinder(peg_height,peg_thickness,peg_thickness);
}
cube([base_size,base_size,base_thickness]);

module peg_line()
{
for (i = [0 : X_pegs-1] ){
translate([((base_size-peg_thickness*4)/(X_pegs-1))*(i)+peg_thickness*2,peg_thickness*2,0]) peg();
}
}

for (i = [0 : Y_pegs-1] ){
translate([0,((base_size-peg_thickness*4)/(Y_pegs-1))*(i),0]) peg_line();
}