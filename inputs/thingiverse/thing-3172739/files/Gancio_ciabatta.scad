$fn=36;

Thickness_of_shelf=37;
Length_of_fork=30;
Plug_x=26;
Plug_y=52;
Thickness_of_structure=4;
Extrusion_height=10;


difference()
{

union()
{
cube([Thickness_of_structure,Length_of_fork,Extrusion_height]);
translate([Thickness_of_shelf+Thickness_of_structure,0,0])
cube([Thickness_of_structure,Length_of_fork,Extrusion_height]);

translate([0,0,0])
rotate([0,0,0])
cube([Thickness_of_shelf+Thickness_of_structure,Thickness_of_structure,Extrusion_height]);

translate([Thickness_of_shelf+Thickness_of_structure,0,0])
cube([Plug_x+Thickness_of_structure*2,Plug_y+Thickness_of_structure*2,10]);

}

translate([Thickness_of_shelf+Thickness_of_structure*2,Thickness_of_structure,-Extrusion_height/2])
cube([Plug_x,Plug_y,Extrusion_height*2]);

}