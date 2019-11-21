hexDia=7.1;
clr=0.5;

tiers=4;
rPcs=9;

blkD=hexDia*1.6;
blkW=hexDia*1.4;
blkH=hexDia*1.9;
hInc=5;

main();

module main(){
	difference(){
		stack();
		for (r=[0:tiers-1])
			translate([r*blkD+blkD/2,rPcs*blkW/2,0])cube([2,rPcs*blkW+0.1,1],center=true);
		for(c=[0:rPcs-1])
			translate([tiers*blkD/2,c*blkD+blkW/2,0])cube([tiers*blkD+0.1,2,1],center=true);
	}
}

module stack(){
	for (r=[0:tiers-1]){
		difference(){
			translate([blkD*r,0,0])cube([blkD,blkW*rPcs,blkH+hInc*r]);
			translate([r*blkD+blkD/2,0,r*hInc]){
				if (round(r/2)*2==r) {
					row(rPcs);
				}else{
					translate([0,blkW/2,0])row(rPcs-1);
				}
			}
		}
	}
}

module row(pcs){
	for (p=[0:pcs-1]){
		translate([0,p*blkW+blkW/2,3])cylinder(r=hexDia/2+clr, h=blkH);
	}
}

