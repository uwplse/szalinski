
// Outer (max) Diamater of the nut to upgrade
nut_diam=10.8;
// Height of the nut to upgrade
nut_height=3;
// Diamater of the screw
screw_diam=3;
// Diamater of the desired thumbwheel
wheel_diam=30;
// Full Height of the desired thumbwheel (including nut collar)
wheel_height=6;
// Thickness of the desired thumbwheel
wheel_thick=4;
// Number of major graduations around the thumbwheel (ie: for M3 screws the pitch is 0.5mm so 5 graduations will give you 0.1mm / graduation)
grad_num=5;

/* [Hidden] */

$fn=100;

lip_height=0.5;
lip_thick=0.1;

press_fit=0.05;

engrave_depth=0.5;

grip_num=18;
grip_diam=1.5;

grad_sub=4;
mgrad_diam=1.5;
grad_diam=wheel_diam*0.7;

recess_diam=wheel_diam*0.9;
recess_height=0.3;


module chamfertool(diam)
{
	difference()
	{
		cylinder(d=diam, h=diam/2);
		cylinder(d1=diam,d2=0, h=diam/2);
	}
}

module grips()
{
	for (i=[0:grip_num])
	{
		rotate(360/grip_num*i) translate([wheel_diam/2,0,0]) union()
		{
			cylinder(wheel_thick,d=grip_diam);
			// scale([1,0.8,1]) {
			// 	translate([0,0,grip_diam/2]) sphere(d=grip_diam,center=true,$fn=10);
			// 	translate([0,0,grip_diam/2]) cylinder(wheel_thick-grip_diam,d=grip_diam);
			// 	translate([0,0,wheel_thick-grip_diam/2]) sphere(d=grip_diam,center=true,$fn=10);
			// }
		}
	}
}

module main_grad(engr_plane,num,diam)
{
	translate([diam/2-mgrad_diam/2,0,engr_plane-engrave_depth]) cylinder(engrave_depth*2,d=mgrad_diam*0.85);
	for (i=[0:num]) // Main
	{
		rotate(360/num*i) translate([diam/2,0,engr_plane]) scale([2,1,1]) cylinder(engrave_depth*2,d=mgrad_diam,$fn=3,center=true);
	}
}

module sub_grad(engr_plane,num,sub,diam)
{
	rotate(360/(num*sub))
	for(j=[0:(sub-2)]) // Sub
	{
		rotate(360/(num*sub)*j)
		for(i=[0:num])
		{
			rotate(360/num*i) translate([diam/2,0,engr_plane]) cube([grip_diam,grip_diam/4,engrave_depth*3],center=true);
		}
	}
}

module recess()
{
	difference()
	{
		cylinder(recess_height*2,d=recess_diam,center=true);
		cylinder(wheel_height,d=nut_diam+2,center=true);
	}
}

difference()
{
	union()
	{ // body
		cylinder(wheel_thick,d=wheel_diam);
		cylinder(wheel_height,d=nut_diam+2);
		grips();
	}
	// cutouts
	translate([0,0,wheel_height-nut_height-lip_height]) cylinder(nut_height,d=nut_diam-press_fit); // bolt recess
	translate([0,0,wheel_height-lip_height-0.5]) cylinder(nut_height,d=nut_diam-press_fit-lip_thick); // bolt entry
	translate([0,0,-0.5]) cylinder(wheel_height+1,d=screw_diam+0.5); // vent => all through
	// recess
	translate([0,0,wheel_thick]) recess(); // top
	// chamfer
	translate([0,0,wheel_thick-2]) chamfertool(wheel_diam+grip_diam+1); // top
	translate([0,0,wheel_thick-2]) rotate([0,180,0]) chamfertool(wheel_diam+grip_diam+1); // bottom
}
// graduations
main_grad(wheel_thick-recess_height,grad_num,grad_diam); // main
sub_grad(wheel_thick-recess_height*2,grad_num,grad_sub,grad_diam); // sub
