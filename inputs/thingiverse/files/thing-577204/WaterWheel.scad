
n_slats = 6; //number of blades in the wheel
r_wheel = 30; //overall radius of the wheel
t_wheel = 3; //thickness of the wheel
rot = 360/n_slats; //angle of rotation for the chosen number of slats
s_thick=2; //thickness of the wheel blades
s_width=15; //width of the blades
h_blade=80; //lenght of the blades
h_nut = 20; //length of the piece that turns the wheel
nut_size = 10; //radius of the piece that turns the wheel

blade();
//wwheel();

module blade(){
cube([s_width,h_blade,s_thick],center=true);
}

module wwheel(){
	difference(){
		union(){
			wheel();
			nut();
		}
		slats();
	}
}

module slats(){
for (i=[1:n_slats]){
	rotate([0,0,rot*i]){
		translate([0,r_wheel-s_width+5,0]){
			cube([s_thick+0.6,s_width+0.6,100],center=true);
		}
	}
}
}

module wheel(){
translate([0,0,t_wheel/2]){
for (i=[1:n_slats]){
	rotate([0,0,rot*i]){
		translate([0,r_wheel/2,0]){
			cube([s_thick*2+0.6,r_wheel,t_wheel],center=true);
		}
	}
}
}
}

module nut(){
$fn=5;
translate([0,0,h_nut/2]){
cylinder(h=h_nut,r=nut_size,center=true);
}
}