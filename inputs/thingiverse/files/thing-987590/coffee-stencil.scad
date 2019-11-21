// Font
Text = "xyz"; 

Font = "Allerta Stencil"; // [Allerta Stencil, Stardos Stencil, Sirin Stencil, Emblema One, Keania One, Passero One, Baumans, Expletus Sans, Plaster, Wallpoet, Codystar, Megrim]

// Spacing between characters
Spacing = 1.05; //[0.8, 0.85, 0.9, 0.95, 1, 1.05, 1.1, 1.15, 1.2]

// Font size
Size = 26; // [6:48]

// Stencil height
Height = 2; //[1,2,3]

// Stencil diameter (62 -- small cup, 83 -- mug)
Dia = 83; //[62,83]

module stencil() {
    union() {
        cylinder(d=Dia, h=Height, $fn=100);
        translate([Dia*0.5,0,Height/2]) cube([Dia*0.5, Dia*0.2, Height], center=true);
        translate([Dia*0.75,0,0]) cylinder(d=Dia*0.2, h=Height, $fn=100);
    }
}

difference() {

stencil();
    translate([0, 0, -1]) linear_extrude(height=Height+2) {
        text(size=Size, text=Text, font=Font, halign = "center", valign="center", spacing=Spacing, $fn=100);
    }
    translate([Dia*0.75,0,0]) cylinder(d=5, h=Height, $fn=100);
}
