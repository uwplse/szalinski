brush_radius=42;
brush_height=90;
// Thickness of wall at top.  Bottom is 10% wider.
holder_thickness=10;
holder_top_radius=brush_radius+holder_thickness;
holder_bottom_radius=(brush_radius)*1.1+holder_thickness;
holder_height=brush_height+holder_thickness;

/* [Hidden] */
fn=50;


difference() {
    union() {
        translate([0,0,holder_height]) 
        rotate_extrude(convexity = 10, $fn = fn)
        translate([holder_top_radius-holder_thickness/2,0,0]) 
        circle(r=holder_thickness/2, $fn=fn);
        cylinder(r1=holder_bottom_radius, r2=holder_top_radius, h=holder_height, $fn=fn);
    }
    translate([0,0,brush_radius+holder_thickness])
    union() {
        sphere(r=brush_radius, $fn=fn, center=true);
        cylinder(r=brush_radius, h=brush_height*2, $fn=fn, center=false);
    }
}