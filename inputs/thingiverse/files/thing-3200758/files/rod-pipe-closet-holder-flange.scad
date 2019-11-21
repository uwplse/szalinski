// Parametric (closet) rod/pipe holder/flange

/* [Rod Definitions] */

//The diameter of your rod you want to mount.
rod_diameter = 20; //[0:0.1:100]

//Thickness of wall around rod.
rod_wall_thickness = 4; //[0:0.1:50]

//Total height of the holder. Minimum is flange thickness or pin height.
total_height = 20; //[0:0.1:100]

//To lay the rod into the holder, set this value to 180 degree. To achieve a snap-in behaviour a thin rod_wall_thickness plus maybe 190 degree may work. Needs test prints. 
rod_mount_solid_angle = 360;// [0:360]

/* [Flange Definitions] */

//Thickness of the flange.
flange_thickness = 5;// [0:0.1:50]

//Diameter of the flange. Set to zero to let the script calculate a minimal diameter needed for the screws and rod walls. If screws are placed on flange then too small values are ignored.
flange_diameter = 50;// [0:0.1:200]

// Support for the rod on the back. With a value of zero the rod can pass through the flange.
backwall_thickness = 2; //[0:0.1:50]

//Radius on the part's edges. Limited by the height of rod wall, the width of rod wall thickness and flange thickness.
edge_radius = 1; //[0:0.1:20]

//Radius of design from baseplate to rod holder wall to make it more robust.
extension_radius=8; //[0:0.1:50]

//Finesse
finesse=60; //[16:200]

/* [Pin Definitions] */

// Diameter of the pin to secure the rod in the flange.
pin_diameter = 4; //[0:0.1:10]
// Height/location of the pin's center.
pin_center_z = 15; //[0:0.1:100]
// Number of pins. 
pin_count = 0; //[0:12]
// Rotation of the pin around z axis.
pin_rotation = 0; //[0:0.1:360]

/* [Screws Definitions] */
// Location where the screw holes will be made.
screws_location = "flange"; //[flange, inside]
// Diameter of circle where screw holes are placed. Values outside flange_diameter are ignored. When placing the screw holes on the flange a value of zero calculates the center of the flange width. When placing the screw holes in the center a value of zero places a single screw hole in the center of the flange if number_of_holes is larger than zero. 
screws_circle_diameter = 0;//[0:0.1:100]
// Diameter of screw head. Values smaller the scre hole diameter are being ignored.
screw_head_dia = 7;//[0:0.1:30]
// Diameter of hole for the screw. Values larger than screw_head_dia are being ignored.
screw_hole_dia = 3.5;//[0:0.1:30]
// Number of screw holes.
number_of_holes = 3;//[0:24]
// For flat head screws you don't need a champfer. Useful for wood screws.
screw_champfer = "yes"; //[yes,no]


/* [Hidden] */
//$fn=30;
make_base_or_snapin = 1;
cut=0.01;
screw_head_safety_margin = 10*cut;

customizer_output();
//demo();

// *******************************************
// Modules
// *******************************************

module customizer_output()
{
	params = [rod_diameter,
			rod_wall_thickness,
			total_height,
			rod_mount_solid_angle,
			flange_thickness,
			flange_diameter,
			backwall_thickness,
			edge_radius,
			extension_radius,
			finesse,
			pin_diameter,
			pin_center_z,
			pin_count,
			pin_rotation,
			screws_location, 
			screws_circle_diameter,
			screw_head_dia,
			screw_hole_dia,
			number_of_holes,
			screw_champfer
			];
	make_flange(p=params);
}

module make_flange(p)
{
	//debug(p);
	if(len(p)>0)
	{
		$fn=finesse;
		difference()
		{
			union()
			{
				if(get_rod_mount_solid_angle(p) > 0)
					base_extension(p);
				flange_plate(p);
			}
			translate([0,0,get_backwall_z(p)])
				cylinder(d=p_rod_diameter(p), h = get_total_height(p)*2);
			if(get_num_of_screws(p)>0)
				screw_holes(p);
			if(p_pin_count(p)>0)
				pin_holes(p);
		}
	}
}

module flange_plate(p)
{	
	profile = double_fillet(h=base_plate_top(p), 
					r1=get_flange_edge_radius(p), //upper radius
					r2=0, //lower radius
					//upper area radius
					xoffset1=get_flange_diameter(p)/2-get_flange_edge_radius(p), 
					xoffset2=0, //slope of sides
					$fn=p_finesse(p));
	rotate_extrude(angle=360, convexity=3,$fn=p_finesse(p)) polygon(profile);
	
}

module base_extension(p)
{
	ext_rad = get_base_to_extension_radius(p);
	if(get_extension_height(p)>0)
	{
		profile = double_fillet(h=get_extension_height(p), 
				r1=get_edge_radius(p), //upper radius
				r2=ext_rad, //lower radius
				//upper area radius Flächenradius
				xoffset1=get_extension_diameter(p)/2-get_edge_radius(p), 
				xoffset2=0, //pitch/slope of the side walls
				$fn=p_finesse(p));

		translate([0,0,base_plate_top(p)-cut])
		rotate([0,0,(360-get_rod_mount_solid_angle(p))/2])
		rotate_extrude(angle=get_rod_mount_solid_angle(p), convexity=3,$fn=p_finesse(p))
			polygon(profile);
	}
}

module screw_holes(p)
{
    for(i=[0:get_num_of_screws(p)-1])
        rotate([0,0,i*get_screw_angle(p)])
        translate([get_screw_radius(p),0,-cut])
        union()
        {
            cylinder(d=get_screw_hole_dia(p), h=p_total_height(p)+cut);
            translate([0,0,get_screw_champfer_z(p)+2*cut])
            union()
            {
                cylinder(d=get_screw_head_dia(p), h=p_total_height(p)+cut);
                translate([0,0,-get_screw_champfer_height(p)+cut])
                if(p_screw_champfer(p)=="yes")
                    cylinder(d1=get_screw_hole_dia(p), 
                            d2=get_screw_head_dia(p),
                            h=get_screw_champfer_height(p));
            }
        }
}

module pin_holes(p)
{
	rot_angle_per_pin = p_pin_count(p) == 0 ? 0 :180/p_pin_count(p);
	length = 2*get_extension_diameter(p);
	for(i=[0:p_pin_count(p)-1])
        rotate([0,0,i*rot_angle_per_pin+p_pin_rotation(p)])
		translate([0,0,p_pin_center_z(p)])
		rotate([90,0,0])
		cylinder(d=p_pin_diameter(p), h = length, center=true);
	
}

module debug(p)
{
	echo("flange_diameter",p_flange_diameter(p));
	echo("get_flange_diameter(p)", get_flange_diameter(p));
	echo("get_extension_diameter(p)" ,get_extension_diameter(p));
	echo("get_needed_flange_space_rad(p)",get_needed_flange_space_rad(p));
	echo("get_screw_space(p)",get_screw_space(p));
	echo("get_flange_edge_radius(p)",get_flange_edge_radius(p));
	echo("get_base_to_extension_radius(p)",get_base_to_extension_radius(p));
	echo(get_extension_diameter(p)+ 2*get_needed_flange_space_rad(p));
	echo("get_extension_height(p)",get_extension_height(p));
}

// *******************************************
// Functions
// *******************************************

// Parameter data pick helper functions
function p_rod_diameter(p)=p[0];
function p_rod_wall_thickness(p)=p[1];
function p_total_height(p)=p[2];
function p_rod_mount_solid_angle(p)=p[3];
function p_flange_thickness(p)=p[4];
function p_flange_diameter(p)=p[5];
function p_backwall_thickness(p)=p[6];
function p_edge_radius(p)=p[7];
function p_extension_radius(p)=p[8];
function p_finesse(p)=p[9];
function p_pin_diameter(p)=p[10];
function p_pin_center_z(p)=p[11];
function p_pin_count(p)=p[12];
function p_pin_rotation(p)=p[13];
function p_screws_location(p)=p[14];
function p_screws_circle_diameter(p)=p[15];
function p_screw_head_dia(p)=p[16];
function p_screw_hole_dia(p)=p[17];
function p_number_of_holes(p)=p[18];
function p_screw_champfer(p)=p[19];
			

function get_needed_flange_space_rad(p) =
			get_screw_space(p);

function get_flange_diameter(p) = 
			is_screws_on_flange(p) 
			?	max(p_flange_diameter(p),
					get_num_of_screws(p) == 0 ? get_extension_diameter(p) :
					get_extension_diameter(p) + 2*get_needed_flange_space_rad(p))
			:	max(p_flange_diameter(p),
					get_extension_diameter(p))
		;

function get_flange_space_rad(p) = 
			get_flange_diameter(p)/2-get_extension_diameter(p)/2;

function get_extension_diameter(p) = p_rod_diameter(p) 
									+ 2*p_rod_wall_thickness(p);

function get_extension_height(p) = get_total_height(p)-base_plate_top(p);

function get_rod_mount_solid_angle(p) = p_rod_mount_solid_angle(p) < 0 ? 0 
			: p_rod_mount_solid_angle(p) > 360 ? 360
			: p_rod_mount_solid_angle(p);

function get_backwall_z(p) = p_backwall_thickness(p) == 0 ? 
			-cut
			: p_backwall_thickness(p) >= get_total_height(p) ? 
				get_total_height(p)+cut
				: p_backwall_thickness(p)
			;

function base_plate_top(p) = p_flange_thickness(p) <= p_total_height(p) ?
			p_flange_thickness(p) : p_total_height(p);

function get_total_height(p) = 
			max(p_total_height(p),
			p_pin_count(p) == 0 ? 0 
			: p_pin_center_z(p)+p_pin_diameter(p)/2
			);

function get_edge_radius(p) = min(p_edge_radius(p), 
								p_rod_wall_thickness(p)/2,
								(get_total_height(p)-base_plate_top(p))/2);
								
function get_flange_edge_radius(p) = min(
			p_edge_radius(p),
			base_plate_top(p)/2,
			p_flange_diameter(p) == 0 ? p_edge_radius(p) //auto calc mode
			: get_flange_diameter(p) <= get_extension_diameter(p) ? 0 //no radius
			: get_flange_diameter(p) >= get_extension_diameter(p)
								+ 2*p_edge_radius(p) 
				? p_edge_radius(p) //enough space
				: (get_flange_diameter(p) - get_extension_diameter(p))/2
			);


function get_edge_radius_sum(p) = get_edge_radius(p)+p_extension_radius(p);
				
function get_base_to_extension_radius(p) = min( 
			p_extension_radius(p),
			//limiting factor is height 
			get_extension_height(p)-get_edge_radius(p),
			//limiting factor is flange diameter
			get_flange_diameter(p) <= get_extension_diameter(p) ? 0 //no radius
			: get_flange_diameter(p) >= get_extension_diameter(p)
								+ 2*p_edge_radius(p) 
								+ 2*p_extension_radius(p) 
				? p_extension_radius(p) //enough space
				: get_flange_diameter(p) >= get_extension_diameter(p)
								+ 2*p_edge_radius(p) 
					? //rest for extension radius
					((get_flange_diameter(p)-get_extension_diameter(p))/2)
						-p_edge_radius(p)-cut
					: 0 //no space for extension radius
			,
			//limiting factor is screw space
			is_screws_on_flange(p) ?
				p_extension_radius(p) < get_flange_space_rad(p)
									-get_flange_edge_radius(p) ?
					p_extension_radius(p) : get_flange_space_rad(p)
									-get_flange_edge_radius(p)
			: p_extension_radius(p)
			
    );

function get_screw_space(p) = get_screw_head_dia(p) + 2*screw_head_safety_margin;

function get_screw_head_dia(p) = 
			min(p_rod_diameter(p),
				max(p_screw_head_dia(p), p_screw_hole_dia(p))
			);
function get_screw_hole_dia(p) = p_screw_hole_dia(p);
			
function get_num_of_screws(p) = p_number_of_holes(p) == 0 ? 0
			: 	//one or more screws
				p_screws_circle_diameter(p) == 0 && !is_screws_on_flange(p) ?
				1 : p_number_of_holes(p);

function get_screw_angle(p) = 360/get_num_of_screws(p);

function get_screw_radius(p) = is_screws_on_flange(p) ?
			//screws are on flange and may only be there
			p_screws_circle_diameter(p)/2 <= get_extension_diameter(p)/2
										+ get_screw_space(p)/2 
				?//too small screws_circle_diameter 
				p_screws_circle_diameter(p) == 0 
					? //special case => auto calc
						get_extension_diameter(p)/2 +
						(get_flange_diameter(p)-get_extension_diameter(p))/4
					: //too small ignored
						get_extension_diameter(p)/2+get_screw_space(p)/2
				:	// Check if screw radius is too big
					p_screws_circle_diameter(p)/2 >= get_flange_diameter(p)/2
											- get_screw_space(p)/2 
					? //screws_circle_diameter too big
						get_flange_diameter(p)/2 - get_screw_space(p)/2
					: p_screws_circle_diameter(p)/2 //place it where whished
			: //screws are inside rod holder
				get_num_of_screws(p) == 1 ? 0 //0 => place it in center
				: p_screws_circle_diameter(p)/2 >= p_rod_diameter(p)/2-get_screw_space(p)/2
					? p_rod_diameter(p)/2-get_screw_space(p)/2
					: p_screws_circle_diameter(p)/2
			;
function get_screw_champfer_height(p) = 
            sqrt(2)*(get_screw_head_dia(p)-p_screw_hole_dia(p))/2;

function get_screw_champfer_z(p) = 
			is_screws_on_flange(p) ? base_plate_top(p) 
			: get_backwall_z(p);



function is_screws_on_flange(p) = p_screws_location(p) == "flange";


 
// *******************************************
// Test and Demo output
// *******************************************
module demo()
{
	//translate([0,-100,0])
	//customizer_output();
	base_x=-175;
	params = [20,		// 0 : rod_diameter,
			4,		// 1 : rod_wall_thickness,
			20,		// 2 : total_height,
			360,	// 3: rod_mount_solid_angle,
			5,		// 4: flange_thickness,
			50,		// 5: flange_diameter,
			2,		// 6: backwall_thickness,
			1,		// 7: edge_radius,
			8,		// 8: extension_radius,
			60,		// 9: finesse,
			7,		// 10: pin_diameter,
			15,		// 11: pin_center_z,
			0,		// 12: pin_count,
			0,		// 13: pin_rotation,
			"flange",	// 14: screws_location, 
			0,		// 15: screws_circle_diameter,
			7,		// 16: screw_head_dia,
			3.5,	// 17: screw_hole_dia,
			3,		// 18: number_of_holes,
			"yes",	// 19: screw_champfer];
			];
	translate([base_x+100,0,0])
	make_flange(p=params);
	
	params2 = [20,		// 0 : rod_diameter,
			4,		// 1 : rod_wall_thickness,
			50,		// 2 : total_height,
			360,	// 3: rod_mount_solid_angle,
			2,		// 4: flange_thickness,
			40,		// 5: flange_diameter,
			0,		// 6: backwall_thickness,
			0,		// 7: edge_radius,
			0,		// 8: extension_radius,
			60,		// 9: finesse,
			7,		// 10: pin_diameter,
			15,		// 11: pin_center_z,
			1,		// 12: pin_count,
			0,		// 13: pin_rotation,
			"inside",	// 14: screws_location, 
			0,		// 15: screws_circle_diameter,
			7,		// 16: screw_head_dia,
			3.5,	// 17: screw_hole_dia,
			3,		// 18: number_of_holes,
			"yes",	// 19: screw_champfer];
			];
	translate([base_x+150,0,0])
	make_flange(p=params2);
	
	params3 = [12,		// 0 : rod_diameter,
			7,		// 1 : rod_wall_thickness,
			20,		// 2 : total_height,
			190,	// 3: rod_mount_solid_angle,
			5,		// 4: flange_thickness,
			50,		// 5: flange_diameter,
			2,		// 6: backwall_thickness,
			1,		// 7: edge_radius,
			8,		// 8: extension_radius,
			60,		// 9: finesse,
			7,		// 10: pin_diameter,
			15,		// 11: pin_center_z,
			0,		// 12: pin_count,
			0,		// 13: pin_rotation,
			"flange",	// 14: screws_location, 
			0,		// 15: screws_circle_diameter,
			7,		// 16: screw_head_dia,
			3.5,	// 17: screw_hole_dia,
			2,		// 18: number_of_holes,
			"yes",	// 19: screw_champfer];
			];
	translate([base_x+200,0,0])
	make_flange(p=params3);
	
	params4 = [12,		// 0 : rod_diameter,
			7,		// 1 : rod_wall_thickness,
			20,		// 2 : total_height,
			360,	// 3: rod_mount_solid_angle,
			5,		// 4: flange_thickness,
			28,		// 5: flange_diameter,
			20,		// 6: backwall_thickness,
			3,		// 7: edge_radius,
			0,		// 8: extension_radius,
			60,		// 9: finesse,
			7,		// 10: pin_diameter,
			15,		// 11: pin_center_z,
			0,		// 12: pin_count,
			0,		// 13: pin_rotation,
			"inside",	// 14: screws_location, 
			0,		// 15: screws_circle_diameter,
			7,		// 16: screw_head_dia,
			3.5,	// 17: screw_hole_dia,
			2,		// 18: number_of_holes,
			"yes",	// 19: screw_champfer];
			];
	translate([base_x+250,0,0])
	make_flange(p=params4);	
}

 
 
 
// ********************************************************************
// ********************************************************************
// ********************************************************************
// ********************************************************************


/// **********************************************************************
/// **********************************************************************
//
// Code from Functional OpenSCAD library by thehans 
// https://github.com/thehans/FunctionalOpenSCAD
//
/// **********************************************************************
/// **********************************************************************
// Set View -> Animate, and set FPS to 60 and Steps to 200 or for example morphing through some possible combinations


/// **********************************************************************
// Code from Functional OpenSCAD library by thehans
// double_fillet.scad
/// **********************************************************************


// sine function for animating oscillating parameters
function sine(minY=-1,maxY=1,freq=1,phase=0,x=$t) = minY + (maxY - minY) * (sin(360*freq*x+360*phase)+1)/2;

// Sample
/*
profile = double_fillet(h=10, r1=sine(1,4,3), r2=sine(1,4,2,0.25), xoffset1=12, xoffset2=sine(-15,5,phase=0.66), $fn=100);
rotate_extrude(angle=270, convexity=3,$fn=200) polygon(profile);
*/ 

// Double Fillet generates a path that is a smooth transition between two parallel surfaces
// h is the vertical distance between surfaces, negative height will mirror about the vertical axis
// r1 and r2 are the first and second fillet radius traversing away from origin
// xoffset1 distance from origin where first radius begins ( should be >= 0 )
// xoffset2 distance from edge of first radius to the start of second radius.  0 value makes straight wall, < 0 makes overhang
// closed = true will return a closed polygon ready for extrusion, 
//    while cloesd == false returns a just the curved vertex path that can be use as part of a larger path
function double_fillet(h=1, r1=1, r2=1, xoffset1=0, xoffset2=0, closed=true) = 
  let(
    ah = abs(h),
    xL = r1 + r2 + xoffset2,
    yL = ah - r1 - r2,
    L = max(sqrt(xL * xL + yL * yL), r1 + r2),
    a1 = 90-acos( (r1 + r2) / L ),
    a2 = atan2( yL, xL ),
    a = a1 + a2,
    c1 = [xoffset1,ah-r1],
    c2 = c1 + [xL,-yL],
    arc1 = arc(r=r1, angle=-a, offsetAngle=90,c=c1),
    arc2 = arc(r=r2, angle=-a, offsetAngle=-90,c=c2)
  )
  mirror([0,h < 0 ? 1 : 0],
  concat(
    closed ? [[0,0],[0,ah]] : [],
    arc1,
    reverse(arc2)
  ));
 
 
 
 
// ********************************************************************
// "Functional OpenSCAD" library by Hans Loeblich
// 
// https://github.com/thehans/FunctionalOpenSCAD
//
// This library is an attempt to re-implement OpenSCAD's builtin modules 
// as functions which operate directly on vertex data.

// TODO support multiple paths for polygons in linear_extrude and rotate_extrude
// TODO better document utility functions

//functional_examples();

// Some basic examples of how library functions can be used
module functional_examples() {

  // multiple nested function calls, with the results of a function passed as poly parameter for another
  color("yellow") poly3d(
    translate([10,0,0], 
      poly=scale([1,2,4], 
        poly=sphere(1,$fn=30)
      )
    ) 
  );  
  
  r = 2;
  
  // assigning function results to intermediate variables
  shape = sphere(r=r,$fn=20);
  moved_shape = translate([-10,0,0], poly=shape);
  color("blue") poly3d(moved_shape);  
  
  // calculate properties of the geometry
  echo(str("volume of blue: ", signed_volume(moved_shape), " mm^3" ) );
  echo(str("volume of perfect sphere: V = 4/3*PI*r^3 = ", (4/3)*PI*pow(r,3), " mm^3" ));
  
  // make a vector containing multiple shapes
  shape_vector = [ for (i = [-1:1]) translate([0,i*10,0], poly=cube(i*2+4,center=true)) ];
  color("green") poly3d(shape_vector);

  // compute properties on lists
  b = bounds(shape_vector);
  echo(bounds=b);
  volumes = [for (shape = shape_vector) signed_volume(shape) ];
  echo(volumes=volumes);
  volumesum = signed_volume(shape_vector);
  echo(volumesum=volumesum);

  // show corner points of a bounding volume
  color("red") showPoints(b, r=0.5, $fn=40);

  // debug point locations
  showPoints(shape_vector);
  //echo(shape_vector=shape_vector);

  // display the bounding volume
  //color([1,1,1,0.1]) translate(b[0]) cube(b[1]-b[0]);
}



// basic utility functions
function is_array(a) = len(a) != undef;
function unit(v) = v / norm(v); // convert vector to unit vector
function flatten(l) = [ for (a = l) for (b = a) b ];
function reverse(v) = [ for (i = [0:len(v)-1])  v[len(v) -1 - i] ];
// integer based range, inclusive
function irange(a,b) = let (step = a > b ? -1 : 1) [ for (i = [a:step:b]) i ];

// sum a vector of numbers.  sum([]) == 0
function sum(v, i=0) = len(v) > i ? v[i] + sum(v, i+1) : 0;
// sum a vector of vectors.  vsum([]) == undef
function vsum(v,i=0) = len(v)-1 > i ? v[i] + vsum(v, i+1) : v[i];

// depth of first elements, not necessarily max depth of a structure
function depth(a,n=0) = len(a) == undef ? n : depth(a[0],n+1);
function default(x,default) = x == undef ? default : x;
// "polyhole" conversion, typically for internal holes
function to_internal(r_in, r_max) = r_in / cos (180 / fragments(r_max == undef ? r_in : r_max));
// angle between two vectors (2D or 3D)
function anglev(v1,v2) = acos( (v1*v2) / (norm(v1)*norm(v2) ) );

function sinh(x) = (1 - exp( -2 * x) )/ (2 * exp(-x));
function cosh(x) = (1 + exp( -2 * x)) / (2 * exp(-x));
function tanh(x) = sinh(x) / cosh(x);
function cot(x) = 1 / tan(x);
function mod(a,m) = a - m*floor(a/m);

// Helper functions mainly used within other functions:

// based on get_fragments_from_r documented on wiki
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#$fa,_$fs_and_$fn
function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));

// Calculate fragments for a linear dimension.
// (don't factor in radius-based calculations)
function linear_fragments(l=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(l / $fs),5);

// Generate a list of points for a circular arc with center c, radius r, etc.
// "center" parameter centers the sweep of the arc about the offsetAngle (half to each side of it)
// "internal" parameter enables polyhole radius correction
// optional "d" parameter overrides r
// optional "fragments" parameter overrides calculations from $fn,$fs,$fa with a direct input
// optional "endpoint" parameter specifies whether or not to include the last point in the arc, 
//    by default the endpoint is included as long as the angle is not 360
//    setting endpoint=false can be useful to avoid duplicating points if you are concatenating arc paths together
function arc(r=1, angle=360, offsetAngle=0, c=[0,0], center=false, internal=false, d, fragments, endpoint) = 
  let (
    r1 = d==undef ? r : d/2,
    fragments = fragments==undef ? ceil((abs(angle) / 360) * fragments(r1,$fn)) : fragments,
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0),
    R = internal ? to_internal(r1) : r1,
    last = endpoint==undef ? (abs(angle) == 360 ? 1 : 0) : (endpoint ? 0 : 1)
  )
  [ for (i = [0:fragments-last] ) let(a2=i*step+a) c+R*[cos(a2), sin(a2)] ];

// **2D Primitives**
function square(size=1, center=false,r=0) =
  let(
    x = len(size) ? size.x : size, 
    y = len(size) ? size.y : size,
    o = center ? [-x/2,-y/2] : [0,0],
    d = r*2
  )
  //assert(d <= x && d <= y)
  translate(o, 
    (r > 0 ? 
      concat(
        arc(r=r, angle=-90, offsetAngle=0,   c=[x-r,  r]), 
        arc(r=r, angle=-90, offsetAngle=270, c=[  r,  r]), 
        arc(r=r, angle=-90, offsetAngle=180, c=[  r,y-r]), 
        arc(r=r, angle=-90, offsetAngle=90,  c=[x-r,y-r])
      ) :
      [[[0,0],[0,y],[x,y],[x,0]],[[0,1,2,3]]]
    )
  );

function circle(r=1, c=[0,0], internal=false, offsetAngle=0, d) = 
  let(
    r1 = d==undef ? r : d/2,
    points = arc(r=r1,c=c,angle=-360,offsetAngle=offsetAngle,internal=internal)
  )
  [points,[irange(0,len(points)-1)]];


// **3D Primitives**
function cube(size=1, center=false) = 
  let(
    s = is_array(size) ? size : [size,size,size],
    points = [
      [0,0,0],[s.x,0,0],[0,s.y,0],[s.x,s.y,0],
      [0,0,s.z],[s.x,0,s.z],[0,s.y,s.z],[s.x,s.y,s.z]],
    faces = [[3,1,5,7],[0,1,3,2],[1,0,4,5],[2,3,7,6],[0,2,6,4],[5,4,6,7]],
    c = is_array(center) ? [center.x ? s.x : 0, center.y ? s.y : 0, center.z ? s.z : 0]/2 : s/2 
  )
  center ? [translate(-c,points),faces] : [points,faces];

function sphere(r=1, d) = 
  let(
    R = d == undef ? r : d/2,
    fragments = fragments(R),
    rings = floor((fragments+1)/2),
    c1 = get_points(circle(r=R)),
    points = flatten([for (i = [0:rings-1])
      let(angle =  (180 * (i + 0.5)) / rings)
      translate([0,0,R*cos(angle)], poly=sin(angle)*c1) 
    ]),
    lp = len(points),
    faces = concat(
      flatten([
        for (i = [0:rings-2], j = [0:fragments-1])
          let (
            il = i * fragments,
            il1 = il + fragments,
            j1 = (j == fragments-1) ? 0 : j+1,
            i0 = il + j, 
            i1 = il + j1, 
            i2 = il1 + j, 
            i3 = il1 + j1
          )
          [[i0,i2,i1],[i1,i2,i3]]
      ]),
      [irange(0,fragments-1)], // top ring face
      [irange(lp-1,lp-fragments)] // bottom ring face
    )
  )
  [points,faces];

// cylinder
function cylinder(h=1,r1,r2,center=false,r,d,d1,d2) = 
  let(
    R1 = (d1 == undef ? (d == undef ? (r1 == undef ? (r == undef ? 1 : r) : r1) : d/2) : d1/2),
    R2 = (d2 == undef ? (d == undef ? (r2 == undef ? (r == undef ? 1 : r) : r2) : d/2) : d2/2),
    scale = R2/R1
  )
  linear_extrude(height=h, scale=scale, center=center, poly=circle(r=R1));



// **3D to 2D**
// TODO projection



// **2D to 3D**
function linear_extrude(height=100, center=false, convexity=1, twist=0, slices, scale=1.0, poly) = 
  is_poly_vector(poly) ? 
    [for (p = poly) _linear_extrude(height=height,center=center,convexity=convexity,twist=twist,slices=slices,scale=scale,poly=poly)] :
    _linear_extrude(height=height,center=center,convexity=convexity,twist=twist,slices=slices,scale=scale,poly=poly);

function _linear_extrude(height, center, convexity, twist, slices, scale, poly) = 
  let(
    points = get_points(poly),
    sl = slices == undef ? (twist == 0 ? 1 : 7) : slices,
    hstep = height/sl,
    astep = -twist/sl,
    sstep = (scale-1)/sl,
    hoffset = center ? -height/2 : 0,
    newPoints = flatten([for (i = [0:sl]) 
      rotate(a=astep*i, poly=
        translate([0,0,hstep*i+hoffset], poly=
          scale(1+sstep*i, poly=
            points
          )
        )
      )
    ]),
    l = len(points),
    lp = len(newPoints),
    faces = concat(
      flatten(
        [for (i = [0:sl-1], j = [0:l-1] )
          let(
            il = i*l,
            j1 = j + 1 == l ? 0 : j+1,
            i0 = il + j,
            i1 = il + j1,
            i2 = il+l + j,
            i3 = il+l + j1
          )
          [[i0,i1,i3],[i0,i3,i2]]
        ]),
        [irange(l-1,0),irange(lp-l,lp-1)]
    )
  )
  [newPoints, faces];


// generate points/paths for a polyhedron, given a vector of 2d point data
function rotate_extrude(angle=360, offsetAngle=0, center=false, v_offset=0, i_offset=0, poly) = 
  let(
    points = get_points(poly),
    a = ((angle != angle/*nan check*/ || angle==undef || angle > 360) ? 360 :
      (angle <= -360 ? 360 : angle)
    ),
    full_rev = a==360 ? 1 : 0,
    l = len(points),
    xs = [for (p = points) p.x],
    min_x = min(xs),
    max_x = max(xs),
    fragments = ceil((abs(a) / 360) * fragments(max_x,$fn)),
    steps = fragments - full_rev,
    step = a / fragments,
    a1 = offsetAngle-(center ? a/2 : 0),
    ps = rotate(a=[90,0,0],poly=signed_area(points) < 0 ? reverse(points) : points),
    out_points = flatten([ 
      for (i = [0:steps] ) 
        let(a2=i*step+a1,h=v_offset*i/(fragments)) 
        translate([0,0,h], poly=rotate(a2, poly=ps))
    ]),
    lp = len(out_points),
    out_paths = flatten([
      for (i = [0:fragments-1], j = [0:l-1])
        let(
          il = i*l,
          il1 = (i == steps) ? 0 : (i+1)*l,
          j1 = (j == l-1) ? 0 : j+1,
          a=il+j,
          b=il+j1,
          c=il1+j,
          d=il1+j1,
          ax=ps[j].x,
          bx=ps[j1].x
        )
        ax == 0 ? // ax == cx == 0 
          (bx == 0 ? 
            [] : // zero area tri
            [[c,b,d]] // triangle fan
          ) :
          (bx == 0 ? // bx == dx == 0
            [[a,b,c]] : // triangle fan
            [[a,b,c], [c,b,d]] // full quad
          )
    ]),
    faces = full_rev ? 
      out_paths : 
      concat(out_paths, [irange(l-1,0),irange(lp-l,lp-1)]) // include end caps
  )
  //assert(min_x >= 0)
  [out_points, faces];


// **Transform**

// get/set point array from 3 possible input types: 
//    poly=[points, faces] (as used by polyhedron), 
//    poly=[points, paths] (as used by polygon), 
// or poly=points (used by polygon or for intermediate point data processing)
function get_points(poly) = depth(poly) <= 2 ? poly : poly[0];
function set_points(poly, points) = depth(poly) <= 2 ? points : [points,poly[1]];

function is_poly_vector(poly) = depth(poly) > 3;
function is_3d_poly(poly) = is_poly_vector(poly) ?
  len(get_points(poly[0])[0]) == 3 : 
  len(get_points(poly)[0]) == 3;
  
// scale
function scale(v=1, poly) = is_poly_vector(poly) ? 
  [for (p=poly) _scale(v=v,poly=p)] :
  _scale(v=v,poly=poly);

// scale for single poly, no vectors of polys
function _scale(v, poly) = 
  let(
    points = get_points(poly),
    s = len(v) ? v : [v,v,v],
    newPoints = len(points[0]) == 3 ? 
      [for (p = points) [s.x*p.x,s.y*p.y,s.z*p.z]] : 
      [for (p = points) [s.x*p.x,s.y*p.y]]
  )
  set_points(poly, newPoints);


// resize
function resize(newsize,poly) = 
  let(
    b = bounds(poly),
    minB = b[0],
    maxB = b[1],
    sX = newsize.x ? newsize.x/(maxB.x-minB.x) : 1,
    sY = newsize.y ? newsize.y/(maxB.y-minB.y) : 1,
    v1 = len(minB) == 3 ? 
      [sX, sY, newsize.z ? newsize.z/(maxB.z-minB.z) : 1] :
      [sX, sY]
  )
  scale(v1,poly);

function rotate(a=0, v, poly) = is_poly_vector(poly) ? 
  [for (p=poly) _rotate(a=a,v=v,poly=p)] :
  _rotate(a=a,v=v,poly=poly);

function _rotate(a, v, poly) = 
  let(
    points = get_points(poly),
    newPoints = is_3d_poly(points) || len(a) == 3 ? 
      _rotate3d(a=a,v=v,points=points) : 
      _rotate2d(a=a,points=points)
  )
  set_points(poly, newPoints);

function _rotate3d(a,v,points) = 
  let(A = is_array(a) ? to3d(a) : [0,0,a])
  (!is_array(a) && is_array(v)) ?
    _rotate3d_v(a,unit(to3d(v)),points) :
    _rotate3d_xyz(A,points);

// rotate a list of 3d points by angle vector a
// a = [pitch,roll,yaw] in degrees
function _rotate3d_xyz(a, points) = 
  let(
    cosa = cos(a.z), sina = sin(a.z),
    cosb = cos(a.y), sinb = sin(a.y),
    cosc = cos(a.x), sinc = sin(a.x),
    Axx = cosa*cosb,
    Axy = cosa*sinb*sinc - sina*cosc,
    Axz = cosa*sinb*cosc + sina*sinc,
    Ayx = sina*cosb,
    Ayy = sina*sinb*sinc + cosa*cosc,
    Ayz = sina*sinb*cosc - cosa*sinc,
    Azx = -sinb,
    Azy = cosb*sinc,
    Azz = cosb*cosc
  )
  [for (p = points)
    let( pz = (p.z == undef) ? 0 : p.z )
    [Axx*p.x + Axy*p.y + Axz*pz, 
     Ayx*p.x + Ayy*p.y + Ayz*pz, 
     Azx*p.x + Azy*p.y + Azz*pz] ];

function _rotate3d_v(a, v, points) = 
  let(
    cosa = cos(a), sina = sin(a)
  )
  [for (p = points)
    let( P=to3d(p) )
    P*cosa+(cross(v,P))*sina+v*(v*P)*(1-cosa) // Rodrigues' rotation formula
  ];

// rotate about z axis without adding 3rd dimension to points
function _rotate2d(a, points) = 
  let(cosa = cos(a), sina = sin(a))
  [for (p = points) [p.x * cosa - p.y * sina,p.x * sina + p.y * cosa]];

function translate(v, poly) = is_poly_vector(poly) ? 
  [for (p=poly) _translate(v=v, poly=p)] :
  _translate(v=v, poly=poly);

function _translate(v, poly) = 
  let(
    points = get_points(poly),
    lp = len(points[0]), // 2d or 3d point data?
    lv = len(v),         // 2d or 3d translation vector?
    V = lp > lv ? [v.x,v.y,0] : v, // allow adding a 2d vector to 3d points
    newPoints = (lv > lp) ?
        [for (p = points) [p.x,p.y,0]+V] : // allow adding a 3d vector to 2d point data
        [for (p = points) p+V] // allow adding 2d or 3d vectors 
  )
  set_points(poly, newPoints);

function mirror(normal, poly) = is_poly_vector(poly) ? 
  [for (p=poly) _mirror(normal=normal, poly=p)] :
  _mirror(normal=normal, poly=poly);
        
function _mirror(normal=[1,0], poly) = 
  let(
    points = get_points(poly),
    newPoints = [for (p = points)
      let(
        n = normal*normal, 
        t = n == 0 ? 0 : (-p*normal) / n
      )
      p + 2*t*normal
    ]
  )
  set_points(poly, newPoints);

function multmatrix(M, poly) = is_poly_vector(poly) ?
  [for (p = poly) _multmatrix(M=M,poly=p)] :
  _multmatrix(M=M,poly=poly);

function _multmatrix(M, poly) = 
  let(
    points = get_points(poly),
    newPoints = is_3d_poly(poly) ? 
      [for (p = points) to3d(M*[p.x,p.y,p.z,1])] : 
      [for (p = points) to2d(M*[p.x,p.y,0,1])]
  )
  set_points(poly, newPoints);


function bounds(poly) = is_3d_poly(poly) ?
  (is_poly_vector(poly) ?
    _bounds_multi_3d(poly) :
    _bounds_3d(poly)) :
  (is_poly_vector(poly) ? 
    _bounds_multi_2d(poly) :
    _bounds_2d(poly));

function _bounds_2d(poly) = 
    let(
      points = get_points(poly),
      minX = min([for (p = points) p.x]),
      maxX = max([for (p = points) p.x]),
      minY = min([for (p = points) p.y]),
      maxY = max([for (p = points) p.y])
    )
    [[minX,minY],[maxX,maxY]];

function _bounds_3d(poly) = 
    let(
      points = get_points(poly),
      minX = min([for (p = points) p.x]),
      maxX = max([for (p = points) p.x]),
      minY = min([for (p = points) p.y]),
      maxY = max([for (p = points) p.y]),
      minZ = min([for (p = points) p.z]),
      maxZ = max([for (p = points) p.z])
    )
    [[minX,minY,minZ],[maxX,maxY,maxZ]];

function _bounds_multi_2d(polys) = 
    let(
      minX = min([for (poly=polys, p = get_points(poly)) p.x]),
      maxX = max([for (poly=polys, p = get_points(poly)) p.x]),
      minY = min([for (poly=polys, p = get_points(poly)) p.y]),
      maxY = max([for (poly=polys, p = get_points(poly)) p.y])
    )
    [[minX,minY],[maxX,maxY]];

function _bounds_multi_3d(polys) = 
    let(
      minX = min([for (poly=polys, p = get_points(poly)) p.x]),
      maxX = max([for (poly=polys, p = get_points(poly)) p.x]),
      minY = min([for (poly=polys, p = get_points(poly)) p.y]),
      maxY = max([for (poly=polys, p = get_points(poly)) p.y]),
      minZ = min([for (poly=polys, p = get_points(poly)) p.z]),
      maxZ = max([for (poly=polys, p = get_points(poly)) p.z])
    )
    [[minX,minY,minZ],[maxX,maxY,maxZ]];

// reverse direction of all faces in polyhedron.
function invert(poly) = 
  let(faces = poly[1])    
  [ poly[0], [for (face = faces) reverse(face)] ];

function to3d(p) = let(l = len(p)) (l>2 ? [p.x,p.y,p.z] : (l>1 ? [p.x,p.y,0]:(l>0 ? [p.x,0,0] : [0,0,0])));
function to2d(p) = let(l = len(p)) (l>1 ? [p.x,p.y]:(l>0 ? [p.x,0] : [0,0]));

// shoelace formula, returns negative value for clockwise wound polygons
function signed_area(points) =
  let( l = len(points) )
  sum([
    for (i = [0:l-1]) 
      let(
        p_i = points[i], 
        i1 = i+1, 
        p_i1 = points[i1 >= l ? i1-l : i1]
      )
      p_i.x * p_i1.y - p_i1.x * p_i.y
  ])/2;

function signed_volume(poly) = is_poly_vector(poly) ? 
  sum([for (p=poly) _signed_volume(p)]) :
  _signed_volume(poly);

function _signed_volume(poly) =
  let(
    points = poly[0],
    faces = poly[1]
  )
  sum([for(face = faces) 
    let(l = len(face))
    (l > 2) ?
      sum([ for(i = [1:l-2])
        cross(points[face[i+1]], points[face[i]]) * points[face[0]]
      ]) / 6 :
      0
  ]);  

/* Visualizations */

// visualize a vector of points
module showPoints(poly, r=0.1, $fn=8) {
  if (is_poly_vector(poly))
    for (p = poly) _showPoints(p, r);
  else
    _showPoints(poly, r);
}

module _showPoints(poly, r) {
  points = get_points(poly);
  for (c = points) translate(c) sphere(r=r);
}

module poly3d(poly, convexity=1) {
  if (is_poly_vector(poly))
    for (p = poly) polyhedron(points=p[0],faces=p[1], convexity=convexity);
  else
    polyhedron(points=poly[0],faces=poly[1], convexity=convexity);
}

module poly2d(poly) {
  if (is_poly_vector(poly))
    for (p = poly) polygon(points=p[0], paths=p[1]);
  else {
    if (depth(poly) == 2)
      polygon(poly);
    else
      polygon(points=poly[0], paths=poly[1]);
  }
}
