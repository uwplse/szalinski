/* 
 * Instructions:
 * 1. Download and install the fonts from here: https://andrewgioia.github.io/Keyrune/index.html & https://andrewgioia.github.io/Mana/index.html
 * 2. Set your front set symbol and your back set symbol by copying the icon from this page: https://andrewgioia.github.io/Keyrune/cheatsheet.html or this page: https://andrewgioia.github.io/Mana/cheatsheet.html. You want the icon, nothing else. If it doesn't look quite right in the string input, that should be ok; the rendering uses the specifc Keyrune font. (if you want, you can use the unicode like \ue93f, but if you don't understand how to do that, just copy and paste the symbol). If you want the same symbol on front and back...paste the same symbol.  If you don't want a symbol on one side, just use an empty string.
 * 3. Set clip_right to false to put the clip on the left side instead. I recommend alternating them.
 */

/* [Divider] */
// Width of the divider.
width = 66;
// Height of the divider.
height = 93;
// Thickness of the divider. Also acts as the diameter of all the rounded edges.
depth = 3; // [1.5:0.1:6]
// The number of bars supporting the divider structure. Fairly hollow by default to save material. Setting to about 32 or higher will create a solid divider.
bars = 2; // [0:32]

/* [Clip] */
// Width of the clip on the side of the divider. This should be slightly bigger than whatever wall you want to clip it to.
clip_width = 10.65;
// Height of the clip on the side of the divider. Higher will make it clip better. Keep it reasonably small though.
clip_height = 15;
// Depth of the clip on the side of the divider. Higher will make it clip better. Keep it reasonably small though.
clip_depth = 7.5;
// Determines which side to place the clip on. Alternating sides every column is recommended. For outer columns, plan on having this face inside.
clip_right = 1; // [1:Right, 0:Left]
// Number of millimeters to move the clip down the side. Leave at zero for the top of the divider.
clip_vertical_position=0;

/* [Label] */
// Size of how big to make the text. Don't go too big, or it will be blocked by the cards. 
label_size = 10; // [6:24]
// The expansion set symbol for the front of the divider.
front_set_image = ""; // [image_surface:100x100]
// An additional identifying symbol for the front of the divider, such as a color identity.
front_symbol_image = ""; // [image_surface:100x100]
// The expansion set symbol for the back of the divider.
back_set_image = ""; // [image_surface:100x100]
// An additional identifying symbol for the back of the divider, such as a color identity.
back_symbol_image = ""; // [image_surface:100x100]

/* [Hidden] */

// Strongly recommended you use these instead of images. Images are provided for Customizer use.
// The symbol you want on the front side of the divider. The front side has the clip on the right. Paste this from https://andrewgioia.github.io/Keyrune/cheatsheet.html
front_set = "";
// The symbol you want on the back side of the divider. The back side has the clip on the left. Paste this from https://andrewgioia.github.io/Keyrune/cheatsheet.html
back_set = "";
// The symbol you want on the front side of the divider. The front side has the clip on the right. Paste this from https://andrewgioia.github.io/Mana/cheatsheet.html
front_symbol = "";
// The symbol you want on the back side of the divider. The back side has the clip on the left. Paste this from https://andrewgioia.github.io/Mana/cheatsheet.html
back_symbol = "";

// Variables that make life easier
rad = depth / 2;
rad_w_padding = depth * 3 / 4;
space_size = width / (bars + 1) - depth - 2 * depth / (bars + 1);
font_size = label_size*.7;


/*
 * Do the work!
 */


rotate([90, 0, 0])
union() {
    if(clip_right){
        translate([width / 2, -height / 2, 0])mirror([1, 0, 0])rotate([-90, 0, 0])halfDivider();
    } else {
        translate([-width / 2, -height / 2, 0])rotate([-90, 0, 0])halfDivider();
    }


    // Front Text
    rotate([0, 0, 180]) {
        translate([0, height / 2 - font_size / 5 - rad_w_padding / 3, 0]) {
            translate([-width / 3 + label_size + 1, -label_size / 2, 0]) {
                print_image(front_set_image);
                linear_extrude(height=rad) {
                    text(front_set, font="Keyrune", size=font_size, valign="center", halign="center");
                }
            }
            translate([width / 3 -label_size - 1, -label_size / 2, 0]) {
                print_image(front_symbol_image);
                linear_extrude(height=rad) {
                    text(front_symbol, font="Mana", size=font_size, valign="center", halign="center");
                }
            }
        }
    }

    // Back Text
    rotate([0, 180, 180]) {
        translate([0, height / 2 - font_size / 5 - rad_w_padding / 3, 0]) {
            translate([-width / 3 + label_size - 1, -label_size / 2, 0]) {
                print_image(back_set_image);
                linear_extrude(height=rad) {
                    text(back_set, font="Keyrune", size=font_size, valign="center", halign="center");
                }
            }
            translate([width / 3 - label_size + 1, -label_size / 2, 0]) {
                print_image(back_symbol_image);
                linear_extrude(height=rad) {
                    text(back_symbol, font="Mana", size=font_size, valign="center", halign="center");
                }
            }
        }
    }
}


module halfDivider(){
    difference(){
        union(){
            divider();
            translate([0, 0, clip_vertical_position])clip();
        }
        
        //delete half the clip, leaving a smooth surface
        translate([0, 0, clip_vertical_position])translate([width - rad, 0, -rad])cube([clip_width + depth, clip_depth + depth,  clip_height + depth + 0.1]);
//        translate([width+clip_width-3,-0.2,clip_height])cube([5,1,1]); // TODO add small bump & notch to help two halves lock together.
    }
}

/* Making the divider itself */
module divider()
{
    // Make Base Divider
    union(){
        difference() {
            // Start with a rectangle, width x height
            hull() {
                corner([0, 0, 0]);
                corner([0, 0, height]);
                corner([width, 0, 0]);
                corner([width, 0, height]);
            }
            // Add gaps in the main divider to save plastic.
            for(gap=[0:bars]){
                translate([depth + rad + gap * (depth + space_size), -rad, rad_w_padding + 1.5 * label_size]){
                    cube([space_size, depth, height - 2 * depth - 1.5 * label_size]);
                }
            }
            // Cut out spaces for Text on each side. Guarantee 1mm thickness remaining
            hull() {
                corner([rad_w_padding, 0.5 + rad, rad_w_padding]); // 0.05 of width is border
                corner([rad_w_padding, 0.5 + rad, label_size + rad_w_padding]); // use font_size as a relative adjustment
                corner([width - depth - rad, 0.5 + rad, label_size + rad_w_padding]);
                corner([width - depth - rad, 0.5 + rad, rad_w_padding]);
            }
            hull() {
                corner([rad_w_padding, -0.5 - rad, rad_w_padding]);
                corner([rad_w_padding, -0.5 - rad, label_size + rad_w_padding]);
                corner([width - depth - rad, -0.5 - rad, label_size + rad_w_padding]);
                corner([width - depth - rad, -0.5 - rad, rad_w_padding]);
            }
        }
        // Add 2 cross beams to support the gaps.
        hull(){        
            translate([rad, 0, height - rad])cube([rad, depth, rad], center=true);
            translate([width - rad, 0, rad + 1.5 * label_size])cube([rad, depth, rad], center=true);
        }
        hull(){        
            translate([width - rad, 0, height - rad])cube([rad, depth, rad], center=true);
            translate([rad, 0, rad + 1.5 * label_size])cube([rad, depth, rad], center=true);
        }
    }
}

/* make the clip to attach to the side of the divider */
module clip()
{
    // Make Clip Base
    hull() {
//        corner([width-1.5,0,0]);
        corner([width, 0, 0]);
        corner([width, -clip_depth, 0]);
        corner([width + clip_width, 0, 0]);
        corner([width + clip_width, -clip_depth, 0]);
    }
    
    // Make Clip Side 1
    hull() {
        corner([width, 0, 0]);
        corner([width, -clip_depth, 0]);
        corner([width, -clip_depth, clip_height]);
        corner([width, 0, clip_height * 1.75]);
    }
    
    // Make Clip Side 2. Make a flat edge with a slightly indented inner edge
    hull() {
        corner([width + clip_width - 0.15, clip_depth, 0]);
        corner([width + clip_width - 0.15, -clip_depth, 0]);
        corner([width + clip_width, clip_depth, 0]);
        corner([width + clip_width, -clip_depth, 0]);
        corner([width + (clip_width * 0.875), clip_depth * 0.85, clip_height]);
        corner([width + (clip_width * 0.875), -clip_depth * 0.85, clip_height]);
        corner([width + (clip_width), clip_depth * 0.85, clip_height]);
        corner([width + (clip_width), -clip_depth * 0.85, clip_height]);
    }
    
// If you want to print flat and support is hard to remove, try uncommenting either the next line or the next 4 lines. It will add small posts that will raise the divider off the bed and give you more room for supports    
//    translate([width - rad, 1, clip_height + rad])cube(1);
//    translate([width - rad, 1, height - rad])cube(1);
//    translate([rad, 1, clip_height + rad])cube(1);
//    translate([rad, 1, height - rad])cube(1);
}

/* 
 * Helper to make corners for the rounded edges. Give location as a vector and it will create a sphere with a size of half the depth (the radius). Use hull() to connect them into a shape.
 */
module corner(location)
{
    translate(location) {
        sphere(rad, $fn=24);
    }
}

module print_image(filename)
{
    if (filename != "") {
        scale([0.1, 0.1, rad]) {
            surface(file=filename, center=true, convexity=5); // Front Image
        }
    }
}