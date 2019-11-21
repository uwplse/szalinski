/* Strainer by Simon Peters */
/* Available under Creative Commons Share-alike licence */
/*[Global]*/
//Strainer thickness
thick = 1; //[2:10]	
// Outer radius
o_rad = 50; //[20:200]
// Inner radius
i_rad = 35;	//[20:200]
// Strainer hole radius
h_rad = 1;	 //[0.5:10]
// Hole circle radius pitch
h_r_pitch = 4; //[1:30]
// Hole circle circumference pitch
h_c_pitch = 4; //[1:30]
// Drainer Dip Depth
dipdepth = 18; //[0:100]

/*[Hidden]*/
pi = 3.14159;
real_i_rad=floor(i_rad/h_r_pitch)*h_r_pitch;
hthick=h_r_pitch/real_i_rad*dipdepth;


function circ(r)=2*pi*r;
function nh(r) = floor(circ(r) / h_c_pitch);

difference(){
	create_disk();
	create_holes();
}
module create_holes() {
//$fn=12;
	for (r = [0 : h_r_pitch : real_i_rad ]) {
		translate([0,0,0-(dipdepth+1)]) {
			cylinder(h=thick+dipdepth+2,r=h_rad);
			for (c = [0 : circ(r)/nh(r): circ(r) ]) {	
				translate ([sin((c/circ(r))*360)*r,cos((c/circ(r))*360)*r, 0]) {
					cylinder(h=thick+dipdepth+2,r=h_rad);
				}
			}
		}
	}
}
module create_disk() {
		rotate_extrude(convexity=36)
		polygon(points=[[0,0-dipdepth],[real_i_rad,0],[o_rad,0],[o_rad,thick],[real_i_rad,thick],[0,thick-dipdepth]],paths=[[0,1,2,3,4,5]]);
}