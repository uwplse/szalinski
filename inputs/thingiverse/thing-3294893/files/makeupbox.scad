nbx=5;
nby=4;
sz=20;
wallsize=1;
myh=70;

difference()
{
	for (x = [0:nbx])
		for (y = [0:nby])
			translate([x*(sz+wallsize*2), y*(sz+wallsize*2), 0]) difference()
			{
				cube([sz+wallsize*2, sz+wallsize*2, myh]);
				translate([wallsize, wallsize, wallsize]) cube([sz, sz, myh]);
			}
	translate([-1, 0, myh]) rotate([-20, 0, 0]) cube([nbx*sz*2, nby*sz*2, myh]);
}
