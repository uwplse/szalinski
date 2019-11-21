; $fn=200;

tube_length = 30; // [10:50]

module pie_slice(r=3.0,a=30, h=1) {
 linear_extrude (h) {
	  $fn=256;
	  intersection() {
		circle(r=r);
		square(r);
		rotate(a-90) square(r);
	  }
  }
}

// ignore
tab_height = 1.1;
tab_rad = 21;
tab_a1=58;
tab_a2=tab_a1;
tab_a3=65.4;
tab_p2=116.2;
tab_p3=232.5;
adapter_height = tube_length-5;
mount_height = 4;
mount_rad = 20;
mount_hole = 16;

union()  {
	// dimples
	rotate(-155)
	translate([24.6,0, adapter_height+2.5 ])
		sphere(r=1);

	rotate(142)
	translate([23.7,0,5])
		sphere(r=1);

	// camera
	difference () {
		union () {
			pie_slice(r=tab_rad, a=tab_a1, h=tab_height-0.2);
			rotate(tab_p2)
				pie_slice(r=tab_rad, a=tab_a2, h=tab_height-0.2);
			rotate(tab_p3)
				pie_slice(r=tab_rad, a=tab_a3, h=tab_height-0.2);
			cylinder(mount_height, mount_rad, mount_rad);
		}
	
		translate([0, 0, -1]) 
			cylinder(mount_height+2, mount_hole, mount_hole);
	}


	difference() {
		translate([0,0,mount_height]) cylinder(adapter_height-mount_height, 24, tab_rad+4);
		translate([0,0,mount_height]) cylinder(adapter_height-mount_height, 16, tab_rad+1);
		}


	// lens
	translate([0,0,adapter_height]) {

		mount_height = 4;
		union() {
			difference() {
				cylinder(mount_height, tab_rad+4, tab_rad+4);
				translate([0, 0, -1]) 
					cylinder(mount_height+2, 22, 22);
			}
	
			tab_offset = 0.85;

			translate([0, 0, mount_height - tab_height - tab_offset]) 
			  difference () {
				union () {
					pie_slice(r=tab_rad+1, a=tab_a1-5, h=tab_height+tab_offset);
					rotate(tab_p2)
						pie_slice(r=tab_rad+1, a=tab_a2-5, h=tab_height+tab_offset);
					rotate(tab_p3)
						pie_slice(r=tab_rad+1, a=tab_a3-5, h=tab_height+tab_offset);


					translate ([0,0,-0.98]) {
						pie_slice(r=tab_rad+1, a=4, h=tab_height);

						rotate(tab_p2)
							pie_slice(r=tab_rad+1, a=4, h=tab_height);
						rotate(tab_p3)
							pie_slice(r=tab_rad+1, a=4, h=tab_height);
						}

					}

				//
				//	The length of these tabs determine show the lens fits
				//
				translate([0, 0, -1]) 
					cylinder(mount_height+2, mount_rad+0.5, mount_rad+0.5);
				}
			}
		}
}
