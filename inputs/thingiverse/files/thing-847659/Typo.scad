// Requires Write.scad: http://www.thingiverse.com/thing:16193
use <write/Write.scad>;

text = "TYPO";
base = 2; // [0:None,1:Basic,2:Full]
gutter = 1; // [0:No,1:Yes]
font = "Orbitron.dxf"; // [Letters.dxf:Default,BlackRose.dxf:Black Rose,orbitron.dxf:Orbitron,knewave.dxf:Knewave,braille.dxf:Braille]

scale(10)
rotate([90, 0, 0])
union() {
    // Primary text shapes.
    difference() {
        for (i = [0 : len(text)]) {  
            rotate([0, i * (360 / len(text)), 0], "center")
            translate([.115, 0, len(text) / 2 - len(text) / 8 - .5])
            write(text[i], t = 0.535, center = true, font = font);
        }
        
        if (gutter)
            for (i = [0 : len(text)]) { 
                rotate([0, i * (360 / len(text)), 0], "center")
                translate([.115, 0, len(text) / 2 - len(text) / 8 - .3])
                linear_extrude(0.2)
                difference() {
                    offset(.05) {
                        projection() write(text[i], t = 0.535, center = true, font = font);
                    }
                    projection() write(text[i], t = 0.535, center = true, font = font);
                }
            }
    }
    
    // Base w/options
    if (base) {
        if (base == 1)
            base();
        
        if (base == 2)
            hull() {
                base();
            }
    }
}

// Base module.
module base() {
    for (i = [0 : len(text)]) { 
        rotate([0, i * (360 / len(text)), 0], "center")
        translate([0, -2, len(text) / 2 - len(text) / 8 - .5])
        cube([2.75, .1, .75], center = true);
    }
}