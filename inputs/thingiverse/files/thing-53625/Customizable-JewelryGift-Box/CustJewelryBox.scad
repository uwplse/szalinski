/*ToDo
1. Customizer Variables
2. Build Flow
*/

//Author: Bennett Marks
//Date: 23-FEB-2013
//Copyright: This autoscad script is made available under Creative Commons
//           You are free to use this work in any manner you desire provided
//           you acknowledge the author and origination

/************ This is a customizable jewelry/gift box with filigree top
 The shape is customizable, as is the filigree design in the top
Optionally you can print out an insert plate that fits behind the filigree. It should be printed
in a different color. This will seal the box but allow the pattern to be prominent.

This script may be edited directly, but is written to run with the Makerbot "Customizer". When run with 
 "Customizer", you may change appropriate parameters without the need to edit the script. This makes it
 easy to play with different box types, patterns and inserts
**************/

//*******************************Customizer parameters

//Customizer Control - You may display the whole assembly or generate each part individually. Note: The top is inverted for printing.
part = "show_all"; //[show_all:Display assembly,body:Box Body STL,top: Box Top STL,insert:Top Insert STL]

//Choose the shape of your container.0=heart, 1=6-sided star, 2=cross, 3-20=n sided, 30-102=circular 103-199=n-sided racetracks 203-299=ovaloids 300-350=rounded rectangles
box_shape=0; //[0:350]

//Set the height of the container in mm
box_height=30; //[10:200]

//Scale the approximate size of largest dimension of the container in mm
box_size=100; //[10:200]

//Set the thickness of bottom, sides and top of box in mm
box_wall_thickness=2; //[1:6]

//Pick a type of pattern for your Filigree top (solid means no filigree)
filigree_type=2; //[0:Solid,1:Linear,2:Radial,3:Circular]

//Pick the pattern shape. Each choice generates a different pattern.
filigree_pattern_shape=1; //[0:60]

//Choose the thickness of the pattern lines - 2-5 tend to look nice
filigree_pattern_thickness=3; //[1:30]

//Rotate the pattern for unique shapes and repetition 
filigree_pattern_rotation=10; //[0:359]

//Overlap the pattern centers and size. 1.5 to 20.0 generate interesting results.
filigree_pattern_radius=2.3; //

//Put in a Pattern Magic number #1 a float between 0.01-100 (The magic #'s interact.)
filigree_magic_one=4.0;	//

//Put in another Pattern Magic number #2 a float between 0.01-100
filigree_magic_two=0.5;	//

//pattern vertical centering - allows you to move the pattern around vertically
filigree_vertical_centering=0; //[-75:75]

//pattern horizontal centering - allows you to move the pattern around horizontally
filigree_horizontal_centering=0; //[-75:75]

//Buildplate - for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1:Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//width of extrusion for print - you shouldn't need to tweak this unless the box top is too loose or too tight
print_extrusion_width=.39; //

//Layer height - typical layer height - you shouldn't need to tweak this unless the top doesn't press all the way down
print_extrusion_height=.25; //

//*******************************Script Parameters
//  For the Print
Pextrwid=print_extrusion_width;	//standard for .35 nozzle (you only need to change this if the box top is too loose or too tight)
Pextrhgt=print_extrusion_height;	//typical extrusion layer height ( shouldn't need to change this unless top doesn't press all the way down)

//  For the Box
Bshape=box_shape;     			//0=heart, 1=6-sided star, 2=cross, 3-20=n sided, 30-102=circular 
								//103-199=n-sided racetracks 203-299=ovaloids 300-399=rounded rectangles
Bheight=box_height;				// interior box height (total height = Bheight+2*Wall height [top & bottom]) [1-150]
Bradius=box_size/2;				// radius of bounding circle of box (overall size) [10-100]
Bwall=box_wall_thickness;		// wall thickness (multiple of extrusion width may result in best print)[.5-6]

//  For the Filigree
Ftype=filigree_type;		//0=solid 1=linear, 2=radial 3=circular
Frotation=filigree_pattern_rotation;	//pattern rotation [0.0 - 359.9]
Fradius=filigree_pattern_radius;	//pattern radius [0.1-100]
Fouterrad=filigree_magic_one;	//pattern outer radius   overlap = outer/inner [.01-100]
Finnerrad=filigree_magic_two;	//pattern inner radius   [.01-100]
Fshape=filigree_pattern_shape;		//pattern shape (0,1 are interesting special cases) [0-100]
Fthickness=filigree_pattern_thickness;	//pattern line thickness[.5-25]

FcenterUpDown=filigree_vertical_centering;		//-75 to +75 allows moving the pattern around up and down for centering
FcenterLeftRight=filigree_horizontal_centering;		//-75 to +75 allows moving the pattern around left and right for centering

use <utils/build_plate.scad> //This is the Buildplate library provided by Makerbot
//Shape Modules
module JStar(rad,hgt)
{
	union()
	{
		cylinder(r=rad,h=hgt,$fn=3);
		rotate([0,0,180])cylinder(r=rad,h=hgt,$fn=3);
	}
}
module Cross(offset,hgt)
{
	union()
	{
		cube([4*Bradius/3-offset,2*Bradius/3-offset,hgt]);
		translate([Bradius/3,-Bradius,0])
			cube([2*Bradius/3-offset,2*Bradius-offset,hgt]);
	}
}
module Heart(size,hgt)
{
	
	scale([size/29,size/29,1])union()
	{
		hull(){translate([3,0,.5*hgt])rotate([0,0,45])cube([18,18,hgt],center=true);
		translate([-3,-6,0])cylinder(r=9,h=hgt,$fn=40);}
		hull(){translate([3,0,.5*hgt])rotate([0,0,45])cube([18,18,hgt],center=true);
		translate([-3,6,0])cylinder(r=9,h=hgt,$fn=40);}
	}
	
}
module Racetrack(rad,hgt)
{
	hull()
	{
		rotate([0,0,180])cylinder(r=rad, h=hgt, $fn=Bshape-100);
		translate([Bradius,0,0])cylinder(r=rad, h=hgt, $fn=Bshape-100);
	}
}
module Ovaloid(offset,hgt)
{
	hull()
	{
		rotate([0,0,180])cylinder(r=Bradius/4+offset, h=hgt, $fn=Bshape-200);
		translate([3*Bradius/4,0,0])cylinder(r=Bradius/2+offset, h=hgt, $fn=Bshape-200);
		translate([3*Bradius/2,0,0])cylinder(r=Bradius/4+offset, h=hgt, $fn=Bshape-200);
	}
}
/* PIZZELLE
This routine generates infinite interesting circular and rotated patterns
	edge=sharpness of edges 3=very sharp 30=very round
	rad=radius of total pattern
	r1=radius of inner loop
	r2=radius of outer loop
	rep=repetition in degrees (e.g. 10=every 10 degrees, or 36 times around the circle)
	rot=rotation around the pattern 360=all the way around 180=halfway
*/
module pizzelle(edge,rad,r1,r2,rep,rot,th,hgt)
{
	union()
	{
	for(pat=[0:rep:rot])
	{
		if(edge<3)
		{
			rotate([0,0,pat])difference()
			{

				hull()
				{
					cylinder(h=hgt,r=th+r1, center=true, $fn=3);
					translate([rad,0,0])cylinder(h=hgt,r=th+r2, center=true, $fn=3);
				}
				hull()
				{
					cylinder(h=hgt+1,r=r1, center=true, $fn=3);
					translate([rad,0,0])cylinder(h=hgt+1,r=r2, center=true, $fn=3);
				}	
			}
		} else
		{
			rotate([0,0,pat])difference()
			{

				hull()
				{
					cylinder(h=hgt,r=th+r1, center=true, $fn=edge);
					translate([rad,0,0])cylinder(h=hgt,r=th+r2, center=true, $fn=edge);
				}
				hull()
				{
					cylinder(h=hgt+1,r=r1, center=true, $fn=edge);
					translate([rad,0,0])cylinder(h=hgt+1,r=r2, center=true, $fn=edge);
				}	
			}
		}
	}
	}
}
/* HONEYCOMB
This routine generates infinite interesting gridded patterns
		w=width of the gridding area
		l=length of the gridding area
		rot=rotation variable
		rad=radius variable
		rmod=radius modifier
		th=base line thickness
		sides=number of side to pattern 0,1,2 are interesting
Based on routine from Makerbot Customizable IPhone scad
*/
module honeycomb(w,l,hgt,rot,rad,rmod,th,sides) //th=thickness
{
	
	columns = l/(rad*3);
	rows = w/((rad*sqrt(3)/2)*2)+1;
	translate([-w/2,l/2,0])
	{
		rotate([0,0,-90])
		{
			for(i = [0:rows])
			{
				
				translate([0,rad*sqrt(3)/2*i*2,0])
				{
					//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns])
					{
						translate([rad*i*3,0,0])
						{
							for(i = [0:1]){
								translate([rad*1.5*i,rad*sqrt(3)/2*i,0])
								{
									rotate([0,0,rot])
									//sides=0 pointy chevron, sides=1 use hull, sides=2 use rectangle
									if(sides == 0)
									{
										difference()
										{
											hull()
											{
												cube([2*(rad+th),rad+th,hgt], center=true, $fn=40);
												rotate([0,0,rot])translate([10*th,0,0])cube([2*(rad+th),rad+th,hgt], center=true, $fn=40);
											}
											hull()
											{
												cube([2*rad,rad,hgt+1], center=true, $fn=40);
												rotate([0,0,rot])translate([10*th,0,0])cube([2*rad,rad,hgt+1], center=true, $fn=40);
											}
										}
									}
									else if(sides == 1)
									{
										difference()
										{
											hull()
											{
												cylinder(h=hgt,r=rad/10+th+(rad*rmod/50), center=true, $fn=40);
												rotate([0,0,rot])translate([10*th,0,0])cylinder(h=hgt,r=th+rad/10+(rad*rmod/50), center=true, $fn=40);
											}
											hull()
											{
												cylinder(h=hgt+1,r=rad/10+(rad*rmod/50), center=true, $fn=40);
												rotate([0,0,rot])translate([10*th,0,0])cylinder(h=hgt+1,r=rad/10+(rad*rmod/50), center=true, $fn=40);
											}
										}
									}
									else if (sides == 2)
									{
										difference()
										{
											cube([2*(rad+th),rad+th,hgt],center=true);
											cube([2*rad,rad,hgt+1],center=true);
										}
									}
									else
									{
										difference()
										{
											if(sides < 5){
												cylinder(h = hgt, r = rad+th+(rad*rmod/50), center = true, $fn = sides);
											} else {
												cylinder(h = hgt, r = rad+(rad*rmod/50), center = true, $fn = sides);
											}
											cylinder(h = hgt+1, r = rad-th+(rad*rmod/50), center = true, $fn = sides);
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

module filigree()
{
	if(Ftype==1)
	{
		translate([FcenterLeftRight,FcenterUpDown,Bwall])honeycomb(200,200,2*Bwall,Frotation,3.5+Fradius,Fouterrad/Finnerrad,Fthickness,Fshape);
	}
	else if(Ftype==2)
	{
		translate([FcenterLeftRight,FcenterUpDown,Bwall])pizzelle(Fshape,Fradius*20,Fouterrad,Finnerrad,Frotation,360,Fthickness,2*Bwall);
	}
	else if(Ftype==3)
	{
		translate([FcenterLeftRight,FcenterUpDown,Bwall])pizzelle(Fshape,Fradius*20,Finnerrad,Fouterrad,Frotation,360,Fthickness,2*Bwall);
	}
	else
		translate([-100,-100,Bwall])cube([200,200,Bwall]); //solid top
}

module makeBox()
{
	color("Gold")
	//Make the box
	if (Bshape == 0) //Heart Box
	{
		difference()
		{
			Heart(Bradius*2,Bheight);
			translate([0,0,Bwall])Heart(2*(Bradius-Bwall), Bheight);
		}
	} else if (Bshape == 1) //Jewish Star Box
	{
		difference()
		{
			JStar(Bradius+2*Bwall,Bheight);
			translate([0,0,Bwall]) JStar(Bradius,Bheight+100);
		}
	} else if (Bshape == 2) //Cross Box
	{
		difference()
		{
			Cross(0,Bheight);
			translate([Bwall,Bwall,Bwall])Cross(2*Bwall,Bheight);
		}
	} else if (Bshape >102 && Bshape <200 ) //Racetrack Box
	{
		difference()
		{
			Racetrack(Bradius/2+Bwall,Bheight);
			translate([0,0,Bwall])Racetrack(Bradius/2,Bheight);
		}
	} else if (Bshape >202 && Bshape <300 ) //Ovaloid Box
	{
		difference()
		{
			Ovaloid(Bwall,Bheight);
			translate([0,0,Bwall])Ovaloid(0,Bheight);
		}
	} else if (Bshape == 300) //Squared Rectangle Box
	{
		difference()
		{
			cube([2*Bradius,Bradius,Bheight]);
			translate([Bwall,Bwall,Bwall])cube([2*(Bradius-Bwall),Bradius-2*Bwall,Bheight]);
		}
	}else if (Bshape >300 && Bshape <400 ) //Progressively rounded corner rectangle box
	{
		if(Bshape-300 < Bradius/2)
		{
			difference()
			{
				minkowski()
				{
					cube([2*Bradius+2*Bwall-2*(Bshape-300),Bradius+2*Bwall-2*(Bshape-300),.001]);
					cylinder(r=(Bshape-300), h=Bheight, $fn=40);
				}
				translate([Bwall,Bwall,Bwall])minkowski()
				{
					cube([2*Bradius-2*(Bshape-300),Bradius-2*(Bshape-300),.001]);
					cylinder(r=(Bshape-300), h=Bheight,$fn=40);
				}
			}
		}
		else
		{
			difference()
			{
				minkowski()
				{
					cube([Bradius+2*Bwall,2*Bwall,.001]);
					cylinder(r=Bradius/2, h=Bheight);
				}
				translate([Bwall,Bwall,Bwall])minkowski()
				{
					cube([Bradius,.001,.001]);
					cylinder(r=Bradius/2, h=Bheight);
				}
			}
		}
	}
	else	// N-sided box
	{
		difference()
		{
			cylinder(r=Bradius+Bwall, h=Bheight,$fn=Bshape);
			translate([0,0,Bwall])cylinder(r=Bradius, h=Bheight+100,$fn=Bshape);
		}
	}
}
module makeTop()
{
	color("IndianRed")
	if (Bshape == 0) //Heart Top
	{
		union()
		{
			translate([0,0,Bwall])
			union()
			{
				intersection()
				{
					translate([0,0,-Bwall])filigree();
					Heart(2*(Bradius-Bwall),Bheight+100);
				}
				difference()
				{
					Heart(2*Bradius,Bwall);
					translate([0,0,-1])Heart(2*(Bradius-2*Bwall),Bwall+2);
				}
			}
			difference()
			{
				Heart(2*(Bradius-Bwall-Pextrwid),Bwall);
				translate([0,0,-1])Heart(2*(Bradius-2*Bwall),Bwall+2);
			}
		}
	} else if (Bshape == 1)	//Jewish Star Top
	{
		union()
		{
			translate([0,0,Bwall])
			union()
			{
				intersection()
				{
					translate([0,0,-Bwall])filigree();
					JStar(Bradius,Bheight+100);
				}
				difference()
				{
					JStar(Bradius+2*Bwall,Bwall);
					translate([0,0,-1])JStar(Bradius-Bwall,Bwall+2);
				}
			}
			difference()
			{
				JStar(Bradius-2*Pextrwid,Bwall);
				translate([0,0,-1])JStar(Bradius-Bwall,Bwall+2);
			}
		}
	} else if (Bshape == 2) //Cross Top
	{
		union()
		{
			translate([0,0,Bwall])intersection()
			{
				translate([2*Bradius/3,Bradius/3,0])filigree();
				translate([2*Bwall,2*Bwall,0])Cross(4*Bwall,Bwall);
			}
			translate([0,0,Bwall])difference()
			{
				union()
				{
					Cross(0,Bwall);
					translate([Bwall,Bwall,-Bwall])Cross(2*(Bwall+Pextrwid),Bwall);
				}
				translate([2*Bwall,2*Bwall,-3])Cross(4*Bwall,Bwall+4);
			}
		}
	}else if (Bshape >102 && Bshape <200 ) //Racetrack shape top
	{
		union()
		{
			intersection()
			{
				translate([Bradius/2,0,0])filigree();
				Racetrack(Bradius/2-Bwall,Bwall);
			}	
			difference()
			{
				union()
				{
					Racetrack(Bradius/2+Bwall,Bwall);
					translate([0,0,-Bwall])Racetrack(Bradius/2-Pextrwid,2*Bwall);
				}
				translate([0,0,2*-Bwall])Racetrack(Bradius/2-Bwall,5*Bwall);
			}
		}
	} else if (Bshape >202 && Bshape <300 ) //Ovaloid top
	{
		union()
		{
			intersection()
			{
				translate([3*Bradius/4,0,0])filigree();
				Ovaloid(Bwall,Bwall);
			}	
			difference()
			{
				union()
				{
					Ovaloid(Bwall,Bwall);
					translate([0,0,-Bwall])Ovaloid(-Pextrwid,2*Bwall);
				}
				translate([0,0,2*-Bwall])Ovaloid(-Bwall,5*Bwall);
			}
		}
	} else if (Bshape == 300) //Rectangular top
	{
		union()
		{
			translate([0,0,Bwall])
			{
				union()
				{
					intersection()
					{
						translate([Bradius,Bradius/2,-Bwall])filigree();
						translate([2*Bwall,2*Bwall,0])cube([2*Bradius-4*Bwall,Bradius-4*Bwall,Bwall]);
					}
					difference()
					{
						cube([2*Bradius,Bradius,Bwall]);
						translate([2*Bwall,2*Bwall,-1])cube([2*Bradius-4*Bwall,Bradius-4*Bwall,Bwall+2]);
					}
				}
			}
			difference()
			{
				translate([Bwall,Bwall,0])cube([2*Bradius-2*(Bwall+Pextrwid),Bradius-2*(Bwall+Pextrwid),Bwall]);
				translate([2*Bwall,2*Bwall,-1])cube([2*Bradius-4*Bwall,Bradius-4*Bwall,Bwall+2]);
			}
		}
	}
	else if (Bshape >300 && Bshape <400 ) //Rounded Rectangle top
	{
		if(Bshape-300 < Bradius/2)
		{
			union()
			{
				intersection()
				{
					translate([Bradius-(Bshape-300),Bradius/2-(Bshape-300),0])filigree();
					translate([2*Bwall,2*Bwall,0])minkowski()
					{
						cube([2*Bradius-2*Bwall-2*(Bshape-300),Bradius-2*Bwall-2*(Bshape-300),.001]);
						cylinder(r=(Bshape-300), h=Bwall, $fn=40);
					}
				}
				difference()
				{
					union()
					{
						minkowski()
						{
							cube([2*Bradius+2*Bwall-2*(Bshape-300),Bradius+2*Bwall-2*(Bshape-300),.001]);
							cylinder(r=(Bshape-300), h=Bwall, $fn=40);
						}
						translate([Bwall,Bwall,-Bwall])minkowski()
						{
							cube([2*Bradius-2*(Bshape-300),Bradius-2*(Bshape-300),.001]);
							cylinder(r=(Bshape-300)-Pextrwid, h=2*Bwall, $fn=40);
						}
					}
					translate([2*Bwall,2*Bwall,-2*Bwall])minkowski()
					{
						cube([2*Bradius-2*Bwall-2*(Bshape-300),Bradius-2*Bwall-2*(Bshape-300),.001]);
						cylinder(r=(Bshape-300), h=5*Bwall, $fn=40);
					}
				}
			}
		}else
		{
			union()
			{
				intersection()
				{
					translate([Bradius/2,0,0])filigree();
					minkowski()
					{
						cube([Bradius+2*Bwall,2*Bwall,.001]);
						cylinder(r=Bradius/2, h=Bwall);
					}
				}
				difference()
				{
					union()
					{
						minkowski()
						{
							cube([Bradius+2*Bwall,2*Bwall,.001]);
							cylinder(r=Bradius/2, h=Bwall);
						}
						translate([Bwall,Bwall,-Bwall])minkowski()
						{
							cube([Bradius,.001,.001]);
							cylinder(r=Bradius/2-Pextrwid, h=2*Bwall);
						}
					}
					translate([Bwall,Bwall,-2*Bwall])minkowski()
					{
						cube([Bradius,.001,.001]);
						cylinder(r=Bradius/2-Bwall, h=5*Bwall);
					}
				}
			}
		}
	}else
	{
		union() // N-sided cylinder top
		{
			intersection()
			{
				filigree();
				translate([0,0,Bwall])cylinder(r=Bradius-Bwall+.5, h=Bwall,$fn=Bshape);
			}
		}
		difference()
		{
			union()
			{
				translate([0,0,Bwall])cylinder(r=Bradius+Bwall, h=Bwall,$fn=Bshape);
				difference()
				{
					cylinder(r=Bradius-Pextrwid, h=Bwall, $fn=Bshape);
					translate([0,0,-1])cylinder(r=Bradius-Bwall, h=Bwall+1,$fn=Bshape);
				}
			}
			cylinder(r=Bradius-Bwall, h=Bwall+10,$fn=Bshape);
		}
		
	}
}
module makeInsert()
{
	color("YellowGreen")
	if      (Bshape == 0)Heart(2*(Bradius-2*Bwall-Pextrwid),3*Pextrhgt);
	else if (Bshape == 1)JStar(Bradius-Bwall-2*Pextrwid,3*Pextrhgt);
	else if (Bshape == 2)translate([2*Bwall,2*Bwall,0])Cross(4*Bwall-2*Pextrwid,3*Pextrhgt);
	else if (Bshape >102 && Bshape <200 )Racetrack(Bradius/2-Bwall-Pextrwid,3*Pextrhgt);
	else if (Bshape >202 && Bshape <300 )Ovaloid(-Bwall-Pextrwid,3*Pextrhgt);
	else if (Bshape == 300)translate([2*Bwall,2*Bwall,0])cube([2*Bradius-4*Bwall-2*Pextrwid,Bradius-4*Bwall,3*Pextrhgt]);
	else if (Bshape >300 && Bshape <400 ) //rounded rectangle insert
	{
		if(Bshape-300 < Bradius/2)
		{
			translate([2*Bwall,2*Bwall,-2*Bwall])minkowski()
			{
				cube([2*Bradius-2*Bwall-2*(Bshape-300),Bradius-2*Bwall-2*(Bshape-300)-2*Pextrwid,.001]);
				cylinder(r=(Bshape-300), h=3*Pextrhgt, $fn=40);
			}
		}
		else
		{
					translate([Bwall,Bwall,-2*Bwall])minkowski()
					{
						cube([Bradius-2*Pextrwid,.001,.001]);
						cylinder(r=Bradius/2-Bwall, h=3*Pextrhgt);
					}
		}
	}else cylinder(r=Bradius-Bwall-2*Pextrwid, h=3*Pextrhgt,$fn=Bshape);
}
module showBuildPlate()
{
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}
module showAll()
{
	showBuildPlate();
	makeBox();
	translate([0,0,Bheight+16])makeTop();
	translate([0,0,Bheight+8])makeInsert();
}
module printTop()
{
	showBuildPlate();
	translate([0,0,2*Bwall])rotate([180,0,0])makeTop();
}
module printInsert()
{
	showBuildPlate();
	makeInsert();
}
module printBox()
{
	showBuildPlate();
	makeBox();
}

if(part == "show_all")
	showAll();
else if (part == "body")
	printBox();
else if (part == "top")
	printTop();
else if (part == "insert")
	printInsert();
