
/* [Dimensions] */

//Clamp length
l=40;
//Clamp height
h=7;
//Clamp width
w=25;
//Default thickness
thck=2;
//Filament thickness
ft=1.75;
//Smoothness
$fn=100;

module fillament_clip(l=l, h=h, w=w, thck=thck, ft=ft) {
   // rotate([0,90,0])
	translate([-w/2-thck,0,thck]) {
	difference() {
		union() {
			translate([-w/2-thck,thck,-thck])
				cube([w+2*thck,l+w/2+thck,h+2*thck]);

			translate([0,0,-thck])
				cylinder(r=w/2+thck, h=h+2*thck);
		}

		union() {
			translate([0,0,-thck-1])
				cylinder(r=w/2, h=h+2*thck+2);

			translate([-w/2-thck-1,w/2+thck,0])
				cube([w+2*thck+2,l+1,h]);

			translate([-w/2-thck-1,l+w/2+thck-1,thck-1])
				cube([w+2*thck+2,thck+2,h-2*thck]);

			translate([-w/2-thck-1,-ft/2,-thck-1])
				cube([thck+2,ft,h+2*thck+2]);
		}
	}

    }
}



fillament_clip();