//************************************************************************************
//*
//*  This creates a bracket for blinds
//*
//* The global variables can be edited as required for better resolution, a tighter
//*  or looser fit or a different fillet size.
//*
//* Keith Welker 2/2/18
//************************************************************************************
//dimensions (all in mm) (unless stated otherwise)

//
// MISC variables
//
//$fn for cylinders
FN = 360;// [60:Low Detail,120:Medium Detail,360:High Detail]

//a small offset to clear up any cutouts.
DELTA = .005; // [.001,.005,.01,.1]

//
// bracket configuration variables
//
//length of the bracket
L = 22; // [15:35]
// material thickness
thk = 3; //[2:0.5:6]
//pin distance from base
pd = 27.5; // [20:40]
//diamater at top of bracket (must be <= length)
dia = 16; // [15:35]
// bracket foot width (not including the thickness of the bracket)
W = 12; //[6:18]
//hole offset from upper bracket
H_O = 7; //[4:12]
//hole diameter
H_D = 4; //[1:6]
//hole center-center
H_CC = 11; //[5:14]
//pin thickness
p_thk = 5; //[1:8]
//pin diameter
p_dia = 2.75; //[1:5]

//truss thickness
t_thk = 6; //[2:10]


//fillet radius
fr = 3; //[2:8]

union()
{
    //truss
    t_points= [[0,0], [0,t_thk], [pd,0]];
    rotate([270,270,0])
    translate([thk,W+thk-DELTA,(L/2)-thk/2])
    linear_extrude(height = thk)
    polygon(t_points);
    
    // add the pin
    rotate([0,90,0])
    translate([-(thk+pd),L/2,W-p_thk])
    cylinder($fn=FN, h = p_thk, d = p_dia);
    
    //pin mounting flange
    p_points= [[0,0], [(L-dia)/2,pd], [L-(L-dia)/2, pd], [L,0]];
    rotate([90,0,0])
    rotate([0,90,0])
    translate([0,thk,W])
    linear_extrude(height = thk)
    polygon(p_points);
    rotate([0,90,0])
    translate([-(thk+pd),L/2,W])
    cylinder($fn=FN, h = thk, d = dia);
    
    //the base with mounting holes
    difference()
    {
        translate([fr/2,fr/2,0])
        //cube([W+thk+t_thk,L,thk]);
        base([W+thk+t_thk,L,thk], fr);
        translate([W-H_O,L-H_CC/2,-DELTA])
        cylinder($fn=FN, h = thk+2*DELTA, d = H_D);
        translate([W-H_O,H_CC/2,-DELTA])
        cylinder($fn=FN, h = thk+2*DELTA, d = H_D);
    }
    
}

    module base(size, fr)
    {
        x = size[0];
        y = size[1];
        z = size[2];
        minkowski()
        {
            cylinder($fn=FN, h = z/2, d= fr);
            cube([x-fr,y-fr,z/2]);
        } 
    }
