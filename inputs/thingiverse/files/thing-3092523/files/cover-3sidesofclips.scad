cover_width=105; //overall width
cover_length=64; //overall length
opening_width=96; //opening width, used for positioning the clips
opening_length=55; //opening length, used for positioning the clips
opening_thickness=3.5; //thickness of opening, used for size of clips
cover_radius=3.5; //curve radius for edges of the cover
cover_thickness=3;
logo_thickness=2;
logo_diameter=57;
$fn=96;

//corners
translate([cover_width/2-cover_radius,cover_length/2-cover_radius,0])
cylinder(r=cover_radius,h=cover_thickness);
translate([-cover_width/2+cover_radius,cover_length/2-cover_radius,0])
cylinder(r=cover_radius,h=cover_thickness);
translate([-cover_width/2+cover_radius,-cover_length/2+cover_radius,0])
cylinder(r=cover_radius,h=cover_thickness);
translate([cover_width/2-cover_radius,-cover_length/2+cover_radius,0])
cylinder(r=cover_radius,h=cover_thickness);

//middle and logo
difference(){
translate([0,0,cover_thickness/2])
cube([cover_width-2*cover_radius,cover_length-2*cover_radius,cover_thickness],center=true);
translate([0,-3,-0.01])
linear_extrude(height=logo_thickness)
	oshw_logo_2d(logo_diameter);
}

//the rest of the cover
translate([cover_width/2-cover_radius,-cover_length/2+cover_radius,0])
cube([cover_radius,cover_length-cover_radius*2,cover_thickness]);
translate([-cover_width/2,-cover_length/2+cover_radius,0])
cube([cover_radius,cover_length-cover_radius*2,cover_thickness]);
translate([-cover_width/2+cover_radius,-cover_length/2,0])
cube([cover_width-cover_radius*2,cover_radius,cover_thickness]);
translate([-cover_width/2+cover_radius,cover_length/2-cover_radius,0])
cube([cover_width-cover_radius*2,cover_radius,cover_thickness]);

//clips
translate([opening_width/2-1,opening_length/4,0])
clip();
translate([opening_width/2-1,-opening_length/4,0])
clip();
rotate([0,0,180]){
translate([opening_width/2-1,opening_length/4,0])
clip();
translate([opening_width/2-1,-opening_length/4,0])
clip();
}
translate([opening_width/4,opening_length/2-1,0])
rotate([0,0,90])
clip();
translate([-opening_width/4,opening_length/2-1,0])
rotate([0,0,90])
clip();
/*rotate([0,0,180]){
translate([opening_width/4,opening_length/2-1,0])
rotate([0,0,90])
clip();
translate([-opening_width/4,opening_length/2-1,0])
rotate([0,0,90])
clip();
*/


module clip(){
translate([0,0,cover_thickness])
difference(){
cube([2,5,opening_thickness+1]);
translate([1,0,0])
cube([3,5,opening_thickness]);
}
}


// The below code was downloaded from www.thingiverse.com/thing:27097 and modified to remove the assign() function and comment out the example logo.
//
// OSHW Logo Generator
// Open Source Hardware Logo : http://oshwlogo.com/
// -------------------------------------------------
//
// Adapted from Adrew Plumb/ClothBot original version
// just change internal parameters to made dimension control easier
// a single parameter : logo diameter (millimeters)
//
// oshw_logo_2D(diameter) generate a 2D logo with diameter requested
// just have to extrude to get a 3D version, then add it to your objects
//
// cc-by-sa, pierre-alain dorange, july 2012

module gear_tooth_2d(d) {
	polygon( points=[ 
			[0.0,10.0*d/72.0], [0.5*d,d/15.0], 
			[0.5*d,-d/15.0], [0.0,-10.0*d/72.0] ] );
}

module oshw_logo_2d(d=10.0) {
	rotate(-135) {
		difference() {
			union() {
				circle(r=14.0*d/36.0,$fn=20);
				for(i=[1:7]) {rotAngle=45*i+45;
					rotate(rotAngle) gear_tooth_2d(d);}
			}
			circle(r=10.0*d/72.0,$fn=20);
			intersection() {
	  			rotate(-20) square(size=[10.0*d/18.0,10.0*d/18.0]);
	  			rotate(20)  square(size=[10.0*d/18.0,10.0*d/18.0]);
			}
    		}
  	}
}

// usage : oshw_logo_2d(diameter)

//linear_extrude(height=2)
//	oshw_logo_2d(25);

