/* [Customize] */

// the words that will appear on your tag.
tag_text = "to: Elizabeth";
// the font to render
font_name = "Nunito"; // [Roboto,Bungee,Noto Sans,Nunito,Oswald]
// the length of the tag in mm (x axis)
tag_length = 84;
// the height of the tag in mm (y axis)
tag_height = 16;
// the depth of the tag base in mm (z axis)
tag_depth = 1;
// the depth of the text in mm (must be > tag_depth, is 2x by default)
text_depth = tag_depth*2;
// how much space between the text and the edge
text_border=3;
// how wide to make the tag border
tag_border=2;


// preview[view:south, tilt:top]

// Model - Start

bold_font_name = str(font_name,":style=Bold");

//Arial Rounded MT Bold is a great 3d printer font. Sadly not available on thingiverse
//bold_font_name = "Arial Rounded MT Bold";

tag_points = [
    [tag_length,-1*(tag_height/2)], 
    [-1*(tag_height/2), -1*(tag_height/2)],
    [-1*(tag_height),0],
    [-1*(tag_height/2),tag_height/2], 
    [tag_length, tag_height/2]];

difference() {
    union() {
        linear_extrude(height=tag_depth) {
            polygon(points=tag_points);
        }
        translate([(-1*(tag_height/2))+(tag_height/5/2),0,0]) {
            cylinder(r=(tag_border*2),h=text_depth);
        }
    }
    translate([(-1*(tag_height/2))+(tag_height/5/2),0,0]) {
        cylinder(r=tag_border,h=text_depth*2);
    }
}
    
translate([text_border,0,0]) {
    linear_extrude(height = text_depth) {
        text(tag_text,font=bold_font_name, size=tag_height-text_border*2, valign="center");
        }
}

linear_extrude(height = text_depth) {
    polygon(points=[
    [tag_points[0][0], tag_points[0][1]],
    [tag_points[0][0], tag_points[0][1]-tag_border],
    [tag_points[1][0], tag_points[1][1]-tag_border],
    [tag_points[1][0], tag_points[1][1]],
    ]);

    polygon(points=[
    [tag_points[1][0], tag_points[1][1]],
    [tag_points[1][0], tag_points[1][1]-tag_border],
    [tag_points[2][0]-tag_border, tag_points[2][1]],
    [tag_points[2][0], tag_points[2][1]],
    ]);

    polygon(points=[
    [tag_points[2][0], tag_points[2][1]],
    [tag_points[2][0]-tag_border, tag_points[2][1]],
    [tag_points[3][0], tag_points[3][1]+tag_border],
    [tag_points[3][0], tag_points[3][1]],
    ]);

    polygon(points=[
    [tag_points[3][0], tag_points[3][1]+tag_border],
    [tag_points[3][0], tag_points[3][1]],
    [tag_points[4][0], tag_points[4][1]],
    [tag_points[4][0], tag_points[4][1]+tag_border],
    ]);

    polygon(points=[
    [tag_points[4][0], tag_points[4][1]+tag_border],
    [tag_points[4][0]+tag_border, tag_points[4][1]+tag_border],
    [tag_points[0][0]+tag_border, tag_points[0][1]-tag_border],
    [tag_points[0][0], tag_points[0][1]-tag_border],
    ]);
}