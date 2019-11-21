//[Basic Cube Settings]
// the size in mm of the cubes. The gap will be subtracted
size = 20; //[10-50]

// [mm] The minimal distance you can print without glueing neighboring objects together. This value will be used as distance between the cubes and within the mechanics. This should be slightly larger than your layer height
gap = 0.70; //[0.30-0.90]

// How many rows to print, it will always be 2 wide so the actual number of cubes is twice this number
numRows=6; //[2-12]

// diameter of the center pin
pinDia=8;

showCutaway=false; // [true,false]


//[Hidden]
$fn=60;
//$fa=4;
//$fs=0.4;
small=0.02;



module doCubes(num)
{
    translate([0,(size-gap)/2,0])
    for (i=[0:num-1])
    {
        translate([0,i*size,0])
        cube([size,size-1*gap,size],center=true);

    }
}

module doHinge(num,gap)
{
    translate([0,0.15*size-gap,0])
    rotate([-90,0,0])
    cylinder(d=pinDia+1*gap, h=size*(num-.3)+2*gap);
    
    for (i=[0:num-1])
    {
        translate([0,(i+.5)*size,0])
        rotate([-90,0,0])
        cylinder(d1=1.4*pinDia+1*gap,d2=pinDia+gap, h=0.1*size/2+gap/2);
        
        translate([0,(i+.5)*size,0])
        rotate([90,0,0])
        cylinder(d1=1.4*pinDia+1*gap,d2=pinDia+gap, h=0.1*size/2+gap/2);

    }
    
}
//!doHinge(numRows,gap);

module doFaces(num,letters)
{
    for (i=[0:num-1])
    {
        translate([0,(i+.5)*size,size/2-1])
        linear_extrude(height=2)
        text(text=letters[i],size=size*.7,halign="center",valign="center");

    }
}
//!doFaces(6,"ABCDEF");


difference()
{
    doCubes(numRows);

    doHinge(numRows,gap);

    doFaces(numRows,"O :X#+");
    
    rotate([0,90,0])
    doFaces(numRows,"X#X+ X");
    
    rotate([0,180,0])
    doFaces(numRows,"::::::");
    
    rotate([0,270,0])
    doFaces(numRows,"+XX#XO");
    
    translate([0,-1,0])
    rotate([-90,0,0])
    linear_extrude(height=2)
    text(text="#",size=size*.7,halign="center",valign="center");

    if (showCutaway)
    {
        translate([0,-1,0])
        cube([200,200,200]);
    }
       
}

doHinge(numRows,0);


