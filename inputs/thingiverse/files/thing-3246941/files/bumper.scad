z = 10;
bh = 100; // height
tw = 120; // top width
thick = 3.0;
buf = 5 + 2*thick;

// bottom and top radius
br = 10;
tr = tw/6;

module bumper_filled() {
     difference() {
	  union() {
	       translate([tr,bh-tr]) circle(r=tr);
	       translate([tw-tr,bh-tr]) circle(r=tr);

	       translate([0,br]) circle(r=br);
	       translate([tw,br]) circle(r=br);

	       polygon(points=[
			    [0,0], [-br,br], [0,bh-tr],
			    [tw,bh-tr], [tw+br, br], [tw,0]]);

	  }
	  translate([tw/2,buf+tr]) circle(r=tr);
	  translate([2*tr,buf+tr]) square([2*tr, bh-tr]);
     }
}


module bumper_hull() {
     difference() {
	  bumper_filled();
	  offset(delta=-thick, $fn=100) bumper_filled();
     }
}

linear_extrude(z, $fn=100) bumper_hull();
