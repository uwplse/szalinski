// Greg's Wade reloaded - Guidler, Tilt Screws, Fishbone Gears
//mod (c)g3org bowden universal adapter for normal fittings like M10



//manigofset
manigofset=0.1;

// screw distance
screwdist=50;

//dinameter monting screw
mounting_screw=3;

//lenght
mount_length=60;

//width
mount_width=25;

//Material thickness
thickness=7;


//fittingdiameter M10? 
fittingdiameter=10.1;
fitting_screw_deep=5.5;



//hotend_diameter  only the value
hotend_diameter=16;

// hotend_thickness only the value
hotend_thickness=5;

//filament hole
filament_hole=2.5;


$fn=50*1;

// Plate

module plate();{
	difference(){
		cube([mount_length,mount_width,thickness],center=true);
		translate([0,0,-thickness/2])	cylinder(h = fitting_screw_deep, r=fittingdiameter/2);



//Bohrung1	
		translate([screwdist/2,0,0])		cylinder(h = thickness+manigofset, r=mounting_screw/2,center=true);
//Bohrung2
		translate([-screwdist/2,0,0])		cylinder(h = thickness+manigofset, r=mounting_screw/2,center=true);

//		translate([0,0,0])		cylinder(h = thickness+hotend_thickness+manigofset, r=fittingdiameter/2,center=true);

		rotate([90,30,0]){
			translate([0,0,0]){	
					cylinder(h = mount_width/2+manigofset, r=1.75);
					cylinder($fn = 6,h=8,r=3);
			}
		}
	}
}

module fittingmount();{
	difference(){
//wade extruder diameter
		translate([0,0,thickness/2])		cylinder(h = hotend_thickness, r=hotend_diameter/2);
//fitting diameter
		translate([0,0,thickness/2]){
			cylinder(h = hotend_thickness+thickness, r=filament_hole/2);
		}
		
	}
}





