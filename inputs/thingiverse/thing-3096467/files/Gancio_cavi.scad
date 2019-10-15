$fn=36;

Thickness_of_shelf=37;
Length_of_fork=30;
Distance_to_cables=80;
Passage_for_cables_radius=25;
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
cube([Distance_to_cables,Thickness_of_structure,Extrusion_height]);

translate([Distance_to_cables,Passage_for_cables_radius,0])
cylinder(r=Passage_for_cables_radius,h=Extrusion_height);

}


translate([Distance_to_cables,Passage_for_cables_radius,0])
cylinder(r=Passage_for_cables_radius-Thickness_of_structure,h=Extrusion_height*3,center=true);



}