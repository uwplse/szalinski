/////////// Customizer section
//Text
text="Dreams";
//Text size
letter_size = 10;

/////////////////
diam=66;
thickness=3;
cube_size=6.8;
cube_gap=.5;

//translate([0,0,5])        // Uncomment to get assembled view
translate([diam+15,0,0])  // Uncomment to get both details at one print
Manhole(); 
Base(); // Uncomment to get the manhole base

module Foot(flen=diam/17, fwidth=diam/10)
{
    translate([diam/2,0,thickness/2])scale([flen,fwidth,thickness])cube(1,center=true);
}

module Foots(flen=diam/17, fwidth=diam/10)
{
    Foot(flen,fwidth);
    rotate([0,0,90])Foot(flen,fwidth);
    rotate([0,0,180])Foot(flen,fwidth);
    rotate([0,0,-90])Foot(flen,fwidth);

}

module ManholeBase()
{
    cylinder(d=diam, h=thickness, $fn=64);
    Foots();
}

font = "Calibri";
//font = "Arial";


letter_height = 2;

module letter(l) {
  translate([0,0,-letter_height / 2])
  {
    linear_extrude(height = letter_height, convexity = 10) {
   
        text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16, spacing=1);
    }
  }
}


module InnerPattern()
{
    /*translate([-cube_gap/2,-cube_gap/2,0]);
    for(i=[-10:1:10])
    {
        for(j=[-10:1:10])
        {
            translate([i*cube_size, j*cube_size,0])
            scale([cube_size-cube_gap,cube_size-cube_gap,1])cube(1);
        }
    }*/
    min_diam=30;
    max_diam=diam-15;
    n_circles=2;
    
    for(i=[0:1:n_circles])
    difference()
    {
        di=min_diam+(max_diam-min_diam)*i/n_circles; // Current diam
        cylinder(d=di+2, , h=thickness-2, $fn=64);
        cylinder(d=di, , h=thickness+.1, $fn=64);
    }
}


module Manhole()
{
    difference()
    {

        union()
        {
            difference()
            {
                union()
                {
                    ManholeBase();

                    translate([0,0,3])
                    intersection()
                    {
                       InnerPattern();
                        
                        cylinder(d=diam-8, h=thickness, $fn=64);   
                    }

                    difference()
                    {
                        cylinder(d=diam-2, , h=thickness+1.5, $fn=64);
                        cylinder(d=diam-5, , h=thickness+2.1, $fn=64);
                    }
                }
                cylinder(d=3, h=10, $fn=64);
            }

            translate([-.3,-0.3,3])
            scale([52.25,13,2]) cube(1,center=true);
        }

        translate([0,0,4])
        letter(text);
    }
}

module Base()
{
    height=8;
    gap=1;
    difference()
    {
        union()
        {
            cylinder(d=diam+gap+4, h=height, $fn=64);
            cylinder(d=diam+gap+2*height, h=2, $fn=64);
        }
        translate([0,0,-.05])
        cylinder(d=diam+gap, h=height+.1, $fn=64);
        translate([0,0,5])
        //minkowski()
        {
            Foots(10,diam/9);
            //sphere(.5);
        }
    }
    difference()
    {
        cylinder(d=diam+gap+4, h=height/2, $fn=64);
        translate([0,0,-.05])
        cylinder(d=diam-2, h=height/2+.1, $fn=64);
    }

    for(i=[0:1:4])
    rotate([0,0,45+90*i])
    translate([diam/2+gap,0,height/2])
    rotate([90,0,0])
    Right_Angled_Triangle(a=height*.75, b=height*.75, height=2, centerXYZ=[false,true,false]);
}


// I used two functions by Tim Koopman.
/*
Triangles.scad
 Author: Tim Koopman
 https://github.com/tkoopman/Delta-Diamond/blob/master/OpenSCAD/Triangles.scad

         angleCA
           /|\
        a / H \ c
         /  |  \
 angleAB ------- angleBC
            b

Standard Parameters
	center: true/false
		If true same as centerXYZ = [true, true, true]

	centerXYZ: Vector of 3 true/false values [CenterX, CenterY, CenterZ]
		center must be left undef

	height: The 3D height of the Triangle. Ignored if heights defined

	heights: Vector of 3 height values heights @ [angleAB, angleBC, angleCA]
		If CenterZ is true each height will be centered individually, this means
		the shape will be different depending on CenterZ. Most times you will want
		CenterZ to be true to get the shape most people want.
*/



module Right_Angled_Triangle(
			a, b, height=1, heights=undef,
			center=undef, centerXYZ=[false, false, false])
{
	Triangle(a=a, b=b, angle=90, height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}

/* 
Triangle
	a: Length of side a
	b: Length of side b
	angle: angle at point angleAB
*/
module Triangle(
			a, b, angle, height=1, heights=undef,
			center=undef, centerXYZ=[false,false,false])
{
	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCA = ((heights==undef) ? height : heights[2])/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCA);

	// Calculate Offsets for centering
	offsetX = (center || (center==undef && centerXYZ[0]))?((cos(angle)*a)+b)/3:0;
	offsetY = (center || (center==undef && centerXYZ[1]))?(sin(angle)*a)/3:0;
	
	pointAB1 = [-offsetX,-offsetY, centerZ-heightAB];
	pointAB2 = [-offsetX,-offsetY, centerZ+heightAB];
	pointBC1 = [b-offsetX,-offsetY, centerZ-heightBC];
	pointBC2 = [b-offsetX,-offsetY, centerZ+heightBC];
	pointCA1 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ-heightCA];
	pointCA2 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ+heightCA];

	polyhedron(
		points=[	pointAB1, pointBC1, pointCA1,
					pointAB2, pointBC2, pointCA2 ],
		triangles=[	
			[0, 1, 2],
			[3, 5, 4],
			[0, 3, 1],
			[1, 3, 4],
			[1, 4, 2],
			[2, 4, 5],
			[2, 5, 0],
			[0, 5, 3] ] );
}
