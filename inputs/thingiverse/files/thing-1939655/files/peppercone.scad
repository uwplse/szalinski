// The diameter at the bottom of the funnel
d0 = 25; // [5:.1:100]

// The diameter at the bend of the funnel
d1 = 30;  // [5:.1:100]

// The diameter at the top of the funnel
d2 = 70;  // [5:.1:100]

// The distance from the bottom of the funnel to the bend
h1 = 25;  // [5:.1:100]

// The distance from the bend of the funnel to the top
h2 = 30;  // [5:.1:100]

// The width of the slot
sw = 6;   // [5:.1:100]

// The thickness of the wall
th = 1.4; // [ .1:.05:5.0]


h1h2 = h1+30;

function reverse_inset_half_profile(p, dx) =
    concat(p, [for(i = [len(p)-1:-1:0]) [p[i][0]-dx, p[i][1]]]);

function half_profile() =
    [
        [d0/2, 0],
        [d1/2, h1],
        [d2/2, h1h2],
    ];

function profile() =
    reverse_inset_half_profile(half_profile(), th);

translate([0,0,h1h2])
rotate([180,0,0])
difference() {
    render() rotate_extrude(convexity=8) polygon(profile(), convexity=4);
    cube([100, sw, (h1-sw)*2], center=true);
    translate([0,0,h1-sw])
    rotate([0,90,0])
    cylinder(d=sw, h=100, center=true);
}
