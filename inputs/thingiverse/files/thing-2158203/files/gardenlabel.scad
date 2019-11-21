// Text to display on the label.
label_text = "legplant";
// Length of the sign.
sign_l = 150;
// Width of the sign.
sign_w = 40;
// Overall thickness.
thickness = 5;
// Font to use.  See www.google.com/fonts for a full list of available fonts.
font = "Yellowtail";

module label(lbl) {
    tw = len(lbl) * 15; // a guess at how wide the text will end up
    th = sign_w-5;
    difference() {
        cube([sign_l, sign_w, thickness]);
        translate([sign_l-tw-5, 5, -.1]) cube([tw, sign_w-10, thickness+.2]);
    }
    translate([sign_l-tw-5, sign_w/2, 0]) {
        linear_extrude(thickness) {
            resize([tw, 0]) {
                text(lbl, size=th, valign="center", font=font);
            }
        }
    }
    linear_extrude(thickness) polygon(points=[[0, 0], [0, sign_w], [-45, sign_w/2]]);
}

label(label_text);
