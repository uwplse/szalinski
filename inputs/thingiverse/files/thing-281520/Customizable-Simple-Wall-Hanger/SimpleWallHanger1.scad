// ************* Credits part *************

// Programmed by Fryns - March 2014

// Optimized for Customizer 

// Includes Pie Slice OpenSCAD Library by Chris Petersen, published on Thingiverse 27-Jun-2013 (thing:109467)	 

// ************* Declaration part *************

/* [Hanger] */
// Width of hanger in mm
width=20;
// Thickness of hanger in mm
thickness=4;
// Length of straigth part in mm
length=40;
// Diameter of circle producing hanger arc in mm
turn_diameter=40;
// Angle of arc
turn_angle=120; //[1:360]

/* [Geometry and finish] */
resolution=50; //[20:Draft,50:Medium,100:Fine, 200:very fine]
// Choose even numbers: 8 for 3D print optimized and higher e.g. 100 for fine
geometry=8; // Note that module "end" is only accurate for geometry = 4*integer

/* [Holes] */
// Hole size in mm
hole_diameter=3;
// Hole 1 position in mm
hole1=0;
// Hole 1 position in mm
hole2=20;
// Depth of countersink in mm
countersink_depth=2;

/* [Hidden] */
geo_width=width-thickness*cos(360/(geometry*2));

// ************* Executable part *************
rotate(a=[0,90,180])
difference(){
	assembly();
	translate([hole1,0,0])
		hole();
	translate([hole2,0,0])
		hole();
}

// ************* Module part *************

module assembly(){
	translate([0,0,0])
		rotate(a=[0,0,0])
			end();
	translate([0,0,0])
		rotate(a=[0,0,0])
			straight(length=length);
	translate([length,0,0])
		rotate(a=[0,0,0])
			turn(diameter=turn_diameter,angle=turn_angle);
	translate([length+turn_diameter/2*cos(turn_angle-90),turn_diameter/2+turn_diameter/2*sin(turn_angle-90),0])
		rotate(a=[0,0,turn_angle-180])	
			end();
}

module hole(){
	translate([0,0,width/2])
		rotate(a=[-90,0,0]){
			rotate(a=[0,0,90-(180-(360/geometry))/2])
				cylinder(h = thickness+0.01, r = hole_diameter/2, $fn=geometry, center = true);
			translate([0,0,thickness/2-countersink_depth])
				cylinder(h = countersink_depth+0.01, r1 = hole_diameter/2, r2 = (hole_diameter+2*countersink_depth)/2, $fn=resolution, center = false);
		}
}

module turn(diameter,angle){
	translate([0,diameter/2,0])
		rotate(a=[0,0,-90])
			intersection(){
				ring(diameter=diameter);
				translate([0,0,-(geo_width+thickness)])
					pie(radius=diameter/2+thickness, angle=angle, height=2*(geo_width+thickness), spin=0);
			}
}

module straight(length){
	translate([0,0,thickness*cos(360/(geometry*2))/2])
		rotate(a=[-180,-90,0])
			linear_extrude(height = length, center = false, convexity = 10, twist = 0)
				hull() {
   				translate([geo_width,0,0])
				rotate(a=90-(180-(360/geometry))/2)
    				circle(thickness/2,$fn=geometry);
				rotate(a=90-(180-(360/geometry))/2)
   				circle(thickness/2,$fn=geometry);
 				}
}

module ring(diameter){
	translate([0,0,thickness*cos(360/(geometry*2))/2])
		rotate_extrude(convexity = 10, $fn = resolution)
			translate([diameter/2, 0, 0])
				rotate(a=[0,0,90])
					hull() {
   					translate([geo_width,0,0])
						rotate(a=90-(180-(360/geometry))/2)
    						circle(thickness/2,$fn=geometry);
						rotate(a=90-(180-(360/geometry))/2)
   						circle(thickness/2,$fn=geometry);
 				}
}

module end() {
	translate([0,0,geo_width/2+thickness*cos(360/(geometry*2))/2])
		intersection(){
			translate([-2*(geo_width+thickness),-(geo_width+thickness),-(geo_width+thickness)])
				cube(2*(geo_width+thickness));
			rotate(a=[90,-90,0])
				rotate(a=90-(180-(360/geometry))/2)
					rotate_extrude(convexity = 10, $fn = geometry)
						hull() {
	   					translate([(geo_width/2+thickness*cos(360/(geometry*2))/2)/cos(360/(geometry*2))-thickness*cos(360/(geometry*2))/2,0,0])
							rotate(a=90-(180-(360/geometry))/2)
    							circle(thickness/2,$fn=geometry);
							translate([thickness*cos(360/(geometry*2))/2,0,0])
   							square(thickness*cos(360/(geometry*2)),center=true);
 						}
		}
}

// ****************************************************************************
// Borrowed code
// ****************************************************************************

/**
 * pie.scad
 *
 * Use this module to generate a pie- or pizza- slice shape, which is particularly useful
 * in combination with `difference()` and `intersection()` to render shapes that extend a
 * certain number of degrees around or within a circle.
 *
 * This openSCAD library is part of the [dotscad](https://github.com/dotscad/dotscad)
 * project.
 *
 * @copyright  Chris Petersen, 2013
 * @license    http://creativecommons.org/licenses/LGPL/2.1/
 * @license    http://creativecommons.org/licenses/by-sa/3.0/
 *
 * @see        http://www.thingiverse.com/thing:109467
 * @source     https://github.com/dotscad/dotscad/blob/master/pie.scad
 *
 * @param float radius Radius of the pie
 * @param float angle  Angle (size) of the pie to slice
 * @param float height Height (thickness) of the pie
 * @param float spin   Angle to spin the slice on the Z axis
 */
module pie(radius, angle, height, spin=0) {

    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }

}