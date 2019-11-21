WIDTH=40.7;
HEIGHT=12.4;
LENGTH=205;
BEVEL=1;
TRACK_WIDTH=6.2;
TRACK_HEIGHT=3;
TRACK_DIST=20;

BRIDGE_HEIGHT=64;
BRIDGE_R1=214;
BRIDGE_R2=220;

CONN_WIDTH=7.3;
CONN_R=6.5;
CONN_BEVEL=1.7;
CONN_DEPTH=16;

ROUND_R=189;

SUPPORT_SIDE=7.2;
SUPPORT_THICK=33;
SUPPORT_WIDTH=WIDTH+1+2*SUPPORT_SIDE;

TUNNEL_R=28.5;
TUNNEL_H=65;
TUNNEL_LEN=135;
TUNNEL_THICK=2.1;
TUNNEL_SIDE_W=4.3;

CONN_LEN=31.6;
CONN_HEIGHT=11.5;

CONN_MALE_R=6;
CONN_MALE_W=6.5;
CONN_MALE_HOLE_Y=6.8;
CONN_MALE_HOLE_Z=6.4;
CONN_MALE_RIM=1;
CONN_MALE_PROTRUDE=0.75;
CONN_MALE_PROTRUDE_R=1.5;

CONN_FEMALE_R=5.6;
CONN_FEMALE_PROTRUDE_R=1.2;
CONN_FEMALE_THICK=1.6;
CONN_FEMALE_BRIDGE_L=6.5;
CONN_FEMALE_BRIDGE_W1=3.5;
CONN_FEMALE_BRIDGE_W2=4.5;
CONN_FEMALE_BRIDGE_RIM=CONN_FEMALE_BRIDGE_W2-CONN_FEMALE_BRIDGE_W1;
CONN_FEMALE_THICK=1.7;

module track_single() {
    square([TRACK_WIDTH,TRACK_HEIGHT]);
}

module track() {
    translate([WIDTH/2-TRACK_WIDTH-TRACK_DIST/2,HEIGHT-TRACK_HEIGHT,0])
        track_single();
    translate([WIDTH/2+TRACK_DIST/2,HEIGHT-TRACK_HEIGHT,0])
        track_single();
}

module body() {
    difference() {
        polygon(points=[[BEVEL,0],[WIDTH-BEVEL,0],[WIDTH,BEVEL],[WIDTH,HEIGHT-BEVEL],[WIDTH-BEVEL,HEIGHT],[BEVEL,HEIGHT],[0,HEIGHT-BEVEL],[0,BEVEL]]);
        translate([0,0,0.01])
            track();
    }
}

module brio_curved(r, parts) {
    translate([0,-r,0])
    difference() {
        rotate([0,0,-360/parts])
        difference() {
            rotate_extrude(convexity = 10, $fn=200)
            translate([r, 0, 0])
            difference() {
                body();
                translate([0,-HEIGHT+TRACK_HEIGHT,0])
                track();
            }
            translate([0,-500,-500])
            cube([1000,1000,1000]);
            translate([0,r+WIDTH/2,5*HEIGHT])
            mirror([1,0,0])
            rotate([90,0,0])
            connector();
        }

        translate([0,r+WIDTH/2,5*HEIGHT])
        rotate([90,0,0])
        connector();
        translate([-1000,-500,-500])
        cube([1000,1000,1000]);
    }
}

module round_quart() {
    intersection() {
        translate([0,0,WIDTH])
        rotate_extrude(convexity = 10, $fn = 200)
            translate([BRIDGE_R1, 0, 0])
            rotate([0,0,-90])
translate([0,-HEIGHT,0])
                body();

        cube([1000,1000,1000]);
    }
}

module round_quart_2() {
    intersection() {
        translate([0,0,WIDTH])
        rotate_extrude(convexity = 10, $fn = 200)
            translate([BRIDGE_R2, 0, 0])
            rotate([0,0,-90])
                mirror([0,1,0])
translate([0,-HEIGHT,0])
                body();

            cube([1000,1000,1000]);
    }
}


module curved_track() {
    intersection() {
        translate([0,-BRIDGE_R1+BRIDGE_HEIGHT,0])
        round_quart();
        cube([LENGTH/2,BRIDGE_HEIGHT,WIDTH]);
    }

    intersection() {
        translate([LENGTH,BRIDGE_R2+HEIGHT,0])
        mirror([1,1,0])
        round_quart_2();
        translate([LENGTH/2,0,0])
        cube([LENGTH/2,BRIDGE_HEIGHT,WIDTH]);
    } 
}

module bridge_hole_part(t, w,h,w2,h2) {
    hull() {
        cylinder(0.01,r=w/2);
        translate([0,0,t])
            cylinder(0.01,r=w2/2);
    }  
    hull() {
        translate([-w/2,0,0])
            cube([w,h-w/2,0.01]);
        translate([-w2/2,0,t])
            cube([w2,h2-w2/2,0.01]);
    } 
}

module bridge_hole(w,h) {
    mirror([0,1,0])
    translate([0,-h+w/2+0.01,BEVEL]) {
        bridge_hole_part(WIDTH-2*BEVEL,w,h,w,h);
        translate([0,0,-BEVEL])
            bridge_hole_part(BEVEL,w+BEVEL,h+BEVEL,w,h);
        translate([0,0,WIDTH-2*BEVEL])
            bridge_hole_part(BEVEL,w,h,w+BEVEL,h+BEVEL); 
    }
}

module bridge_body() {
    curved_track();
    intersection() {
    translate([0,-BRIDGE_R2+BRIDGE_HEIGHT-HEIGHT/2,0])
    cylinder(WIDTH,r=BRIDGE_R2, $fn=200);
    translate([0,BEVEL,0])
    cube([LENGTH,BRIDGE_HEIGHT,WIDTH]);
    }
    translate([0,BEVEL,0])
    cube([LENGTH,HEIGHT-TRACK_HEIGHT-BEVEL,WIDTH]);
    translate([130,BEVEL,0])
    cube([25,HEIGHT,WIDTH]);
    hull() {
        translate([0,0,BEVEL])
        cube([LENGTH,0.01,WIDTH-2*BEVEL]);
        translate([0,BEVEL,0])
        cube([LENGTH,0.01,WIDTH]);
    }
}

module brio_bridge() {
    rotate([90,0,-90])
    difference() {
        bridge_body();
        translate([84,0,0])
        bridge_hole(44.5,30);
        bridge_hole(68,BRIDGE_HEIGHT-HEIGHT);
        translate([-0.01,9*HEIGHT,WIDTH/2])
        connector();
        translate([LENGTH+0.01,9*HEIGHT,WIDTH/2])
        mirror([1,0,0])
        connector();
    }
}

module conn_bevel() {
    translate([WIDTH/2-BEVEL,0,0])
    linear_extrude(height=10*HEIGHT)
        polygon(points=[[0,-0.01],[BEVEL+0.01,BEVEL],[BEVEL+0.01,-0.01]]);
}
module connector() {
    rotate([90,90,0])
    {
    hull() {
        translate([-(CONN_WIDTH+2*CONN_BEVEL)/2,-0.01,0])
            cube([CONN_WIDTH+2*CONN_BEVEL, 0.01, 10*HEIGHT]);
        translate([-CONN_WIDTH/2,CONN_BEVEL,0])
            cube([CONN_WIDTH, 0.01, 10*HEIGHT]);
    }
    translate([-CONN_WIDTH/2,0,0])
        cube([CONN_WIDTH, CONN_DEPTH, 10*HEIGHT]);

    difference() {
        translate([0,CONN_DEPTH-CONN_R+1.1,0])
            cylinder(10*HEIGHT,r=CONN_R);
        translate([-CONN_WIDTH/2,CONN_DEPTH,0])
            cube([CONN_WIDTH, CONN_DEPTH, 10*HEIGHT]);
    }

    conn_bevel();
    mirror([1,0,0])
        conn_bevel();

    } 
}

module brio_straight(len) {
    rotate([90,0,0])
    difference() {
        linear_extrude(height=len)
            body();
        translate([WIDTH/2,5*HEIGHT,len])
        rotate([0,90,0])
            connector();
        mirror([0,0,1])
        translate([WIDTH/2,5*HEIGHT,0])
        rotate([0,90,0])
            connector();
    }
}

module brio_cross(len) {
    difference() {
        union() {
            translate([-WIDTH/2,len/2,0])
                brio_straight(len);
            rotate([0,0,90])
                translate([-WIDTH/2,len/2,0])
                    brio_straight(len);
        }
        translate([-len,-WIDTH/2,0.01])
            rotate([90,0,90])
                linear_extrude(height=len*2)
                    track();
        translate([-WIDTH/2,len,0.01]) 
            rotate([90,0,0])
                linear_extrude(height=len*2)
                    track();
    }
}

module brick_6_track() {
    translate([0,-0.01,0])
    rotate([90,0,0])
    linear_extrude(height=LENGTH+0.02)
        track();
    translate([-ROUND_R,0,0])
    rotate_extrude(convexity = 10, $fn = 200)
    translate([ROUND_R, 0, 0])
        track();
}

module brio_splitter() {
    difference() {
        union() {
            brio_straight((3/4)*LENGTH);
            rotate([0,0,-90])
            brio_curved(ROUND_R, 8);
        }
        translate([0,0,0.01])
        brick_6_track();
        translate([0,0,-HEIGHT+TRACK_HEIGHT-0.01])
        brick_6_track();
    }

}

module brick_6_track_round() {
    cube([1,1,1]);

    translate([-ROUND_R,0,0])
    rotate_extrude(convexity = 10, $fn = 200)
    translate([ROUND_R, 0, 0])
        track();

    translate([WIDTH,0,0])
    mirror([1,0,0])
    translate([-ROUND_R,0,0])
    rotate_extrude(convexity = 10, $fn = 200)
    translate([ROUND_R, 0, 0])
        track();
}

module brio_splitter_round() {
    difference() {
        union() {
//            brio_straight((3/4)*LENGTH);
 //           rotate([0,0,-90])
//            brio_curved(ROUND_R, 8*3/2);
            rotate([0,0,-90])
            brio_curved(ROUND_R, 8*3/2);
            translate([WIDTH,0,0])
            mirror([1,0,0])
            rotate([0,0,-90])
            brio_curved(ROUND_R, 8*3/2);
        }
        translate([0,0,0.01])
        brick_6_track_round();
        translate([0,0,-HEIGHT+TRACK_HEIGHT-0.01])
        brick_6_track_round();
    }

}
module support_halve() {
    linear_extrude(height=SUPPORT_THICK)
        polygon(points=[[0,HEIGHT-BEVEL],[WIDTH/2+0.5,HEIGHT-BEVEL],[WIDTH/2+0.5,BEVEL],[WIDTH/2+0.5+BEVEL,0],[SUPPORT_WIDTH/2-BEVEL,0],[SUPPORT_WIDTH/2,BEVEL],[SUPPORT_WIDTH/2,BRIDGE_HEIGHT-HEIGHT-BEVEL],[SUPPORT_WIDTH/2-BEVEL,BRIDGE_HEIGHT-HEIGHT],[WIDTH/2,BRIDGE_HEIGHT-HEIGHT],[WIDTH/2,BRIDGE_HEIGHT-2*BEVEL],[WIDTH/2-BEVEL,BRIDGE_HEIGHT-BEVEL],[0,BRIDGE_HEIGHT-BEVEL]]);
}

module brio_support() {
    translate([0,-BRIDGE_HEIGHT-BEVEL,0]) {
        support_halve();
        mirror([1,0,0])
            support_halve();
    }
}

module tunnel_shape(sub) {
    translate([TUNNEL_H-TUNNEL_R,0,0])
        circle(TUNNEL_R-sub, $fn=200);
    translate([0,-TUNNEL_R+sub,0])
        square([TUNNEL_H-TUNNEL_R,TUNNEL_R*2-2*sub]);
}

module tunnel_halve_neg() {
    translate([0,0,0])
        linear_extrude(height=TUNNEL_THICK)
            tunnel_shape(2*TUNNEL_THICK);
    hull() {
        translate([0,0,TUNNEL_THICK])
            linear_extrude(height=0.01)
                tunnel_shape(2*TUNNEL_THICK);
        translate([0,0,2*TUNNEL_THICK])
            linear_extrude(height=0.01)
                tunnel_shape(TUNNEL_THICK);
    }
    translate([0,0,2*TUNNEL_THICK])
        linear_extrude(height=TUNNEL_LEN/2-2*TUNNEL_THICK+0.01)
            tunnel_shape(TUNNEL_THICK);
}

module tunnel_halve_pos() {
    linear_extrude(height=TUNNEL_LEN/2)
        tunnel_shape(0);
}

module tunnel_halve() {
    translate([0,0,-TUNNEL_LEN/2]) {
        difference() {
            tunnel_halve_pos();
            tunnel_halve_neg();
        }
        translate([0,TUNNEL_R-TUNNEL_THICK,0])
            linear_extrude(height=TUNNEL_LEN/2)
                square([TUNNEL_THICK, TUNNEL_SIDE_W]);
        translate([0,-TUNNEL_R+TUNNEL_THICK-TUNNEL_SIDE_W,0])
            linear_extrude(height=TUNNEL_LEN/2)
                square([TUNNEL_THICK, TUNNEL_SIDE_W]);
    }
}

module brio_tunnel() {
    translate([0,-TUNNEL_LEN/2,0])
    mirror([0,0,1])
    rotate([90,90,0]) {
        tunnel_halve();
        mirror([0,0,1])
            tunnel_halve();
    }
}

module connector_male_protrude() {
    translate([0,CONN_MALE_R-CONN_MALE_PROTRUDE_R+CONN_MALE_PROTRUDE,0])
        cylinder((CONN_HEIGHT-2*CONN_MALE_RIM)/2,r=CONN_MALE_PROTRUDE_R,$fn=20);
}

module connector_male_end(len) {
    difference() {
        intersection() {
            translate([0,50,0])
                cube([100,100,100],center=true);
            union() {
                translate([0,0,CONN_HEIGHT/2-CONN_MALE_RIM])
                    hull() {
                        cylinder(0.01, r=CONN_MALE_R, $fn=20);
                        translate([0,0,CONN_MALE_RIM])
                            cylinder(0.01, r=CONN_MALE_R-CONN_MALE_RIM, $fn=20);
                    }
                cylinder(CONN_HEIGHT/2-CONN_MALE_RIM, r=CONN_MALE_R, $fn=20);
                rotate([0,0,40])
                    connector_male_protrude();
                rotate([0,0,-40])
                    connector_male_protrude();
            }
        }
        translate([-CONN_MALE_R/2,0,0])
            cube([CONN_MALE_R,CONN_MALE_HOLE_Y,CONN_MALE_HOLE_Z],center=true);
    }
}

module connector_male_bridge(len) {
    hull() {
        cube([len-CONN_MALE_R,0.01,CONN_HEIGHT/2], center=true);
        translate([0,CONN_MALE_RIM,-CONN_MALE_RIM/2])
            cube([len-CONN_MALE_R-2*CONN_MALE_RIM,0.01,CONN_HEIGHT/2-CONN_MALE_RIM], center=true);
    }
    translate([0,-(CONN_MALE_W-2*CONN_MALE_RIM)/4,0])
        cube([len-CONN_MALE_R,(CONN_MALE_W-2*CONN_MALE_RIM)/2,CONN_HEIGHT/2], center=true);
}

module connector_male_quart(len) {
    connector_male_end(len);
    translate([(len-CONN_MALE_R)/2,CONN_MALE_W/2-CONN_MALE_RIM,CONN_HEIGHT/4])
        connector_male_bridge(len);
}

module connector_male(len) {
    translate([-len+CONN_MALE_R,0,0]) {
        connector_male_quart(len);
        mirror([0,0,1])
            connector_male_quart(len);
        mirror([0,1,0]) {
            connector_male_quart(len);
            mirror([0,0,1])
                connector_male_quart(len);
        }
    }
}

module connector_female_end(len) {
    difference() {
        intersection() {
            translate([0,50,0])
                cube([100,100,100],center=true);
            difference() {
                cylinder(CONN_HEIGHT/2, r=CONN_FEMALE_R, $fn=20);
                rotate([0,0,38])
                    translate([-CONN_FEMALE_R/2,CONN_FEMALE_R,0])
                        cube([CONN_FEMALE_R,CONN_FEMALE_R*2,CONN_HEIGHT], center=true);
                minkowski() {
                    intersection() {
                        translate([0,50+CONN_FEMALE_BRIDGE_W1/2+CONN_FEMALE_THICK/2,0])
                            cube([100,100,100],center=true);
                        cylinder(CONN_HEIGHT/2,r=CONN_FEMALE_R-3*CONN_FEMALE_THICK/2,$fn=20);
                    }
                    cylinder(CONN_FEMALE_THICK,r=CONN_FEMALE_THICK/2,$fn=20);
                }
            }
        }
    }
    rotate([0,0,38])
        translate([0,CONN_FEMALE_R-CONN_FEMALE_PROTRUDE_R,0])
            cylinder(CONN_HEIGHT/2,r=CONN_FEMALE_PROTRUDE_R, $fn=20);

}

module connector_female_bridge(len) {
    translate([0,0,CONN_HEIGHT/4]) {
        translate([(len-CONN_FEMALE_THICK/2)/2,CONN_FEMALE_BRIDGE_W1/4,0])
            cube([len-CONN_FEMALE_THICK/2,CONN_FEMALE_BRIDGE_W1/2,CONN_HEIGHT/2],center=true);
        hull() {
            translate([(CONN_FEMALE_BRIDGE_L+CONN_FEMALE_BRIDGE_RIM)/2,CONN_FEMALE_BRIDGE_W1/2,0])
                cube([CONN_FEMALE_BRIDGE_L+CONN_FEMALE_BRIDGE_RIM,0.01,CONN_HEIGHT/2],center=true);
            translate([CONN_FEMALE_BRIDGE_L/2,CONN_FEMALE_BRIDGE_W2/2,0])
                cube([CONN_FEMALE_BRIDGE_L,0.01,CONN_HEIGHT/2],center=true);
        }
    }

}

module connector_female_quart(len) {
    translate([len-CONN_FEMALE_R,0,0])
        connector_female_end(len);
    connector_female_bridge(len);
}

module connector_female(len) {
        connector_female_quart(len);
        mirror([0,0,1])
            connector_female_quart(len);
        mirror([0,1,0]) {
            connector_female_quart(len);
            mirror([0,0,1])
                connector_female_quart(len);
        }
}

module brio_connector(len) {
    connector_male(len/2);
    connector_female(len/2);
}

//brio_straight(LENGTH);
//brio_straight((3/4)*LENGTH);
//brio_straight((1/2)*LENGTH);
//brio_straight((1/4)*LENGTH);
//brio_curved(ROUND_R, 8); // inner radius, Nth part
//brio_curved(ROUND_R, 16); // inner radius, Nth part
//brio_bridge();
//brio_cross(LENGTH/2);
//brio_splitter();
brio_splitter_round();
//brio_support();
//brio_tunnel();
//brio_connector(CONN_LEN);
