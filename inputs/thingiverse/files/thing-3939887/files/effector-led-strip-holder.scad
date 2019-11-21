height=55;
hollow="no"; // [yes,no]
rail_wall=0.8;

strip_width=10;
strip_clearence=0.2;
strip_border_height=2;
strip_border_width=1.2;
strip_hook_width=0.7;
strip_thickness=0.8;

angle=30;
offset_y=0;

/* [Hidden] */

// FIXME: offset_x should be 0
offset_x=0;

rail_width=strip_width+2*strip_clearence+2*strip_border_width;
rail_base_width=max(rail_width*cos(angle),0);
strip_holder_min_raise = strip_border_width*(1-sin(angle));

module strip_holder_shape() {
    x1=rail_width/2-strip_border_width;
    y2=strip_thickness;
    x3=x1-strip_hook_width;
    y4=strip_border_height;
    x5=rail_width/2;

    polygon([
        [-x1,0.001],
        [-x1,y2],
        [-x3,y2],
        [-x3,y4],
        [-x5,y4],
        [-x5,-0.001],

        [x5,-0.001],
        [x5,y4],
        [x3,y4],
        [x3,y2],
        [x1,y2],
        [x1,0.001],
    ]);
}

module rail_base_shape() {
    ay=max(strip_holder_min_raise,offset_y);
    x1=rail_width/2;
    x2=x1-ay*tan(angle);
    x5=rail_base_width-x1;
    y5=rail_width*sin(angle);
    x3=x5+strip_border_width*(1-cos(angle));
    by=angle==0?0:strip_border_width*(1-cos(angle))/tan(angle);
    y4=y5-by;

    polygon([
        [-x1+offset_x-0.001,ay+0.001],
        [-x2,-0.001],
        [x3,-0.001],
        [x3,y4+ay+0.001],
        [x5,y5+ay+0.001]
    ]);
}

module rail_shape() {
    translate([rail_width/2-rail_base_width/2,0]) {
        translate([-rail_width/2+offset_x,max(strip_holder_min_raise,offset_y)])
            rotate(angle)
                translate([rail_width/2,0])
                    strip_holder_shape();
        
        rail_base_shape();
    }
}

module rail() {
    if (height>0) {
        linear_extrude(height=height) {
            difference() {
                rail_shape();
                if (hollow=="yes")
                    offset(-rail_wall)
                        rail_shape();
            }
        }
    } else {
        difference() {
            rail_shape();
            if (hollow=="yes")
                offset(-rail_wall)
                    rail_shape();
        }
    }
}

rail();
