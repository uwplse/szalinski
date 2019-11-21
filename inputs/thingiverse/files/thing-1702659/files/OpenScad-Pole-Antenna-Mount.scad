// **
// Saddle clamp/PVC pipe antenna mast mount by jaymzx
// http://www.thingiverse.com/thing:1702659 

// Remixed from http://www.thingiverse.com/thing:320124 by tonymtsai
// **

//The diameter of your pipe
pipe_d = 22.5; // 3/4" SCH 40 PVC = 22

//The lift your pipe from surface
pipe_lift = 0;

//Measurements for the screw

//Screw Thread Diameter, M8 bolt = 8.4
screw_d = 8.4;

//Screw Head Diameter, M8 bolt with 16mm OD (ISO 7089) washer = 16.5mm
screwh_d = 16.5; 

//Screw Countersunk depth
screw_trans = 0; // flat = 0

//Generate support for printing the bridge. 
support_d = 0;

//Thickness of the base
base_thickness = 8;

//Thickness of the structure
mount_t = 6; //mount thickness




base_thick = max(base_thickness,screw_trans);

pipe_r = pipe_d/2;

mount_d = screwh_d + mount_t *2 + 2; //mount depth, slightly wider for stronger support

mount_w = pipe_d + (mount_d + mount_t) * 2 ;  //mount wings width

mount_w_trust =  mount_w - mount_d + 2*sqrt(pow(mount_d/2,2)-pow(mount_d/2-mount_t,2));
    //mount trust width

pipe_rplus = pipe_r + mount_t;//outer pipe

$fn = 120;
module screw (){
	//head
	cylinder(h = 40, r = screwh_d/2, center=false);

	//transition
	
	translate([0,0, -screw_trans])
	cylinder(h = screw_trans, r2 = screwh_d/2, r1 = screw_d /2, center=false);

	//screw shaft
	translate([0, 0, -40- screw_trans])
	cylinder(h = 40, r = screw_d/2, center=false);

}


module trust(){

	//mount_w_trust = mount_w - 6;
	
	hull()
	{
		translate([0, 0, pipe_rplus + pipe_lift])
		rotate([-90, 0, 0])
		cylinder(r = pipe_rplus, h = mount_t, center=false);


		translate([-mount_w_trust/2, 0, 0])
		cube([mount_w_trust,mount_t,base_thick]);
	}
}

//Tunnel
module pipe(piper = pipe_r, heig = 20) {
	hull()
	{
		translate([0, 0, piper + pipe_lift])
		rotate([-90, 0, 0])
		cylinder(r = piper, h = heig, center=false);

		translate([-piper, 0, 0])
		cube([piper*2,heig,1]);
	}
}


module body_raw() {
	translate([-mount_w /2, 0, 0])
	cube([mount_w,mount_d , base_thick]);

	pipe(piper = pipe_rplus, heig = mount_d);

	trust();
	translate([0, mount_d- mount_t, 0])
	trust();
}

module body() {
	intersection() {
		body_raw();
		translate([-(mount_w -mount_d)/2, mount_d/2, 0])
		hull() {
			cylinder( h = pipe_rplus * 2+pipe_lift, r = mount_d/2, center=false);
			translate([mount_w-mount_d, 0, 0])
			cylinder( h = pipe_rplus * 2+pipe_lift, r = mount_d/2, center=false);
		}
	}
}


difference()
{
	body();
	
	//internal pipe
	translate([0, support_d,0])
	pipe(pipe_d/2,mount_d-support_d * 2);
	
    translate([pipe_rplus + mount_d/2, mount_d /2, base_thick])
    #screw();

	translate([-pipe_rplus - mount_d/2, mount_d /2, base_thick])
	#screw();
 
 // echo size parameters   
    echo (hole_pitch=(pipe_rplus + mount_d/2) *2);
    echo (mount_width=mount_w);
    echo (mount_depth=mount_d);
}


