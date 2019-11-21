
// (c) 2017 Eryk Makowski <vramin@tiger.com.pl>


module supports(
    height,
    r_top,
    r_bottom,
    size,
    min_distance) 
{
    r_max = max(r_top, r_bottom);
    s_count = ceil(2 * PI * r_max / min_distance);
    h = sin(30)*size;
    bottom_size = min(size,PI*(r_bottom-h)/s_count);
    top_size = min(size,PI*(r_top-h)/s_count);
    a = 360/s_count;
    
    for(i=[0:s_count-1]) {
        rotate([0,0,i*a])
        translate( [0,r_bottom-0.1,0] ) 
        polyhedron(
            points = [
                [0,0,0],
                [-bottom_size/2,-h,0],
                [bottom_size/2,-h,0],
                [0,r_top-r_bottom,height],
                [-top_size/2,r_top-r_bottom-h,height],
                [top_size/2,r_top-r_bottom-h,height]
            ],
            faces = [
                [0,1,2],
                [4,5,2,1],
                [3,4,1,0],
                [0,2,5,3],
                [5,4,3],
            ]);
    }
}



module sleeve(
    height,             // height of sleeve
    r_top_intern,       // top internal radius
    r_top_extern,       // top external radius
    r_bottom_intern,    // bottom internal radius
    r_bottom_extern,    // bottom external radius
    elem_count,         // number of holes in one layer
    elem_border,        // border width
    elem_height,        // layer (element) height
    make_supports       // supports
) {
    if(make_supports) {
        supports(
            height = height,
            r_top = r_top_intern,
            r_bottom = r_bottom_intern,
            size = 4,
            min_distance = 5
        );
    }
    
    elem_a1 = 240;
    elem_a2 = elem_a1 + 360/elem_count;

    elem_a = 360/elem_count;

    layer_count = height/elem_height;

    difference() {
        cylinder(
            h = height,
            r1 = r_bottom_extern,
            r2 = r_top_extern,
            center = false);

        union() {
            translate([0,0,-0.05])
            cylinder(
                h = height+0.1, 
                r1 = r_bottom_intern, 
                r2 = r_top_intern, 
                center = false);
            for(layer_no=[0:(layer_count-1)]) {
                elem_r_extern = r_bottom_extern+layer_no/layer_count*(r_top_extern-r_bottom_extern);
                hole_r = elem_r_extern+10;
                elem_bot_a = 360*elem_border/(2*PI*elem_r_extern);
                elem_z = layer_no*elem_height+elem_border;
                elem_z2 = (layer_no==layer_count-1 ? height : elem_z+elem_height) -elem_border;
                a_offset = layer_no * 180 / elem_count;
                for(i=[0:(elem_count-1)]) {
                    elem_a1 = a_offset + i*elem_a;
                    elem_a2 = elem_a1+elem_a;
                    polyhedron(
                        points = [
                            [0,0,elem_z],
                            [cos(elem_a1)*hole_r,sin(elem_a1)*hole_r,elem_z],
                            [cos(elem_a2-elem_bot_a)*hole_r,sin(elem_a2-elem_bot_a)*hole_r,elem_z],
                            [0,0,elem_z2],
                            [cos(elem_a1)*hole_r,sin(elem_a1)*hole_r,elem_z2],
                            [cos(elem_a2-elem_bot_a)*hole_r,sin(elem_a2-elem_bot_a)*hole_r,elem_z2]
                        ],
                        faces = [
                            [0,1,2],
                            [5,4,3],
                            [3,4,1,0],
                            [2,5,3,0],
                            [4,5,2,1]
                            ]
                            );
                }
            }
        }
    }
}

// EXAMPLE:
/*
sleeve(
    height = 29,                // height of sleeve
    r_top_intern = 4,           // top internal radius
    r_top_extern = 5.5,         // top external radius
    r_bottom_intern = 4,        // bottom internal radius
    r_bottom_extern = 6.5,      // bottom external radius
    elem_count = 3,             // number of holes in one layer
    elem_border = 1,            // border width
    elem_height = 2,            // layer (element) height
    make_supports = true
    );
*/

height = 35;

r_top_intern = 4.5;
r_top_extern = 5.5;
r_bottom_intern = 14.5;
r_bottom_extern = 7.5;
elem_count = 3;
elem_border = 1;
elem_height = 2.5;

supports(
    height = 14,
    r_top = 4,
    r_bottom = 4,
    size = 4,
    min_distance = 5
);
