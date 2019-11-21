// preview[view:west, tilt:top]
IncludeText = true; 
Text = "1";
IncludeMagnetHole = true;

/* [Advanced Text Settings] */
TextFont = "Euphemia UCAS:style=bold";
TextHeight = 7;  // 6.5 for 2 digits
//This needs adjusted depending on the TextHeight and actual Characters
TextDistanceFromCenter = 2; // 2.6 for 2 digits
//The lower the number the deeper the text.
TextDepth = 0.6;

/* [Advanced Magnet Settings] */
MagnetDiameter = 3.4;  
MagnetPosition = [2,2,-1.4];  

/* [Hidden] */
$fn = 50;

difference() {
    union() {
        mainShape();
        topShape();
    }
    bottomShape();
    textCutout();
    magnetCutout();
}
    
module mainShape() {
    minkowski() {
        heart(10, 0.3, 1); // 10 small, 13 medium, 16 large
        translate([1,1,0])
        sphere(1);
    }
}

module topShape() {
    translate([1.0,1.0,1.3])
    difference() {
        heart(9.3, 1, 1.0);
        heart(7.9, 4, 1.8);
    }
}

module bottomShape() {
    translate([1,1,-1]) {
        difference() {
            heart(10, 2, 0.8);
            heart(7.4, 3, 2);
        }
    }
}

module textCutout() {
    if (IncludeText) {
        translate([TextDistanceFromCenter,TextDistanceFromCenter,TextDepth])
            rotate([0,0,-45])
                printText(d=4, scale=.6);
    }
}

module magnetCutout() {
    if (IncludeMagnetHole) {
        translate(MagnetPosition) {
            cylinder(d=MagnetDiameter, h=3, center=true);
        }
    }
}

module heart(d, h, e) {
    translate([d/2+e,0,0])
        cylinder(d=d, h=h, center=true);
    translate([0,d/2+e,0])
        cylinder(d=d, h=h, center=true);
    cube([d,d,h], center=true);
    translate([e,0,0])    
        cube([d,d,h], center=true);
    translate([0,e,0])
        cube([d,d,h], center=true);
}

module printText(d, scale) {
    linear_extrude(d)
        text(text = Text, font = TextFont, size=TextHeight, halign="center", valign="center");
}
