
// start thickness
_1_start = 0.0;

// thickness increment between samples
_2_increment = 0.05;

// end thickness
_3_end = 1;

// width of each sample
_4_width = 4; // [1:10]

// minimum height of each sample (varies from 
_5_height = 6; // [1:50]


////////////////////////////////////////////////////////////


module layerTest(start, increment, end, width, length) {
	count = round((end-start)/increment)+1;
	radius = width/3;
	eps = 0.1;
	union() {
		for (index = [0:count-1]) {
			assign (h = start + increment * index) {
				echo(h);
				if (h > 0) {
					translate([index * width,0,0]) {
						difference() {
							cube(size=[width+eps, length + (index-1)%10, h]);

							if (index%10 == 0) {
								translate([width/2,0,0]) {
									cylinder(r=radius, h=end*3, center=true, $fn=30);
								}
							} else if (index%2 == 0) {
								translate([width/2,0,0]) {
									cylinder(r=radius/2, h=end*3, center=true, $fn=30);
								}
							}
						}
					}
				}
			}
		}
	}

}

layerTest(_1_start,_2_increment,_3_end,_4_width,_5_height);