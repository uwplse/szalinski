// Length of your business card. I would recommend giving an extra 1mm buffer over what you measured.
CardLength = 93;
// Breadth of your business card. I would recommend giving an extra 1mm buffer over what you measured.
CardBreadth = 57;
// Text
Text = "CORT";
// Font size
FontSize = 15;
// Clearance affects how tightly the two halves fit together. The smaller it is, the tighter it'll fit
Clearance = 0.5;

/* [Hidden] */
$fa = 6;
$fs = 0.5;

difference() {
    linear_extrude(height=CardLength+3)
        polygon([[0,0], [CardBreadth+3,0], [CardBreadth+4,5], [-1,5]]);
    union() {
        translate([1.5,1.5,1.5])
            cube([CardBreadth, 3.6, CardLength]);
        translate([(CardBreadth+3)/2,-0.1,20])
            rotate([-90,0,0])
                union() {
                    cylinder(h=2, r=10);
                    translate([0,-25,0])
                        cylinder(h=2, r=10);
                    translate([-10,-25,0])
                        cube([20,25,2]);
                }
    }
}
//
translate([-10,7,0])
rotate([0,0,180])
difference() {
    union() {
        linear_extrude(height=CardLength+3)
            polygon([
                [-3.5,7], [-3.5,0], [-1*Clearance,0], [-2,5.5], 
                [CardBreadth+5,5.5], [CardBreadth+3+Clearance,0], [CardBreadth+6.5,0], [CardBreadth+6.5,7]
            ]);
        translate([(CardBreadth+3)/2,5.5,3])
        rotate([0,90,0])
        cylinder(h=3, r=1.5, center=true);
        translate([(CardBreadth+3)/2,5.5,CardLength])
        rotate([0,90,0])
        cylinder(h=3, r=1.5, center=true);
    }
    translate([(CardBreadth+3)/2, 5.1, 25])
        rotate([-90,0,0])
            linear_extrude(height=2)
                text(Text, font="Stencilia\\-A:style=Regular", size=FontSize, halign="center", valign="center");    
}

