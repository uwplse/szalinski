$desk_height = 40;
$width =  20;
$depth = 70;
$cable_diameter = 20;
$wall_thickness = 2;
$radius_outer_edge = 10;
$radius_inner_edge = 5;

difference()
{
    rotate([90, 0, 0])
    {
        difference()
        {
            cube([$depth + $wall_thickness * 2, $width, $desk_height + $wall_thickness * 2 + $cable_diameter + $wall_thickness * 4]);

        rotate([-90, 0, 0])
            {
            translate([-0.1, -$desk_height - $wall_thickness * 6 - $cable_diameter - 0.1, -0.5])
            cube([$radius_outer_edge, $radius_outer_edge, $width + 1]);

            translate([0.1 + $depth + $wall_thickness * 2 - $radius_outer_edge, -$desk_height - $wall_thickness * 6 - $cable_diameter - 0.1, -0.5])
            cube([$radius_outer_edge, $radius_outer_edge, $width + 1]);

            translate([0.1 + $depth + $wall_thickness * 2 - $radius_outer_edge, -$radius_outer_edge + 0.1, -0.5])
            cube([$radius_outer_edge, $radius_outer_edge, $width + 1]);

            translate([0.1 + $depth + $wall_thickness * 2 - $radius_outer_edge, -$desk_height - $wall_thickness * 4 - 0.1, -0.5])
            cube([$radius_outer_edge, $radius_outer_edge, $width + 1]);
            }
        }

        rotate([-90, 0, 0])
        {
            translate([$radius_outer_edge, -$desk_height - $wall_thickness * 6 - $cable_diameter + $radius_outer_edge, 0])
            cylinder($width, $radius_outer_edge, $radius_outer_edge, $fn = 50);

            translate([$depth + $wall_thickness * 2 - $radius_outer_edge , -$desk_height - $wall_thickness * 6 - $cable_diameter + $radius_outer_edge, 0])
            cylinder($width, $radius_outer_edge, $radius_outer_edge, $fn = 50);

            translate([$depth + $wall_thickness * 2 - $radius_outer_edge, -$radius_outer_edge, 0])
            cylinder($width, $radius_outer_edge, $radius_outer_edge, $fn = 50);

            translate([$depth + $wall_thickness * 2 - $radius_outer_edge, -$desk_height - $wall_thickness * 4 + $radius_outer_edge, 0])
            cylinder($width, $radius_outer_edge, $radius_outer_edge, $fn = 50);    
        }
    }
    
    rotate([90, 0, 0])
    {
        translate([-0.1, -$wall_thickness / 2, $wall_thickness])
        cube([$depth - $wall_thickness - $radius_inner_edge, $width + $wall_thickness, $desk_height]);

        translate([0, -$wall_thickness / 2, $wall_thickness + $radius_inner_edge])
        cube([$depth - $wall_thickness, $width + $wall_thickness, $desk_height - $radius_inner_edge * 2]);

        hull()
        {
            rotate([-90, 0, 0])
                translate([$cable_diameter / 2 + $wall_thickness * 2, -$desk_height - $wall_thickness * 4 - $cable_diameter / 2, -1])
                    cylinder($width + 2, $cable_diameter / 2, $cable_diameter / 2, $fn = 100);

            rotate([-90, 0, 0])
                translate([$depth - $wall_thickness / 2 - $cable_diameter / 2, -$desk_height - $wall_thickness * 4 - $cable_diameter / 2, -1])
                    cylinder($width + 2, $cable_diameter / 2, $cable_diameter / 2, $fn = 50);
        }

        translate([$wall_thickness * 2 + $cable_diameter / 2, -0.5, $wall_thickness * 4 + $desk_height])
        cube([$depth, $width + 1, $cable_diameter / 2]);

        rotate([-90, 0, 0])
        {
            translate([$depth - $wall_thickness - $radius_inner_edge, -$radius_inner_edge - $wall_thickness, -0.5])
            cylinder($width + 1, $radius_inner_edge, $radius_inner_edge, $fn = 50);

            translate([$depth - $wall_thickness - $radius_inner_edge, -$desk_height - $wall_thickness + $radius_inner_edge, -0.5])
            cylinder($width + 1, $radius_inner_edge, $radius_inner_edge, $fn = 50);
        }
    }
}

rotate([90, 0, 0])
{
translate([0, 0, $wall_thickness])
    rotate([-90, 0, 0])
        cylinder($width, $wall_thickness, $wall_thickness, $fn = 50);

translate([0, 0, , $desk_height + $wall_thickness])
    rotate([-90, 0, 0])
        cylinder($width, $wall_thickness, $wall_thickness, $fn = 50);
}
