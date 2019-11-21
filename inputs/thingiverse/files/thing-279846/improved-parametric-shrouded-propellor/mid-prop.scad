//Parametric propeller using an ellipse for the fin shape, twisted by an angle.
// Derived from http://www.thingiverse.com/thing:116974 by Robotbeat
// Updated by Kevin Osborn (http://baldwisdom.com) to improve variable documentation
// 	changed fin attachment to a cylinder, with an optional spherical "hubcap"
//Creative Commons license.

// preview[view:south, tilt:top]

// ring radius
trad=32; //outerradius not counting outw. 23.5 good
// ring thickness
outw=1.5; //outerwidth. 1.5 is good
// outer ring bevel height
bevh = 2;

//hub radius
rins= 5; //radius of coupling thing, 5 is good
// shaft radius including tolerance. 1.2 works well for 2mm motor shafts
chrad = 1.2; 
//hub style -- 0 is none, 1 is sphere hubcap
hubstyle = 1; //[0,1]
// fin parameters
// number of fins
nfins=5; //number of fins. Min # is 2, but 3 is better
// prop depth, reduce if nfins is big
tdepth = 5; 
// fin angle > 60 may have too much overhang for printing
fangle = 60;
// fin thickness
tfin = 1; 


/* [rendering resolution */
//facet size
fs=.2;   //.2 is good, 2 is for viewing, facet size
//facet angle
fa=4;	 //4 is decent, 12 is for viewing, deg per facet
//number of facets
fn=40;  //40 is good, 10 is for viewing
//slices for twist in fin
nslices=15; //15 is good, 5 is for viewing


module total(fs,fa,fn,nslices,trad,outw,nfins,rins,tdepth,fangle,bevh,tfin,hubstyle)
{  //.5, 4, 40, 12
$fs=fs;$fa=fa;$fn=fn;  //default $fs,$fa,$fn is 2,12,10,min facet size,deg.per facet,etc

union(){
	difference(){
		union(){
			// make the hub
			cylinder(r=rins, h=tdepth);
			if (hubstyle == 1){
				translate([0,0,tdepth])hubcap();
			}
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
$fn=50;

difference(){ //This difference is to add a centering hole
	difference(){total(fs,fa,fn,nslices,trad,outw,nfins,rins,tdepth,fangle,bevh,tfin,hubstyle);
		//Difference so that it will print nice. Otherwise it wouldn't.
		translate([0,0,-119-3]) cylinder(h=119,r=119);} //This is to trim it flat
		// axle hole, almost all the way through (1mm from top
		translate([0,0,-4]) cylinder(h=(tdepth+rins+3),r=chrad);
}


module hubcap(){
	difference(){
		sphere(r=rins);
		// chop off the bottom
		translate([-(rins/2),-(rins/2),-rins])cube([rins,rins,rins]);
	}
}
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
