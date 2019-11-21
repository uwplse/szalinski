/***********************************************************************************************************************************
Universal Spool Roller Ring Designed by: Mike Thompson 8/8/2013, http://www.thingiverse.com/mike_linus
V2 Updated 11/8/2014 by Mike Thompson: improved handling of cutouts when using retainers

Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.  Further 
information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB

The spool roller is the ideal platform for simple, low cost, light, convenient and effective filament spool mounting.  It is easy to build with 
minimal hardware, requires minimal effort to mount and dismount spools and takes up minimal space.  This design was motivated by the
basic simplicity and efficiency of the roller configuration while trying to address the inherent weaknesses in existing designs.  

Some of the key issues with existing designs are:
- lack of parametric designs that can handle all typical spool dimensions
- instability causing the spool to dislodge when the spool weight is low or while using large diameter narrow spools
- inability to mount at any angle which is often required when working in limited space or feed angles are critical
- the need for additional metal components (apart from bearings)
- difficulty in changing spools quickly.

This design addresses these deficiencies by providing increased lateral stability in the base
and the addition of retainers to prevent dislodgement, regardless of the spool weight or even base angle. By selecting
appropriate values for improved stiffness and strength, the spool can be mounted at any angle, even inverted.

Key features:
- Ring structure provides better stability with minimal filament and suffers less ABS print warping compared to straight edges
- Retainers prevent spool dislodging when weight reduced and allow mounting at any angle
- Inner flanges on bearing holders negate the need for washers on the base
- Fully parametric design allows complete control of all options from minimal lightweight to reinforced multi-angle mounted designs

Instructions: alter the values below for the required configuration. The minimal configuration without retainers requires
4 x M8 bolts and nuts and 4 x 608 bearings. If using retainers, use threaded rod between the retainers to secure 2 retainer bearings.
See my nuts and bolts collection for printable versions of all the required threasded rod, washers and nuts - All parts are printable
except the bearings. Recommend using at least 40% fill. Note: The ring style base will require a slightly larger build platform than
a radial design. Some objects used in differencing have small values eg. 0.1 added to fix display anomalies when using preview mode
(f5) to render with OpenCSG, rather than the full CGAL render (f6). 
************************************************************************************************************************************/

/**************************************************************************
Enter the values corresponding to your spool requirements in this section
***************************************************************************/

/* [Spool Dimensions] */

//The thickness of the outer perimeter walls of the spool (the edge in contact with the bearings)
spool_wall     		= 5;		
//The dimension of the spool from the centre of the flange in contact with the bearing to the centre of the opposite flange. Examples: Lybina 300m Spool = 160, Bilby 1Kg = 90
spool_width    		= 90;
//The diameter of the outer edges of the spool body (not the filament section outer diameter). Examples: Lybina 300m Spool = 204, Bilby 1Kg = 160	
spool_diameter 		= 160;	
//The diameter of the hole inside the spool. Examples: Lybina 300m Spool = 104, Bilby 1Kg = 32
hole_diameter  		= 32;	

/* [Bearing Dimensions] */

//The outer diameter of the bearing. Default 22 for standard 608 bearing
bearing_diameter  	= 22;	
//The side to side dimension of the bearing + allowed gap to wall e.g. 7(608 Bearing) + 0.5 gap either side  = 7 + 1 = 8
bearing_thickness 	= 8;		
//This is the diameter of the bolt to be used to secure the bearings. Default 8 for standard M8 bolts
bolt_diameter     	= 8;		

/* [Retainer Options] */

//Generate side retainers to stop the spool from lifting or tipping off the base and to support alternate angle mounting with the use of a retainer rod
retainer_include		= "include";//[include,exclude]
//offset from bearing line for retainer to accommodate spool centre extending beyond bearing line. Examples: Lybina 300m Spool = 5. Most spools = 0 (spool centre flush with rim)
retainer_offset		= 0;	

/************************************************************************************************************
The following values may be altered to increase/decrease stiffness and strength and tweak the ring dimensions
*************************************************************************************************************/

/* [Advanced Options] */

//Show Spool to visualise dimensions. Remember to hide for final compilation
display_spool		= "hide";//[hide,show]		
//Cross bracing is recommended when flexing needs to be reduced such as mounting on an angle
cross_brace_include	= "include";//[include,exclude]		
//Number of cutouts in main ring. Use 0 for maximum rigidity
ring_cutouts			= 0;//[0:32]		
//width of ring section. Recommend 20 or larger values if large base or if not mounting horizontally
ring_width 			= 20;	
//Offset of ring radius from centre of bearing mount. Higher values reduce effective ring_radius
ring_offset			= 10;		
//margin for up/down adjustment of retainer bearing cutout
retainer_margin		= 5;		
//The thickness of the bearing holder and retainer
holder_wall        	= 4;		
//The thickness of the base of the stand
holder_base_height 	= 4;		

/*********************************************************************************************************
The following values should not be changed
**********************************************************************************************************/

holder_base_length 	= spool_diameter/1.5; //Length based on ratio to maintain stability in proportion to spool diameter
holder_bearing_height	= bearing_diameter/2+(holder_base_height*2);
ring_radius			= sqrt(((spool_width/2-2*holder_wall)*(spool_width/2-2*holder_wall)) + ((holder_base_length/2)*(holder_base_length/2)));
ring_edge			= ring_radius+(ring_width/2)-ring_offset; 		//outer edge of ring
spool_height			= sqrt((spool_diameter/2*spool_diameter/2)-((holder_base_length/2-bearing_diameter)*(holder_base_length/2-bearing_diameter)))+bearing_diameter;

module spool()  //For display only
{
	$fn = 64; //lower resolution for display only to reduce compile time
	rotate([0, 90, 0])
	difference()
	{
		union()
		{
			color("gray")
			translate([0, 0, (spool_width / 2)])
			cylinder(r = spool_diameter / 2, h = spool_wall, center = true);
			color("gray")
			translate([0, 0, -(spool_width / 2)])
			cylinder(r = spool_diameter / 2, h = spool_wall, center = true);
			color("lime")
			translate([0, 0, 0])
			cylinder(r = spool_diameter / 2 - spool_wall, h = spool_width - spool_wall, center = true);
			if (retainer_offset>0)
			{
				color("gray")
				translate([0, 0, (spool_width / 2)+retainer_offset])
				cylinder(r = (hole_diameter / 2)+1, h = retainer_offset, center = true);
				color("gray")
				translate([0, 0, -(spool_width / 2)-retainer_offset])
				cylinder(r = (hole_diameter / 2)+1, h = retainer_offset, center = true);
			}	
		}
		color("gray")
		cylinder(r = hole_diameter / 2, h = spool_width + 2*spool_wall + retainer_offset + 0.1, center = true);
	}
}

module bearing_mount() //the main bearing holder. Comment out the flanges module if using washers instead.
{
	difference()
	{
		union()
		{
			rotate([0, 90, 0])
			cylinder(r = bearing_diameter / 2, 
					 h = bearing_thickness + (holder_wall * 2), 
					 center = true);
		
			translate([0, 0, -holder_bearing_height / 2])
			cube([bearing_thickness + holder_wall * 2, 
				  bearing_diameter, 
				  holder_bearing_height], 
				  center = true);
			
			translate([bearing_thickness/2,-bolt_diameter/3,0])	//Spool guard
			rotate([0,90,0])
			cylinder(h=holder_wall, 
					r=((bearing_diameter/2)+bolt_diameter/3));	
		}
		
		rotate([0, 90, 0])
		cylinder(r = bearing_diameter / 2 + 2, 
				 h = bearing_thickness, 
				 center = true);			

		rotate([0, 90, 0])
		cylinder(r = bolt_diameter/2, 
				 h = spool_wall + bearing_thickness * 2 + 0.1, 
		 		center = true);
	}
	flanges(); //comment out if using fender washers instead 
}

module flanges() //creates tapered flanges to hold the bearings without the use of washers
{
	difference()
	{
		union()
		{
			rotate([0, 90, 0])
			cylinder(r1 = (bolt_diameter/2)+2, 
					r2 = 1, 
					h = bearing_thickness, 
		 			center = true);							

			rotate([0, 90, 0])
			cylinder(r2 = (bolt_diameter/2)+2, 
					r1=1, 
					h = bearing_thickness, 
		 			center = true);										
		}

		rotate([0, 90, 0])
		cylinder(r = (bolt_diameter/2)+2, 
				 h = bearing_thickness-1, 
	 			center = true);							

		rotate([0, 90, 0])
		cylinder(r = bolt_diameter/2, 
				 h = spool_wall + bearing_thickness * 2 + 0.1, 
		 		center = true);
	}
}

module retainer() //creates bearing holders to trap the centre of the spool, prevent tip over and allow mounting at any angle
{
	difference()
	{
		union()
		{
			hull()
			{	//vertical support
				translate([0,-(bolt_diameter+15)/2,0])cube([holder_wall, bolt_diameter+15, spool_height-(hole_diameter/2)],center=false); 
				//round end cap
				translate([holder_wall/2,0,spool_height-(hole_diameter/2)+bearing_diameter])rotate([0,90,0])cylinder(r=(bolt_diameter+15)/2,h=holder_wall, center=true);
			}

			//triangular x brace
			translate([holder_wall/2, holder_wall/2, 0]) 																					
				rotate([90,0,0])linear_extrude (height=holder_wall, convexity=4)
				{
					polygon(points=[[0,0],[ring_edge-(spool_width/2+bearing_thickness/2+retainer_offset)-holder_wall/2,0],[0,spool_height-20-retainer_margin*2]]);
				}
		}		
		hull() //retainer bolt cutout
		{
			//bolt hole top
			translate([-0.5, 0, spool_height-(hole_diameter/2)+(bearing_diameter/2)+(retainer_margin)])
				rotate([0,90,0])cylinder(r=(bolt_diameter)/2,h=holder_wall+1);

			//bolt hole bottom
			translate([-0.5, 0, spool_height-(hole_diameter/2)+(bearing_diameter/2)-(retainer_margin/2)])
				rotate([0,90,0])cylinder(r=(bolt_diameter)/2,h=holder_wall+1);			
		}
	}

	//triangular y braces
	translate([holder_wall,(bolt_diameter+15)/2,0])rotate([0,-90,0])linear_extrude (height=holder_wall, convexity=4)
	{
		polygon(points=[[0,0],[((spool_diameter / 2)+(bearing_diameter/2))/2,0],[0,bearing_diameter/2]]);
	}
	mirror([0,1,0])translate([holder_wall,(bolt_diameter+15)/2,0])rotate([0,-90,0])linear_extrude (height=holder_wall, convexity=4)
	{
		polygon(points=[[0,0],[((spool_diameter / 2)+(bearing_diameter/2))/2,0],[0,bearing_diameter/2]]);
	}
	//lateral brace particularly important when retainer not supported by the outer ring eg. tall and thin spool
	translate([holder_wall/2,0,holder_base_height/2])cube([ring_width, ring_radius*2, holder_base_height], center=true);

}

module ring_cutouts() //creates holes in ring.  Use the ring_cutouts variable above to set the number of holes 
{
	for (i= [1:ring_cutouts])
	{
		translate([cos(360/ring_cutouts*i)*(ring_radius-ring_offset), sin(360/ring_cutouts*i)*(ring_radius-ring_offset), 0 ])
		cylinder(r=ring_width/3,h=holder_base_height+0.2);
	}
}

module ring()  //creates the base ring structure
{
	difference()
	{
		cylinder(r=ring_edge,h=holder_base_height);
		translate([0,0,-0.1])cylinder(r=ring_radius-(ring_width/2)-ring_offset,h=holder_base_height+0.2);
		translate([0,0,-0.1])ring_cutouts(); 
	}
}

module cross_brace()
{
	difference()
	{
		union()
		{
			translate([0,0,holder_base_height/2])cube([(ring_radius-(ring_width/2)-ring_offset)*2+3, ring_width, holder_base_height], center=true);
			translate([0,0,holder_base_height/2])cube([ring_width, (ring_radius-(ring_width/2)-ring_offset)*2+3, holder_base_height], center=true);
			cylinder(r=ring_radius/2+(ring_width/2)-ring_offset,h=holder_base_height);
		}
		translate([0,0,-0.1])cylinder(r=ring_radius/2-(ring_width/2)-ring_offset,h=holder_base_height+0.2);
	}
}

module base()  //builds the final object
{
	$fn = 100; //make curves high resolution for final build
	color([1, 0, 0])
	translate([0, 0, -spool_height])
	union()
	{
		ring();

 		if (cross_brace_include!="exclude") //change the "cross_brace_include" value to "exclude" if no bracing required
		{
			cross_brace();
		}
		
		if (retainer_include!="exclude") //change the "retainer_include" value to "exclude" if no retainer required
		{
			difference()
			{
				union()
				{
					translate([spool_width/2+bearing_thickness/2+retainer_offset, 0, 0])retainer();
					mirror([1,0,0])translate([spool_width/2+bearing_thickness/2+retainer_offset, 0, 0])retainer();	
				}
				difference() //trim lateral brace to fit inside ring
				{
					translate([0,0,-0.1])cylinder(r=ring_radius*2,h=holder_base_height+0.2);
					translate([0,0,-0.1])cylinder(r=ring_edge-ring_width,h=holder_base_height+0.2);
				}	
			}
		}
		
		translate([spool_width/2, 
				   holder_base_length/2 - bearing_diameter/2, 
				   holder_bearing_height])
		bearing_mount();

		translate([-spool_width / 2,
				holder_base_length / 2 - bearing_diameter / 2,
				holder_bearing_height])
		mirror([1,0,0])bearing_mount();

		translate([spool_width / 2, 
				  -(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])		
		mirror([0,1,0])bearing_mount();

		translate([-spool_width / 2,
				-(holder_base_length / 2 - bearing_diameter / 2),
				holder_bearing_height])
		mirror([0,1,0])mirror([1,0,0])bearing_mount();
	}
}
	
//****************************	
//Build!
//****************************

base();
echo("Print bed size X/Y required =",ring_edge*2); //calculate build area - useful if large print area required that exceeds print bed.  Increase ring_offset to reduce ring radius and build area to required value. Note: reducing ring radius may reduce the support for the bearing holders.
if (display_spool!="hide")
{
	spool(); 		//show spool position - change "display_spool" value to "hide" before generating final compilation
}