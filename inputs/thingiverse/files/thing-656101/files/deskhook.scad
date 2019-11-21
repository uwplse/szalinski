deskwidth = 39;
module deskhook()
{
	cube([10,50,40]);
	translate([10,40,0]) cube([40,10,40]);
	translate([50,-10,0]) cube([10,60,40]);
	translate([40,-10,0]) cube([10,10,40]);
	translate([-1*(deskwidth+10),0,0]) cube([deskwidth+10,10,40]);
	translate([-1*(deskwidth+10),10,0])cube([10,40,40]);
}
deskhook();