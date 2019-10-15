// Measure left to right of monitor base from outer edge of monitor's rubber feet (mm).
Stand_Width = 200;          // [100:300]

// Measure front to rear of monitor base (mm).
Stand_Depth = 170;          // [100:300]

// Overall height of the stand (mm).
Stand_Height = 125;         // [80:300]

// Width of side walls, should at least match the diameter of the monitor's rubber feet.
Wall_Width = 20;            // [10:50]

// Applies to the thickness of everything.
Overall_Thickness = 4.1;    // [0.1:0.1:9.9]

// Adds error compensation to interlock joint gaps, use the fitment test print to trial for your printer.
Fitment_Adjust = 0.8;       // [0:0.1:3]

// Leave off to speed up viewing, enable before creating.
Rounded_Corners = "No";     // [Yes,No]

// Select part to view.
Build = "Assembled";        // [Wall:Wall,Support:Support,Assembled:Assembled Stand,Fit_Test:Joint fitment test, Print_Bed:All 3 parts laid out for printing]

/* [Hidden] */

WW = Wall_Width;                                    // Wall Width
TH = Overall_Thickness;                             // Thickness
L = Stand_Width - WW - TH;                          // Length
W = Stand_Depth;                                    // Width
H = Stand_Height;                                   // Height
FW = 10;                                            // Section Frame Width
CW = 22;                                            // Center Width
R = (Rounded_Corners == "Yes" ? 3.5 : 0);           // Rounded Edge Radius
TA = Fitment_Adjust;                                // Joint gap fitment compensation adjustment
SW = 15;                                            // Support Width
SH = 20;                                            // Support Height
TL = 80;                                            // Triangle Length
LH = 25;                                            // Latch Height
LP = 1;                                             // Latch Position
HP = 10;                                            // Hole Position
HH = 20;                                            // Hole Height
HW = 16;                                            // Hole Width
GH = 23.6;                                          // Gap Height
GW = 5.3;                                           // Gap Width
WR = ((W / 2) - ((TH + FW) * 2) - (CW / 2)) / 2;    // Frame void radius if height is within limit
HR = (H - TH - (FW * 2)) / 2;                       // Frame void radius if height is outside limit
$fn = 40;                                           // Number of sides in a circle

// Build wall
if(Build == "Wall")
{
    wall();
}

// Build support
else if(Build == "Support")
{
    support();
}


// Build assembled stand
else if(Build == "Assembled")
{
    rotate(a = [180, 0,0])
    {
        support();
       
        for(X = [1, -1])
            translate(v = [(L + TH) / 2 * X, 0, (H - TL) / 2])
                rotate(a = [0, 0, 90 * X])
                    wall();
    }
}

else if(Build == "Fit_Test")
{
    // Create latch hole only.
    translate(v = [0, 0, H / 2])
        difference()
        {
            wall();

            translate(v = [(W / 4) + (CW / 2) + TH, 0, 0])
                cube(size = [W / 2, WW * 2, H * 1.1], center = true);
            translate(v = [-(W / 4) - (CW / 2) - TH, 0, 0])
                cube(size = [W / 2, WW * 2, H * 1.1], center = true);
            translate(v = [0, 0, H / 2])
                cube(size = [CW + (TH * 3), WW * 2, (H * 2) - (TL * 2)], center = true);
        }
    
    // Create latch tab only.
    translate(v = [(L / 2) - (TL / 2), 0, TL / 2])
        difference()
        {
            support();
            
            translate(v = [15, 0, 0])
                cube(size = [L, SW * 1.1, H], center = true);
        }
}

else if(Build == "Print_Bed")
{   
    rotate(a = [0, 0, 45])
    {
        translate(v = [0, 0, TL / 2])
        support();
        for(X = [1, -1])
        translate(v = [0, X * WW * 1.5, H / 2])
        wall();
    }
}

module support()
{
    rotate(a = [180, 0, 0])
        difference()
        {
            union()
            {
                translate(v = [0, 0, (TL / 2) - (SH / 2)])
                    difference()
                    {
                        cube(size = [L, SW, SH], center = true);

                        for(X = [1, -1])
                            translate(v = [0, X * ((SW / 2) - (((SW / 2) - TH) / 2)), -TH / 2 - 0.01])
                                cube(size = [L - (TH * 2), SW / 2, SH - TH], center = true);
                    }
       
                for(X = [1, -1])
                {
                    translate(v = [((L / 2) - (TL / 2)) * X, 0, 0])
                        triangle(size = [TL, SW, TL], dir = X);          

                    translate(v = [((L / 2) + (((TH * 2) + TA) / 2) - 0.01) * X, 0, -LP])
                        difference()
                        {
                            cube(size = [(TH * 2) + TA, SW, LH], center = true);

                            for(Y = [1, -1])
                                translate(v = [-X * (TH / 2), Y * SW / 1.5, 0])
                                    cube(size = [TH + TA, SW, LH + 0.01], center = true);

                            translate(v = [(TA + (TH * 2)) / 2 * -X, -SW, LH / 2])
                                rotate (a = [0, 180 + (-90 * X) - 45, 0])
                                    cube(size = [(TA + TH) * 6, SW * 2, (TA + TH) * 6]);
              
                            for(Y = [1, -1])
                                translate(v = [(-0.01 * X) + TH - (TA / 2 * -X) + (TH * X), SW * 0.1666 * Y, (LH / 2) - TA - TH])
                                    rotate (a =[0, 45 - 90 + (90 * Y), 90])
                                        cube(size = [TH * 2, TH * 2, TH * 2]);

                            for(Y = [1, -1])
                                translate(v = [(-0.01 * X) +  - (TA / 2 * -X) + (TH * X), SW * 0.1666 * Y, -(LH / 2)])
                                    rotate (a =[45 - (45 * Y), 45 + 90 + (90 * X), 0])
                                        cube(size = [TH * 2, TH * 2, TH * 2]);
                        }
                }
            }

            for(X = [1, -1])
                for(Y = [1, -1])
                    translate(v = [((L / 2) - (TL / 2) + (TH / 1.5)) * X, Y * ((SW / 2) - (((SW / 2) - TH) / 2)), TH / 1.5])
                        triangle(size = [TL - (TH * 3.5), SW / 2, TL - (TH * 3.5)], dir = X);
        }
}

module wall()
{
    rotate(a = [180, 0, 0])
        difference()
        {
            // Main wall structure
            cube(size = [W, WW, H], center = true);
   
            // Remove outside section material
            for(X = [1, -1])
                for(Y = [1, -1])
                {
                    // Remove to create inset area
                    translate(v = [(W + CW) / 4 * X, Y * ((WW / 2) - (((WW / 2) - TH) / 2)), -TH])
                        roundedBox(size = [(W / 2) - (TH * 2) - (CW / 2), WW / 2, H], center = true, radius = R);

                    // Remove to create hole/frame
                    if(H - TH - FW - FW < (WR * 2))                   // Check if frame radius is valid for given height
                    {
                        // Frame radius is too big for height, limit for given height instead
                        translate(v = [(W + CW) / 4 * X, 0, (((H - TH) / 2) - HR - FW) - (TH / 2)])                    
                            rotate(a = [90, 0, 0])
                                cylinder(r = HR, h = WW / 2, center = true);
                    }
                    
                    else
                    {
                        for(Z = [1, -1])
                            translate(v = [(W + CW) / 4 * X, 0, (Z * (((H - TH) / 2) - WR - FW)) - (TH / 2)])                    
                                rotate(a = [90, 0, 0])
                                    cylinder(r = WR, h = WW / 2, center = true);
                        translate(v = [(W + CW) / 4 * X, 0, -TH / 2])
                            cube(size = [(W / 2) - ((TH + FW) * 2) - (CW / 2), WW / 2, (2 * (((H - TH) / 2) - WR - FW)) - (TH / 2)], center = true);
                    }
                }
            
            // Remove to create inset in middle
            translate(v = [0, ((WW / 2) - (((WW / 2) - TH) / 2)), -TH])
                roundedBox(size = [CW, WW / 2, H], center = true, radius = R);
            translate(v = [0, -((WW / 2) - (((WW / 2) - TH) / 2)), 0])
                cube(size = [CW, WW / 2, H + 0.01], center = true);
                
            // Remove hole and channel for center support interlock
            translate(v = [0, 0, (H / 2) - HP - (HH / 2)])
            {
                cube(size = [HW, TH + 0.01, HH], center = true);
                translate(v = [0, 0, -(GH + HH - 0.01) / 2])
                    cube(size = [GW + TA, TH + 0.01, GH], center = true);
            }

            // Angle hole for printing
            for(X = [1, -1])
                translate(v = [X * HW / 2, -TH, (H / 2) - HP - HH])
                    rotate(a = [0, 45 + 90 + (X * 90), 0])
                        cube(size = [HW / 2, HW / 2, HW / 2]);
        }
}

module triangle(size, dir)
{
    difference()
    {
        cube(size, center = true);
    
        translate(v = [-(dir * size[0] / 2), -size[1], size[2] / 2])
            rotate(a = [0, 135, 0])
                cube(size = [size[0] * 1.5, size[1] * 2, size[2] * 1.5]);
    }
}

// --- from MCAD/boxes.scad
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly)
	{
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
			y = [radius-size[1]/2, -radius+size[1]/2])
		{
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else
	{
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2])
		{
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
				y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2])
			{
				rotate(rot[axis])
				translate([x,y,0])
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
			y = [radius-size[1]/2, -radius+size[1]/2],
			z = [radius-size[2]/2, -radius+size[2]/2])
		{
			translate([x,y,z]) sphere(radius);
		}
	}
}