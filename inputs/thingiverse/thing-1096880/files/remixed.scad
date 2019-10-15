// Device to produce PLA springs in openscad
// http://www.thingiverse.com/thing:188285/
// REFACTORED (well, prettied up) by sfinktah
//////////////////////////////////
// PARAMETERS
//////////////////////////////////
springLength = 80;             //  length of spring [mm]
springDiameter = 12.25;            //  spring outer diameter [mm]
filamentDiameter = 1.75;        //  spring wire diameter [mm] 
springWindings = 8;            //  number of active windings
padLength = 5;                  //  top/bottom padding [mm]
resolution = 10;                //  resolution (nfi)
//////////////////////////////////


// INTERNAL PARAMETERS (DO NOT CHANGE)
//////////////////////////////////////
innerRadius = springDiameter / 2;
filamentRadius = filamentDiameter / 2;
outerRadius = innerRadius + filamentRadius;
windingHeight = springWindings / springLength;
step = 1 / windingHeight;
epsilon = 0.01;
//////////////////////////////////////

difference() {
	cylinder(h = springLength + 2 * padLength, 
			r = outerRadius, 
			$fn = resolution);
	union () {
		start();
		spring();
		end();
	}
}

module start() {
    translate(v = [-epsilon, outerRadius - filamentRadius*2, padLength] ) {
        rotate([0,-270,0]) {
            // the curved corner
            for (i = [0:resolution:90-resolution] ) {
                hull() {
                    rotate([i, 0, 0])
                    translate([0, filamentRadius * 2, 0] )
                        cylinder(h = 1, 
                                 r = filamentRadius, 
                                 $fn = resolution, 
                                 center = true);
                    rotate([i+resolution, 0, 0])
                    translate([0, filamentRadius * 2, 0] )
                        cylinder(h = 1, 
                                 r = filamentRadius, 
                                 $fn = resolution, 
                                 center = true);
                }
            }
            // straight section
            translate([0,0,filamentRadius*2])
            rotate([90,0,0])
                cylinder(h = 2 * outerRadius, 
                         r = filamentRadius, 
                         $fn = resolution, 
                         center = false);
        }
    }
}

module end() {
	translate(v = [0, outerRadius - 2 * filamentRadius, padLength + springLength] ) {
		rotate(a = 270, v = [0, 1, 0] ) {
			for (i = [0:90] ) {
				rotate(a = i, v = [1, 0, 0] ) {
					translate(v = [0, filamentRadius * 2, 0] ) {
						rotate(a = i, v = [0, 0, 1] ) {
							if (i == 90) {
								cylinder(h = 2 * outerRadius, 
										r = filamentRadius, 
										$fn = resolution, 
										center = false);
							} else {
								cylinder(h = 1, 
										r = filamentRadius, 
										$fn = resolution, 
										center = true);
							}
						}
					}
				}
			}
		}
	}
}

module spring() {
    for (j = [0:(springWindings - 1)] ) {
        translate(v = [0, 0, j * step + padLength] ) {
            rotate(a = 270, v = [0, 1, 0] ) {   // flip it to basis plane[x,y]
                for (i = [0:resolution:360] )
                    hull() {
                        rotate(a = i, v = [1, 0, 0] )
                        translate(v = [(i / (360 * windingHeight)), outerRadius, 0] )
                            cylinder(h = 1, 
                                     r = filamentRadius, 
                                     $fn = resolution, 
                                     center = true);
                        rotate(a = i+resolution, v = [1, 0, 0] )
                        translate(v = [(i / (360 * windingHeight)), outerRadius, 0] )
                            cylinder(h = 1, 
                                     r = filamentRadius, 
                                     $fn = resolution, 
                                     center = true);
                }
            }
        }
    }
}
/* vim: set ts=4 sts=0 sw=4 noet: */