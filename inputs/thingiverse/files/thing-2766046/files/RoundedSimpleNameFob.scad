//key fob base length (X dimension)
fob_length = 50;

//key fob width (Y dimension)
fob_width = 20;

//key fob thickness (Z dimension)
fob_thickness = 3;

//radius of key loop hole
hole_radius = 5;

//width of key loop
loop_width = 3;

//offset of key loop hole - percent of hole diameter
hole_offset_percent = 50;   //[0:100]

//text to appear on the fob
name = "Christopher";

//thickness of text (Z dimension) - positive values will protrude, negaive values will inset
text_thickness = 1;

//border spacing between edge of fob and text
text_border = 3;

//text font to use (can be any Google fonts from: https://fonts.google.com/)
text_font = "Classic Comic";

//$fn value to use in rendering fob edges - lower values yield faster results, but rougher edges, higher values yield smoother edges, but longer render times
edge_fn = 14; //[0:50]

//$fn value for rendering the shape of the loop - how many sides the full loop will have. Lower numbers will produce non-circular shapes (3 = triangle, 6 = hexagon, etc) and will render faster. Larger values will provide a smooth, circular loop, but will render slowly.
loop_fn = 8; //[3:50]

difference() {
    minkowski() {
        fob();
        sphere(r=fob_thickness/2, $fn=edge_fn);
    }
    if (text_thickness < 0)
        translate([0, 0, text_thickness + .01])
            name();
}
if (text_thickness > 0)
    name();

module fob() {
    translate([fob_thickness/2, fob_thickness/2, fob_thickness/2]) {
        cube([fob_length - fob_thickness, fob_width - fob_thickness, .001]);

        translate([fob_length - fob_thickness/2 - hole_radius + 2*hole_radius * hole_offset_percent/100, (fob_width - fob_thickness)/2, 0])
            difference() {
                cylinder(r=hole_radius + loop_width/2 + loop_width/2 - fob_thickness/2 + .001, h=.001, $fn=loop_fn);
                cylinder(r=hole_radius + loop_width/2 - (loop_width/2 - fob_thickness/2) - .001, h=.004, $fn=loop_fn);
            }
        }
}

module name() {
    color("Blue")
        translate([fob_length/2, fob_width/2, fob_thickness - .04])
            resize([fob_length - 2*text_border, fob_width - 2*text_border, 0])
                linear_extrude(abs(text_thickness))
                    text(name, font = text_font, halign="center", valign="center");
}
