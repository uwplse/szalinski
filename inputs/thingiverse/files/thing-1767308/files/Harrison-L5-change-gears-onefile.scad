Teeth = 50; // [40:127]
// Original measures 22.3
Bore_Diameter=22.8; 
// Original measures 6.35
Keyway_Width=6.6; 
// Original measures 4.6
Keyway_Depth=4.6;

use <write/Write.scad>

// This file is licensed Creative Commons Attribution-ShareAlike 3.0.
// http://creativecommons.org/licenses/by-sa/3.0/

// Gear parameters changed to suit Harrison L5 change 
// gears and OpenSCAD file modified to suit
// customizer by nglasson - 2016

/* [Hidden] */
Thickness=19.05;

// Change gear set for 9x20 HarborFreight, Jet, and Grizzly lathes
// 127x120T, 127x80T, 120x80T, 80x40T, 60x40T
// 45x40T, 48x24T, 42x40T, 40x30T, 40x28T
// 20T, 22T, 28T, 30T (x2), 36T, 40T, 42T, 45T, 60T, and 80T

// If you want a gear set then define the second gear via the TeethSet value
// For printability the second gear should be a smaller value.
// Leave the value commented out if you only want one gear.
//TeethSet=40;

PressureAngle=14.5;
DiametralPitch=0.55118110236220472440944881889764;
// note - above number is 14/25.4  Change this if you want a different DP
/* Found on internet that Harrison L5 lathes use 14 DP and 14.5 deg pressure angle
*/
// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// ------------------------------------------------------------------------

//Mod1 Gears have a constant Diametral Pitch of 1
//If making something else you will need to calculate this value
//or stipulate the value for your specific gear specifications.
//To calculate Diametral Pitch for Mod1
// (Number of teeth +2) / Outside diameter
//Divide number of teeth + 2 by the outside diameter
// Pd = (N+2) / OD
// OD = Teeth + 2
//Thus ((N+2) / (N+2)) = 1

if (TeethSet == undef)
	{
		Gear(Teeth);
	} else {
		GearSet(Teeth,TeethSet);
	}

module GearSet(Gear1, Gear2){
	difference(){
		union(){
			Gear(Gear1);
			translate ([0,0,Thickness]){
				Gear(Gear2);
			}
		}
	}
}

module Gear(ToothCount){
	difference(){
		union(){
			gear(
				number_of_teeth=ToothCount,
				pressure_angle=PressureAngle,
				diametral_pitch=DiametralPitch,
                bore_diameter=Bore_Diameter,
				gear_thickness=Thickness,
				rim_thickness=Thickness,
				hub_thickness=Thickness,
				hub_diameter=Bore_Diameter*1.5
				);
		}
	if (TeethSet == undef)
	{
		if (Teeth >= 28) {
			Text(Teeth);
		}
	} else {
		if (TeethSet >= 28) {
			Text(str(Teeth ,"x", TeethSet));
		}
	}

	Keyway();
	}
}

module Keyway(){
	translate([-(Bore_Diameter/2),0,(Thickness/2)]){
		cube(size=[Keyway_Depth,Keyway_Width,Thickness*1.1],center=true);
	}		
}

module Text(Text){
	if (TeethSet == undef) {
		if (Teeth >= 36)
		{
			translate ([(Bore_Diameter/2)+5,0,Thickness]) {
				rotate(90,[0,0,1])
				write(str(Text),t=(Thickness/4)+2,h=8,center=true);
			}
		} else {
			translate ([(Bore_Diameter/2)+2.8,0,Thickness]) {
				rotate(90,[0,0,1])
				write(str(Text),t=(Thickness/4)+2,h=4.5,center=true);
			}
		}
	} else {
		if (TeethSet >= 36)
		{
			translate ([(Bore_Diameter/2)+4,0,Thickness]) {
				rotate(90,[0,0,1])
				write(str(Text),t=(Thickness/4)+2,h=7.5,center=true);
			}
		} else {
			translate ([(Bore_Diameter/2)+2,0,Thickness]) {
				rotate(90,[0,0,1])
				write(str(Text),t=(Thickness/4)+2,h=4.2,center=true);
			}
		}

	}
}

pi=3.1415926535897932384626433832795;

//==================================================
// Bevel Gears:
// Two gears with the same cone distance, circular pitch (measured at the cone distance)
// and pressure angle will mesh.

module bevel_gear_pair (
        gear1_teeth = 41,
        gear2_teeth = 7,
        axis_angle = 90,
        outside_circular_pitch=1000)
{
        outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
        outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
        pitch_apex1=outside_pitch_radius2 * sin (axis_angle) +
                (outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
        cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
        pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
        echo ("cone_distance", cone_distance);
        pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
        pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
        echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
        echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);

        rotate([0,0,90])
        translate ([0,0,pitch_apex1+20])
        {
                translate([0,0,-pitch_apex1])
                bevel_gear (
                        number_of_teeth=gear1_teeth,
                        cone_distance=cone_distance,
                        pressure_angle=30,
                        outside_circular_pitch=outside_circular_pitch);
        
                rotate([0,-(pitch_angle1+pitch_angle2),0])
                translate([0,0,-pitch_apex2])
                bevel_gear (
                        number_of_teeth=gear2_teeth,
                        cone_distance=cone_distance,
                        pressure_angle=30,
                        outside_circular_pitch=outside_circular_pitch);
        }
}

//Bevel Gear Finishing Options:
bevel_gear_flat = 0;
bevel_gear_back_cone = 1;

module bevel_gear (
        number_of_teeth=11,
        cone_distance=100,
        face_width=20,
        outside_circular_pitch=1000,
        pressure_angle=30,
        clearance = 0.2,
        bore_diameter=5,
        gear_thickness = 15,
        backlash = 0,
        involute_facets=0,
        finish = -1)
{
        echo ("bevel_gear",
                "teeth", number_of_teeth,
                "cone distance", cone_distance,
                face_width,
                outside_circular_pitch,
                pressure_angle,
                clearance,
                bore_diameter,
                involute_facets,
                finish);

        // Pitch diameter: Diameter of pitch circle at the fat end of the gear.
        outside_pitch_diameter = number_of_teeth * outside_circular_pitch / 180;
        outside_pitch_radius = outside_pitch_diameter / 2;

        // The height of the pitch apex.
        pitch_apex = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius, 2));
        pitch_angle = asin (outside_pitch_radius/cone_distance);

        echo ("Num Teeth:", number_of_teeth, " Pitch Angle:", pitch_angle);

        finish = (finish != -1) ? finish : (pitch_angle < 45) ? bevel_gear_flat : bevel_gear_back_cone;

        apex_to_apex=cone_distance / cos (pitch_angle);
        back_cone_radius = apex_to_apex * sin (pitch_angle);

        // Calculate and display the pitch angle. This is needed to determine the angle to mount two meshing cone gears.

        // Base Circle for forming the involute teeth shape.
        base_radius = back_cone_radius * cos (pressure_angle);        

        // Diametrial pitch: Number of teeth per unit length.
        pitch_diametrial = number_of_teeth / outside_pitch_diameter;

        // Addendum: Radial distance from pitch circle to outside circle.
        addendum = 1 / pitch_diametrial;
        // Outer Circle
        outer_radius = back_cone_radius + addendum;

        // Dedendum: Radial distance from pitch circle to root diameter
        dedendum = addendum + clearance;
        dedendum_angle = atan (dedendum / cone_distance);
        root_angle = pitch_angle - dedendum_angle;

        root_cone_full_radius = tan (root_angle)*apex_to_apex;
        back_cone_full_radius=apex_to_apex / tan (pitch_angle);

        back_cone_end_radius =
                outside_pitch_radius -
                dedendum * cos (pitch_angle) -
                gear_thickness / tan (pitch_angle);
        back_cone_descent = dedendum * sin (pitch_angle) + gear_thickness;

        // Root diameter: Diameter of bottom of tooth spaces.
        root_radius = back_cone_radius - dedendum;

        half_tooth_thickness = outside_pitch_radius * sin (360 / (4 * number_of_teeth)) - backlash / 4;
        half_thick_angle = asin (half_tooth_thickness / back_cone_radius);

        face_cone_height = apex_to_apex-face_width / cos (pitch_angle);
        face_cone_full_radius = face_cone_height / tan (pitch_angle);
        face_cone_descent = dedendum * sin (pitch_angle);
        face_cone_end_radius =
                outside_pitch_radius -
                face_width / sin (pitch_angle) -
                face_cone_descent / tan (pitch_angle);

        // For the bevel_gear_flat finish option, calculate the height of a cube to select the portion of the gear that includes the full pitch face.
        bevel_gear_flat_height = pitch_apex - (cone_distance - face_width) * cos (pitch_angle);

//        translate([0,0,-pitch_apex])
        difference ()
        {
                intersection ()
                {
                        union()
                        {
                                rotate (half_thick_angle)
                                translate ([0,0,pitch_apex-apex_to_apex])
                                cylinder ($fn=number_of_teeth*2, r1=root_cone_full_radius,r2=0,h=apex_to_apex);
                                for (i = [1:number_of_teeth])
//                                for (i = [1:1])
                                {
                                        rotate ([0,0,i*360/number_of_teeth])
                                        {
                                                involute_bevel_gear_tooth (
                                                        back_cone_radius = back_cone_radius,
                                                        root_radius = root_radius,
                                                        base_radius = base_radius,
                                                        outer_radius = outer_radius,
                                                        pitch_apex = pitch_apex,
                                                        cone_distance = cone_distance,
                                                        half_thick_angle = half_thick_angle,
                                                        involute_facets = involute_facets);
                                        }
                                }
                        }

                        if (finish == bevel_gear_back_cone)
                        {
                                translate ([0,0,-back_cone_descent])
                                cylinder (
                                        $fn=number_of_teeth*2,
                                        r1=back_cone_end_radius,
                                        r2=back_cone_full_radius*2,
                                        h=apex_to_apex + back_cone_descent);
                        }
                        else
                        {
                                translate ([-1.5*outside_pitch_radius,-1.5*outside_pitch_radius,0])
                                cube ([3*outside_pitch_radius,
                                        3*outside_pitch_radius,
                                        bevel_gear_flat_height]);
                        }
                }
                
                if (finish == bevel_gear_back_cone)
                {
                        translate ([0,0,-face_cone_descent])
                        cylinder (
                                r1=face_cone_end_radius,
                                r2=face_cone_full_radius * 2,
                                h=face_cone_height + face_cone_descent+pitch_apex);
                }

                translate ([0,0,pitch_apex - apex_to_apex])
                cylinder (r=bore_diameter/2,h=apex_to_apex);
        }        
}

module involute_bevel_gear_tooth (
        back_cone_radius,
        root_radius,
        base_radius,
        outer_radius,
        pitch_apex,
        cone_distance,
        half_thick_angle,
        involute_facets)
{
//        echo ("involute_bevel_gear_tooth",
//                back_cone_radius,
//                root_radius,
//                base_radius,
//                outer_radius,
//                pitch_apex,
//                cone_distance,
//                half_thick_angle);

        min_radius = max (base_radius*2,root_radius*2);

        pitch_point =
                involute (
                        base_radius*2,
                        involute_intersect_angle (base_radius*2, back_cone_radius*2));
        pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
        centre_angle = pitch_angle + half_thick_angle;

        start_angle = involute_intersect_angle (base_radius*2, min_radius);
        stop_angle = involute_intersect_angle (base_radius*2, outer_radius*2);

        res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

        translate ([0,0,pitch_apex])
        rotate ([0,-atan(back_cone_radius/cone_distance),0])
        translate ([-back_cone_radius*2,0,-cone_distance*2])
        union ()
        {
                for (i=[1:res])
                {
                        assign (
                                point1=
                                        involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i-1)/res),
                                point2=
                                        involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i)/res))
                        {
                                assign (
                                        side1_point1 = rotate_point (centre_angle, point1),
                                        side1_point2 = rotate_point (centre_angle, point2),
                                        side2_point1 = mirror_point (rotate_point (centre_angle, point1)),
                                        side2_point2 = mirror_point (rotate_point (centre_angle, point2)))
                                {
                                        polyhedron (
                                                points=[
                                                        [back_cone_radius*2+0.1,0,cone_distance*2],
                                                        [side1_point1[0],side1_point1[1],0],
                                                        [side1_point2[0],side1_point2[1],0],
                                                        [side2_point2[0],side2_point2[1],0],
                                                        [side2_point1[0],side2_point1[1],0],
                                                        [0.1,0,0]],
                                                triangles=[[0,1,2],[0,2,3],[0,3,4],[0,5,1],[1,5,2],[2,5,3],[3,5,4],[0,4,5]]);
                                }
                        }
                }
        }
}

module gear (
        number_of_teeth=15,
        circular_pitch=false, diametral_pitch=false,
        pressure_angle=28,
        clearance = 0.2,
        gear_thickness=5,
        rim_thickness=8,
        rim_width=5,
        hub_thickness=10,
        hub_diameter=15,
        bore_diameter=5,
        circles=0,
        backlash=0,
        twist=0,
        involute_facets=0)
{
        if (circular_pitch==false && diametral_pitch==false)
                echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

        //Convert diametrial pitch to our native circular pitch
        circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

        // Pitch diameter: Diameter of pitch circle.
        pitch_diameter = number_of_teeth * circular_pitch / 180;
        pitch_radius = pitch_diameter/2;
        echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

        // Base Circle
        base_radius = pitch_radius*cos(pressure_angle);

        // Diametrial pitch: Number of teeth per unit length.
        pitch_diametrial = number_of_teeth / pitch_diameter;

        // Addendum: Radial distance from pitch circle to outside circle.
        addendum = 1/pitch_diametrial;

        //Outer Circle
        outer_radius = pitch_radius+addendum;

        // Dedendum: Radial distance from pitch circle to root diameter
        dedendum = addendum + clearance;

        // Root diameter: Diameter of bottom of tooth spaces.
        root_radius = pitch_radius-dedendum;
        backlash_angle = backlash / pitch_radius * 180 / pi;
        half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

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

        difference ()
        {
                union ()
                {
                        difference ()
                        {
                                linear_extrude (height=rim_thickness, convexity=10, twist=twist)
                                gear_shape (
                                        number_of_teeth,
                                        pitch_radius = pitch_radius,
                                        root_radius = root_radius,
                                        base_radius = base_radius,
                                        outer_radius = outer_radius,
                                        half_thick_angle = half_thick_angle,
                                        involute_facets=involute_facets);

                                if (gear_thickness < rim_thickness)
                                        translate ([0,0,gear_thickness])
                                        cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
                        }
                        if (gear_thickness > rim_thickness)
                                cylinder (r=rim_radius,h=gear_thickness);
                        if (hub_thickness > gear_thickness)
                                translate ([0,0,gear_thickness])
                                cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);
                }
                translate ([0,0,-1])
                cylinder (
                        r=bore_diameter/2,
                        h=2+max(rim_thickness,hub_thickness,gear_thickness),$fn=32);
                if (circles>0)
                {
                        for(i=[0:circles-1])        
                                rotate([0,0,i*360/circles])
                                translate([circle_orbit_diameter/2,0,-1])
                                cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3);
                }
        }
}

module gear_shape (
        number_of_teeth,
        pitch_radius,
        root_radius,
        base_radius,
        outer_radius,
        half_thick_angle,
        involute_facets)
{
        union()
        {
                rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

                for (i = [1:number_of_teeth])
                {
                        rotate ([0,0,i*360/number_of_teeth])
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


