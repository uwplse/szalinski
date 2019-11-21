//main radius
r=80;
//ball radius
br=4;
//revolutions count
n=5;
//angular step
s=2;
//initial radius
ir=6;
//border
border=3;
//floor thickness
floor=1;
nsteps=(360*n)/s;
rdelta=(r-ir)/nsteps;

difference()
{
	translate([0,0,-br-floor])cylinder(r=r+br+border,h=br+floor);
	for ( i = [0 : nsteps] )
		{
		
		rotate([0,0,s*i])translate([ir+(i*rdelta),0,0]) sphere(r=br);
		}
	
}