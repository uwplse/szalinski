/*
NOTES NOTES NOTES NOTES NOTES

TEST Print the following:
  Ears -- check nut and bolt dimensions
  Sleeve -- check nut, bolt and dowel dimesions
  WireBox -- check screw holes, connector fit, lid fit, wire clearance

  Print a test plate using ../test/nut_bolt_test.scad 
  to check slop values

  Make sure there are few parts that extend more than the channel depth 
  above the surface to avoid casting shadows!
    - with the current light strip, nothing should be > 8mm or so
    - if more space is needed, add depth by increasing floor thickness
      - this will require a new variable and a rewrite of sleeve and ear mods

  RV01 
    * add wire hole near dowel 

  To Do:
    * Add variable to print without any ears
    
*/



include <MCAD/boxes.scad>
/* [Global] */
//Add bolt ears?
ears=1; //[1:Yes,0:No]
//Which part to print?
piece=0; //[0:Whole,1:1of3,2:2of3,3:3of3]
//Rounded Box Corner Radius
corner=2; //[0:5]
//Curve Refinement
$fn=36; 

/*[Nuts and Bolt Dimensions]*/
//Nut Thickness (Default are Dimensions for M5)
nutThickness=2.35;
//Distance Across Flats
nutFlat=5.5; 
//Bolt Diameter
boltDia=3; 
//Percentage Slop to Add to Holes and Insets
slop=1.1;


/* [Ring Dimensions */
//Length of LED Light Strip (mm)
lightStripL=250; 
//Wall Thickness (mm)
wallThick=2;  
//Width of Light Strip Channels (mm)
channWidth=7.8; 
//Depth of Channels (mm)
channDepth=5; 
//Dowel Connector Diameter (mm)
dowelD=8.5; 
//Wire Hole Diameter (mm)
wireD=4;


/*[Hidden]*/
//CALCULATED VALUES

//Various radii
rad1=lightStripL/(2*PI); //radius of inside channel 
rad2=rad1+channWidth+wallThick; //outter channel radius 
rad3=rad2+channWidth+wallThick*1; //full outside radius
dowelR=dowelD/2;
wireR=wireD/2;


//Nut and bolt dimensions to use 
nutF=nutFlat*slop; //distance across flats of a hex nut
boltR=.5*boltDia*slop; //bolt radius
nutR=.5*nutF*1/cos(30); //calculate the nut radius (do not add slop!)
nutT=nutThickness*slop; //thickness of nut add slop

//Dowel Sleeve Dimensions
sleeveX=dowelR*3;  
sleeveY=dowelR*2+nutT*5;
sleeveZ=channDepth+wallThick;

/* [Joint Ear Dimensions] */
earX=nutR*3;
earY=nutT*3.5;
earZ=nutR*2.5;


//Draw the base
module DrawDisk () {
  difference() {
    cylinder(r=rad3, h=wallThick+channDepth, center=true);
    cylinder(r=rad1-wallThick, h=wallThick+channDepth+2, center=true);	
    echo("inside dia", 2*(rad1-wallThick));
    echo("inside ring circumfrence", lightStripL);
    echo("outside ring circumfrence", 2*PI*rad2);

  }
} //end DrawDisk


//Cut a channel for the light strip 
module CutChannel(rad, width, wall) {
  difference() {
    cylinder(r=rad+width, h=channDepth+2, center=true);
    cylinder(r=rad, h=channDepth+3, center=true);  
  }
} //end CutChannel
	

//Assemble the disk and cut rings
module BuildRing() {
  difference() {
    DrawDisk();
    //cut the channels
    translate([0, 0, wallThick]) CutChannel(rad1, channWidth, wallThick);
    translate([0, 0, wallThick]) CutChannel(rad2, channWidth, wallThick);

    //make a hole for the wires
    translate([0, rad3-channWidth-wallThick-wireR/2, 0]) 
      cylinder(h=wallThick+channDepth*2, r1=wireR, r2=wireD, center=true);
  }

} // end BuildRing

//ears for nuts and blots to allow cutting into mulitple pieces 
module DrawEar(x, y, z) {
  difference() {
    roundedBox([x, y, z], corner, sidesonly=1); //, $fn=36); //ear box
    rotate([90, 0, 0]) cylinder(r=boltR, h=y*2, center=true, $fn=36); //poke bolt hole

    //cut holes for nut
    rotate([90, 0, 0]) translate([0, 0, -y/2+.5*nutT-.01]) 
      cylinder(r=nutR, h=nutT, center=true, $fn=6); //create 6 sided cylinder (nut hole)
  }
} //end DrawEar


// draw a dowel sleeve
module DrawSleeve(sleeveX, sleeveY, sleeveZ, dowelR) {
  difference() {
    //dowel holding sleeve
    roundedBox([sleeveX, sleeveY, sleeveZ], corner, sidesonly=1); 

    //dowel hole
    translate([0, -sleeveY*.15, 0]) 
      cylinder(r=dowelR, h=sleeveZ*2, $fn=30, center=true);

    // nut hole
    translate([0, sleeveY*.25, (.5*sleeveZ-nutR)/2])
      cube([nutF, nutT, .5*sleeveZ+nutR*1.05], center=true);

    //bolt hole
    translate([0, sleeveY*.4, 0]) rotate([90, 0, 0]) 
      cylinder(r=boltR, h=sleeveY, center=true, $fn=36);
  }
} //end DrawSleeve

//Assemble the ring entire thing
module AssembleRing() {

  union() {
    if (ears==1) { 
      //bottom left ear
      translate([cos(30)*(rad3+earX/2-wallThick*.9), sin(30)*(rad3+earX/2-wallThick*.9), 
        earZ/2-(wallThick+channDepth)/2]) 
        rotate([0, 0, 30]) DrawEar(earX, earY, earZ);

      //bottom right ear
      translate([-cos(30)*(rad3+earX/2-wallThick*.9), sin(30)*(rad3+earX/2-wallThick*.9), 
        earZ/2-(wallThick+channDepth)/2]) 
        rotate([0, 0, 150]) DrawEar(earX, earY, earZ);

      //top ear
      translate([0, -(rad3+earX/2-wallThick*.9), earZ/2-(wallThick+channDepth)/2])
        rotate([0, 0, -90]) DrawEar(earX, earY, earZ);
    }
        
    // Sleeve
    translate([0, rad3+sleeveY/2-wallThick*.9, sleeveZ/2-(wallThick+channDepth)/2]) 
      DrawSleeve(sleeveX, sleeveY, sleeveZ, dowelR);     
    BuildRing();

  }

} //end Assemble


module CutRing(piece=0) {

  cX=rad3*2;
  cY=cX;
  cZ=channDepth+wallThick+10;


  difference(){
    AssembleRing();

    if (piece==1) {
      //2/3 comment out to keep 2/3 section
      translate([0, 0, -cZ/2]) rotate([0, 0, -60]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -90]) cube([cX, cY, cZ]);

      //Seam between 2/3 and 3/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -120]) cube([cX, cY, cZ]);


      //3/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -180]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -210]) cube([cX, cY, cZ]);

     
    } // end piece=1


    if (piece==2) {
      //1/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -300]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -330]) cube([cX, cY, cZ]);

      //3/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -180]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -210]) cube([cX, cY, cZ]);

      //Seam between 3/3 and 1/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -240]) cube([cX, cY, cZ]);
    } //end piece 2


    if (piece==3) {
      //1/3
      translate([0, 0, -cZ/2]) rotate([0, 0, -300]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -330]) cube([cX, cY, cZ]);
     
      //seam 
      translate([0, 0, -cZ/2]) rotate([0, 0, -360]) cube([cX, cY, cZ]);

      //2/3 comment out to keep 2/3 section
      translate([0, 0, -cZ/2]) rotate([0, 0, -60]) cube([cX, cY, cZ]);
      translate([0, 0, -cZ/2]) rotate([0, 0, -90]) cube([cX, cY, cZ]);

    } //end piece 3

  } // end difference

} //end CutRing

CutRing(piece);

