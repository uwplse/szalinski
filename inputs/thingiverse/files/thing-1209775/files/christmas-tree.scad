/*
 * Christmas Tree Generator
 * By Craig Wood
 *
 * Copyright 2019 Craig Wood - http://github.com/w3ace
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in thehope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.

 */

// CUSTOMIZER Parameters Height is the base of all scaling for the model, 
// it refers to the overall height of the trunks

height=55; // [40:10:220]

// Thickness is the model thickness that will be used for all of the
// Trunks and Branches.

thickness=2; // [1:12]

// This refers to the excess space built into the slots, less slop 
// will make the model tighter, slop is added to model thickness

slop=0.1; // [0:0.1:0.4]

// tab_radius is the radius of the frame and the connective tissue

tab_radius=1.4; // [0.8:0.2:3]

// decoration describes the top of the tree

decoration = "Hanger"; // [Star,Hanger,None]

if(decoration == "Star") {
	star(points=5,outer=5*height*.02,inner=2*height*.02,thickness=thickness);
} else {
	if (decoration == "Hanger")
	{
		hanger(thickness=thickness,height=height);
	}
}

//		hanger(thickness=thickness,);

bottom_trunk(height=height, thickness=thickness, slop=slop);
top_trunk(height=height, thickness=thickness, slop=slop);

branch(height=height*.90, slot=height/3*.99, vertices=7, x=height*1.3, y=height*.8, thickness=thickness, slop=slop);
branch(height=height*.75, slot=height/3*4/5, vertices=7, x=height*1.15, y=height*1.6, thickness=thickness, slop=slop);
branch(height=height*.6, slot=height/3*3/5,  vertices=6, x=height*1.1, y=height*2.3, thickness=thickness, slop=slop);
branch(height=height*.4, slot=height/3*2/5, vertices=6, x=height*.6, y=height*2.05, thickness=thickness, slop=slop);
branch(height=height*.3, slot=height/3*1/5, vertices=5, x=height*.55, y=height*1.55, thickness=thickness, slop=slop);

frame(height=height,tab_radius=tab_radius);


// Variance for the branch polygons 

function variance (height) = rands(-height,height,1)[0]/10;

module hanger(thickness,height)
{
	color ("Darkgreen")
		translate([height*1.6,height*1.47,0])
			union() {
				rotate_extrude(convexity = 10, $fn = 25)
					translate([height*.02, 0, 0])
						square([height*0.02,thickness]);
				translate([-height*.02,height*0.025,0])
					linear_extrude(height=thickness)
						square([height*0.04,height*0.14]);
			}
}

// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module star(points, outer, inner, thickness=2) 
{
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a); 
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	color ("Gold")
	translate([height*1.6,height*1.5,0])
	rotate([0,0,270])
	linear_extrude(height=thickness)

	union()
	{
		for (p = [0 : points-1]) 
		{
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

				x_outer = x(outer, increment * p);
					y_outer = y(outer, increment * p);
					x_inner = x(inner, (increment * p) + (increment/2));
					y_inner = y(inner, (increment * p) + (increment/2));
					x_next  = x(outer, increment * (p+1));
					y_next  = y(outer, increment * (p+1));
				polygon (points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next],[0, 0]], convexity=1); //, paths  = [[0, 1, 2, 3]]);
		}
	}
}

// older versions of OpenSCAD do not support "angle" parameter for rotate_extrude
// this module provides that capability even when using older versions (such as thingiverse customizer)
//API from thehans : http://forum.openscad.org/rotate-extrude-angle-always-360-tp19035p19040.html
module rotate_extrude2(angle=360, convexity=20, size=1000) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}


module frame_tab (x=0,y=0,rx=0,rz=0,length=0,style=0)
{
	translate([x,y,0])
		rotate([rx,0,rz])
		union () {
			cylinder(r=tab_radius,3.5);
			cylinder(r=tab_radius/2,length);
		}
}

module inner_tab (x=0,y=0,rx=0,rz=0,length=0,style=0)
{
	translate([x,y,0])
		rotate([rx,0,rz])
			cylinder(r=tab_radius/2,length);
}


// Create Outside Frame

module frame (height=66,tab_radius=1.4)
{

	width_multiplier = 1.2;
	height_multiplier = 2;
	arc_distance = height/5;

	$fn=25;

	difference()
	{
		color("Goldenrod")
		union()
		{

			translate([height/4,height/4+arc_distance,0])
				rotate([270,90,0])
					cylinder(r=tab_radius,h=height*height_multiplier);
			translate([height/4+arc_distance,height/4,0])
				rotate([0,90,0])
					cylinder(r=tab_radius,h=height*width_multiplier);
			translate([height/4+height*width_multiplier+arc_distance*2,height/4+arc_distance,0])
				rotate([270,90,0])
					cylinder(r=tab_radius,h=height*height_multiplier);
			translate([height/4+arc_distance,height/4+height*height_multiplier+arc_distance*2,0])
				rotate([0,90,0])
					cylinder(r=tab_radius,h=height*width_multiplier);

			translate([height/4+arc_distance,height/4+arc_distance,0])		
			rotate ([0,0,180]) 
					rotate_extrude2(angle=90,convexity=10,size=arc_distance*2)
		   			translate([arc_distance, 0,0]) 
		   					circle(tab_radius);

			translate([height/4+arc_distance+height*width_multiplier,height/4+arc_distance,0])
				rotate ([0,0,270]) 
					rotate_extrude2(angle=90,convexity=10,size=arc_distance*2)
		   			translate([arc_distance, 0,0]) 
		   					circle(tab_radius);

			translate([height/4+arc_distance+height*width_multiplier,height/4+height*height_multiplier+arc_distance,0])
					rotate_extrude2(angle=90,convexity=10,size=arc_distance*2)
		   			translate([arc_distance, 0,0])
		   					circle(tab_radius);

			translate([height/4+arc_distance,height/4+height*height_multiplier+arc_distance,0])
				rotate ([0,0,90]) 
					rotate_extrude2(angle=90,convexity=10,size=arc_distance*2)
		   			translate([arc_distance, 0,0]) 
		   					circle(tab_radius);

		  		tab_base_x = height/4;
		  		tab_base_y = height/4;
		  		tab_top_x = height/4+arc_distance*2+height*width_multiplier;
		  		tab_top_y = height/4+arc_distance*2+height*height_multiplier;

				 	frame_tab(x=tab_base_x+height*.22,y=tab_base_y,rx=270,rz=0,length=height*.15);
				 	frame_tab(x=tab_base_x+height*.4,y=tab_base_y,rx=270,rz=0,length=height*.15);
				 	frame_tab(x=tab_base_x+height*.9,y=tab_base_y,rx=270,rz=0,length=height*.4);
				 	frame_tab(x=tab_base_x+height*1.2,y=tab_base_y,rx=270,rz=0,length=height*.4);

			//	 	frame_tab(x=tab_base_x+height*.27,y=tab_top_y,rx=90,rz=0,length=height*.5);
				 	frame_tab(x=tab_base_x+height*.4,y=tab_top_y,rx=90,rz=0,length=height*.5);
				 	frame_tab(x=tab_base_x+height*.75,y=tab_top_y,rx=90,rz=0,length=height*.25);
			//	 	frame_tab(x=tab_base_x+height*.95,y=tab_top_y,rx=90,rz=0,length=height*.25);
				 	frame_tab(x=tab_base_x+height*1.27,y=tab_top_y,rx=90,rz=0,length=height*.25);
				 	frame_tab(x=tab_base_x+height*1.42,y=tab_top_y,rx=90,rz=0,length=height*.25);

				 	frame_tab(x=tab_base_x,y=tab_base_y+height*.6,rx=90,rz=90,length=height*.25);
				 	frame_tab(x=tab_base_x,y=tab_base_y+height*1.27,rx=90,rz=90,length=height*.2);
				 	frame_tab(x=tab_base_x,y=tab_base_y+height*1.8,rx=90,rz=90,length=height*.25);

				 	frame_tab(x=tab_top_x,y=tab_base_y+height*1.6,rx=90,rz=270,length=height*.25);
				 	frame_tab(x=tab_top_x,y=tab_base_y+height*.6,rx=90,rz=270,length=height*.35);

				 	inner_tab(x=tab_base_x+height*.25,y=tab_base_y+height*.5,rx=90,rz=90,length=height*.55);
				 	inner_tab(x=tab_base_x+height*.37,y=tab_base_y+height*1.35,rx=90,rz=90,length=height*.3);
				 	inner_tab(x=tab_base_x+height*1.05,y=tab_base_y+height*1.45,rx=90,rz=90,length=height*.3);
				 	inner_tab(x=tab_base_x+height*1,y=tab_base_y+height*2.1,rx=90,rz=90,length=height*.3);

				 	inner_tab(x=tab_base_x+height*.92,y=tab_base_y+height*1.15,rx=90,rz=0,length=height*.45);
				 	inner_tab(x=tab_base_x+height*.8,y=tab_base_y+height*1.9,rx=90,rz=0,length=height*.4);
				 	inner_tab(x=tab_base_x+height*.3,y=tab_base_y+height*1.7,rx=90,rz=0,length=height*.3);

		}


		translate([0,0,-tab_radius])
			cube([height/4+arc_distance+height*width_multiplier+arc_distance*2+tab_radius*2,
						height/4+height*height_multiplier+arc_distance+arc_distance*2+tab_radius*2,tab_radius]);

	}
}

// Make trunk pieces

module bottom_trunk (height=66, thickness=2, slop=.4)
{
	x = height/2.5;
	y = height/2.5;

  color("Darkgreen")
	difference()
	{
		linear_extrude (height=thickness)
		{
			polygon(points=[
				[x,y],
				[x+height/3,y],
				[x+height/6,y+height]
			]);
		}
		translate([x+height/6,y+height*3/4,thickness/2])
			cube([thickness+slop/2+.2,height/2,thickness+.4],true);
	}
}
	// Trunk with Bottom Slot

module top_trunk (height=66, thickness=2,slop=.4)
{

	x = height*1.6;
	y = height*1.5;

  color("Darkgreen")
	difference()
	{
		linear_extrude (height=thickness)
		{
			polygon(points=[
				[x,y],
				[x-height/6,y+height],
				[x+height/6,y+height]
			]);
		}
		translate([x,y+height*3/4,thickness/2])
			cube([thickness+slop,height/2+slop/2,thickness+.4],true);
	}
}

// Module to create a horizontal branch

module branch (height=80, slot=75, vertices=7, x=0, y=0, thickness=2,slop=.4)
{
	p = rands(vertices,vertices+4,1)[0];

	// Put branch in proper location 
	translate ([x,y,0])
	{
  		color("Darkgreen")
		difference() 
		{
			// Random number of branches
			for(i=[360/p:375/p:390]) 
			{
				// Save the pt 
				xpt = (height/3)+variance(height/4);
				ypt = (height/3)+variance(height/4);
				rotate([0,0,i])
					difference()
					{
						linear_extrude (height=thickness)
							polygon(points=[
							 	[-(height/5)+variance(height/1.5),(height/5)+variance(height/1.5)],	
								[(height/5)+variance(height/1.5),-(height/5)+variance(height/1.5)],
							 	[xpt,ypt]
							]);
						
						// Clip the corners of the Triangle if the get too divergent... no idea why I need this rotate.
						rotate([0,0,315])
							union()
								{
									translate([-height/2.8,height/8.5,thickness/2])
										cube([height/3,height/2.5,thickness+.4],true);
									translate([height/2.8,height/8.5,thickness/2])
										cube([height/3,height/2.5,thickness+.4],true);
								}
					}
			}

			// Trunk Slot
			rotate ([0,0,rands(1,90,1)[0]])
			translate([0,0,thickness/2])
			union ()
			{
				cube([thickness+slop,slot,thickness+.4],true);
				rotate([0,0,90])
					cube([thickness+slop,slot,thickness+.4],true);				
			}
		}
	}
}

