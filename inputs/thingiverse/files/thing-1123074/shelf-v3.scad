
shelf_height=17.5;		//Height from center of "axle" Default 17.5
shelf_width=45;			// Default 45
shelf_length=45;		// Default 45
axle_diameter=6;		//Default 6
axle_width=1.7;			// Default 1.7
thickness=2;			// Default 2
//
number_x=1;		//////
number_y=1;		//////
//
distance_to_window=2;			// Default 2

tolerance=0.7;			// Default 0.7
cup_size=35;			// 




$fn=50;


module shelf()
{
// Shelf


translate([-shelf_width/2,0,shelf_height])
cube([shelf_width, shelf_length, thickness]);

difference()
{
hull()
{

// Suction Cup Connection


translate([0,distance_to_window + axle_width/2,0])
rotate([90,0,0])
cylinder(r=axle_diameter*2, h=axle_width, center=true);

// Legs


translate([-shelf_width/2, distance_to_window,shelf_height])
cube([shelf_width, axle_width, thickness]);


}

// Notch

translate([0,(distance_to_window + axle_width/2 ),0])
rotate([90,0,0])
cylinder(r=(axle_diameter + tolerance)/2, h=axle_width+2, center=true);


translate([-(axle_diameter+tolerance)/2, distance_to_window-1, -axle_diameter*2])
cube([axle_diameter + tolerance, axle_width+2, axle_diameter*2]);
}


// support

difference()
{

// FIX THIS FOR LARGER SHELF HEIGHT
translate([-axle_width/2,distance_to_window+axle_width,axle_diameter/2+tolerance/2])
cube([axle_width,cup_size/2+axle_diameter/2-thickness,shelf_height-(axle_diameter/2)]);


translate([0,shelf_height + distance_to_window + axle_width,tolerance/2])
rotate([0,90,0])
cylinder(r=shelf_height,h=axle_width+2, center=true);
}

}

//--------------------------------------------------------

for (i=[0:number_x-1], j=[0:number_y-1])
{

translate([i*(shelf_width+5), j*(shelf_length+5),shelf_height + thickness])
rotate([0,180,0])
shelf();


}
