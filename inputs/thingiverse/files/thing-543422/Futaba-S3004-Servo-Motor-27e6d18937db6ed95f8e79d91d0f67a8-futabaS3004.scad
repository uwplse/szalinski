/*
Futaba S3004 servo
Aaron Ciuffo - aaron dot ciuffo 2 gmail

This library produces a fotuaba S3004 futaba servo or a projection for cutting
a hole in a 2D shape for a laser cutter.  

The scale of the projected hole for the body can be adjusted below

It can be used in other models by calling:

  import <futaba_s3004.scad>
  futaba();

The library can also produce a 2D projection that is useful for making a cutout for
a DXF to be used with a laser cutter:
  futaba(project=true)
 
To produce a projection that includes pilot holes for wood screws use:
  futaba(project, bolt=false);




V1 11 November 2014


*/
/*[Setup]*/
$fn=36; //curve refinement

/*[Body Dimensions]*/
bX=40.1;
bY=19.9;
bZ=36;

/*[Flange Dimensions and position]*/
fX=7.4;
fY=17.8;
fZ=2.55;
//flange distance from Base
flangeFromB=26.4;
fBoltDia=4.5;
fBoltRad=fBoltDia/2;
fScrewDia=2.1;
fScrewRad=fScrewDia/2;
fScrewPilot=fScrewRad*.5;

//position from edges
fScrewY=1.7;
fScrewX=0.9;
fScrewZ=7.0;

/*[Shaft Dimensions and Position]*/
shaftDia=6;
shaftRad=shaftDia/2;
shaftZ=6;
shaftX=7.3+shaftRad;
shaftS1=14.4/2;
shaftS2=11.4/2;
shaftSZ=1.8;

/*[Horn Dimensions]*/
hornZ=2.0; 
hornX=38.9;
hornY=hornX;
hornArmX=8.5;
hornRad=5.5/2;

//horn location
hornZoverB=7.8; //height of horn over top of body
hornZoverShaft=hornZoverB-shaftZ; //horn height over shaft



/*[Wire Gland]*/
wireX=2;
wireY=6.5;
wireZ=5.3;


module horn() {
  union() {
    hull() {
      cube([hornX-2*hornRad, hornArmX, hornZ], center=true);
      translate([hornX/2, 0, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
      translate([-hornX/2, 0, 0])
        cylinder(h=hornZ, r=hornRad, center=true);

    }
    
    hull() {
      cube([hornArmX, hornY-2*hornRad, hornZ], center=true);
       translate([0, hornY/2, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
      translate([0, -hornY/2, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
   }
 }
    
  
}

module flange(project=false, bolt=true) {
  fHoleRad= bolt==true ? fBoltRad : fScrewPilot;
  
  if (project==false) {
    difference() {
      cube([fX, fY, fZ], center=true);
      translate([fX/2-fBoltRad-fScrewX, fY/2-fBoltRad-fScrewY, 0])
        cylinder(h=fZ*2, r=fHoleRad, center=true);
      translate([fX/2-fBoltRad-fScrewX, -fY/2+fBoltRad+fScrewY, 0])
        cylinder(h=fZ*2, r=fHoleRad, center=true);
    }
  }

  //leave the cylinders in place for projecting a bolt hole
  if (project==true) {
    translate([fX/2-fScrewRad-fScrewX, fY/2-fScrewRad-fScrewY, 0])
      cylinder(h=fZ*2, r=fScrewRad, center=true);
    translate([fX/2-fScrewRad-fScrewX, -fY/2+fScrewRad+fScrewY, 0])
      cylinder(h=fZ*2, r=fScrewRad, center=true);
  
  }

}


module body(project=false, bolt=true, scalePct=1.05, horn=false) {
  scalePctLoc= project==true ? scalePct : 1;
  union() {
    color("gray")
      scale(scalePctLoc) cube([bX, bY, bZ], center=true);
    color("red")
      translate([bX/2+fX/2, 0, bZ/2-fZ/2-fScrewZ])
        flange(project, bolt);
    color("red")
      translate([-bX/2-fX/2, 0, bZ/2-fZ/2-fScrewZ]) rotate([0, 0, 180])
        flange(project, bolt);
    translate([-bX/2+shaftX, 0, bZ/2]) color("green")
      cylinder(h=shaftZ, r=shaftRad);
    translate([-bX/2+shaftX, 0, bZ/2]) color("blue")
      cylinder(h=shaftSZ, r1=shaftS1, r2=shaftS2);
    color("purple")
      translate([-bX/2-wireX/2, 0, -bZ/2+wireZ/2])
        cube([wireX, wireY, wireZ], center=true);
    if (horn==true) {
      color("yellow")
        translate([-bX/2+shaftX, 0, bZ/2+shaftZ-hornZ/2+hornZoverShaft])
          horn();
    }
  }

}

module futaba(project=false, bolt=true, scalePct, center="main", horn=false) {
  
  //hrn=horn; //WTF?  why do I need this?
  // move everything down to put the horn at the origin
  hornZoffset= horn==true ? hornZoverShaft : 0;

  if (project==true) {
    projection() body(project, bolt, scalePct);
  } else {
    if (center=="shaft") {
      translate([bX/2-shaftX, 0, -bZ/2-shaftZ-hornZoffset])
        body(project, bolt, horn=horn);
    } else if (center=="flange") {
      translate([0, 0, -bZ/2+(bZ-flangeFromB)])
        body(project, bolt, horn=horn);
      
    } else{
      body(project, bolt, horn=horn);
    }
  }
 
}

futaba(project=false, bolt=true, center="false", horn=true);
//futaba(project=true, bolt=false, scalePct=1.05);


