// Number of towers
towers = 3;

//Width of towers
width = 1.5;

//Height of towers
height = 5;

//Base thickness
base = 1;

// Spacing between pegs

//Small Spacing
small = 3;

//Large Spacing
large = 5;


for (x = [0.5:towers])
    for (y = [0.5:towers])
        translate([y*large,x*small,0])
    cylinder(h=height,d=width,$fn=36);
    
cube([large*towers,small*towers,base]);
