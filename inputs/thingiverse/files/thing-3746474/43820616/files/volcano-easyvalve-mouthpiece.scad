// Detail level
$fn = 300;

outer_shaft_od = 16.5;
outer_shaft_detent_depth = 0.5;
outer_shaft_detent_length = 4.5;
outer_shaft_detent_offset = 2;
outer_shaft_detent_chamfer_length = 0.75;

inner_shaft_od = 10;
inner_shaft_thickness = 1;

outer_shaft_length = 31;
inner_shaft_length = 37.5;

lip_od = 33.4;
lip_depth = 7;
lip_rim_thickness = 1;
lip_resolution_step = 0.025;

difference() {
    union() {
        // Inner Shaft
        cylinder(r=inner_shaft_od/2, h=inner_shaft_length);
        // Outer Shaft
        translate([0, 0, lip_depth-0.1]) cylinder(r=outer_shaft_od/2, h=outer_shaft_length-lip_depth+0.1);
        // Mouth Part
        rotate_extrude()
        translate([inner_shaft_od/2, 0, 0])
        resize([(lip_od-lip_rim_thickness-inner_shaft_od)/2, lip_depth-lip_rim_thickness])
        polygon(points=concat(
                [[0, 0], [0.0316,0]],
                [ for (i = [0.05 : lip_resolution_step : 4]) [i, log(i)+1.5] ],
                [[0, log(4)+1.5]]
            )
        );
        // Fix for funny business between inner_shaft_od and rotate_extrude around inner_shaft_od/2
        cylinder(h=lip_depth, r1=inner_shaft_od/2, r2=inner_shaft_od/2+0.1);
        // Beveled Edge
        hull() rotate_extrude() translate([(lip_od-lip_rim_thickness)/2, lip_depth-(lip_rim_thickness/2)]) circle(d=lip_rim_thickness);
    }
    // Hollow Core
    translate([0, 0, -0.5]) {cylinder(r=inner_shaft_od/2-inner_shaft_thickness, h=inner_shaft_length+1);}
    // Detent
    translate([0, 0, outer_shaft_length-outer_shaft_detent_length-outer_shaft_detent_offset-(2*outer_shaft_detent_chamfer_length)]) {
        difference() {
            // Detent Outer
            cylinder(r=outer_shaft_od/2+1, h=outer_shaft_detent_length+(2*outer_shaft_detent_chamfer_length));
            // Detent Core
            cylinder(r=outer_shaft_od/2-outer_shaft_detent_depth, h=outer_shaft_detent_length+(2*outer_shaft_detent_chamfer_length));
            // Lower Detent Chamfer
            cylinder(h=outer_shaft_detent_chamfer_length, r1=outer_shaft_od/2, r2=outer_shaft_od/2-outer_shaft_detent_depth);
            // Upper Detent Chamfer
            translate([0, 0, outer_shaft_detent_length+outer_shaft_detent_chamfer_length]) {cylinder(h=outer_shaft_detent_chamfer_length, r1=outer_shaft_od/2-outer_shaft_detent_depth, r2=outer_shaft_od/2);}
        }
    }
}
