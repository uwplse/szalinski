// many melltorp connector no.2
// in mm

// The space between the tables (for cables)
gutter = 20;

height = 40;

// wall thickness
thickness = 4;

/* [Hidden] */
leg_width = 20;
leg_depth = 60;

depth = 2 * leg_depth + gutter;
width = leg_width + 2 * thickness;

difference() {
    cube( [ width, depth, height], center=true );

    translate( [0, (leg_depth+gutter) / 2, 0] )
      cube( [ leg_width, leg_depth, height ], center=true );
    translate([0,(depth/2)+height*0.35,0])
        rotate([90,0,90])
            cylinder(r=height/2,40, center = true);

    
    translate( [0, -(leg_depth+gutter) / 2, 0] )
      cube( [ leg_width, leg_depth, height ], center=true );
    translate([0,-(depth/2)-height*0.35,0])
        rotate([90,0,90])
            cylinder(r=height/2,40, center = true);



}

