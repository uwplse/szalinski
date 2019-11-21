//
// http://www.thingiverse.com/thing:1973679
//
// preview[view:north, tilt:bottom]
//

part = "vertical"; // [vertical:Vertical with top bar,horizontal:Horizontal with top bar,vertical_short:Vertical with clip hole]

card_thickness = 2; // [0:0.1:10]
// ISO/IEC 7810 ID-1 card width
card_width = 53.98;
// ISO/IEC 7810 ID-1 card height
card_height = 85.6;

horizontal_tolerance = 0.5; // [0:0.1:5]
vertical_tolerance = 0.05; // [0:0.01:2]

/* [Back Pattern] */

back_pattern_type = "voronoi"; // [voronoi,hacker_emblem,text,fill,none]
back_pattern_protrudes = "yes"; // [yes,no]

hacker_emblem_size = 35; // [0:100]

/* [Text Pattern Parameters] */

// Up to 3 lines of text
text_line1 = "BLAH!";
text_line2 = "BLAH!";
text_line3 = "BLAH!";
// Additional interval between lines of text
text_line_interval = 5;
text_font = "Anton";
text_size = 12; // [0:100]
text_rotate = "no"; // [no,right,left,down]

/* [Voronoi Pattern Parameters] */

voronoi_thickness = 4; // [0:20]
voronoi_number_of_elements = 20; // [1:200]
voronoi_rounding = 1.5;
// Predefined Voronoi patterns
voronoi_pattern = 0; // [0:Random,-1:Manually entered seed value,-700680,-482985,369411,-433878,-334886,-353855,-861656,22473,50112,324884,-403254,449244,-55987,-140449,-812941,-35685]
// Seed to get repeatable Voronoi pattern
voronoi_seed = 0; // [-999999:999999]

/* [Advanced Parameters] */

bottom_thickness = 1; // [0:0.1:20]
top_thickness = 1; // [0:0.1:20]
side_thickness = 2; // [0:0.1:20]

top_bar_height = 8; // [0:40]

leaf_size = 3; // [0:40]
leaf_length = 12; // [0:40]
leaf_hole_offset = 1.5; // [0:0.1:20]
chamfer = .7; // [0:0.1:5]

top_bar_clip_hole_width = 11; // [0:100]
top_bar_clip_hole_height = 4; // [0:40]
top_bar_vertical_belt_hole_distance = 40; // [0:100]
top_bar_horizontal_belt_hole_distance = 60; // [0:100]

card_clip_hole_width = 13; // [0:100]
card_clip_hole_height = 3; // [0:40]
// Distance from the edge to the clip hole center
card_clip_hole_position = 6; // [0:40]

/* [Hidden] */

image_file = "image-surface.dat"; // [image_surface:100x100]
image_depth = 50; // [0:100]
image_invert = "no"; // [no,yes]


enable_top_bar = (part == "vertical_short") ? false : true;
orientation = (part == "horizontal") ? "horizontal" : "vertical";
hollow_size = (orientation == "horizontal") ?
    [card_height+horizontal_tolerance*2,
        card_width+horizontal_tolerance*2,
        card_thickness+vertical_tolerance*2] :
    [card_width+horizontal_tolerance*2,
        card_height+horizontal_tolerance*2,
        card_thickness+vertical_tolerance*2];
top_bar_belt_hole_distance = (orientation == "horizontal") ?
    top_bar_horizontal_belt_hole_distance :
    top_bar_vertical_belt_hole_distance;

two_side = false;   // Not ready yet

g_seed = voronoi_pattern==0 ?
    floor(rands(-999999, 1000000, 1)[0]) :
    (voronoi_pattern==-1 ?
        voronoi_seed :
        voronoi_pattern);
if (back_pattern_type == "voronoi")
    echo(str("Seed: ", g_seed));

dot = 0.01;
$fn=64;

rotate([0,0,180])
    card_holder();

module leafs() {
    lsize = (orientation == "vertical") ?
        hollow_size : [hollow_size.y,hollow_size.x];
    lrotation = (orientation == "vertical") ? 0 : 90;
    lpos = (orientation == "vertical") ? [0,0] : [hollow_size.x,0];
    
    translate(lpos) {
        rotate([0,0,lrotation]) {
            translate([0,lsize.y-dot])
                square([leaf_length,dot]);
            translate([0,lsize.y-leaf_length])
                square([dot,leaf_length]);
        
            translate([0,lsize.y/3-leaf_size])
                square([dot,leaf_length]);
        
            translate([lsize.x-leaf_length,lsize.y-dot])
                square([leaf_length,dot]);
            translate([lsize.x-dot,lsize.y-leaf_length])
                square([dot,leaf_length]);
        
            translate([lsize.x-dot,lsize.y/3-leaf_size])
                square([dot,leaf_length]);
        }
    }
}

module grid(step=10, angle=30, size=[40,40], offset=0, width=1)
{
    intersection() {
        square(size);
        for (yy = [offset:step:size.y*2]) {
            ll = size.x/cos(angle) + width*tan(angle);
            echo(ll);
            translate([0,yy])
                rotate([0,0,-angle])
                    translate([-width/2*tan(angle),-width/2])
                        square([ll,width]);
            translate([size.x,yy])
                rotate([0,0,180+angle])
                    translate([-width/2*tan(angle),-width/2])
                        square([ll,width]);
        }
    }
}

module top_hole() {
    offset(r=leaf_size)
    {
        difference() {
            offset(r=-leaf_size)
                square([hollow_size.x,hollow_size.y]);

            if (two_side) {
                translate([0,hollow_size.y/3])
                    offset(r=leaf_size*2) {
                        square([hollow_size.x,dot]);
                        grid(step=20, size=[hollow_size.x,hollow_size.y*2/3], width=dot);
                    }
            } else {
                offset(r=leaf_size*2)
                    leafs();
            }
        }
    }
}

module bottom_hole() {
    if (two_side) {
        step = 20;
        translate([0,hollow_size.y/3]) {
            difference()
            {
                offset(r=-leaf_hole_offset)
                    square([hollow_size.x,hollow_size.y*2/3+step/2]);
                offset(r=-leaf_size) {
                    offset(r=leaf_size*2+leaf_hole_offset) {
                        //translate([0,-step/2])
                        grid(step=step, angle=30, size=[hollow_size.x,hollow_size.y*2/3+step/2], width=dot, offset=step/2);
                    }
                }
            }
        }
    } else {
        intersection() {
            offset(r=-leaf_hole_offset)
                square([hollow_size.x,hollow_size.y]);
            offset(r=-leaf_size)
                offset(r=leaf_size*2+leaf_hole_offset)
                    leafs();
        }
    }
}

module base_holes(for_voronoi=false) {
    if (enable_top_bar) {
        if (!for_voronoi) {
            translate([hollow_size.x/2-top_bar_belt_hole_distance/2,-top_bar_height/2])
                circle(r=top_bar_clip_hole_height/2);
            translate([hollow_size.x/2+top_bar_belt_hole_distance/2,-top_bar_height/2])
                circle(r=top_bar_clip_hole_height/2);
            translate([hollow_size.x/2-top_bar_clip_hole_width/2,-top_bar_height/2]) {
                hull() {
                    circle(r=top_bar_clip_hole_height/2);
                    translate([top_bar_clip_hole_width,0,0])
                        circle(r=top_bar_clip_hole_height/2);
                }
            }
        }
    } else {
        translate([hollow_size.x/2-card_clip_hole_width/2,card_clip_hole_position]) {
            hull() {
                circle(r=card_clip_hole_height/2);
                translate([card_clip_hole_width,0,0])
                    circle(r=card_clip_hole_height/2);
            }
        }
    }
}

module base() {
    offset(r=side_thickness) {
        if (enable_top_bar) {
            translate([0,-top_bar_height+side_thickness])
                square([hollow_size.x,hollow_size.y+top_bar_height-side_thickness]);
        } else {
            square([hollow_size.x,hollow_size.y]);
        }
    }
}

// http://www.catb.org/hacker-emblem/
module hacker_emblem(size=30, grid=true, fused=false, step=100, dia = 80, wall = 5, fuse = 20) {
    hacker_emblem = [[0,0],[1,0],[2,0],[2,1],[1,2]];

    resize([size,size]) {
        translate([-step*3/2,-step*3/2]) {
            for (pos = hacker_emblem)
                translate([(pos[0]+.5)*step,(pos[1]+.5)*step])
                    circle(dia/2);

            if (grid) {
                difference() {
                    union() {
                        for (xx = [0:3])
                            translate([step*xx-wall/2,-wall/2])
                                square([wall,step*3+wall]);
                        for (yy = [0:3])
                            translate([-wall/2,step*yy-wall/2])
                                square([step*3+wall,wall]);
                    }
    
                    if (fused) {
                        for (xx = [0:2])
                            translate([step*(xx+.5)-fuse/2,-fuse/2-1])
                                square([fuse,step*3+fuse+2]);
                        for (yy = [0:2])
                            translate([-fuse/2-1,step*(yy+.5)-fuse/2])
                                square([step*3+fuse+2,fuse]);
                    }
                }
            }
        }
    }
}

module card_holder() {
    difference() {
        // Chamfered base
        hull() {
            translate([0,0,chamfer*3/2])
                linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness-chamfer*3)
                    base();
            linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness)
                offset(r=-chamfer)
                    base();
        }

        translate([0,0,-.001])
            linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness+.002)
                base_holes();

        translate([0,0,-.001])
            linear_extrude(height=bottom_thickness+.002)
                bottom_hole();
        translate([0,0,bottom_thickness])
            cube([hollow_size.x,hollow_size.y,hollow_size.z]);
        translate([0,0,hollow_size.z+bottom_thickness-.001])
            linear_extrude(height=top_thickness+.002)
                top_hole();

        if (!two_side) {
            logo_thickness = (back_pattern_protrudes == "yes") ?
                bottom_thickness : bottom_thickness/2;
            translate([hollow_size.x/2,(hollow_size.y-(enable_top_bar&&back_pattern_type!="voronoi"&&back_pattern_type!="image"&&back_pattern_type!="none"?top_bar_height:0))/2,-.001]) {
                linear_extrude(height=logo_thickness+.002) {
                    mirror([0,1,0]) {
                        if (back_pattern_type == "hacker_emblem") {
                            hacker_emblem(hacker_emblem_size,grid=false,fused=true);
                        } else if (back_pattern_type == "none") {
                            translate([-hollow_size.x/2,-hollow_size.y/2])
                                offset(-leaf_hole_offset)
                                    square([hollow_size.x,hollow_size.y]);
                        } else if (back_pattern_type == "text") {
                            angle = (text_rotate == "right") ? -90 :
                                (text_rotate == "left") ? 90 :
                                (text_rotate == "down") ? 180 : 0;
                            lines = (text_line3&&text_line2&&text_line1)?2:
                                ((text_line2&&text_line1)?1:0);
                            rotate([0,0,angle]) {
                                translate([0,lines/2*(text_size+text_line_interval)])
                                    text(text=text_line1, size=text_size, font=text_font, halign="center", valign="center");
                                if (lines > 0)
                                    translate([0,(lines/2-1)*(text_size+text_line_interval)])
                                        text(text=text_line2, size=text_size, font=text_font, halign="center", valign="center");
                                if (lines > 1)
                                    translate([0,-lines/2*(text_size+text_line_interval)])
                                        text(text=text_line3, size=text_size, font=text_font, halign="center", valign="center");
                            }
                        } else if (back_pattern_type == "voronoi") {
                            difference() {
                                voronoi_pattern([hollow_size.x-2*leaf_hole_offset,hollow_size.y-2*leaf_hole_offset]);

                                mirror([0,1,0]) {
                                    translate([-hollow_size.x/2,-hollow_size.y/2]) {
                                        offset(voronoi_thickness) {
                                            bottom_hole();
                                            base_holes(for_voronoi=true);
                                        }
                                    }
                                }
                            }
                        } else if (back_pattern_type == "image") {
                            difference() {
                                image([hollow_size.x-2*leaf_hole_offset,hollow_size.y-2*leaf_hole_offset]);

                                mirror([0,1,0]) {
                                    translate([-hollow_size.x/2,-hollow_size.y/2]) {
                                        offset(voronoi_thickness) {
                                            bottom_hole();
                                            base_holes(for_voronoi=true);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

module voronoi_pattern(size,thickness=voronoi_thickness,round=voronoi_rounding) {
    intersection() {
        square(size,center=true);
        random_voronoi(n = voronoi_number_of_elements, thickness = thickness/2, maxx = size.x, maxy = size.y, seed = g_seed, round = round, nuclei = false);
    }
}

//!image();
module image(size)
{
    projection(cut=true)
        translate([0,0,-0.1/*image_depth/100*/])
            surface(file = image_file, center = true,
                invert = (image_invert=="yes"?true:false));
}


// ------------------------------------------------------
// https://github.com/felipesanches/OpenSCAD_Voronoi_Generator
// (c)2013 Felipe Sanches <juca@members.fsf.org>
// licensed under the terms of the GNU GPL version 3 (or later)

function normalize(v) = v / (sqrt(v[0] * v[0] + v[1] * v[1]));

module voronoi(points, L = 200, thickness = 1, round = 0, nuclei = true) {
	for (p = points) {
		difference() {
			//minkowski() {
				intersection_for(p1 = points){
					if (p != p1) {
						angle = 90 + atan2(p[1] - p1[1], p[0] - p1[0]);

						translate((p + p1) / 2 - normalize(p1 - p) * (thickness + round))
						rotate([0, 0, angle])
						translate([-L, -L])
						square([2 * L, L]);
					}
				}
			//	circle(r = round, $fn = 20);
			//}
			if (nuclei)
				translate(p) circle(r = 1, $fn = 20);
		}
	}
}

module random_voronoi(n = 20, nuclei = true, L = 200, thickness = 1, round = 0, maxx = 100, maxy = 100, seed) {

	// Generate points.
	x = rands(0, maxx, n, seed);
	y = rands(0, maxy, n, seed + 1);
	points = [ for (i = [0 : n - 1]) [x[i], y[i]] ];
        
	// Center Voronoi.
	offset_x = -(max(x) - min(x)) / 2;
	offset_y = -(max(y) - min(y)) / 2;
	translate([offset_x, offset_y])
    
	offset(round) offset(-round) voronoi(points, L = L, thickness = thickness, round = 0, nuclei = nuclei);
}

// example with an explicit list of points:
/*point_set = [
	[0, 0], [30, 0], [20, 10], [50, 20], [15, 30], [85, 30], [35, 30], [12, 60],
	[45, 50], [80, 80], [20, -40], [-20, 20], [-15, 10], [-15, 50]
];*/
//voronoi(points = point_set, round = 4, nuclei = true);

// example with randomly generated set of points
//random_voronoi(n = 64, round = 6, maxx = 500, maxy = 100, seed = 42);
