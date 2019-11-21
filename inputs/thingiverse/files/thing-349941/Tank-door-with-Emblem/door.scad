// preview[view:south, tilt:top]

// Load a 100x100 pixel image.(images will be stretched to fit). Black and white images are best. Experiment with gray scale. More contrast is more difference in depth. Smooth edges look better
image_file = "icon.dat"; // [image_surface:100x100]

// Enter how thick the emblem will be on the door
emblem_bevel_scale = 1;

module door(scale)
scale([scale, scale, scale]){
{
rotate([0,0,90])
{
difference()
{
	cube([30.5,24,1.4]);
	translate([-4.5,0,-1])rotate([0,0,-45])cube(5);
	translate([-4.5,24,-1])rotate([0,0,-45])cube(5);
	translate([28,24,-1])rotate([0,0,-45])cube(5);
	translate([28,0,-1])rotate([0,0,-45])cube(5);
	translate([-8,-8,-40])cube(40);
}
translate([-1.45,2.53,0]) cube([1.45, 3.5,1.4]);
translate([-1.45,17.97,0]) cube([1.45, 3.5,1.4]);

translate([12+6.5/2,12,1.4])
scale([21/100, 21/100,emblem_bevel_scale])rotate([0,0,-90])surface(file=image_file, center=true, convexity=5);
}
}
}

door(0.98);