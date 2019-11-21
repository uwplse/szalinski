// Text to put on the plant sign
text="Example Text";

// Font size (mm): The generated text will have approximately an ascent of the given value (height above the baseline).  Note that specific fonts will vary somewhat and may not fill the size specified exactly, usually slightly smaller.
size=4;

// Font to use (any font.google.com should work and other common ones too)
font="Oswald";

module rounded_square(size, r=1) {
    x=size[0];
    y=size[1];
    union() {
        translate([r,r]) circle(r=r, $fn=50);
        translate([r,y-r]) circle(r=r, $fn=50);
        translate([x-r,r]) circle(r=r, $fn=50);
        translate([x-r,y-r]) circle(r=r, $fn=50);
        translate([0,r]) square([x,y-(r*2)]);
        translate([r,0]) square([x-(r*2),y]);
    }
}

module rounded_cube(size, r=1) {
    linear_extrude(height=size[2]) rounded_square(size=size, r=r);
}

// If thingiverse let you import stls then I could enable this to let anyone generate their own single colour signs.  Alas, not yet...

// Either generate the full "sign" or just the "text" (to use as part of a multi-colour print)
mode="text";    // [sign, text]

module label() {
    label=[22,39,0.7];
    translate([-label[0]/2, -label[1]/2, 0.5]) rounded_cube(label, r=2.5);
}

module outer() {
    difference() {
        import("stl/plant_label.stl");
        label();
    }
}

module _text() {
    translate([0,0,0.75]) rotate([0, 0, 90]) linear_extrude(height=1) text(font=font, text=text, size=size, halign="center", valign="center");
}

if (mode == "sign") {
    outer();
    label();
    _text();
}

if (mode == "text") {
    _text();
}
