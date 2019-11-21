$fn = 50;

od = 75;
id = od/4;


spool_wall_thickness=3;
outer_spool_thickness=10;

cable_tie_thickness=10;

cable_tie_offset_from_inner_spool = 10;

part_height = id*1.61803398875;

module ring(inner,outer,height) {
    difference() {
        echo("Making a ring with od of ");
        echo(outer);
        echo(" and an inner diameter of ");
        echo(inner);
        cylinder(r=outer, h=height);
        cylinder(r=inner, h=height);

    }
}



module cable_tie_holes1() {
    echo("cutting inner holes for cable ties");
    for(a = [0:90:359]) {
        rotate([0,0,a])
        {
            translate([id/2+spool_wall_thickness+cable_tie_offset_from_inner_spool,0,0]) {
                hull() {
                    cylinder(r=cable_tie_thickness/2,part_height);
                    translate([cable_tie_thickness,0,0]) cylinder(r=cable_tie_thickness/2,part_height);
                    translate([cable_tie_thickness*2,0,0]) cylinder(r=cable_tie_thickness/2,part_height);
                }
            }
        }
    }
}

module ring1(){
        echo("Creating outside spool primitive");
        ring(id/2,od/2,part_height);
}

module ring2() {
        echo("Creating cut cylinder to hollow out spool");
        translate([0,0,outer_spool_thickness/2]) {
            ring(
                id/2+spool_wall_thickness,
                od*2,
                part_height-outer_spool_thickness);
    }
}

difference() {
    difference(){
        color([1,0,0]) ring1();
        color([0,1,0]) ring2();

    }
    color([0,0,1]) cable_tie_holes1();
}
//color([1,0,0]) ring1();
//color([0,1,0]) ring2();