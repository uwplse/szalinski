$fn = 128;

//front
fwidth = 50;
fheight = 50;
fz = 25;
roundness = 4;
//minkowski(){
	color("red") union(){
		rotate([90,0,0]) cube([fz, fwidth, fheight]);
		translate([20,0,0]) rotate([90,0,0]) cube([fz,fz,fwidth]);
	}
	//sphere(roundness);
//}

//back
bwidth = fwidth;
bheight = fheight/2;
blength = 80;
xd = 5; //extrusion difference (thickness of truck rim)
depth = 10;
color("red") rotate([0,0,180]) difference(){
	cube([blength, bwidth, bheight]);
	translate([xd,xd,depth]) cube([blength-2*xd, bwidth-2*xd, bheight+depth]);
}

//wheels
thickness = 10;
x = 15;
y = thickness/2;
z = 0;
i = 5;
wheelround = 1;
//minkowski() {
	difference(){
		color("black") translate([x,y,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/2);
		translate([x,y+i*1.5,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/4);
		translate([x,y-i*1.5,z]) rotate([90,0,0]) cylinder(h = i, r = fz/4);
	}
	//sphere(wheelround);
//}
//minkowski() {
	difference(){
		color("black") translate([x,y-fwidth,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/2);
		translate([x,y+i*1.5-fwidth,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/4);
		translate([x,y-i*1.5-fwidth,z]) rotate([90,0,0]) cylinder(h = i, r = fz/4);
	}
	//sphere(wheelround);
//}
//minkowski() {
	difference(){
		color("black") translate([x-blength,y,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/2);
		translate([x-blength,y+i*1.5,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/4);
		translate([x-blength,y-i*1.5,z]) rotate([90,0,0]) cylinder(h = i, r = fz/4);
	}
	//sphere(wheelround);
//}
//minkowski() {
	difference(){
		color("black") translate([x-blength,y-fwidth,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/2);
		translate([x-blength,y+i*1.5-fwidth,z]) rotate([90,0,0]) cylinder(h = thickness, r = fz/4);
		translate([x-blength,y-i*1.5-fwidth,z]) rotate([90,0,0]) cylinder(h = i, r = fz/4);
	}
	//sphere(wheelround);
//}