// make a stand to invert bottles
// dave312/20190615

$fn=120;

// diameter of the neck
neckD=29;						// [10:100]

// height of the neck
neckH=40;						// [10:100]

// height of the base (angled part)
standH=17;					    // [10:100]

// angle for the base
standA=40;						// [0:45]

// thickness of the walls
wall=3;							// [0:0.1:5]

standD=(tan(standA)*standH)*2+neckD;


rotate([0,180,0]) translate([0,0,-1*(neckH+standH)])
difference() {
	makeTube(standH,standD+2*wall,neckH,neckD+2*wall);
	makeTube(standH,standD,neckH,neckD);
	for(m=[0:90:180]) {
		rotate([0,0,m]) cube([wall*2,standD*2,standH],center=true);
	}
}

// makes a tube
module makeTube(myH1,myD1,myH2,myD2) {
	union() {
		cylinder(h=myH1,r2=myD2/2,r1=myD1/2);
		translate([0,0,myH1]) cylinder(h=myH2,r=myD2/2);
	}
}