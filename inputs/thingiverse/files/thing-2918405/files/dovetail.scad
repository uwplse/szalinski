/*[Parameters]*/
//Type of dovetail
type = 6;//[4:1/4,5:1/5,6:1/6,7:1/7,8:1/8]
//Diam of magnet
magnet_d = 10;
//Height of magnet
magnet_h = 5;
icons = 0; //[0:no, 1:yes]
/*[Advanced]*/
//Magnet diam gap
gap_d = 0.1;
//Magnet diam height
gap_h = 0.2;
//Width of base
w = 50;
//Width of tower
w1 = 24;
//Height of base
h = 65;
//Height of tower
h1 = 20;
/*[Hidden]*/
$fn=32;
//icon size
i_h = w/5;
//text size
t_h = w1/3;
//text depth
t_d = 0.5;
a = atan2(1,type);
module pin(){
	translate([(w-w1)/2,(w-w1)/2,0])difference(){
		cube([w1,w1,h]);
		rotate([0,0,90-a])cube([w1*2,w1,h+1]);
		translate([w1,0,0]) rotate([0,0,a])cube([w1,w1*2,h+1]);
		translate([w1/2, w1/2, h-t_d]) rotate([0, 0, 90]) linear_extrude(1) text(str("1:",type), size = t_h, halign = "center", valign = "center");
	}
}
module base(){
	difference(){
	difference(){
		cube([w,w,h1]);
		rotate([0,a-90,0])cube([w,w,2*h1]);
	}
}
}
difference(){
	union(){
		base();
		pin();
	}
	translate([0,0,h1/2])holes();
	translate([0,w,h1/2])rotate([180,0,0])holes();
	rotate([0,a,0])translate([0,0,h1/2])rotate([0,0,90])rotate([180,0,0])holes();
	translate([w,0,h1/2])rotate([0,0,90])holes();
	if(icons){
		translate([w/2-i_h/2,w/10,0]) pins();
		translate([w/2+i_h/2,w*9/10,0]) rotate([0,0,180]) pins();
		translate([i_h+w/10,w/2-i_h/2,0]) rotate([0,0,90]) tails();
		translate([w*9/10,w/2-i_h/2,0]) rotate([0,0,90]) angle90();
	}
}
module holes(){
	delta = magnet_h+magnet_d/2+1;
	for(i = [delta,w-delta]){
		translate([i,-1,0])rotate([-90,0,0])cylinder(d = magnet_d+gap_d, h = magnet_h+gap_h+1);
	}
}
module pins(){
	ang = atan2(1,4);
	cube([i_h,1,1]);
	translate([0,i_h*.6,0])cube([i_h,1,1]);
	translate([i_h/8,1,0])rotate([0,0,90-ang])translate([0,-1,0])cube([i_h*.6,1,1]);
	translate([i_h*7/8,1,0])rotate([0,0,90+ang])cube([i_h*.6,1,1]);
}
module tails(){
	ang = atan2(1,4);
	cube([i_h,1,1]);
	translate([0,i_h,0])cube([i_h,1,1]);
	translate([0,1,0])rotate([0,0,90-ang])translate([0,-1,0])cube([i_h,1,1]);
	translate([i_h,1,0])rotate([0,0,90+ang])cube([i_h,1,1]);
}
module angle90(){
	cube([i_h,1,1]);
	cube([1,i_h,1]);
	translate([i_h/2+1,i_h/2+1,0])rotate([0,0,180])union(){
		cube([i_h/2+0.5,1,1]);
		cube([1,i_h/2+0.5,1]);
	}
}
