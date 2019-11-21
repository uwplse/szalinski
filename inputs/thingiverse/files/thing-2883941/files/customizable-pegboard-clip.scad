//
// Customizer UI
//

// (mm) distance between nearby pegboard's holes
hole_spacing = 24.4;
L = hole_spacing;

// (mm) diameter of a pegboard's hole
hole_diameter = 6.35;
D = hole_diameter;

// (mm) diameter of a pegboard's hook
hook_diameter = 6.35;
d = hook_diameter;

// (mm) width of the clip; must be smaller than the diameter of a pegboard's hole
clip_width = 4;
W = clip_width;

// 0-90; pick smaller values for more rigid plastic
spring_angle = 10;
a = spring_angle;

// (mm) extra space to allow for the spring action
spring_space = 1;
x = spring_space;

// (mm) thickness of the clip's round part
bend_thickness = 2;
w = bend_thickness;

// (mm) thickness of the clip's long parts
leg_thickness = 2;
v = leg_thickness;

// (mm) thickness of the clip's hook
hook_thickness = 2;
u = hook_thickness;

// (mm) size of the clip's hook; must be larger than the pegboard's thickness
clip_hook_size = 2;
h = clip_hook_size;

// (mm) size of the notch on the clip's hook
clip_hook_notch = 2;
n = clip_hook_notch;

// number of round part's fragments; more is smoother, but slower
bend_fragments = 48; // [24, 32, 48, 72, 96]
$fn = bend_fragments;

//
// Convenience variables
//

m = D/100;
R = D/2;
r = d/2;
s = r + w;
y = (D - sqrt(D*D - W*W))/2;
l = L - r - R + y;

//
// Scene
//

union()
{
    ClipLeg();

    ClipBend();

    mirror([1, 0, 0])
    ClipLeg();
}

//
// Parts of the clip
//

module ClipLeg()
{
    rotate([0, 0, a])
    union()
    {
        // Straight part
        linear_extrude(height = W)
        translate([r, -(r + x)])
        polygon([
            [0, 0],
            [l + u, 0],
            [l + u, v],
            [w, v],
            [w, r + x + m],
            [0, r + x + m]
        ]);

        // Hook
        translate([r + l + u, -(r + x), 0])
        translate([R - (n + u), -h, W/2])
        rotate([90, 0, 0])
        difference()
        {
            union()
            {
                hull()
                {
                    union()
                    {
                        cylinder(h = m, d = D);

                        translate([R + u - m, 0, u/2])
                        cube([m, D, u], center = true);
                    }

                    translate([u, 0, u - m])
                    cylinder(h = m, d = D);
                }

                translate([n, 0, -(h + m)])
                cylinder(h = m + h + m, d = D);
            }

            translate([n + u + R, 0, 0])
            cube(2*D, center = true);

            translate([0, D + W/2, 0])
            cube(2*D, center = true);

            translate([0, -(D + W/2), 0])
            cube(2*D, center = true);
        }
    }
}

module ClipBend()
{
    mask = [
        [s, 0],
        [s, -s],
        [-s, -s],
        [-s, 0]
    ];

    linear_extrude(height = W)
    difference()
    {
        circle(r = s);

        circle(r = r);

        rotate([0, 0, a])
        polygon(mask);

        rotate([0, 0, -a])
        polygon(mask);
    }
}
