// BezQuadCurve from https://www.thingiverse.com/thing:8443/#files

DEBUG = false;
display = "all";

joinfactor = 0.125;

gFocalPoint = [0,0];
gSteps = 30;
gHeight = 2;

if (display == "mount" || display == "all") {
    mount();
}
if (display == "lock" || display == "all") {
    lock();
}

module lock()
{
    color("red")
    difference()
    {
        union()
        {
            translate([-1, 2.5, 0])
            rotate([90, 0, 0])
            rotate([0, 90, 0])
            BezQuadCurve( [[0, 48],[0,25],[25,12],[30,23]], [35,35], gSteps, gHeight);

            hull()
            {
                translate([0, -18/3, 48+18/2])
                rotate([0, 90, 0])
                cylinder( d = 18, h = 2, $fn = 100, center = true);

                translate([0, 55-9.5, 48/2])
                rotate([0, 90, 0])
                cylinder( d = 18, h = 2, $fn = 100, center = true);
            };
        }
        
        translate([0, -10+2.1, 48-4])
        cube( [ 8, 20, 8], center = true );

        translate([0, 55-16.5-9/2, 48/2])
        rotate([0, 90, 0])
        cylinder( d = 9, h = 15, $fn = 100, center = true);
        
        U_hole();
    }
}

module mount()
{
    difference()
    {
        translate([0, 4.5, 0]) U_shape();
        V_shape();
        U_hole();
    }
}

module U_shape()
{
    rotate(180)
    rotate_extrude(angle = 180, convexity = 60, $fn = 100)
    translate([2.5, 0, 0])
    square(size = [ 2, 48 ]);

    translate([2/1 + 1.5, (55-4.5)/2, 48/2])
    cube(size = [ 2, 55-4.5, 48 ], center = true);

    translate([-2/1 - 1.5, (55-4.5)/2, 48/2])
    cube(size = [ 2, 55-4.5, 48 ], center = true);
}

module V_shape()
{
    hull() {
        translate([0, 0, 48/2])
        cube([15, 1, 48-8*2], center = true);

        translate([0, 55-16.5-9/2, 48/2])
        rotate([0, 90, 0])
        cylinder( d = 9, h = 15, $fn = 100, center = true);
    }
}

module U_hole()
{
    translate([0, 55-9.5, 48/2])
    rotate([0, 90, 0])
    cylinder( d = 1, h = 15, $fn = 100, center = true);
}



//=======================================
// Functions
//=======================================
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function PointAlongBez4(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

//=======================================
// Modules
//=======================================
// c - ControlPoints
module BezQuadCurve(c, focalPoint, steps=gSteps, height=gHeight)
{
	// Draw control points
	// Just comment this out when you're doing the real thing
	if (DEBUG) {
        for(point=[0:3])
        {
            translate(c[point])
            color([1,0,0])
            cylinder(r=1, h=height+joinfactor);
        }
    }
    
	for(step = [steps:1])
	{
		linear_extrude(height = height, convexity = 10) 
		polygon(
			points=[
				focalPoint,
				PointAlongBez4(c[0], c[1], c[2],c[3], step/steps),
				PointAlongBez4(c[0], c[1], c[2],c[3], (step-1)/steps)],
			paths=[[0,1,2,0]]
		);
	}
}

//==============================================
// Test functions
//==============================================
//PlotBEZ0(100);
//PlotBEZ1(100);
//PlotBEZ2(100);
//PlotBEZ3(100);
//PlotBez4Blending();


module PlotBEZ0(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ03(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ1(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ13(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ2(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ23(step/steps)*cubeHeight]);
	}	
}

module PlotBEZ3(steps)
{
	cubeSize = 1;
	cubeHeight = steps;

	for (step=[0:steps])
	{
		translate([cubeSize*step, 0, 0])
		cube(size=[cubeSize, cubeSize, BEZ33(step/steps)*cubeHeight]);
	}	
}

module PlotBez4Blending()
{
	sizing = 100;

	translate([0, 0, sizing + 10])
	PlotBEZ0(100);

	translate([sizing+10, 0, sizing + 10])
	PlotBEZ1(100);

	translate([0, 0, 0])
	PlotBEZ2(100);

	translate([sizing+10, 0, 0])
	PlotBEZ3(100);
}
