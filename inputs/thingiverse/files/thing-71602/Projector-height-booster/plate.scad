//Part to render
part="base"; // [plate,base,top]

//Plate dia
d=40;
//Plate height
h=12;

// What is one layer height?
layer_height=.25;

// How thick to inset the logo (0 to turn off logo)
logo_height=1.5;

$fs=1/10;
$fa=10/10;


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

// usage : oshw_logo_2d(diameter)


// END OSHW Logo Generator
// Downloaded from http://www.thingiverse.com/thing:27097



logo_layers = ceil(logo_height / layer_height);
difference(){
	cylinder(r=d/2, h=h+logo_height);

	union(){
		for(i =  [0:logo_layers-1])
			translate([0,0,h+layer_height*i])
				linear_extrude(height=-layer_height)
					oshw_logo_2d(d/1.2 + (5/logo_layers)*i);
	}

}
