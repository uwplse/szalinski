/* [General] */

// Change this number to vary the overall gear diameter.  NOTE: In final shape, some of the teeth are trimmed for the gap to tighten by the screw.
NUMBER_OF_TEETH = 140;
// Hole diameter. Change by 0.5mm increments and test
INNER_DIAMETER = 65.5;



/* [Thickness] */

// Outer axial thickness of the gear
GEAR_OUTER_THICKNESS = 24;
// Inner axial thickness of the gear
GEAR_INNER_THICKNESS = 13;
// Radial thickness of the gear
GEAR_RADIAL_THICKNESS = 10;
// Thickness of the inner planarly spring. the multiple of extruder's nozzle diamiter is good.
SPRING_THICKNESS = 2.4;



/* [Screw Tip] */

// Length of the tip for the screw
SCREW_TIP_LENGTH = 9.5;
// Thickness of the tip for the screw
SCREW_TIP_THICKNESS = 5;
// the gap between the screw tips
SCREW_TIP_GAP = 7.5;

// Diameter of the hole for screw
SCREW_HOLE_DIAMETER = 3.2;
// Offset of the screw hole from gear surface outward.
SCREW_HOLE_OFFSET = 4.8;



/* [Accuracy] */

// $fs is the minimum size of a fragment. The default value is 2. If you don't know exactly what you do, just leave the default value.
FS = 0.5;
// $fa is the minimum angle for a fragment. The default value is 12. If you don't know exactly what you do, just leave the default value.
FA = 2;


/*

Ver. 1.01
* GEAR_THICKNESS becomes exactly as stated.
* The dimensions of screw tip become fully customizable.
* For my requirement, introduce INNER_THICKNESS_OFFSET.

Ver. 1.02
* Fix bug for screw tip placement.

Ver. 1.03
* Organize parameters into sections for easy understanding
* Change the structure of thickness parameters for easy understanding

*/



module dummy() {
}

//---------------------------------------------------------------------------------------------------
// PITCH_DIAMETER
module_number = 0.8;    
diametral_pitch = 1/module_number;
circular_pitch = 180/diametral_pitch;
PITCH_DIAMETER  =  NUMBER_OF_TEETH * circular_pitch / 180;

//---------------------------------------------------------------------------------------------------
// OUTER_DIAMETER
OUTER_DIAMETER = PITCH_DIAMETER - GEAR_RADIAL_THICKNESS*2;

//---------------------------------------------------------------------------------------------------
// Other Constants
inf_length = 100;
spring_unit_degree = 50;
spring_offset_degree = 10;

//---------------------------------------------------------------------------------------------------
$fs = FS; // 0.5; // Changed minimum size of circle fragment. Default 2.
$fa = FA; // 2; // Changed minimum angle for circle fragment, gives smoother circle. Default 12.

//---------------------------------------------------------------------------------------------------
// radius
inner_r = (INNER_DIAMETER+SPRING_THICKNESS*2)/2;
outer_r = (OUTER_DIAMETER+SPRING_THICKNESS*2)/2;
pitch_r = PITCH_DIAMETER/2;

//---------------------------------------------------------------------------------------------------
// Thickness of the gear
GEAR_THICKNESS = GEAR_OUTER_THICKNESS;   // [1:1:60]
// Hole diameter. Change by 0.5mm increments and test
BORE_DIAMETER = OUTER_DIAMETER;  // [3:.1:200]


//---------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
r = inner_r;
h = GEAR_OUTER_THICKNESS;
t = SPRING_THICKNESS;
l = outer_r - inner_r + SPRING_THICKNESS;
tip_l = SCREW_TIP_LENGTH;
tip_t = SCREW_TIP_THICKNESS;
tip_g = SCREW_TIP_GAP;


//---------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
module spring_tube(r,h,t) {
    difference () {
        cylinder ( r = r, h = h, center = true);
        cylinder ( r = r - t, h = h*2, center = true);
    }
}

module spring_trimmer_left  (r, h) { translate ([  1 * (inf_length/2 + r*sin(spring_unit_degree/2)), 0, 0]) cube ([inf_length,inf_length,h*2], center = true); }
module spring_trimmer_right (r, h) { translate ([ -1 * (inf_length/2 + r*sin(spring_unit_degree/2)), 0, 0]) cube ([inf_length,inf_length,h*2], center = true); }
module spring_trimmer_bottom (h) {
    translate ([ 0, -inf_length/2, 0]) cube ([inf_length,inf_length,h*2], center = true);
}
module spring_trimmer_top (r, h) {
    cube ([ r*sin(spring_offset_degree/2)*2, inf_length , h*2], center = true);
}
module spring_trimmer_top_inner (r, h, t) {
    translate ([0, inf_length/2 + r + t ,0]) cube ([ 2 * r * sin(spring_unit_degree/2) - t*2 , inf_length,h*2], center = true);
}
module spring_trimmer_top_screw_tip (r, h, t) {
    translate ([0, inf_length/2 + r + t ,0]) cube ([ tip_g , inf_length,h*2], center = true);
}


module spring_wings (r, h, t) {
    difference () {
        spring_tube ( r, h, t );
        spring_trimmer_left  ( r, h );
        spring_trimmer_right ( r, h );
        spring_trimmer_bottom ( h );
        spring_trimmer_top (r, h);
    }
}

module spring_bridge_left  (r, h, t, l) { translate ([  1 * (r*sin(spring_unit_degree/2) - t/2), r*cos(spring_unit_degree/2), 0]) translate ([ 0, l/2 - 1*t/2, 0]) cube ([t,l,h], center = true); }
module spring_bridge_right (r, h, t, l) { translate ([ -1 * (r*sin(spring_unit_degree/2) - t/2), r*cos(spring_unit_degree/2), 0]) translate ([ 0, l/2 - 1*t/2, 0]) cube ([t,l,h], center = true); }

module spring (r, h, t, l) {
    union () {
        spring_wings (r, h, t);
        spring_bridge_left  (r, h, t, l);
        spring_bridge_right (r, h, t, l);
    }
}
module springs (r, h, t, l) {
    for ( i = [0:5] ) {
        rotate ([0,0,60*i]) spring (r, h, t, l);
    }
}

module spring_outer_tube (r, h, t, outer_r) {
    difference () {
        spring_tube(outer_r, h, t);
        spring_trimmer_top_inner (r, h, t);
    }
}

module spring_final (r, h, t, l, outer_r) {
    union () {
        springs (r, h, t, l);
        spring_outer_tube (r, h, t, outer_r);
    }
}




module screw_tip_left (r, h, t, l, tip_t, tip_l) {
    cube_x = tip_t;
    cube_y = tip_l + t;
    
    translate ([
          // 1 * (r*sin(spring_unit_degree/2)+ cube_x/2 - t)
          1 * (tip_g/2 + cube_x/2)
        , pitch_r - t + cube_y/2
        , 0])
    
    cube ([cube_x, cube_y, h], center = true);
}
module screw_tip_right (r, h, t, l, tip_t, tip_l) {
    cube_x = tip_t;
    cube_y = tip_l + t;

    translate ([
         //-1 * (r*sin(spring_unit_degree/2)+ cube_x/2 - t)
         -1 * (tip_g/2 + cube_x/2)
        , pitch_r - t + cube_y/2
        , 0])
    cube ([cube_x, cube_y, h], center = true);
}

module screw_hole () {
    translate ([0,
        pitch_r + tip_l - SCREW_HOLE_OFFSET //SCREW_TIP_LENGTH/2
        , 0] ) 
    rotate([0,90,0]) 
    cylinder ( r = SCREW_HOLE_DIAMETER/2, h = inf_length, center = true);
}





//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
// Copied from:
// https://github.com/jaymis/lens-gear-follow-focus
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================


// Parametric Cinema/Film Lens Gears by Jaymis - http://jaymis.com
// Create precisely-sized, 360 seamless follow focus gears for film and still lenses.
// Including a perky little bevel on gear teeth to remove sharp edges.
//
// Based on "Parametric Involute Bevel and Spur Gears by GregFrost"
// http://www.thingiverse.com/thing:3575
//
// Thanks to sveltema for help making this work with Customiser
// http://www.thingiverse.com/thing:1060283#comment-726112
// http://www.thingiverse.com/sveltema

//==>> Move to header section =======================================================================//
//==>>==// // Change this number to vary the overall gear diameter
//==>>==// NUMBER_OF_TEETH = 140; // [10:1:260]
//==>>==// // Hole diameter. Change by 0.5mm increments and test
//==>>==// BORE_DIAMETER = 64.0;  // [3:.1:200]
//==>>==// // Thickness of the gear
//==>>==// GEAR_THICKNESS = 10;   // [1:1:60]


// Simple Camera Lens Gear:

module gear (
	NUMBER_OF_TEETH=15,
	circular_pitch=false, diametral_pitch=false, module_number = false,	//diametrial pitch is US, Pc is used by tool
	pressure_angle=20,
	clearance = 0.2,
	GEAR_THICKNESS=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	BORE_DIAMETER=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	no_bore = false
	)
{
	if (circular_pitch==false && diametral_pitch==false && module_number==false) 
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//convert module to diametrial pitch because I don't know how to logic
	diametral_pitch = (diametral_pitch!=false?diametral_pitch:1/module_number);

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  NUMBER_OF_TEETH * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", NUMBER_OF_TEETH, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = NUMBER_OF_TEETH / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / NUMBER_OF_TEETH - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

difference () // Difference off hollow cone shapes to remove sharp edges of gears
    {

	difference () // Original gear code
	{
		union () 
		{
			difference () 
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					NUMBER_OF_TEETH,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (GEAR_THICKNESS < rim_thickness)
					translate ([0,0,GEAR_THICKNESS])
					cylinder (r=rim_radius,h=rim_thickness-GEAR_THICKNESS+1);
             
			}
			if (GEAR_THICKNESS > rim_thickness)
				cylinder (r=rim_radius,h=GEAR_THICKNESS);
			if (hub_thickness > GEAR_THICKNESS)
				translate ([0,0,GEAR_THICKNESS])
				cylinder (r=hub_diameter/2,h=hub_thickness-GEAR_THICKNESS);
		}
		if (!no_bore) {
			translate ([0,0,-1])
			cylinder (
				r=BORE_DIAMETER/2,
				h=2+max(rim_thickness,hub_thickness,GEAR_THICKNESS));
		}
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(GEAR_THICKNESS,rim_thickness)+3);
		}



	}
  

union () // Union two separate copies of the same tooth bevelling shape because I don't know how to mirror/copy in OpenSCAD 
    {

    difference() // Create a hollow cone shape for bevelling gear teeth
    {
    translate([0,0,rim_thickness-addendum*2]) 
    cylinder(h = outer_radius, r1 = outer_radius+GEAR_THICKNESS, r2 = outer_radius, center = rim_width); // make a cylinder for bevelling gears
    translate([0,0,rim_thickness-addendum*2-clearance]) 
    cylinder(h = outer_radius, r1 = outer_radius+addendum, r2 = 0, center = outer_radius); // make a cone for bevelling gears
    }

mirror( [0,0,1] )
{
    difference() // Create an inverted hollow cone shape for bevelling gear teeth
    {
    translate([0,0,-addendum*2]) 
    cylinder(h = outer_radius, r1 = outer_radius+GEAR_THICKNESS, r2 = outer_radius, center = rim_width); // make a cylinder for bevelling gears
    translate([0,0,-addendum*2-clearance]) 
    cylinder(h = outer_radius, r1 = outer_radius+addendum, r2 = 0, center = outer_radius); // make a cone for bevelling gears
    }
}


} // end union join top and bottom bevel shapes



}

}

module gear_shape (
	NUMBER_OF_TEETH,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=NUMBER_OF_TEETH*2, r=root_radius);

		for (i = [1:NUMBER_OF_TEETH])
		{
			rotate ([0,0,i*360/NUMBER_OF_TEETH])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res])
		assign (
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res))
		{
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2)))
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}

//==>> Move to header section =======================================================================//
//==>>==// /* [Hidden] */
//==>>==// $fs = 0.5; // Changed minimum size of circle fragment. Default 2.
//==>>==// $fa = 2; // Changed minimum angle for circle fragment, gives smoother circle. Default 12.

pi=3.1415926535897932384626433832795;

//==>> Move to final rendering section =======================================================================//
//==>>==// gear (module_number=0.8, // Camera lens gears are Mod 0.8. Don't change this number unless you have a non-standard follow focus system.
//==>>==// 
//==>>==// 	NUMBER_OF_TEETH = NUMBER_OF_TEETH, 
//==>>==//     BORE_DIAMETER = BORE_DIAMETER, // Hole diameter. Change by 0.5mm increments and test
//==>>==// 
//==>>==// 	rim_thickness = GEAR_THICKNESS, // Thickness of the part with the gear teeth
//==>>==//     GEAR_THICKNESS = GEAR_THICKNESS // Thickness of the part which grips the lens barrel
//==>>==//     );

// Mathematical Functions
//===============

	// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
	//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

	function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

	// Calculate the involute position for a given base radius and involute angle.

	function rotated_involute (rotate, base_radius, involute_angle) = 
	[
		cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],
		cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]
	];

	function mirror_point (coord) = 
	[
		coord[0], 
		-coord[1]
	];

	function rotate_point (rotate, coord) =
	[
		cos (rotate) * coord[0] + sin (rotate) * coord[1],
		cos (rotate) * coord[1] - sin (rotate) * coord[0]
	];

	function involute (base_radius, involute_angle) = 
	[
		base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
		base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),
	];


//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
// END OF COPY
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================
//===================================================================================================




//---------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
difference () {

    union () {

        difference () {
            translate ([0,0,-h/2])
            gear (module_number=0.8, // Camera lens gears are Mod 0.8. Don't change this number unless you have a non-standard follow focus system.

                NUMBER_OF_TEETH = NUMBER_OF_TEETH, 
                BORE_DIAMETER = BORE_DIAMETER, // Hole diameter. Change by 0.5mm increments and test

                rim_thickness = GEAR_THICKNESS, // Thickness of the part with the gear teeth
                GEAR_THICKNESS = GEAR_THICKNESS // Thickness of the part which grips the lens barrel
                );
            spring_trimmer_top_screw_tip (r, h, t);
        }

        spring_final (r, h, t, l, outer_r);

        screw_tip_left  (r, h, t, l, tip_t, tip_l);
        screw_tip_right (r, h, t, l, tip_t, tip_l);
    }

    screw_hole () ;

    if ( h - GEAR_INNER_THICKNESS > 0) {
        trimmer_h = h - GEAR_INNER_THICKNESS;
        translate ([0,0,(h - trimmer_h)/2 ])
        cylinder(h = trimmer_h, r1 = inner_r, r2 = outer_r - t, center = true);
    }

}




