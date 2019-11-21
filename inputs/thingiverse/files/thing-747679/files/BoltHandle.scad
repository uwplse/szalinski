
//Size of the wrench used to tightnen (mm)
WrenchSize=10.2;

//Thickness of the handle piece(mm)
HandleH=5;

//Height of the inner cylinder (mm(
InnerH=10;

//Diameter of Handle piece (mm)
HandleD=25;

//Diameter of the pass-through hole (mm)
HoleD=6.5;

//Nut trap depth (mm)
NutH=4;

//Handle decoration/grip radius (mm)
DecoR=2;

//Number of Decoration/grip bites
DecoN=12;

//Decoration offset, increase to decrease the arch of decoration (mm) (<DecoR)
DecoOS=0;

//Decoration smoothness, increase to make smoother decorations (mm)
DecoSu=0;


module Handle1(D,H,dr,dn,dos,ds){
minkowski(){
	difference(){
		cylinder(r=D/2-ds, h=H);
		for (a = [0:360/dn:360]){
	           rotate([0,0,a])
	            translate([-(D-ds)/2-dos,0,-0.5]) cylinder(r=dr+ds/2,h=H+1);
	       }
		}
	//sphere(r=ds);
	cylinder(r=ds,h=1, $fn=10);
	}
}

module Handle(D,H,dr,dn,dos,ds){

if(ds>0){
	Handle1(D,H-1,dr,dn,dos,ds);
}else{
	Handle1(D,H,dr,dn,dos,ds);
}
}

module BoltHandle(WrenchSize, HandleH, TotalH, HandleD, HoleD, NutH, DecoR, DecoN,DecoOS=0,DecoSu=0){
difference(){
	union(){
		Handle(HandleD,HandleH,DecoR,DecoN,DecoOS,DecoSu);
		cylinder(r=HoleD, h = TotalH);	
	}
	cylinder(r=HoleD/2,h=TotalH);
	cylinder(r=sqrt(3)*WrenchSize/3,h=NutH,$fn=6);

}
}


BoltHandle(WrenchSize,HandleH,InnerH,HandleD,HoleD,NutH,DecoR,DecoN,DecoOS,DecoSu);