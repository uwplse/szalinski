// Dual head ditto printing, 0 for false, 1 for true
ditto=0;
//Width of chainmail
x_dim=220;
//Length of chainmail
y_dim=140;
// thickness
T=2;
// vertical spacing
vtol=0.6;
// number of links between nozzles
np=3;
// for ditto printing, also controls size of links
nozzle_separation=33;
// cut width for open links
gap=0.2;

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 220; //[100:400]
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

pitch=nozzle_separation/np;
w=pitch-(pitch/2-2*T)/2;
echo(w);

if(ditto)
	dittomesh(stripes=round(x_dim/(np*2*pitch)-0.5-1/(4*np)),m=round(y_dim/pitch-1));
else
	mesh(n=round(x_dim/pitch-1),m=round(y_dim/pitch-1));

module dittomesh(stripes,m)
for(i=[1:stripes])assign(o= i==stripes ? 1 : 0)
	translate([(i-stripes/2-1/4)*np*2*pitch,0,0])mesh(np,m,openX=o);

module mesh(n=2,m=2,openX=1,openY=1){
translate([pitch/4,pitch/4,T/2])grid(n,m,openX,openY);
translate([-pitch/4,-pitch/4,T/2])grid(n,m);
}

module grid(n=2,m=2,openX=0,openY=0)
for(i=[1:n]){
	for(j=[1:m]){
		assign(open= ((i==n && openX) || (j==m && openY)) ? 1 : 0)
		translate([(i-n/2-1/2)*pitch,(j-m/2-1/2)*pitch,0])link(open);
	}
}

module link(open=0)
difference(){
	cube([w,w,T],center=true);
	translate([0,0,T/2-vtol/2])cube([w+T,w-2*T,T],center=true);
	translate([0,0,-T/2+vtol/2])cube([w-2*T,w+T,T],center=true);
	translate([w/2,-w,vtol/2])rotate([0,-45,0])cube(2*w);
	translate([-w/2,-w,vtol/2])rotate([0,-45,0])cube(2*w);
	translate([-w,w/2,-vtol/2])rotate([-135,0,0])cube(2*w);
	translate([-w,-w/2,-vtol/2])rotate([-135,0,0])cube(2*w);
	if(open==1)translate([w,0,0])cube([2*w,gap,2*T],center=true);
}
