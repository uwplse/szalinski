$fn=72;

Thickness_of_shelf=36.5;
Length_of_top_segment=20;
Passage_for_cables_radius=15;
Thickness_of_structure=6;
Extrusion_height=10;

difference()
{
union()
    {
cube([Thickness_of_structure,Length_of_top_segment,Extrusion_height]);
translate([Thickness_of_shelf+Thickness_of_structure,0,0])
cube([Thickness_of_structure,Passage_for_cables_radius+Thickness_of_structure,Extrusion_height]);

translate([0,0,0])
rotate([0,0,0])
cube([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2,Thickness_of_structure,Extrusion_height]);

difference()
{
       translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2,Passage_for_cables_radius+Thickness_of_structure,0])
    cylinder(r=Passage_for_cables_radius+Thickness_of_structure,h=Extrusion_height);

       translate([Thickness_of_shelf+Thickness_of_structure*2,-1,-1])
      cube([Passage_for_cables_radius,Passage_for_cables_radius+Thickness_of_structure,Extrusion_height+2]);

}

    }   //Fine union

// Tagli
    translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2,-1,-1])
        cube([0.5,Passage_for_cables_radius,Extrusion_height+2]);
    translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure-1,Passage_for_cables_radius+Thickness_of_structure,-1])
    rotate([0,0,90])
        cube([0.5,Passage_for_cables_radius,Extrusion_height+2]);

//Foro centrale passaggio_cavi
translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2,Passage_for_cables_radius+Thickness_of_structure,-1])
cylinder(r=Passage_for_cables_radius,h=Extrusion_height*3,center=true);

//Fori assemblaggio
translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure-5,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=1.25,h=30,center=true);

translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2+15,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=1.6,h=30,center=true);

translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2+15+3,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=3,h=30,center=true);

translate([Thickness_of_shelf+Thickness_of_structure*2,-Thickness_of_shelf-Thickness_of_structure,0])
union()
rotate([0,0,90])
{
translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2-10,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=1.25,h=30,center=true);

translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2+15,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=1.6,h=30,center=true);

translate([Thickness_of_shelf+Passage_for_cables_radius+Thickness_of_structure*2+15+3,Thickness_of_structure/2,Extrusion_height/2])
rotate([0,90,0])
cylinder(r=3,h=30,center=true);
}
}

//Shelf
*%translate([6.2,6.25,0])
cube([36,100,10]);