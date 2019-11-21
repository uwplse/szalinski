
bar_width = 114;
bar_depth = 6.5;   // normal is ~5
bar_heigh = 14.1;

screw_r1 = 5.45/2;
screw_h1 = 2.66;
screw_r2 = 10.45/2;
screw_h2 = 5-2.66;

screw_offx = 19.33+5.45/2;
screw_offy = 3.89+5.45/2;

chopsize = 1;


// the main bar
rotate([0,0,45])
difference()
{
    // the bar (base)
    linear_extrude(height=bar_depth)
        square([bar_width,bar_heigh]);

    // cutout the screw holes
    for(i=[screw_offx, bar_width-screw_offx]) translate([i,screw_offy,0]) union()
    {
        cylinder(h=screw_h1+0.1, r=screw_r1, $fn=18);
        translate([0,0,screw_h1]) cylinder(h=screw_h2, r1=screw_r1, r2=screw_r2, $fn=18);
        translate([0,0,screw_h1+screw_h2])
            cylinder(h=bar_heigh-screw_h2-screw_h1+0.1, r=screw_r2, $fn=18);
    }

    // cutout the bottom rounded area
    translate([-0.1,-0.1,-0.1])
    rotate([0,90,0]) rotate([0,0,90]) linear_extrude(height=bar_width+0.2)
        polygon(points=[[0,0], [0,chopsize], [chopsize,0]], paths=[[0,1,2]]);

    // round off the top
    translate([-0.1,bar_heigh/2,bar_depth+0.2]) rotate([0,90,0]) scale([0.2,1,1])
        cylinder(h=bar_width+0.2, r=(bar_heigh-3)/2, $fn=40);
}


