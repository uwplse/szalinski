/*
 * A multi-purpose stacked hexagonal storage.
 * It can be stacked in 3 different ways:
 * - stacked on top of each other with simple rails,
 * - stacked underneath of each other with grips, but these are almost impossible to print,
 * - stacked underneath of each other with more elaborate rails which fit perfectly.
 * Note that the grips cannot be easily printed and weren't a success, I'm leaving them here if anyone wants to improve them.
 * It can be attached to a wall with 2 screws (or more if you wish so - the file is easy to modify).
 * Adjust the different parameters of your storage (diameter, number of holes, length of the holes, presence of rails or fixing holes).
 * Be aware that this can be very demanding in calculation, you may want to set the "Turn off rendering at..." value in the preferences much higher.
 * Also make sure that the total size of the final result fits in your printer.
 * A final note on the stacking evolved rails: make sure in the slicer that the bottom part of the bottom rails gets at least one thickness of printing.
 */


//------------------------------------------------------------
// Hexagon
// key	overall size (like key numbers)
// h	height
//------------------------------------------------------------
module hexagon(key,h)
{
	angle = 360/6;		// 6 sides
	side = key * cot(angle);

	union()
	{
		rotate([0,0,0])
			cube([key,side,h],center=true);
		rotate([0,0,angle])
			cube([key,side,h],center=true);
		rotate([0,0,2*angle])
			cube([key,side,h],center=true);
	}
}

// Cotangent function
function cot(x)=1/tan(x);

// One hexagon in the hive
module hivepart(size, thickness, deepness, angle)
{
	union()
	{
		// Intersect the part with a cube to make it straight
		intersection()
		{
			rotate([angle, 0, 0]) difference()
			{
				// The main frame
				hexagon(size+thickness, deepness * 2);
				// The hexagonal hole
				translate([0, 0, 1]) hexagon(size, deepness * 2 + 3);
			}
			cube([size + thickness * 4, size / cos(angle) * 4, deepness], center=true);
		}
		// The back of the hive to close it and add some strength
		intersection()
		{
			rotate([angle, 0, 0]) hexagon(size+thickness, deepness * 2);
			translate([0, 0, -deepness/2]) cube([size*3, size*3, 1], center=true);
		}
	}
}

// A simple prism
module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

// The part of the bottom rail that makes sure there is no hole at the bottom from the rail
module railfiller(size1, size2, height, angle)
{
	intersection()
	{
		rotate([angle, 0, 0]) linear_extrude(height=height/cos(angle), center=true) polygon(points=[[0, 0], [0, size1], [size2, -abs(size2)*cos(60)]]);
		cube([abs(size2)*2, height+size1, height], center=true);
	}
}

// Both the top and bottom rails. The bottom one should of course be larger in order for the top on of the underneath piece to be able to fit in
module rail(railwidth, railheight, deepness, angle)
{
	distance=10;// from the edges
	translate([-railwidth/2, -railheight/2/cos(angle), 0]) rotate([angle, 0, 0]) translate([0, 0, -deepness/2+distance/2]) difference()
	{
		cube([railwidth, railheight+1, deepness-distance*2]);
		rotate([-15, 0, 0]) translate([-railwidth, 0, 0]) cube([railwidth*2, deepness, deepness]);
		translate([-railwidth, 0, deepness-distance*2]) rotate([-75, 0, 0]) cube([railwidth*2, deepness, deepness]);
	}
}

// A fixation for screws, adjust the size in the main part of the program
module wallfixation(small, big)
{
	translate([0, 0, -1]) union()
	{
		$fn=50;
		cylinder(h=4, r=small/2);
		translate([0, 0, 3]) cylinder(h=6, r=big/2);
		translate([0, -big, 0]) cylinder(h=9, r=big/2);
		translate([0, -big/2, 0]) cube([small, big, 12], center=true);
		translate([0, -big/2-3, 2]) cube([big, big-6, 12], center=true);
		translate([0, -big/2, 6]) cube([big, big, 6], center=true);
	}
}

// The bottom hole part of stacking grips
module stackgripbottomhole(angle)
{
	rotate([angle, 0, 0]) union()
	{
		translate([0, -1, 0]) cube([8, 10, 6], center=true);
		translate([0, 2, -4]) cube([8, 4, 8], center=true);
		translate([0, -1, -4]) cube([3, 5, 8], center=true);
	}
}

// The bottom filled part of the stacking grips
module stackgripbottomfiller(angle)
{
	rotate([angle, 0, 0]) union()
	{
		translate([0, 0, -6]) linear_extrude(height=6, center=true) polygon(points=[[0, 0], [5, 0], [5, -5*cos(60)]]);
		translate([0, 0, -9]) polyhedron(
			points=[[0, 0, 0], [5, 0, 0], [5, -5*cos(60), -8], [5, -5*cos(60), 0]],
			faces=[[0, 2, 1], [1, 2, 3], [1, 3, 2]]
		);
		translate([0, 0, -6]) linear_extrude(height=6, center=true) polygon(points=[[0, 0], [-5, 0], [-5, -5*cos(60)]]);
		translate([0, 0, -9]) polyhedron(
			points=[[0, 0, 0], [-5, 0, 0], [-5, -5*cos(60), -8], [-5, -5*cos(60), 0]],
			faces=[[0, 1, 2], [1, 2, 3], [1, 3, 2]]
		);
	}
}

// The top hollow part of the stacking grips
module stackgriptopholes(angle)
{
	rotate([angle, 0, 0]) difference()
	{
		union()
		{
			translate([0, -0.8, -5.5]) cube([2.5, 2, 4.8], center=true);
			translate([0, 0, -5.5]) cube([8, 8, 4.8], center=true);
		}
	}
}

// The top filled part of the stacking grips
module stackgriptop(angle)
{
	rotate([angle, 0, 0]) difference()
	{
		union()
		{
			translate([0, -0.8, -5.5]) cube([2.5, 3, 4.8], center=true);
			translate([0, 1.55, -5.5]) cube([8, 3, 4.8], center=true);
		}
	}
}

// The elaborate bottom rail.
module stackrailbottom(deepness, angle)
{
	intersection()
	{
		translate([0, 0, -0.25]) cube([200, 200, deepness+0.5], center=true);
		rotate([angle, 0, 0]) cube([9, 3.6, deepness+40], center=true);
	}
}

// The elaborate top rail.
// Note that we can make it thicker at the bottom so that the top one will be able to fit in.
// The parameter "filled" allows that: when it is true, then we are creating the top rail, and false when creating the bottom one (larger).
module stackrailtop(deepness, angle, filled)
{
	intersection()
	{
		translate([0, 0, -0.25]) cube([200, 200, deepness+0.5], center=true);
		rotate([angle, 0, 0]) union()
		{
			translate([0, 0.5, 0]) cube([filled ? 6 : 7, filled ? 1.5 : 2.5, deepness+40], center=true);
			translate([0, -1.1, 0]) cube([filled ? 2.4 : 3.5, 1.8, deepness+40], center=true);
		}
	}
}

/**************************************
 * ADJUST THOSE VALUES TO YOUR NEEDS. *
 **************************************/
// spices
hsize=48;// diameter of each hole
deepness=85;// deepness of the storage
interval=1;// thickness of the walls
lines=4;// number of lines
columns=2;// number of columns

/* waste bags
hsize=60;// diameter of each hole
deepness=150;// deepness of the storage
interval=1;// thickness of the walls
lines=3;// number of lines
columns=2;// number of columns
*/

// pens
/*hsize=14;// diameter of each hole
deepness=90;// deepness of the storage
interval=1;// thickness of the walls
lines=9;// number of lines
columns=6;// number of columns*/

//test values
/*hsize=14;
deepness=40;
interval=1;
lines=2;
columns=2;*/

// Rails for stacking *on top* of each other.
rails=false;
railheight=2;// height of the rails - default value should be ok
railwidth=1;// width of the rails - default value should be ok

// Holes to fit in screws to put the storage on a wall
wallfixation=true;
wallscrewsmalldiam=6;// you may need to add 1mm to the size of your actual screw for it to be able to fit in
wallscrewbigdiam=10.5;// add at least 0.5 mm to the actual size of the screw, possibly more

// These are grips. If you manage to print them, I'd love to hear from you!
stackgripstopholes=false;
stackgripstoponly=false;
stackgripsbottom=false;
stackgripshalfdistance=26;

// These are elaborate rails in order to stack storage pieces under one that is fixed to a wall.
// You would probably not want to stack those on top of each other as it would put too much pressure forward on the screws.
stackrailtop=true;// Add a top rail
stackrailbottom=true;// Add a bottom rail

// Angle of the hive for objects not to fall out.
// You may not want an angle at all to put non-breakable things (such as waste bags) in it.
// This angle should be negative.
angle=-6;// -6 for spices
// If it is at an angle, add a stand at the front to make it stay straight
addstand=false;

// Calculated values, do not touch from here unless you know what you are doing!
space=hsize+interval;
evencols = (columns % 2 == 0);
railoffset=space*cot(60);

if (stackgripstoponly)
// This part is to print only the grips without the storage itself
{
	translate([0, -stackgripshalfdistance*sin(angle), +stackgripshalfdistance*cos(angle)]) stackgriptop(angle);
	translate([0, +stackgripshalfdistance*sin(angle), -stackgripshalfdistance*cos(angle)]) stackgriptop(angle);
	extrz = stackgripshalfdistance*cos(angle) + 5;
	posy = 3*sin(30);
	thickx = 6*cos(30);
	thicky = -6*sin(30);
	translate([0, -3.6, -5.5]) rotate([angle, 0, 0]) polyhedron(
		points=[
			[0, posy, extrz],// 0 = top point front
			[0, posy, -extrz],// 1 = top point back
			[thickx, posy+thicky, -extrz],// 2 = right point back
			[thickx, posy+thicky, extrz],// 3 = right point front
			[-thickx, posy+thicky, extrz],// 4 = left point front
			[-thickx, posy+thicky, -extrz]],// 5 = left point back
		faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
}
else
// Print a full storage
{
	difference()
	{
		union()
		{
			// The main hive parts - fillers
			for (y = [0:columns-1])
			{
				even = (y % 2 == 0);
				for (x = [0: (even ? lines-1 : lines-2)])
					translate([space*x + (even?0:space/2), y * space * cos(30) / cos(angle), 0]) hivepart(hsize, interval, deepness, angle);
			}
			if (addstand)
			{
				difference()
				{
					union()
					{
						translate([space*(lines-1)/2, space/2-space/cos(30)/2+(deepness/2+3.5)*tan(angle), -0.25]) cube([space*(lines-1), space, deepness+0.5], center=true);
					}
					union()
					{
						for (y = [0:columns-1])
						{
							even = (y % 2 == 0);
							for (x = [0: (even ? lines-1 : lines-2)])
								translate([space*x + (even?0:space/2), y * space * cos(30) / cos(angle), 0]) rotate([angle, 0, 0]) hexagon(hsize+interval, deepness * 2);
						}
					}
				}
			}
			if (rails)
			{// Simple stacking rails (for stacking on top of each other) - the top rails and the bottom rail fillers
				for (x = [0: (evencols == 0 ? lines-1 : lines-2)])
					translate([space*x+(evencols?space/2:0), (columns-1)*space*cos(30)+space/2/sin(60)+(railheight/2)/cos(angle), 5]) rail(railwidth, railheight, deepness, angle);
				for (x = [0: lines-2])
					translate([space*x+space/2, -railoffset/2/cos(angle), 0]) union()
					{
						railfiller(railheight*4,  railwidth*3, deepness, angle);
						railfiller(railheight*4, -railwidth*3, deepness, angle);
					}
			}
			if (wallfixation)
			{// Screw holes
				$fn=50;
				// The main cylinders that will actually hold the screw - we are filling here
				// The right one
				translate([space*(lines-2)+space/2, (railoffset/2+1)/cos(angle)+deepness/2*sin(angle), -deepness/2]) cylinder(h=10, r1=wallscrewbigdiam/2+1, r2=wallscrewsmalldiam);
				// The left one
				translate([space/2,                 (railoffset/2+1)/cos(angle)+deepness/2*sin(angle), -deepness/2]) cylinder(h=10, r1=wallscrewbigdiam/2+1, r2=wallscrewsmalldiam);
			}
			if (stackgripsbottom)
			// Bottom grips - filling
				for (x = [0: lines-2])
				{
					translate([space*x+space/2, -railoffset/2/cos(angle)-stackgripshalfdistance*sin(angle),  stackgripshalfdistance*cos(angle)]) stackgripbottomfiller(angle);
					translate([space*x+space/2, -railoffset/2/cos(angle)+stackgripshalfdistance*sin(angle), -stackgripshalfdistance*cos(angle)]) stackgripbottomfiller(angle);
				}
			if (stackrailbottom)
			// Filler of bottom elaborate rails
				for (x = [0: lines-2])
					translate([space*x+space/2, -(railoffset/2+0.7)/cos(angle), 0]) stackrailbottom(deepness, angle);
			if (stackrailtop)
			// Top elaborate rails / they consist in the rail itself along with a filler underneath to make the structure stronger
				for (x = [0: lines-2])
					translate([space*x+space/2, (space*(columns-1+cos(30)/2)+0)/cos(angle), 0]) union()
					{
						// The rail itself
						stackrailtop(deepness, angle, true);
						// The filler that makes the structure stronger
						intersection()
						{
							extrz = deepness;
							posy = 3*sin(30);
							thickx = 6*cos(30);
							thicky = -6*sin(30);
							translate([0, -1.5/cos(angle), 0]) rotate([angle, 0, 0]) polyhedron(
								points=[
									[0, posy, extrz],// 0 = top point front
									[0, posy, -extrz],// 1 = top point back
									[thickx, posy+thicky, -extrz],// 2 = right point back
									[thickx, posy+thicky, extrz],// 3 = right point front
									[-thickx, posy+thicky, extrz],// 4 = left point front
									[-thickx, posy+thicky, -extrz]],// 5 = left point back
								faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
							);
							// Make sure it stays within the boundaries of the object
							cube([40, 50, deepness], center=true);
						}
					}
		}
		/* FROM HERE, WE ARE SUBSTRACTING */
		if (rails)
		// Bottom rails
			for (x = [0: lines-2])
				translate([space*x+space/2, (-railoffset/2+railheight/2-interval)/cos(angle), 5]) rail(railwidth+1, railheight+1, deepness+4, angle);
		if (wallfixation)
		{// sculpt the two holes for screws
			translate([space*(lines-2)+space/2, (railoffset/2+1)/cos(angle)+deepness/2*sin(angle), -deepness/2]) wallfixation(wallscrewsmalldiam, wallscrewbigdiam);
			translate([space/2,                 (railoffset/2+1)/cos(angle)+deepness/2*sin(angle), -deepness/2]) wallfixation(wallscrewsmalldiam, wallscrewbigdiam);
		}
		if (stackgripsbottom)
			for (x = [0: lines-2])
			{// sculpt grips
				translate([space*x+space/2, -railoffset/2/cos(angle)-stackgripshalfdistance*sin(angle),  stackgripshalfdistance*cos(angle)]) stackgripbottomhole(angle);
				translate([space*x+space/2, -railoffset/2/cos(angle)+stackgripshalfdistance*sin(angle), -stackgripshalfdistance*cos(angle)]) stackgripbottomhole(angle);
			}
		if (stackgripstopholes)
			for (x = [0: lines-2])
			{// Sculpt holes of grips on the top
				translate([space*x+space/2, space*(columns-0.5)*cos(angle)-1/cos(angle)/*-railoffset/2/cos(angle)*/-stackgripshalfdistance*sin(angle), stackgripshalfdistance*cos(angle)]) stackgriptopholes(angle);
				translate([space*x+space/2, space*(columns-0.5)*cos(angle)-1/cos(angle)/*-railoffset/2/cos(angle)*/+stackgripshalfdistance*sin(angle), -stackgripshalfdistance*cos(angle)]) stackgriptopholes(angle);
			}
		if (stackrailbottom)
		// Sculpt the bottom rails - note that we use the same rails than the top ones - the last parameter tells we're subscracting
			for (x = [0: lines-2])
				translate([space*x+space/2, -(railoffset/2+1)/cos(angle), 0]) stackrailtop(deepness, angle, false);
		if (stackrailtop)
			for (x = [0: lines-2])
				translate([space*x+space/2, (space*(columns-1+cos(30)/2)+0)/cos(angle), 0]) difference()
				{
					// Sculpt the main shape around the top rail to scrub out the parts of the beehive that would stand in the way...
					stackrailbottom(deepness, angle);
					// ... but of course keep the rail itself
					stackrailtop(deepness, angle, true);
				}
		//translate([-2, 12, -20]) cube([40, 5, 60]); this is a test cube to put with test values in order to see if the rails fit
	}
}