board_dimensions = [136, 76];
hole_pts = [
    [0, 0],
    [0, 76],
    [136, 76],
    [136, 0],
];
fixing_holes=2;
fixing_hole_distance=[20, 0];

/* [Hidden] */
$fn=72;
inner_fn=36;

BoardHolder(board_dimensions, hole_pts, fixing_holes, fixing_hole_distance);

module BoardHolder(
    board_dimensions,
    hole_pts,
    fixing_holes,
    fixing_hole_distance,
    frame_width=2,
    frame_height=6,
    mount_hole_diameter=2.5, // Defaults are based on a #4 screw
    mount_post_diameter=2.8,
    mount_post_height=2.2,
    mount_1_type="hole", // [hole, post]
    mount_2_type="post",
    mount_3_type="hole",
    mount_4_type="hole",
    pillar_height=3,
    fixing_hole_diameter=3, // Defaults are based on a #4 screw
    fixing_hole_head_diameter=6,
    fixing_height=1.2,
) {

    module cylinder_outer(height,radius,center=false){
        fudge = 1/cos(180/inner_fn);
        cylinder(h=height,r=radius*fudge, center=center);
    }

    module sequentialHull(){
    for (i = [0: $children-2])
        hull(){
            children(i);
            children(i+1);
        }
    }

    module multiHull(){
    for (i = [1 : $children-1])
        hull(){
            children(0);
            children(i);
        }
    }

    function defined(a) = str(a) != "undef";

    position_types=[
        [mount_1_type, hole_pts[0]],
        [mount_2_type, hole_pts[1]],
        [mount_3_type, hole_pts[2]],
        [mount_4_type, hole_pts[3]]
    ];

    // fixing holes
    fixing_hole_origin=[
        board_dimensions.x / 2 - (fixing_hole_distance.x * (fixing_holes - 1) / 2),
        board_dimensions.y / 2 - (fixing_hole_distance.y * (fixing_holes - 1) / 2)
    ];

    fixing_pts = [ for(i=[1:fixing_holes]) [
        fixing_hole_origin.x + (fixing_hole_distance.x * (i-1)),
        fixing_hole_origin.y + (fixing_hole_distance.y * (i-1))
    ] ];

    module hole_0() {
        translate(hole_pts[0]) cylinder_outer(frame_height, frame_width / 2);
    };

    module hole_1() {
        translate(hole_pts[1]) cylinder_outer(frame_height, frame_width / 2);
    }

    module hole_2() {
        translate(hole_pts[2]) cylinder_outer(frame_height, frame_width / 2);
    }

    module hole_3() {
        translate(hole_pts[3]) cylinder_outer(frame_height, frame_width / 2);
    }

    difference() {
        union() {
            // hull around from hole_pt to hole_pt to create frame's basic outline
            sequentialHull() {
                hole_0();
                hole_1();
                hole_2();
                hole_3();
                hole_0();
            }
            // pillars
            pillar_radius = max(mount_post_diameter, mount_hole_diameter);
            for(position_type=position_types) {
                translate(position_type[1]) {
                    cylinder_outer(frame_height + pillar_height, pillar_radius);
                    if (position_type[0]=="post") {
                        translate([0, 0, frame_height + pillar_height]) cylinder_outer(mount_post_height, mount_post_diameter / 2);
                    }
                }
            }

            multiHull() {
                translate(fixing_pts[0]) cylinder_outer(fixing_height, fixing_hole_diameter);
                hole_0();
                hole_1();
                hole_2();
                hole_3();
            }

            if (defined(fixing_pts[1])) {
                multiHull() {
                    translate(fixing_pts[1]) cylinder_outer(fixing_height, fixing_hole_diameter);
                    hole_0();
                    hole_1();
                    hole_2();
                    hole_3();
                }
            }
        }
        union() {
            // cut out mounting holes
            for(position_type=position_types) {
                if (position_type[0]=="hole") {
                    translate(position_type[1]) cylinder_outer(frame_height + pillar_height + 1, mount_hole_diameter / 2);
                }
            }
            // clear area for fixing hole head
            for(pt=fixing_pts) {
                translate([pt.x, pt.y, fixing_height]) cylinder_outer(frame_height, fixing_hole_head_diameter / 2);
            }
            // cut out fixing holes
            for(pt=fixing_pts) {
                translate(pt) cylinder_outer(frame_height,fixing_hole_diameter / 2);
            }
        }
    }
}
