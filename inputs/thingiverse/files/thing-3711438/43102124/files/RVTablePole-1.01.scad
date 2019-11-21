// version 1.01

// adjust this for the diameter of the table pole
POLEDIA=73;



// you probably dont need to adjust any value below here
WIDTH=25;
THICK=5;

DEPTH=POLEDIA+(THICK*2);
HEIGHT=POLEDIA+THICK;

CLIP=30;

SCREWHOLE=4;
COUNTERSINK=10;


difference()
{
    union()
    {
        translate([0,0,WIDTH/2])
        rotate([-90,0,0])
        cylinder(d=WIDTH,h=DEPTH,$fn=90);
        cube([HEIGHT,DEPTH,WIDTH]);
    }
	
	
    translate([-WIDTH/2,-1,0-1])
    cube([WIDTH/2+POLEDIA/2,POLEDIA+THICK+1,WIDTH+2]);
    
    translate([POLEDIA/2,POLEDIA/2+THICK,-1])
    cylinder(d=POLEDIA,h=WIDTH+2,$fn=90);

	// champher for the shoe molding 
	// under the couch
	translate([HEIGHT,DEPTH-CLIP/1.5,-1])
	rotate([0,0,45])
	color("red")    
	cube([CLIP,CLIP,WIDTH+2]);

	
	
	// upper screw hold
	translate([0,0,WIDTH/2])
	rotate([-90,0,0])
	cylinder(h=DEPTH+1,d=SCREWHOLE,$fn=90);

	// upper chamfer
	translate([0,POLEDIA+THICK,WIDTH/2])
	rotate([-90,0,0])
	cylinder(h=THICK,d2=0,d1=COUNTERSINK,$fn=90);

	// lower scew hold
	translate([POLEDIA/2-WIDTH/2,0,WIDTH/2])
	rotate([-90,0,0])
	cylinder(h=DEPTH+1,d=SCREWHOLE,$fn=90);

	// lower chamfer
	translate([POLEDIA/2-WIDTH/2,POLEDIA+THICK,WIDTH/2])
	rotate([-90,0,0])
	cylinder(h=THICK,d2=0,d1=COUNTERSINK,$fn=90);
}
    


//round the end the bracket
translate([POLEDIA/2,0,WIDTH/2])
color("green")
rotate([-90,0,0])
cylinder(d=WIDTH,h=THICK,$fn=90);
