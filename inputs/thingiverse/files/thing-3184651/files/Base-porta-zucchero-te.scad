$fn=36;

Render=0;      //0=Base    1=Vase support    2=Both
Base_diameter=66;
Base_thickness=5;
Column_diameter=5;
Columns_placement_radius=68;
Sugar_base_fit=40;
Vase_base_diameter=63;
Vase_base_thickness=10;


if(Render==0 || Render==2)
difference()
{

union()
{
translate([0,Columns_placement_radius,50])
cylinder(r=Column_diameter,h=100,center=true);

rotate([0,0,120])
translate([0,Columns_placement_radius,50])
cylinder(r=Column_diameter,h=100,center=true);

rotate([0,0,240])
translate([0,Columns_placement_radius,50])
cylinder(r=Column_diameter,h=100,center=true);

rotate([0,0,0])
translate([0,Columns_placement_radius,100])
sphere(r=Column_diameter);

rotate([0,0,120])
translate([0,Columns_placement_radius,100])
sphere(r=Column_diameter);

rotate([0,0,240])
translate([0,Columns_placement_radius,100])
sphere(r=Column_diameter);

difference()
    {
    union()
        {
        cylinder(r=Base_diameter,h=Base_thickness);
        }
    translate([0,0,2])
    cylinder(r=Sugar_base_fit,h=10);
    }

}

translate([0,0,97])
union()
{
difference()
    {
    union()
        {
        cylinder(r=Base_diameter,h=Vase_base_thickness);
        }
    cylinder(r=Vase_base_diameter,h=30,center=true);
    }

difference()
    {
    union()
        {
        cylinder(r=Base_diameter,h=3);
        }
    cylinder(r=Vase_base_diameter-10,h=30,center=true);
    }
}

}

if(Render==1 || Render==2)
{


translate([0,0,97])
union()
{
difference()
    {
    union()
        {
        cylinder(r=Base_diameter,h=Vase_base_thickness);
        }
    cylinder(r=Vase_base_diameter,h=30,center=true);
    }

difference()
    {
    union()
        {
        cylinder(r=Base_diameter,h=3);
        }
    cylinder(r=Vase_base_diameter-10,h=30,center=true);
    }
}

}