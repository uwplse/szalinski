th=3; //thickness and inter-distance
lr=50; // spiral radius
ma=0.01; //margin for union
$fn = 30; //fragments, only increase before rendering, use even and integer divider of 360 for best results

    union()
    {
        translate([0,th,0])
        sphere(d=th,center=true);
        
        difference()
        {
            for(a=[th:2*th:lr])
            rotate_extrude(convexity = 10,$fn = 60)
            translate([a, 0, 0])
            circle(d = th,$fn=20);

            translate([ma,-lr-th/2,-th/2-ma])
            cube([lr,2*lr+th,th+2*ma]);
        };

        translate([0,th,0])
        rotate([0,0,180])
        difference()
        {
            for(a=[2*th:2*th:lr])
            rotate_extrude(convexity = 10,$fn = 60)
            translate([a, 0, 0])
            circle(d = th,$fn=20);

            translate([ma,-lr-th/2,-th/2-ma])
            cube([lr,2*lr+th,th+2*ma]);
        };
        
    };