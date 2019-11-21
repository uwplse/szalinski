//Parametric propeller using an ellipse for the fin shape, twisted by an angle.
//There are probably better ways to do this.
//Creative Commons license.

fs=.2;   //.2 is good, 2 is for viewing, facet size
fa=4;	 //4 is decent, 12 is for viewing, deg per facet
fn=40;  //40 is good, 10 is for viewing
nslices=15; //15 is good, 5 is for viewing
trad=23.5; //outerradius not counting outw. 23.5 good
outw=1.5; //outerwidth. 1.5 is good
nfins=5; //number of fins. Min # is 2, but 3 is better
rins= 7; //radius of coupling thing, 5 is good
tdepth = 5; //depth of prop. reduce if nfins is big, 3 good
fangle = 60; //angle of fins, 60 is good for printing?
bevh = 2; // bevel height
tfin = 1; //thickness of fins, 1 is good
chrad = .4; //centering hole radius


module total(fs,fa,fn,nslices,trad,outw,nfins,rins,tdepth,fangle,bevh,tfin)
{  //.5, 4, 40, 12
$fs=fs;$fa=fa;$fn=fn;  //default $fs,$fa,$fn is 2,12,10,min facet size,deg.per facet,etc
module fin()
{union(){rotate([-fangle,0,0]){union() {
			cube([119, 119, tfin]);
				translate( [119,0,.5*tfin]){
rotate([0,-90,0]) cylinder (h=119,r=.5*tfin);}
}}};
}
module betterfin()
{
	rotate([90,0,90]) 
	linear_extrude(height=trad, center=false, convexity=10, twist=fangle, slices=nslices)
	scale([tfin/tdepth,1,1]) circle(r = tdepth);
}

union(){
	difference(){
		union(){
			sphere(r=rins);
			translate([0,0,-119]) cylinder(h=119,r=rins);
			difference(){
				translate([0,0,-14]) cylinder(h=15,r=trad+outw);
				translate([0,0,-15]) cylinder(h=17,r=trad);}
		}
		translate([0,0,-119-tdepth]) cylinder(h=119,r=trad+outw+119);
	}
	translate([0,0,1])
	difference(){
		translate([0,0,0]) cylinder(h=bevh, r1=trad+outw, r2=trad); //bevel
		translate([0,0,-10]) cylinder(h=119, r=trad);}		
	intersection(){
		union(){for (i = [0:(nfins-1)]){rotate([0,0,360*i/nfins]) betterfin();}	}
		translate([0,0,-.5*119]) cylinder(h=119,r=trad);}
}
}

difference(){ //This difference is to add a centering hole
	difference(){total(fs,fa,fn,nslices,trad,outw,nfins,rins,tdepth,fangle,bevh,tfin);
		//Difference so that it will print nice. Otherwise it wouldn't.
		translate([0,0,-119-3]) cylinder(h=119,r=119);} //This is to trim it flat
	translate([0,0,-119]) cylinder(h=119,r=chrad);  //centering hole
}

