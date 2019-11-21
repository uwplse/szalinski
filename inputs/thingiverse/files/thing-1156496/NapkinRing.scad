//CUSTOMIZER VARIABLES

// Name or Text
Text = "TEXT";

// Adjust spacing between letters
Degrees = 15; //  [13,14,15,16,17]

//CUSTOMIZER VARIABLES END

module L_0(char = "A", Degrees = 15, i = 0) {
    rotate([0,0,-Degrees*i])
    translate([0,24,0])
    linear_extrude(height = 5)
    text(size = 12, text = char, font = "Chewy:style=bold", halign = "center", valign= "bottom", $fn = 32);
}

union() {
    difference() {
        cylinder(h = 5, r = 25, $fn = 64);
        translate([0,0,-0.1])
        cylinder(h = 5.2, r = 20, $fn = 64);
    }
    
    union() {
        for (i = [0:len(Text)-1]) {
            L_0(Text[i], Degrees, i);
        }
    }
}