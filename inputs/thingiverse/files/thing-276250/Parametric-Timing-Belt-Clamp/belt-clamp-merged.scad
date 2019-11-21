//	Timing Belt Clamp Plate by Will Winder

// Rounded square module
//include <rounded_corner_square.scad>;
//include <timing_belts.scad>;

//CUSTOMIZER VARIABLES

// Padding around plated parts after generating the mode.
space_between_parts = 4;
// Wall thickness
robustness = 3;

// 5.5
// Diameter of mounting hole in mm
belt_hole_diameter = 5.3;
// 19.4
// Distance between centers of mounting holes in mm.
belt_hole_separation = 20;

// Diameter of hole on clamp in mm.
clamp_hole_diameter = 2.9;
// Diameter of clamp hole countersink in mm.
clamp_hole_countersink_diameter = 6.5;
// Thickness of the clamping section of mount in mm.
clamp_depth = 7;

// Distance in mm above the top of the mounting bolts to the belt section.
belt_clamp_rise = 11.4;
// Distance in mm between the bolt closest to the belt and the belt.
belt_clamp_run = 22.5;
// Width of belt area, you may want to make this slightly oversided.
belt_width = 7;
// Type of belting.
belt_profile = "MXL"; // ["MXL","T2.5", "T5" , "T10"]
// This adjusts how far into the clamp the belt pattern will be cut, the default setting is tuned for MXL.
belt_depth_fine_tuning = 0;

// Position of belt cutout: on the clamp block, on the mount or no belt cutout.
belt_position = "MOUNT"; // ["MOUNT", "CLAMP", "NONE"]

// Change this to customize circle resolution.
$fn=15;

//CUSTOMIZER VARIABLES END

// bolt_plate_calculated
mount_width = belt_hole_separation + belt_hole_diameter*3;
mount_height = belt_hole_diameter * 2 + robustness*2;
bolt_side_radius = belt_hole_diameter;

// belt_plate calculated
belt_plate_farspace = clamp_hole_diameter*2.3; // enough space for the clamp bolts
belt_plate_width = belt_clamp_run + belt_width + belt_plate_farspace - (mount_width-belt_hole_separation)/2;
belt_plate_height = mount_height + (belt_clamp_rise - mount_height/2) ;

// Calculate this one from parameters?
side_support_height = 12;




///////////////////////////////
// HERE ARE THE ACTUAL PARTS //
///////////////////////////////
belt_clamp_assemble();

translate([-space_between_parts-mount_height, mount_width,0]) rotate([0,0,-90])
  rotate([0,0,180])
    mirror([1,1,0])
      belt_clamp_assemble();

translate([belt_plate_height + belt_width + belt_plate_farspace*2, robustness + side_support_height,0])
  rotate([0,0,90])
    belt_clamp();

translate([belt_plate_height + belt_width + belt_plate_farspace*2, (robustness + side_support_height)*2 + space_between_parts,0])
  rotate([0,0,90])
    belt_clamp();

///////////////////////
// BELOW IS THE CODE //
///////////////////////




module right_triangle(width, height, thickness) {
union() {
polyhedron(
	points=[ [0,0,0],
			 [0,width,0],	
			 [0,0,height],
			 
			 [thickness,0,0],
			 [thickness,width,0],
			 [thickness,0,height] ],
	triangles=[[0,1,2], [5,4,3], // front & back
			  [1,5,2], [4,5,1],  // top
			  [0,2,3], [3,2,5],  // back
			  [0,4,1], [0,3,4]]);// bottom
  }
}

module bolt_plate() {
difference() {
  union() {
    linear_extrude(height=robustness)
    rounded_square([mount_height, mount_width], [0,0,bolt_side_radius,bolt_side_radius]);
	
    translate([0,0,robustness])
    right_triangle(mount_width-bolt_side_radius, side_support_height, mount_height);
	
    //translate([mount_height-robustness, 0, robustness])
    //right_triangle(mount_width-bolt_side_radius, side_support_height, robustness);
  }

  // Chop out the middle of the triangle.
  translate([robustness,robustness,robustness]) linear_extrude(height=side_support_height)
  rounded_square([mount_height-robustness*2,mount_width], [2,2,0,0]);

  // one hole
  translate([mount_height/2, (mount_width-belt_hole_separation)/2 + belt_hole_separation, -1])
  cylinder(r=belt_hole_diameter/2, h=robustness+2);

  // other hole
  translate([mount_height/2, (mount_width-belt_hole_separation)/2, -1])
  cylinder(r=belt_hole_diameter/2, h=robustness+2);
}
}

module belt_plate_support() {
union() {
  // base
  linear_extrude(height=robustness)
  polygon( points= [
    [belt_plate_height,belt_width + belt_plate_farspace*2],
    [mount_height,belt_plate_width],
    [0,belt_plate_width],
    [belt_plate_height-clamp_depth,belt_width + belt_plate_farspace*2]
  ]);
  
  // bottom support
  translate([0,0,robustness])
  linear_extrude(height=side_support_height)
    polygon( points= [
      //[belt_plate_height-robustness,0],
      //[belt_plate_height,0],
      [belt_plate_height-clamp_depth+robustness,belt_width + belt_plate_farspace*2],
      [robustness,belt_plate_width],
      [0,belt_plate_width],
      [belt_plate_height-clamp_depth,belt_width + belt_plate_farspace*2]
    ]);

  // top support
  translate([0,0,robustness]) linear_extrude(height=side_support_height)
    polygon( points= [
      //[belt_plate_height-robustness,0],
      //[belt_plate_height,0],
      [belt_plate_height,belt_width + belt_plate_farspace*2],
      [mount_height,belt_plate_width],
      [mount_height-robustness,belt_plate_width],
      [belt_plate_height-robustness,belt_width + belt_plate_farspace*2]
    ]);

  // inner support
  translate([0,0,robustness]) linear_extrude(height=side_support_height)
    polygon( points= [
      //[belt_plate_height-robustness,0],
      //[belt_plate_height,0],
      [belt_plate_height,belt_width + belt_plate_farspace*2],
      [mount_height,belt_plate_width],
      [mount_height-robustness,belt_plate_width],
      [belt_plate_height-robustness,belt_width + belt_plate_farspace*2]
    ]);
  }
}

module belt_plate() {

difference() {
    union() {
      linear_extrude(height=robustness+side_support_height)
      rounded_square([clamp_depth, belt_width + belt_plate_farspace*2, robustness], [belt_plate_farspace/2,0,0,0]);
    }

    if (belt_position == "MOUNT") {
      // cut the belt grooves
      translate([clamp_depth-.6 + belt_depth_fine_tuning, belt_plate_farspace,robustness+side_support_height])
      rotate([0,90,90])
      belt_length(profile = belt_profile, belt_width = belt_width, n = side_support_height);
    }
    // drill holes
	translate([-1,belt_plate_farspace/2,(side_support_height+robustness)/2]) rotate([0,90,0]) cylinder(r=clamp_hole_diameter/2, h=clamp_depth+2);
	translate([-1,belt_width+(belt_plate_farspace/2*3),(side_support_height+robustness)/2]) rotate([0,90,0]) cylinder(r=clamp_hole_diameter/2, h=clamp_depth+2);
  }
}

module belt_clamp() {
    if (belt_position == "CLAMP") {
      translate([-robustness-side_support_height,0 ,clamp_depth/2]) 
      difference() {
        rotate([0,180,0]) 
          belt_clamp_inner();

        // cut the belt grooves
        translate([0 , belt_plate_farspace,-0.6 + belt_depth_fine_tuning])
          rotate([90,180,180])
              belt_length(profile = belt_profile, belt_width = belt_width, n = side_support_height);
      }
    }
    else {
        belt_clamp_inner();
    }
}

module belt_clamp_inner() {
rotate([0,-90,0])
difference() {
    union() {
      linear_extrude(height=robustness+side_support_height)
      rounded_square([clamp_depth/2, belt_width + belt_plate_farspace*2, robustness], [0,belt_plate_farspace/2,0,belt_plate_farspace/2]);
    }

    // drill holes
    translate([-1,belt_plate_farspace/2,(side_support_height+robustness)/2]) 
      rotate([0,90,0]) 
        cylinder(r=(clamp_hole_diameter*1.4)/2, h=clamp_depth+2);
    translate([-1,belt_width+(belt_plate_farspace/2*3),(side_support_height+robustness)/2]) 
      rotate([0,90,0])
        cylinder(r=(clamp_hole_diameter*1.4)/2, h=clamp_depth+2);

     // counter-sink holes
	translate([clamp_depth/8*3,belt_plate_farspace/2,(side_support_height+robustness)/2]) rotate([0,90,0]) cylinder(r=clamp_hole_countersink_diameter/2, h=clamp_depth+2);
	translate([clamp_depth/8*3,belt_width+(belt_plate_farspace/2*3),(side_support_height+robustness)/2]) rotate([0,90,0]) cylinder(r=clamp_hole_countersink_diameter/2, h=clamp_depth+2);

  }
}

module belt_clamp_assemble() {
  union() {
    bolt_plate();
    translate([0,-belt_plate_width,0])
      belt_plate_support();
    translate([belt_plate_height-clamp_depth,-belt_plate_width,0])
      belt_plate();
  }
}







/*Parametric belting section generator 
By - The DoomMeister
Derived from http://www.thingiverse.com/thing:16627 by Droftarts
*/


//Variables
tooth_profile = "MXL"; // "T2.5", "T5" , "T10"
belt_width = 4;
n = 20;

//Draw
/*
belt_length(profile = tooth_profile, belt_width = 10, n = 30);
translate([0,0,-20])color("red")belt_length(profile = "T5", belt_width = 10, n = 15);
translate([0,0,-40])color("green")belt_length(profile = "T10", belt_width = 10, n = 8);
*/

//Outer Module
module belt_length(profile = "T2.5", belt_width = 6, n = 10)
{

			if ( profile == "T2.5" ) 
				{ 
					_belt_length(
						profile=profile, 
						n = n, 
						belt_width = belt_width,
						tooth_pitch = 2.5,
						backing_thickness = 0.6	
						);
				}
			if ( profile == "T5" ) 
				{ 
					_belt_length(
						profile=profile, 
						n = n, 
						belt_width = belt_width,
						tooth_pitch = 5,
						backing_thickness = 1	
						);
				}
			if ( profile == "T10" ) 
				{ 
					_belt_length(
						profile=profile, 
						n = n, 
						belt_width = belt_width,
						tooth_pitch = 10,
						backing_thickness = 2
						);
				}
			if ( profile == "MXL" ) 
				{ 
					_belt_length(
						profile=profile, 
						n = n, 
						belt_width = belt_width,
						tooth_pitch = 2.032,
						backing_thickness = 0.64
						);
				}


}



//inner module
module _belt_length(profile = "T2.5", n = 10, belt_width = 5, tooth_pitch = 2.5, backing_thickness = 0.6)
{

for( i = [0:n])
	{
		union(){

			if ( profile == "T2.5" ) { translate([tooth_pitch*i,0,0])T2_5(width = belt_width);}
			if ( profile == "T5" ) { translate([tooth_pitch*i,0,0])T5(width = belt_width);}
			if ( profile == "T10" ) { translate([tooth_pitch*i,0,0])T10(width = belt_width);}
			if ( profile == "MXL" ) { translate([tooth_pitch*i,0,0])MXL(width = belt_width);}
			translate([(tooth_pitch*i)-(tooth_pitch/2),-backing_thickness,0])cube([tooth_pitch,backing_thickness,belt_width]);
		}
	}
}



//Tooth Form modules - Taken from http://www.thingiverse.com/thing:1662
module T2_5(width = 2)
	{
	linear_extrude(height=width) polygon([[-0.839258,-0.5],[-0.839258,0],[-0.770246,0.021652],[-0.726369,0.079022],[-0.529167,0.620889],[-0.485025,0.67826],[-0.416278,0.699911],[0.416278,0.699911],[0.484849,0.67826],[0.528814,0.620889],[0.726369,0.079022],[0.770114,0.021652],[0.839258,0],[0.839258,-0.5]]);
	}

module T5(width = 2)
	{
	linear_extrude(height=width) polygon([[-1.632126,-0.5],[-1.632126,0],[-1.568549,0.004939],[-1.507539,0.019367],[-1.450023,0.042686],[-1.396912,0.074224],[-1.349125,0.113379],[-1.307581,0.159508],[-1.273186,0.211991],[-1.246868,0.270192],[-1.009802,0.920362],[-0.983414,0.978433],[-0.949018,1.030788],[-0.907524,1.076798],[-0.859829,1.115847],[-0.80682,1.147314],[-0.749402,1.170562],[-0.688471,1.184956],[-0.624921,1.189895],[0.624971,1.189895],[0.688622,1.184956],[0.749607,1.170562],[0.807043,1.147314],[0.860055,1.115847],[0.907754,1.076798],[0.949269,1.030788],[0.9837,0.978433],[1.010193,0.920362],[1.246907,0.270192],[1.273295,0.211991],[1.307726,0.159508],[1.349276,0.113379],[1.397039,0.074224],[1.450111,0.042686],[1.507589,0.019367],[1.568563,0.004939],[1.632126,0],[1.632126,-0.5]]);
	}

module T10(width = 2)
	{
	linear_extrude(height=width) polygon([[-3.06511,-1],[-3.06511,0],[-2.971998,0.007239],[-2.882718,0.028344],[-2.79859,0.062396],[-2.720931,0.108479],[-2.651061,0.165675],[-2.590298,0.233065],[-2.539962,0.309732],[-2.501371,0.394759],[-1.879071,2.105025],[-1.840363,2.190052],[-1.789939,2.266719],[-1.729114,2.334109],[-1.659202,2.391304],[-1.581518,2.437387],[-1.497376,2.47144],[-1.408092,2.492545],[-1.314979,2.499784],[1.314979,2.499784],[1.408091,2.492545],[1.497371,2.47144],[1.581499,2.437387],[1.659158,2.391304],[1.729028,2.334109],[1.789791,2.266719],[1.840127,2.190052],[1.878718,2.105025],[2.501018,0.394759],[2.539726,0.309732],[2.59015,0.233065],[2.650975,0.165675],[2.720887,0.108479],[2.798571,0.062396],[2.882713,0.028344],[2.971997,0.007239],[3.06511,0],[3.06511,-1]]);
	}

module MXL(width = 2)
	{
	linear_extrude(height=width) polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
	}


// Rounded corner square

module rounded_square(dim, corners=[10,10,10,10], center=false){
  w=dim[0];
  h=dim[1];

  if (center){
    translate([-w/2, -h/2])
    rounded_square_(dim, corners=corners);
  }else{
    rounded_square_(dim, corners=corners);
  }
}

module rounded_square_(dim, corners, center=false){
  w=dim[0];
  h=dim[1];
  render(){
    difference(){
      square([w,h]);

      if (corners[0])
        square([corners[0], corners[0]]);

      if (corners[1])
        translate([w-corners[1],0])
        square([corners[1], corners[1]]);

      if (corners[2])
        translate([0,h-corners[2]])
        square([corners[2], corners[2]]);

      if (corners[3])
        translate([w-corners[3], h-corners[3]])
        square([corners[3], corners[3]]);
    }

    if (corners[0])
      translate([corners[0], corners[0]])
      intersection(){
        circle(r=corners[0]);
        translate([-corners[0], -corners[0]])
        square([corners[0], corners[0]]);
      }

    if (corners[1])
      translate([w-corners[1], corners[1]])
      intersection(){
        circle(r=corners[1]);
        translate([0, -corners[1]])
        square([corners[1], corners[1]]);
      }

    if (corners[2])
      translate([corners[2], h-corners[2]])
      intersection(){
        circle(r=corners[2]);
        translate([-corners[2], 0])
        square([corners[2], corners[2]]);
      }

    if (corners[3])
      translate([w-corners[3], h-corners[3]])
      intersection(){
        circle(r=corners[3]);
        square([corners[3], corners[3]]);
      }
  }
}