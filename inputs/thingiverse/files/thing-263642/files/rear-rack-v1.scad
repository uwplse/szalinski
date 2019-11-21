/*
T shapped connector for rear bike racks
*/



/* [Rear Rack] */
// distance from center of center screw to center of any side screw
screw_center_horizontal = 25.5;
// distance from center of top screw to center of bottom screw
screw_center_vertical = 18;
// thickness of the part. must be larger than screw head depth as we will try to make screw flush
thickness = 6;
// radius of the screw head. i.e. half of the mm wrench you want to use
hex_head_radius = 4; //[1:12]
// depth of the screw head.
hex_head_depth = 4;
// margin from the screw to the edge of the part
hex_head_margin = 3;
// radius for hole for the screw body, obviously must be smaller than hex_head_radius
screw_hole_radius = 2;
// direction of the hex head (0=flat top, 30=pointy top)
hex_head_rotation = 0; // [0,30]
// how much the hex head hole should pierce trhu the holder part being attached (not usable on this part alone)
hex_head_pierce = 100;

/* [Hidden] */
Ttop_height = 2*hex_head_radius + 2*hex_head_margin;
Tver_height = screw_center_vertical + hex_head_radius+ hex_head_margin + Ttop_height/2;

module T() {
	translate([0,-thickness/2,-Ttop_height/2])
	union(){
		difference() {
			union(){
				// top of the T
				cube(center=true,[screw_center_horizontal*2, thickness, Ttop_height]);
				translate([screw_center_horizontal,0,0]) rotate(a=90,v=[1,0,0])
					cylinder(r=Ttop_height/2+0.05, h=thickness, center=true);
				translate([-screw_center_horizontal,0,0]) rotate(a=90,v=[1,0,0])
					cylinder(r=Ttop_height/2+0.05, h=thickness, center=true);
				// NOTE: the +0.05 on the cylinders above is to remove one artifact when it joing the body. without it, it looked like the radius was smaller than the height of the cube
				// vertical part of T
				translate([0,0,Ttop_height/2-Tver_height/2])
				cube(center=true,[Ttop_height, thickness, Tver_height]);
//translate([0,1,-5]) main();
			}
			// center hole, top
			translate([0,0,0])
				hex_head();
			// center hole, bottom
			translate([0,0,-screw_center_vertical])
				hex_head();
			// right ... yeah, our axis ended up a little off :)
			translate([-screw_center_horizontal,0,0])
				hex_head();
			// left
			translate([screw_center_horizontal,0,0])
				hex_head();
		}
	}
}

/** a sane way to create hexagons. fuck understanding polyhedron syntax at this hour of the night
*/
module hex_head(){
	// logic of this http://hexnet.org/content/hexagonal-geometry
	rotate( a=hex_head_rotation, v=[0,1,0])
	union(){
		translate([0,hex_head_pierce/2+thickness/2-hex_head_depth/2+0.001,0]){
			cube( size = [hex_head_radius,hex_head_pierce+ hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
			rotate( a=60, v=[0,1,0])
				cube( size = [hex_head_radius, hex_head_pierce+hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
			rotate( a=120, v=[0,1,0])
				cube( size = [hex_head_radius, hex_head_pierce+hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
		}

		rotate(a=90,v=[1,0,0])
			translate([0,0,0])
				cylinder(r=screw_hole_radius, h=thickness+0.001+0.001+0.001+0.001, center=true, $fn=99);
				// NOTE: some reason the +0.001 was not working there... 0.004 did the trick, leaving syntax as 0.001 as i will find it with my regexps later
	}
}

T();

