//Parametric propeller using flat plates (with cylindrical end) for fins
//There are probably better ways to do this.
//Creative Commons license.

fs=1;  //default $fs is 2, is the min facet size
fa=4;  //default $fa is 12, is # of degrees per facet
trad=23.5; //outerradius not counting outw. 23.5 good
outw=1.5; //outerwidth. 1.5 is good
nfins=3; //number of fins. Min # is 2, but 3 is better
rins= 5; //radius of coupling thing, 5 is good
tdepth = 3; //depth of prop. reduce if nfins is big, 3 good
fangle = 40; //angle of fins, 40 is good for printing
tfin = 1; //thickness of fins, 1 is good

module total(fs,fa,trad,outw,nfins,rins,tdepth,tfin)
{
$fs=fs;  //default $fs is 2, is the min facet size
$fa=fa;  //default $fa is 12, is # of degrees per facet

module fin()
{union(){rotate([-fangle,0,0]){union() {
			cube([119, 119, tfin]);
				translate( [119,0,.5*tfin]){
rotate([0,-90,0]) cylinder (h=119,r=.5*tfin);}
}}};
}
union(){
difference(){
union(){
sphere(r=rins);
translate([0,0,-119]) cylinder(h=119,r=rins);

intersection(){
union(){
for (i = [0:(nfins-1)]) {
rotate([0,0,360*i/nfins]) fin();

		}
}
translate([0,0,-.5*119]) cylinder(h=119,r=trad);
}


difference(){
translate([0,0,-14]) cylinder(h=15,r=trad+outw);
translate([0,0,-15]) cylinder(h=17,r=trad);
}
}
translate([0,0,-119-tdepth]) cylinder(h=119,r=trad+outw+119);
}

	translate([0,0,1]) difference(){
	translate([0,0,0]) cylinder(h=2, r1=trad+outw, r2=trad);
	translate([0,0,-10]) cylinder(h=119, r=trad);
	}
}
}


//intersection(){

total(fs,fa,trad,outw,nfins,rins,tdepth,tfin);


