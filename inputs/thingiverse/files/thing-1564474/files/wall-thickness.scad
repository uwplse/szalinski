// Number of test strips to print (for averaging)
strips = 4; // [1:4]

// Height of the strips
height = 3.2; // [3.2, 6.4]

/* [hidden] */

a = 40; // Block length
b = 10; // Block spacings
d = a/25; // Taper amount (1 in 100 slope, divided by 4 surfaces)
e = 0.2; // Undercut width
f = 0.4; // Undercut height
g = b; // cutout centering
h = b; // Cutout width, roughly
i = 0.1; // Test strip increments

difference () {
    cube([a,b*(strips*2 + 1),height]);
    for (x=[0:strips-1]) {
        wedge = [[0,0],[0,b],[a,b+d],[a,0],[0,0]];
        adjusted_wedge = wedge + [[0,-i*x],[0,i*x],[0,i*x],[0,-i*x],[0,-i*x]];
        undercut_wedge = adjusted_wedge + [[0,-e],[0,e],[0,e],[0,-e],[0,-e]];
        translate([0,(2*x + 1)*b,height/4]) {
            linear_extrude(height=f) {
                polygon(undercut_wedge);
            };
            linear_extrude(height=height) {
                polygon(adjusted_wedge);
            };
        };
    };
}

for (x=[0:strips - 1]) {
    wedge = [[0,0],[0,b],[a,b],[a,-d],[0,0]];
    adjusted_wedge = wedge + [[0,-i*x],[0,i*x],[0,i*x],[0,-i*x],[0,-i*x]];
    translate ([a+10,(1 + 2*x)*b,0]) linear_extrude(height=height) polygon(adjusted_wedge);
}
