
OSHW_LOGO_SIZE=15;
USE_SENKKOPF=1;

$fn=64;
//include <oshw.scad>;


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
				for(i=[1:7]) assign(rotAngle=45*i+45)
					rotate(rotAngle) gear_tooth_2d(d);
			}
			circle(r=10.0*d/72.0,$fn=20);
			intersection() {
	  			rotate(-20) square(size=[10.0*d/18.0,10.0*d/18.0]);
	  			rotate(20)  square(size=[10.0*d/18.0,10.0*d/18.0]);
			}
    		}
  	}
}


module baseplate(){
    difference() {
        union(){
            linear_extrude(1){
                hull(){
                    translate([0,0])
                        circle(d=6);
                    translate([24,0])
                        circle(d=6);
                    translate([24,24])
                        circle(d=6);
                    translate([0,24])
                        circle(d=6);
                }
            }
            translate([0,0,0])
                cylinder(d=6,h=10);
            translate([24,0,0])
                cylinder(d=6,h=10);
            translate([0,24,0])
                cylinder(d=6,h=10);
            translate([24,24,0])
                cylinder(d=6,h=10);
            
        }
        union() {
            translate([0,0,0])
                befestigungsloch();
            translate([24,0,0])
                befestigungsloch();
            translate([0,24,0])
                befestigungsloch();
            translate([24,24,0])
                befestigungsloch();
            if (OSHW_LOGO_SIZE > 0) {
                translate([12,12,-0.1])
                    linear_extrude(5)
                        oshw_logo_2d(OSHW_LOGO_SIZE);
            }
        }
    }
}

module senkkopf() {
    //translate([0,0,-0.1])
    //cylinder(h=0.3,d=6);
    translate([0,0,0.0])
    cylinder(h=1.5,d1=6,d2=3);
}

module befestigungsloch() {
    union(){
        translate([0,0,-0.1])
            if (USE_SENKKOPF == 1) 
                senkkopf();
            else
                cylinder(d=6,h=3.1);
        //translate([0,0,3])
            cylinder(d=3.5,h=10.1);
    }
}
translate([-12,-12,0]){
    baseplate();
}
//befestigungsloch();