/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

/* [Edge Tile Support] */
// Size of edge tile addition, 9.2 is standard for openforge
edge = 12.5;
left_edge = "false"; // [false,true]
right_edge = "false"; // [false,true]
front_edge = "false"; // [false,true]
back_edge = "false"; // [false,true]

/* [Magnets] */
// Size of hole for magnet.  5.4 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.4;

/* [Wire Holes] */
// Size of hole for center wire hole.
center_wire_hole = 0; // 0:Off,0.65:20 Gauge,0.7:18 Gauge
paperclip_wire_hole = .7; // 0:Off,0.65:20 Gauge,0.7:18 Gauge

module wire_holes(x,y,center_wire_hole=0,paperclip_wire_hole=0.7,edge=12.5) {
    // center: 1  mm wire  18 gauge 
    // crossed: .8  mm wire  20 gauge 7.4 small  9.3 large  20 gauge
    eoffset = -1 - edge;

    xlength = 2 + 2 * edge + 25 * x;
    if (x > 1) {
        for ( i = [2 : x] ) {
            ipos = i * 25 - 25;
            translate([ipos,eoffset,6/2]) rotate([-90,0,0]) cylinder(xlength,center_wire_hole,center_wire_hole,$fn=50);
            // Large Loop
            translate([ipos+4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([ipos-4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([ipos+4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([ipos-4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            // Small Loop
            translate([ipos+2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([ipos-2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
        }
    }
    
    ylength = 2 + 2 * edge + 25 * y;
    if (y > 1) {
        for ( i = [2 : y] ) {
            ipos = i*25-25;
            translate([eoffset,i*25-25,6/2]) rotate([0,90,0]) cylinder(ylength,center_wire_hole,center_wire_hole,$fn=50);
            // Large Loop
            translate([eoffset,ipos+4.5,6/2+1.5]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([eoffset,ipos-4.5,6/2+1.5]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([eoffset,ipos+4.5,6/2-1]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([eoffset,ipos-4.5,6/2-1]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            // Small Loop
            translate([eoffset,ipos+2.4,6/2+1.5]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            translate([eoffset,ipos-2.4,6/2+1.5]) rotate([0,90,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
        }
    }
}

module magnet_ejection_holes(x,y,magnet_hole,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    if (magnet_hole > 0) {
        l = left_edge == "true"?edge:0;
        r = right_edge == "true"?edge:0;
        f = front_edge == "true"?edge:0;
        b = back_edge == "true"?edge:0;
        for ( i = [1 : x] ) {
            translate([i*25-12.5,3.6-f,-1]) cylinder(10,.9,.9,$fn=50);
            translate([i*25-12.5,y*25-3.6+b,-1]) cylinder(10,.9,.9,$fn=50);
        }
        for ( i = [1 : y] ) {
            translate([3.6-l,i*25-12.5,-1]) cylinder(10,.9,.9,$fn=50);
            translate([x*25-3.6+r,i*25-12.5,-1]) cylinder(10,.9,.9,$fn=50);
        }
    }
}

module magnet_holder(magnet_hole=5.4) {
    // 5mm buckyballs
    if(magnet_hole > 0) {
        translate([0,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=50);
    }
}

module magnet_base(x,y,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5,
        magnet_hole=5.4,center_wire_hole=0,paperclip_wire_hole=0.7) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    difference() {
        union() {
            translate([-l,-f,0]) difference() {
                cube([25*x+l+r,25*y+f+b,6]);
                translate([7.4-l,7.4-f,-1]) cube([25*x-14.8+l+r,25*y-14.8+f+b,8]);
            }
        }

        for ( i = [1 : x] ) {
            translate([i*25-12.5,3.7-f,0]) magnet_holder(magnet_hole);
            translate([i*25-12.5,y*25-3.7+b,0]) magnet_holder(magnet_hole);
        }
        for ( i = [1 : y] ) {
            translate([3.7-l,i*25-12.5,0]) magnet_holder(magnet_hole);
            translate([x*25-3.7+r,i*25-12.5,0]) magnet_holder(magnet_hole);
        }
        magnet_ejection_holes(x,y,magnet_hole,
                left_edge=left_edge,right_edge=right_edge,front_edge=front_edge,back_edge=back_edge,edge=12.5);

        wire_holes(x,y);
    }
}

magnet_base(x,y,left_edge,right_edge,front_edge,back_edge,edge,magnet_hole,center_wire_hole,paperclip_wire_hole);
