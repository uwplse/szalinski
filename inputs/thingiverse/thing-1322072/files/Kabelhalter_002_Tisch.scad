$desk_height = 40;
$width =  15;
$depth = 50;
$cable_diameter = 10;
$wall_thickness = 2;

rotate([90, 0, 0])
{

difference()
{
    cube([$depth + $wall_thickness * 2, $width, $desk_height + $wall_thickness * 2]);

    translate([-0.1, -$wall_thickness / 2, $wall_thickness])
    cube([$depth-$cable_diameter - $wall_thickness * 2, $width + $wall_thickness, $desk_height]);

    hull()
    {
        rotate([-90, 0, 0])
            translate([$depth - $cable_diameter / 2, -$cable_diameter / 2 - $wall_thickness * 2, -1])
                cylinder($width + $wall_thickness, $cable_diameter / 2, $cable_diameter / 2, $fn = 50);

        rotate([-90, 0, 0])
            translate([$depth - $cable_diameter / 2, -$desk_height - $wall_thickness * 2, -1])
                cylinder($width+2, $cable_diameter / 2, $cable_diameter / 2, $fn = 50);
    }
}

translate([0, 0, $wall_thickness])
    rotate([-90, 0, 0])
        cylinder($width, $wall_thickness, $wall_thickness, $fn = 50);

translate([0, 0, , $desk_height + $wall_thickness])
    rotate([-90, 0, 0])
        cylinder($width, $wall_thickness, $wall_thickness, $fn = 50);
}