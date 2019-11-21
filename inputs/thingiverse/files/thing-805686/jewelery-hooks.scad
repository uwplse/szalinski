$fn=20*1; // circle accuracy

E = 0.01*1; // small value used to avoid dumb roundings

/* [General] */

// Number of hooks
num_hooks = 6; // [2:30]

// Diameter of each hook peg (mm)
hook_dia = 7; // [2:30]

// margin around hooks in left-right dimension (mm)
x_margin = 10; // [2:20]

// margin around hooks in up-down dimension (mm)
y_margin = 4; // [2:20]

// length of each hook peg from base (mm)
hook_length=25; // [4:50]

// How thick is the base plate? (mm)
base_thickness = 3; // [1:10]

// What is the diameter of the two mounting holes (zero to disable)? (mm)
hole_dia = 3; // [0:15]

/* [Hook details] */

// how deep is the gap in the peg (zero for no gap)? (%)
gap_depth_percentage = 40; // [0:90]

// how far down onto the peg does the gap start? Must be greater than gap percentage B. (%)
gap_percentage_a = 90; // [70:100]

// how far down onto the peg does the gap end? Must be less than gap percentage A. (%)
gap_percentage_b = 70; // [0:70]

gap_a = gap_percentage_a/100 * hook_length;
gap_b = gap_percentage_b/100 * hook_length;
gap_depth = hook_dia*(0.5-gap_depth_percentage/100);

// How wide is the bottom triangluar support (zero for none)? (mm)
support_width=2;

total_width = (x_margin+hook_dia)*num_hooks+x_margin;
total_height = y_margin+hook_dia+y_margin;

translate([0,0,-base_thickness]) difference() {
    cube([total_width,total_height,base_thickness]);
    for (i = [0,num_hooks-2]) {
        x = x_margin*1.5 + hook_dia + i*(x_margin+hook_dia);
        y = y_margin + hook_dia/2;

        translate([x,y,-E]) cylinder(d=hole_dia, h=base_thickness*1.5);
    }
}

for (i = [0:num_hooks-1]) {
    x = x_margin + hook_dia/2 + i*(x_margin+hook_dia);
    y = y_margin + hook_dia/2;
    translate([x,y,0]) difference() {
        union() {
            cylinder(d=hook_dia,h=hook_length);
            rotate([0,-90,0]) translate([0,0,-support_width/2]) linear_extrude(support_width) polygon([
                [0,0],
                [hook_length,0],
                [0,-(y_margin+hook_dia/2)]
            ]);
        }
        rotate([0,-90,0]) translate([0,0,-hook_dia/2-0.5]) linear_extrude(hook_dia+1) polygon([
            [E,gap_depth],
            [E,hook_dia],
            [gap_a,hook_dia],
            [gap_a,hook_dia/2],
            [gap_b,gap_depth]
        ]);
    }
}