$fn=36;

Tool_thickness=10;
Tool_radius_1=25;
Tool_radius_2=20;
Tool_points_radius=3;
Socket_radius=6;
Square_size=5;
Square_height=10;


difference()
{
union()
{
hull()
    {
    cylinder(r=Socket_radius+3,h=Tool_thickness);
    
    translate([0,Tool_radius_1,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);

    translate([0,-Tool_radius_1,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);
    }

rotate([0,0,45])
hull()
    {
    cylinder(r=Socket_radius+3,h=Tool_thickness);
    
    translate([0,Tool_radius_2,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);

    translate([0,-Tool_radius_2,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);
    }

rotate([0,0,90])
hull()
    {
    cylinder(r=Socket_radius+3,h=Tool_thickness);
    
    translate([0,Tool_radius_1,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);

    translate([0,-Tool_radius_1,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);
    }

rotate([0,0,135])
hull()
    {
    cylinder(r=Socket_radius+3,h=Tool_thickness);
    
    translate([0,Tool_radius_2,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);

    translate([0,-Tool_radius_2,0])
    cylinder(r=Tool_points_radius,h=Tool_thickness);
    }


    cylinder(r=Socket_radius+3,h=Tool_thickness+3);
}

    translate([0,0,4])
    cylinder(r=Socket_radius,h=Tool_thickness);

}
translate([0,0,Tool_thickness/2])
cube([Square_size,Square_size,Square_height],center=true);