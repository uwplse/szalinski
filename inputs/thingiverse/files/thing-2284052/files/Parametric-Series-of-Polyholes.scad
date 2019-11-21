// A list of hole sizes (mm)
holes = [7.9,9.0,10.0,10.9,11.9,13.1,14.6,15.9,17.6];

// Diameter adjustment for your printer (mm)
offset = 0.25;

// The distance between holes, edges (mm)
spacing = 6;

// The overall depth of the part (mm)
thickness = 10;

function add(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180]) {
        radius = (d / 2) / cos(180 / n);
        cylinder(h = h, r = radius, $fn = n);
        echo(d, radius, n);
    }
}

difference() {
    cube(size = [add(holes) + spacing * (len(holes) + 1), max(holes) + spacing * 2, thickness]);
    union() {
        for(i = [0:len(holes) - 1]) {
            xloc = [ for(n = [0:i]) holes[n] ];
            translate([add(xloc) + spacing * (i + 1) - holes[i] / 2, max(holes) / 2 + spacing, -1]) {
                polyhole(h = thickness + 2, d = holes[i] + offset);
            }
        }
    }
}