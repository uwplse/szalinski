
// AA=7, AAA=5, 18650=9.25
CellRadius=9.25;
// AA=51, AAA=46, 18650=69
CellLength=69;
// How many?
CellCount=1;
//For 22 AWG stranded wire: adjust as needed
WireRadius=1.1;
//Add wire channels to the side for wiring management
doWireChannels=1; //[1:Yes,0:No]

/* [Hidden] */
MountThickness=3;
MountWidth=max(CellRadius/3*2,8);
TerminalRadius=4.5;
GripWidth=5;
GripThick=1.5;
GripFactor=0.6;
$fn=30;

module MetricCountersunkScrew(diameter=3, post_length=3,tapped=true,flush=true, tolerance=0.1){
	translate( flush ? [0,0,-diameter/2] : [0,0,0] )
		translate([0,0,0]) cylinder(r1=diameter/2,r2=diameter,h=diameter/2);
		if (tapped) {
 			translate([0,0,-post_length]) cylinder(r=diameter/2+tolerance,h=post_length);
		} else {
 			translate([0,0,-post_length]) cylinder(r=diameter/2+0.2+tolerance,h=post_length);
		}
}

module M3_Nut(head_height=2, tolerance=0.1, bevel=false){
 MetricNut(3.4, head_height, tolerance, bevel);
}

module MetricNut(n_rad=3.4, head_height=2.4, tolerance=0.1, bevel=false){
 // Simple cutout for an M3 nut:
 //3.4mm base radius with an additional 0.1mm tolerance, for a total of 3.5mm
 // produces a good sized hole.  3.3mm+0.1mm makes for a "tight" fit.
 echo("Tolerance",tolerance);
 echo("Total Radius", n_rad+tolerance);
 union(){
  cylinder(r=n_rad+tolerance, h=head_height, $fn=6);
  if ( bevel ) {
   // add a 45 degree bevel to the bottom of the nut
   translate([0,0,-n_rad+1.5-tolerance]) cylinder(r2=n_rad+tolerance, r1=1.5, h=n_rad-1.5+tolerance, $fn=6);
  }
 }
}

module terminalEnd(){
 difference(){
  translate([MountThickness+1,0,CellRadius+MountThickness])
  rotate([0,-90,0])
  difference(){
   union(){
    cylinder(r=TerminalRadius,h=MountThickness);
    translate([0,0,MountThickness]) cylinder(r1=TerminalRadius,r2=TerminalRadius-1,h=1);
    translate([-CellRadius,-MountWidth/2,0])cube([CellRadius,MountWidth,MountThickness]);
    translate([-CellRadius,0,0]) rotate([0,-45,180]) translate([0,-MountWidth/2,0]) cube([10,MountWidth,MountThickness]);
   }
   translate([0,0,MountThickness+1.2]) MetricCountersunkScrew(diameter=3,post_length=10);
   M3_Nut();
  }
  translate([-25,-MountWidth,-50]) cube([50,MountWidth*2,50]);
  //Wire channel:
  translate([2.5,1.5,-1]) cylinder(r=WireRadius,h=MountThickness+CellRadius+1);
 }
}

module cellGrip(){
 //top Grip Curve
 translate([0,0,CellRadius+MountThickness])
 difference(){
  union() {
   rotate([0,90,0]) cylinder(r=CellRadius+GripThick,h=GripWidth,center=true);
   rotate([0,90,0]) cylinder(r=CellRadius+GripThick*1.5,h=GripWidth/2,center=true);
  }
  rotate([0,90,0]) cylinder(r=CellRadius,h=GripWidth+1,center=true);
  translate([-GripWidth,-1.5*CellRadius,GripFactor*CellRadius]) cube([GripWidth*2,3*CellRadius,3*CellRadius]);
 translate([-GripWidth,-1.5*CellRadius,-3*CellRadius]) cube([GripWidth*2,3*CellRadius,3*CellRadius]);
 }
 //Bottom grip curve
 translate([0,0,GripFactor*CellRadius+MountThickness/2])
 rotate([0,180,0])
 difference(){
  union() {
   rotate([0,90,0]) cylinder(r=CellRadius+GripThick,h=GripWidth,center=true);
   rotate([0,90,0]) cylinder(r=CellRadius+GripThick*1.5,h=GripWidth/2,center=true);
  }
  rotate([0,90,0]) cylinder(r=CellRadius,h=GripWidth+1,center=true);
  translate([-GripWidth,-1.5*CellRadius,GripFactor*CellRadius]) cube([GripWidth*2,3*CellRadius,3*CellRadius]);
 translate([-GripWidth,-1.5*CellRadius,-3*CellRadius]) cube([GripWidth*2,3*CellRadius,3*CellRadius]);
 }
 //middle bit of the grip:
 translate([-GripWidth/2,-CellRadius-GripThick,CellRadius*GripFactor+MountThickness/2]) cube([GripWidth,GripThick,CellRadius-(CellRadius*GripFactor-MountThickness)-MountThickness/2]);
 translate([-GripWidth/4,-CellRadius-GripThick*1.5,CellRadius*GripFactor+MountThickness/2]) cube([GripWidth/2,GripThick*1.5,CellRadius-(CellRadius*GripFactor-MountThickness)-MountThickness/2]);
 rotate([0,0,180]){
  translate([-GripWidth/2,-CellRadius-GripThick,CellRadius*GripFactor+MountThickness/2]) cube([GripWidth,GripThick,CellRadius-(CellRadius*GripFactor-MountThickness)-MountThickness/2]);
  translate([-GripWidth/4,-CellRadius-GripThick*1.5,CellRadius*GripFactor+MountThickness/2]) cube([GripWidth/2,GripThick*1.5,CellRadius-(CellRadius*GripFactor-MountThickness)-MountThickness/2]);
 }
 rotate([0,0,45/2]) cylinder(r=max(CellRadius+1,MountWidth/2+WireRadius*2+1),h=MountThickness, $fn=8);

}

//testing:

 //CellModel:
 //  translate([0,0,CellRadius+MountThickness]) color("blue") rotate([0,90,0]) cylinder(r=CellRadius,h=CellLength,center=true);

module cellHolder(){
 difference(){
  union(){
   translate([CellLength/2,0,0]) terminalEnd();
   rotate([0,0,180]) translate([CellLength/2,0,0]) terminalEnd();
   difference(){
    union(){
     translate([-CellLength/2,-MountWidth/2,0]) cube([CellLength,MountWidth,MountThickness]);
     translate([GripWidth*0.6,0,0]){
      translate([CellLength/4,0,0]) cellGrip();
      rotate([0,0,180]) translate([CellLength/4,0,0]) cellGrip();
     }
     //additional support, frankly, for appearance sake.
     translate([-GripWidth*0.6,0,0]){
      translate([CellLength/4,0,0]) rotate([0,0,45/2]) cylinder(r=max(CellRadius+1,MountWidth/2+WireRadius*2+1),h=MountThickness, $fn=8);
      rotate([0,0,180]) translate([CellLength/4,0,0]) rotate([0,0,45/2]) cylinder(r=max(CellRadius+1,MountWidth/2+WireRadius*2+1),h=MountThickness, $fn=8);
     }
    }
    translate([CellLength/4,0,MountThickness]) MetricCountersunkScrew(diameter=3,post_length=10);
    rotate([0,0,180]) translate([CellLength/4,0,MountThickness]) MetricCountersunkScrew(diameter=3,post_length=10);
   }
  }
  if ( doWireChannels ){
   color("red") translate([-CellLength*0.75,MountWidth/2+WireRadius,MountThickness/2]) rotate([0,90,0]) cylinder(r=WireRadius,h=CellLength*1.5);
   color("red") translate([-CellLength*0.75,-MountWidth/2-WireRadius,MountThickness/2]) rotate([0,90,0]) cylinder(r=WireRadius,h=CellLength*1.5);
  }
 }
}

cellHolder();
if (CellCount > 1) {
  // if the separation between cells gets too small, the side channels in between get blocked... working on that
  echo("Distance between:",CellRadius+GripThick - max(CellRadius+1,MountWidth/2+WireRadius*2+1));
 for (i=[1:CellCount-1]){
  translate([0,i*(CellRadius*2+2*GripThick),0]) rotate([0,0,180*i]) cellHolder();
  translate([CellLength/4,CellRadius+GripThick+(i-1)*(CellRadius*2+2*GripThick),MountThickness/2]) cube([CellRadius*1.5,GripThick*3,MountThickness], center=true);
  translate([-CellLength/4,CellRadius+GripThick+(i-1)*(CellRadius*2+2*GripThick),MountThickness/2]) cube([CellRadius*1.5,GripThick*3,MountThickness], center=true);
 }
}
