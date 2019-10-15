/* [Main Dimensions] */
// Smoothness
smoothness=50; // [25:5:100]

// Inner diameter (mm)
inner_diameter=3; // [0.5:0.1:10]

// Height (mm)
outer_height=5; // [1:0.1:10]

// Thickness (mm)
thickness=0.4; //[0.4:0.1:1]

$fn = smoothness;
outer_diameter = inner_diameter + thickness * 2;
inner_height = outer_height - thickness;

module bullet(d, h) {
    r = d/2;
    translate([0,0,h - r])
    sphere(r = r);
    cylinder(r = r, h = h - r);
}    

difference() {
    bullet(d=outer_diameter, h=outer_height);

    translate([0,0,-0.01])
    bullet(d=inner_diameter, h=inner_height);    
}
