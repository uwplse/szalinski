stand_height = 90;
leg_radius = 30;
foot = 4;
border = 2;
tolerance = 1;
$fn = 100;

module stand(order)
{
    // real leg radius
    rlr = leg_radius-order*(border+tolerance);
    difference()
    {
        union()
        {
            translate([0, 0, stand_height-foot])
                cylinder(foot, rlr, rlr-foot);
            cylinder(stand_height-foot, rlr, rlr);
            cylinder(foot, rlr+foot, rlr+foot);
            translate([0, 0, foot])
                cylinder(foot, rlr+foot, rlr);
        }
        cylinder(stand_height-foot-border, rlr-border, rlr-border);
        translate([0, 0, stand_height-foot-border])
            cylinder(foot, rlr-border, rlr-border-foot);
    }
}

translate([0, 0, stand_height]) rotate([180, 0, 0]) stand(0);
//translate([0, 0, stand_height]) rotate([180, 0, 0]) stand(1);
//translate([0, 0, stand_height]) rotate([180, 0, 0]) stand(2);
