mainRadius = 25; //[15:50]
wallSize = 4; //[2:5]

res = 36 * 1;
handleRes = 24 * 1;

holeRadius = 1.5;
cutterWallSize = 0.75*wallSize;
cutterHeight = 35; //[20:50]

gap = 0.5 * 1;

module mainForm(bonusSize, height) {
	cylinder(r1 = mainRadius+bonusSize, r2=mainRadius+bonusSize, h=height, center=false, $fn = res);	

/*
$fn=50;
minkowski()
{
 cube([mainRadius+bonusSize,mainRadius+bonusSize,height], center=false);
 cylinder(r=mainRadius+bonusSize,h=height, center=false);
}
*/
}

module weller() {
union(){
	difference() {	
	mainForm(0,wallSize);
	for(n = [1 : 6])
	{
    	rotate([0, 0, n * 60])
    	{
if (n%2==0)
{
	        translate([max(0.6*mainRadius, 13.5),0,-1])
cylinder(r = holeRadius, h=wallSize+2, center=false, $fn = res);	
} else {
	        translate([max(0.7*mainRadius, 13.5),0,-1])
cylinder(r = holeRadius, h=wallSize+2, center=false, $fn = res);	
}
    	    
    	}
	}
}
	translate([0,0,wallSize]) 
		shaft(16);
	translate([0,0,wallSize+16]) 
		handle();	
	}

}

module cutter() {
	difference() {
		mainForm(cutterWallSize+gap,cutterHeight);
		mainForm(gap,cutterHeight);
	}
}

module shaft(height) {
	union() {
		cylinder(r1=10,r2=10, h=height, center=false,$fn = handleRes);
		cylinder(r1=12,r2=10, h=3, center=false,$fn = handleRes);
		translate([0,0,height])
			cylinder(r1=10,r2=5, h=3, center=false,$fn = handleRes);
		translate([0,0,height])
			cylinder(r1=8.5,r2=5, h=4.5, center=false,$fn = handleRes);
		translate([0,0,height])
			cylinder(r1=7,r2=5, h=6, center=false,$fn = handleRes);
	}
}

module 	handle() {
	union() {
		cylinder(r1=5,r2=5, h=50, center=false,$fn = res);
		translate([0,0,52])
			scale(v = [1, 1, .6]) { 
				sphere(r=10, ,$fn = handleRes);
			}
		
	}
}



weller();
cutter();