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

difference() {
    fob();

    //if negative text_thickness, then sink text into face, and difference it from the fob
    //(if positive text_thickness, then nothing will be differenced from the fob)
    if (text_thickness < 0)
        translate([0, 0, text_thickness + .01])
            name();
}

//if positive text_thickness, then just render it at its default Z position on the face
if (text_thickness > 0)
    name();

//the rectangular body of the fob, with the offset key loop
module fob() {
    cube([fob_length, fob_width, fob_thickness]);

        translate([fob_length - hole_radius + 2*hole_radius * hole_offset_percent/100, fob_width/2, 0]) {
            difference() {
                cylinder(r=hole_radius + loop_width, h=fob_thickness);
                translate([0, 0, -.004])
                    cylinder(r=hole_radius, h=fob_thickness + .008);
            }
        }
}

//the name text, raised above, or inset into, the top surface of the fob
module name() {
    color("Blue")
        translate([fob_length/2, fob_width/2, fob_thickness - .004])
            resize([fob_length - 2*text_border, fob_width - 2*text_border, 0])
                //text_thickness could be negative, so take its absolute value for the extrude
                linear_extrude(abs(text_thickness))
                    text(name, font = text_font, halign="center", valign="center");
}
