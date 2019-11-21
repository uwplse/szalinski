// Whole base is 105mm deep, 126mm wide (flexible)
// Front layer 20mm high, 105mm deep
// Mid layer 40mm high, 70mm deep
// Back layer 60mm high, 35mm deep

/* [Basic] */
// Total width of the stand in mm
width = 120;

// Preset bottle diameters
preset_dia = 35.0; // [32.2:Citadel, 48.5:Vallejo L, 35.0:Vallejo M, 24.5:Vallejo S, 28.25:P3, 0:Custom]

// Preset bottle insets
preset_inset = 15; // [5:Short pots (Citadel), 15:Longer bottles (Vallejo/P3), 0:Custom]

// Bottle diameter for Custom preset
custom_dia = 32.2;

// Bottle inset for Custom preset
custom_inset = 5;

/* [Advanced] */
// Extra diameter to add around bottle
tolerance = 2.0; // [0.0:5.0]

// Chamfer the edges by this radius. Warning: VERY slow and reduced quality.
chamfer = 0; // [0:1]



/* [Hidden] */
bottle_dia = (preset_dia == 0) ? custom_dia + tolerance : preset_dia + tolerance;
bottle_inset = (preset_inset == 0) ? custom_inset : preset_inset;

dia = bottle_dia + (chamfer*2);
inset = bottle_inset + chamfer;
w = width - (chamfer*2);
bottle_count = floor(w / (dia + 2));

module bottle_row(r, c, oy, w) {
    for (i = [1:c]) {
        x = (-w/2) + ((w / (c*2)) * (i*2-1));
        y = (r * 35) - 67.5 + oy;
        z = (r * 20) - inset;
        translate([x, y, z])
            cylinder(100, d=dia, true);
    }    
}

module build() {
    difference() {
        union() {
            translate([-w/2, -50+chamfer, 0])
                cube([w, 105-(chamfer*2), 20], false);
            
            translate([-w/2, -15+chamfer, 20])
                cube([w, 70-(chamfer*2), 20], false);
            
            translate([-w/2, 20+chamfer, 40])
                cube([w, 35-(chamfer*2), 20], false);
        }
        union() {
            bottle_row(1, bottle_count, (dia > 35) ? dia-35 : 0, w);
            if (dia > 35) {
                if (floor(w / (dia * (bottle_count+1))) > bottle_count) {
                    bottle_row(2, bottle_count+1, 0, w);
                } else {
                    bottle_row(2, bottle_count-1, 0, w-dia);
                }
            } else {
                bottle_row(2, bottle_count, 0, w);
            }
            bottle_row(3, bottle_count, (dia > 35) ? 35-dia : 0, w);
        }
    }
}


if (chamfer > 0) {
    // Increase this for better quality edges at the cost of VERY slow rendering.
    $fn = 18;
    minkowski() {
        build();
        sphere(r=chamfer);
    }
} else {
    $fn = 180;
    build();
}