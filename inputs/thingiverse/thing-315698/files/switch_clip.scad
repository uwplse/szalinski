// Semi-automatic Microswitch Probe
// Design by Marius Gheorghescu, 2014-2017

// width of the probe
width = 15; 

// length of the clip
clip_len = 16;

// opening of the clip (thickness of the part the probe attaches to)
clip_gap = 7.0;

// length of the probe
base_to_tip = 50;


/* [Hidden] */

// thickness of the microswitch block (offset of the microswitch)
microswitch_thread_depth = 6;

// height of the microswitch block
microswitch_height = 12;

wall_thickness = 0.405*6;

microswitch_width = max(width, 14);

upper_area = 3*wall_thickness + clip_gap + 2.6 /* Wall + M3 nut + Wall + gap + Wall*/;
probe_len = base_to_tip + upper_area;

echo("clip length:", upper_area);
echo("probe total length:", probe_len);

epsilon = 0.01;

module switch_clip() {

	inner_triangle_height = probe_len - upper_area - 2*wall_thickness - 20;

    difference() {
        union() {

            difference() {
                triangle(probe_len, clip_len, width);
                
                // save material & increase strength
                rotate([0, 90, 0])
                translate([0,0,-wall_thickness])
                intersection() {
                    hull() {
                        rad = 1;
                        $fn = 50;

                        translate([-rad - wall_thickness, probe_len/2 - rad - upper_area, 0])
                            cylinder(r=rad, h=width, center=true);

                        translate([-rad + wall_thickness - base_to_tip/probe_len*clip_len, probe_len/2 - rad - upper_area, 0])
                            cylinder(r=rad, h=width, center=true);

                        translate([-rad - wall_thickness, -probe_len/2 + rad + microswitch_height, 0])
                            cylinder(r=rad, h=width, center=true);
                    }
                    
                    hull() {
                        rad = 1;
                        $fn = 50;

                        translate([-rad - wall_thickness, probe_len/2 - rad - upper_area, 0])
                            cylinder(r=rad, h=width, center=true);

                        translate([-rad + wall_thickness - base_to_tip/probe_len*clip_len, probe_len/2 - rad - upper_area, 0])
                            cylinder(r=rad, h=width, center=true);

                        translate([-rad, -probe_len/2 + rad + microswitch_height, 0])                    
                            cylinder(r=rad, h=width, center=true);
                    }
                }
                
            }

            // microswitch attach
            translate([-microswitch_width/2 + width/2, -probe_len/2 + microswitch_height/2 + epsilon, microswitch_thread_depth/2])
                cube([microswitch_width, microswitch_height, microswitch_thread_depth], center=true);
        }

        // grip / cut-out
        translate([0, probe_len/2 - clip_gap/2 - 2*wall_thickness - 2.6, clip_len/2 + 2*wall_thickness])
            cube([width + epsilon, clip_gap, clip_len], center=true);

        // attach M3 screw
        translate([0, probe_len/2, clip_len/2])
            rotate([90, 0, 0])
            cylinder(r=3.5/2, h=clip_gap + 10, center=true);

        // attach m3 nut
        translate([0, probe_len/2 - 2.6/2 - wall_thickness , clip_len/2])
                cube([width + epsilon, 2.6, 5.65], center=true);

        // cable cutouts
        translate([- wall_thickness, (microswitch_height - upper_area)/2, clip_len/2 + wall_thickness])
        scale([1, base_to_tip/probe_len,1])
        {
            translate([0, -probe_len/4 + 6, 0])
                cube([4, 8, clip_len], center=true);

            translate([0, probe_len/4 - 6, 0])
                cube([4, 8, clip_len], center=true);
        }

        // m1.5 screws for 16mm microswitch
        translate([-microswitch_width/2 + width/2, -probe_len/2 + 6, 3]) {
        
            translate([-6.5/2, 0, 0])
                cylinder(r=0.75, h=20, center=true, $fn=12);

            translate([6.5/2, 0, 0])
                cylinder(r=0.75, h=20, center=true, $fn=12);		
        }

        // m2 screws for 20mm microswitch
        translate([-microswitch_width/2 + width/2, -probe_len/2 + 8, 3]) {
        
            translate([-9.5/2, 0, 0])
                cylinder(r=1.1, h=20, center=true, $fn=12);

            translate([+9.5/2, 0, 0])
                cylinder(r=1.1, h=20, center=true, $fn=12);		
        }


    }
}

module triangle(probe_len, clip_len, width)
{
	bottom = microswitch_thread_depth/2;
	$fn = 36;
	rad = 2;

	rotate([0, 90, 0])
	hull() {

		translate([-rad, probe_len/2 - rad, 0])
			cylinder(r=rad, h=width, center=true);

		translate([-clip_len + rad, probe_len/2 - rad, 0])
			cylinder(r=rad, h=width, center=true);

		translate([-bottom/2, -probe_len/2 + 1/2, 0])
			cube([bottom, 1, width], center=true);
	}

}


rotate([0, 90, 0]) 
{
	switch_clip();
}


