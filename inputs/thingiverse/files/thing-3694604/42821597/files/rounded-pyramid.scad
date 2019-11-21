$fn = 64;

pyramidRounded();

module pyramidRounded(d=[40,60,20,30],h=30,r=[2,2,2.5,2.5]){
	not=0.0001;
	_d = [d[0],d[1],d[2],d[3]];
	_r0 = r[0]<=0 ? not : r[0];
	_r1 = r[1]<=0 ? not : r[1];
	_r2 = r[2]<=0 ? not : r[2];
	_r3 = r[3]<=0 ? not : r[3];

	rotate_extrude() hull() {
		intersection(){
			translate([_d[0]/2+_r0, _r0, 0]) circle(r = _r0);
			translate([_d[0]/2,0,0]) square([_r0,2*_r0]);
		}
		difference(){
			translate([_d[1]/2-_r1, _r1, 0]) circle(r = _r1);
			translate([_d[1]/2,0,0]) square([r[1],2*r[1]]);
		}
		intersection(){
			translate([_d[2]/2+_r2, h-_r2, 0]) circle(r = _r2);
			translate([_d[2]/2,h-2*_r2,0]) square([_r2,2*_r2]);
		}
		intersection(){
			translate([_d[3]/2-_r3, h-_r3, 0]) circle(r = _r3);
			translate([_d[3]/2-_r3,h-2*_r3,0]) square([_r3,2*_r3]);
		}
	}
}
