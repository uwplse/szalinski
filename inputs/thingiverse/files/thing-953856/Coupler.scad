shaft_diameter_a = 8;
nut_diameter_a = 15;
nut_length_a = 6.4;
shaft_length_a = 10;

shaft_diameter_b = 14.6;
nut_diameter_b = 5;
nut_length_b = 6.4;
shaft_length_b = 8;

coupler_mount_hole_diameter = 3.7;
coupler_extra_thickness = 1;

thickest_diam = shaft_diameter_a > shaft_diameter_b ? shaft_diameter_a : shaft_diameter_b;

translate([0,0,thickest_diam/2 + coupler_extra_thickness])
rotate([180,0,0])
{

    difference()
    {
        hull()
        {
            translate([
                        shaft_diameter_a + (1*coupler_extra_thickness) + coupler_mount_hole_diameter,
            -(shaft_length_a -coupler_extra_thickness),0])
            cylinder(r=coupler_extra_thickness,h=thickest_diam/2 + coupler_extra_thickness, $fn=28);

            mirror([1,0,0])
            translate([
                        shaft_diameter_a + (1*coupler_extra_thickness) + coupler_mount_hole_diameter,
            -(shaft_length_a -coupler_extra_thickness),0])
            cylinder(r=coupler_extra_thickness,h=thickest_diam/2 + coupler_extra_thickness, $fn=28);


            translate([
                        shaft_diameter_b + (1*coupler_extra_thickness) + coupler_mount_hole_diameter,
            (shaft_length_b -coupler_extra_thickness),0])
            cylinder(r=coupler_extra_thickness,h=thickest_diam/2 + coupler_extra_thickness, $fn=28);

            mirror([1,0,0])
            translate([
                        shaft_diameter_b + (1*coupler_extra_thickness) + coupler_mount_hole_diameter,
            (shaft_length_b -coupler_extra_thickness),0])
            cylinder(r=coupler_extra_thickness,h=thickest_diam/2 + coupler_extra_thickness, $fn=28);
        }

        color("Red")
        rotate([90,0,0])
        cylinder(r=shaft_diameter_a/2,h=shaft_length_a+1,$fn=shaft_diameter_a*5);

        color("Blue")
        rotate([-90,0,0])
        cylinder(r=shaft_diameter_b/2,h=shaft_length_b+1,$fn=shaft_diameter_b*5);

        /*
         *
         *  Mounting
         *
         */
        color("Green")
        translate([shaft_diameter_a/2 + coupler_extra_thickness + coupler_mount_hole_diameter*1.5,-shaft_length_a/2,0])
        cylinder(r=coupler_mount_hole_diameter/2,h=50,$fn=38);

        mirror([1,0,0])
        color("Green")
        translate([shaft_diameter_a/2 + coupler_extra_thickness + coupler_mount_hole_diameter*1.5,-shaft_length_a/2,0])
        cylinder(r=coupler_mount_hole_diameter/2,h=50,$fn=38);

        color("Green")
        translate([shaft_diameter_b/2 + coupler_extra_thickness + coupler_mount_hole_diameter*1.5,shaft_length_b/2,0])
        cylinder(r=coupler_mount_hole_diameter/2,h=50,$fn=38);

        mirror([1,0,0])
        color("Green")
        translate([shaft_diameter_b/2 + coupler_extra_thickness + coupler_mount_hole_diameter*1.5,shaft_length_b/2,0])
        cylinder(r=coupler_mount_hole_diameter/2,h=50,$fn=38);

        /*
         *
         *  Nut
         *
         */

        color("Red")
        translate([0,-shaft_length_a+nut_length_a - 0.2,0])
        rotate([90,0,0])
        cylinder(r=nut_diameter_a/2,h=nut_length_a,$fn=6);

        color("Blue")
        translate([0,shaft_length_b-nut_length_b + 0.2,0])
        rotate([-90,0,0])
        cylinder(r=nut_diameter_b/2,h=nut_length_b,$fn=6);
    }
}