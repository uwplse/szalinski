length=100;
w=10;
d=1.5;
// holes
h_start=48;
h_space=8;
h_end=90;
border=d*0.9;
// Band
difference(){
	cube(size=[w,length,d]);
	for (hole=[h_start:h_space:h_end]) {
		translate([border, hole, 0]) {
			cube(size=[w-(2*border),border,d]);
		}
	}
}
// Endstueck
difference() {
	translate([-border,-w+border,0]) {
		cube(size=[w+(2*border),w-border,d]);
	}
	translate([0,-w+2*border,0]) {
		cube(size=[w,w-4*border,d]);
	}
}
// Nippel
translate([d,-w-(2*d),0]){
cube(size=[w-2*d,3*d,d]);
cube(size=[w-2*d,d,3*d]);
}