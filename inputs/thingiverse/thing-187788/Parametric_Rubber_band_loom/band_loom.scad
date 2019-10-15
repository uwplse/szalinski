//Size of base X
base_Y = 45; // [10:500]

//Size of base Y
base_X = 150; // [10:500]

//Thickness of base
base_thickness = 5;

//Peg thickness
peg_thickness = 3; // [1:10]

//Peg height
peg_height = 20; // [10:50]

//Gap width in peg
gap_width = 2.5;

//Number of pegs on X axis
X_pegs = 5;

//Width of step on top of peg
step_width = 2; // [0:5]

//% of peg height for step
step_percent = 15; // [5:90]

module core()
{
translate([0,0,(peg_height+base_thickness)-peg_height*(step_percent/100)])cylinder(peg_height*(step_percent/100),peg_thickness+step_width,peg_thickness+step_width);
translate([0,0,base_thickness])cylinder(peg_height,peg_thickness,peg_thickness);
}

module peg()
{
difference()
{core();
translate([-peg_thickness/3,-gap_width/2,base_thickness])cube([peg_thickness*3,gap_width,peg_height]);
}
}
cube([base_X,base_Y,base_thickness]);
peg_line();
translate([((base_X-peg_thickness*4)/(X_pegs-.5))*.5,((base_Y-peg_thickness*4)/2),0])peg_line();
translate([0,base_Y-(peg_thickness*4),0])peg_line();
module peg_line()
{
for (i = [0 : X_pegs-1] ){
translate([((base_X-peg_thickness*4)/(X_pegs-.5))*(i)+peg_thickness*2,peg_thickness*2,0]) peg();
}
}