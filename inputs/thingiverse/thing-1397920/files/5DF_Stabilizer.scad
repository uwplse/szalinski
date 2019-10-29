stabilizer();

$fn = 50;
height = 1;
trace = 1.0;

arbor = 53; // Replicator, etc. = 53, Monoprice = 31;
gap	= 4;
//coreR = 34.25; 	// New
coreR = 33; 	// Old
lip = 2.5;
tabH = coreR+lip+2;
tabL = gap-0.5;

module stabilizer()
{
difference(){
	cylinder(height, arbor/2+2*trace, arbor/2+2*trace);
	cylinder(height, arbor/2, arbor/2);
	}
for(i=[0:3])
	{
	rotate([0,0,i*90]) union(){
	translate([gap/2,arbor/2+trace/2,0]) cube([trace*2, tabH-arbor/2-trace/2,height]);
	translate([gap/2 - tabL,tabH-2*trace,0]) cube([tabL+2*trace,2*trace,height]);
	translate([-gap/2-2*trace-0.5, coreR - 2*trace, 0]) cube([2*trace,lip,height]);
	translate([-gap/2-0.5-2*trace,coreR-2*trace-2*trace,0]) cube([gap+2*trace+0.5+2*trace,2*trace,height]);
		}
	}
}