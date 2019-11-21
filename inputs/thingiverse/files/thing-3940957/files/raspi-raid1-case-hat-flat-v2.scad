include <raspberry-scad-master/raspberry_pi_Bplus_def.scad>
use <roundedcube.scad>

 echo("Version:",version());

// what to print
// "all", "box", "cover", "foot"
PRINT="box";
// set to true for a short cut-out version
MODEL="short"; // "long" or "short" or "cut"
SHORT=(MODEL=="short"); 
CUT=(MODEL=="cut"); // probably useless and hard to print

 // 2.5" disk size
 DiskLength = 100.5;
 DiskWidth = 70.5;
 DiskThickness = 9.5;
 DiskHole1DistFromSide = 14;
 DiskHole2DistFromSide = 90.6;
 DiskHoleDiameter = 4;
 DiskConnectorHeight = 18;
 
 // box size 
 BoxThickness = 1.5;
 BoxLength = SHORT ? 130 : 210;
// hat: +35 height
 BoxHeight = 26+35;
 CoverHeight = 7;
 PiBoxEmptySpace = 5; // room on the pi side for screws in disk wall
 PiBoxWidth = RaspberryPiBplusWidth + BoxThickness+PiBoxEmptySpace;
 DiskWallY = PiBoxWidth + BoxThickness + 1;
 FullBoxWidth = DiskWidth + PiBoxWidth + 3*(BoxThickness+1);
 bb_hh = (DiskConnectorHeight - DiskThickness)/2; 
 FirstDiskHeight = BoxThickness + bb_hh + DiskThickness/2;
 SecondDiskHeight = FirstDiskHeight + DiskThickness + 2*bb_hh;
 Disk1Position = [3, DiskWallY+BoxThickness+0.5, FirstDiskHeight];
 Disk2Position = [3, DiskWallY+BoxThickness+0.5, SecondDiskHeight];

// override ZOffset to hat height
 RaspberryPiBplusZoffset = 28.3;

 FilletR = 3;
 
 DiskWallLength = SHORT ? 
  BoxLength - 2* BoxThickness + 0.1 : 
  DiskLength + Disk1Position.x;
 DiskWallHeight = BoxHeight-BoxThickness-0.5;
 BeamHeight = 4*BoxThickness;
 
 VentSize = [ 2, 10, 10 ];
 FanSize = 30;

 RearHoleWidth = 8;
 RearHoleHeight = 20;
 
 FontSize = 8; // for texts 
 
 // feet
 FootBiggestDiameter = 12;
 FootSmallestDiameter = 8;
 FootHeight = 8;
 FootXPos = 25;
 FootYPos = 12;
 
 Feets = [[FootXPos,FootYPos], [BoxLength-FootXPos,FootYPos], [FootXPos,FullBoxWidth-FootYPos], [BoxLength-FootXPos, FullBoxWidth-FootYPos]]; // feets position
 
 // raspberry pi specs
 RaspberryPiBplusX = 5;
 RaspberryPiBplusHoleX = RaspberryPiBplusHolesDistToSide + BoxThickness+RaspberryPiBplusX;
 RaspberryPiBplusHoleY = BoxThickness+RaspberryPiBplusHolesDistToSide;
 RaspberryPiBplusHoles = [
    [RaspberryPiBplusHoleX, RaspberryPiBplusHoleY],,
    [RaspberryPiBplusHoleX+RaspberryPiBplusBetweenHolesLength,
      RaspberryPiBplusHoleY],
    [RaspberryPiBplusHoleX, 
      RaspberryPiBplusHoleY+RaspberryPiBplusBetweenHolesWidth],
    [RaspberryPiBplusHoleX+RaspberryPiBplusBetweenHolesLength,
      RaspberryPiBplusHoleY+RaspberryPiBplusBetweenHolesWidth],
 ];
 RaspberryPiBplusPowerSocketDistToSide = 10.6;
 RaspberryPiBplusPowerSocketWidth = 8;
 RaspberryPiBplusPowerSocketHeight = 3.5;
 RaspberryPiBplusPowerSocketDistToBoard=0;
 // hat: the power socket is 8.5mm down
 RaspberryPiBplusHatPowerSocketDistToBoard=-8.5;
 RaspberryPiBplusHDMISocketDistToSide = 32;
 RaspberryPiBplusHDMISocketWidth = 16;
 RaspberryPiBplusHDMISocketHeight = 7.5;
 RaspberryPiBplusHDMISocketDistToBoard=0.5;

 RaspberryPiBplusSoundSocketDistToSide = 53.5;
 RaspberryPiBplusSoundSocketDiameter = 7;
 RaspberryPiBplusSoundSocketDistToBoard=0.5;
 
 RaspberryPiBplusLedHoleDistToSide = 8;
 RaspberryPiBplusLedHoleWidth = 5.5;
 RaspberryPiBplusLedHoleHeight = 3;
 RaspberryPiBplusLedHoleDistToBoard=0;

// hat: add power led
 RaspberryPiBplusPowerLedHoleDistToSide = 28;
 RaspberryPiBplusPowerLedHoleWidth = 10;
 RaspberryPiBplusPowerLedHoleHeight = 3;
 RaspberryPiBplusPowerLedHoleDistToBoard=-8.5;

// hat: add power button
 RaspberryPiBplusPowerButtonDistToSide = 70.3;
 RaspberryPiBplusPowerButtonWidth = 8;
 RaspberryPiBplusPowerButtonHeight = 8;
 RaspberryPiBplusPowerButtonDistToBoard=-10;
 
 // generic empty box 
 // dims=dimensions, wt=walls thickness, t=bottom (t=BoxThickness for a box, t=0 or less for walls)
 module gbox(dims, wt, t, r=1) {
  indims = [dims.x-2*wt, dims.y-2*wt, dims.z+1];
  //type=(t<=0? "z" : "all");
   type="zmin";
  difference(){
    roundedcube(dims, radius=r, apply_to=type);
    translate([wt, wt, t]) roundedcube(indims, radius=r, apply_to=type);
  }

 }
 
 module box(dims, t) { gbox(dims, t, t, FilletR); }
 
  // nb vents of size vs each at position pos
 module ventsblock(nb, vs, pos) {
   e=vs.x*2;
   for(i=[1:nb])
     translate ([pos.x+i*e,pos.y-1,pos.z-1]) cube([vs.x, vs.y+1, vs.z+1]);
 }

 // one hole for disk
 module bolthole(h, d) {
   translate([0,h/2+5,0]) rotate([-90, 0, 0])
     cylinder(h=h+15, d=d, center=true, $fn = 10);    
 }
 
 // 2 holes at x1 & x2 for disk
 module diskboltholes (pos) {
  translate([pos.x, pos.y-BoxThickness-1, pos.z]) {
    translate([DiskHole1DistFromSide,0,0]) bolthole(DiskWallY+BoxThickness, DiskHoleDiameter);
    translate([DiskHole2DistFromSide,0,0]) bolthole(DiskWallY+BoxThickness, DiskHoleDiameter);
  }
 }

 // one foot (truncated cone + cylinder)
 module foot() {
   union() {
     cylinder(h=FootHeight+BoxThickness, d=FootSmallestDiameter, $fn=20);
     cylinder(h=FootHeight, d1=FootSmallestDiameter, d2=FootBiggestDiameter, $fn=20);
   }
 }

 module draw_pi() {
  translate([BoxThickness+RaspberryPiBplusX,  
   BoxThickness-0.8,
   BoxThickness+RaspberryPiBplusThickness+RaspberryPiBplusZoffset])
  color("orange")
  import("libraries/raspberry-scad-master/raspberry_pi_Bplus.STL", convexity=10);
}

module fillet(l, r, pos, rot=[0,0,0]) {
  translate(pos) {
    rotate(rot)
    difference() {
      cube([l, r, r]);
      translate([-1,r,r]) 
        rotate([0,90,0])
          cylinder(r=r, h=l+2, $fn=50);
    }
  }
}

// fan grid for a square fan of 's' mm side
module fangrid(s) {
  dp=s-2; // fan hole diameter
  hd=4; // screw hole diameter
  dd=(s-1-hd)/2;
  pd=s/5;
  s3_2 = sqrt(3)/2;
  poly = [[pd, 0], [pd/2, pd*s3_2], [-pd/2, pd*s3_2], [-pd, 0], [-pd/2, -pd*s3_2], [pd/2, -pd*s3_2]];
  ww = sqrt(pow(dp*s3_2/2-pd,2) + pow(dp/4,2))+2;

  linear_extrude(height=10, center=true)
  difference() {
    union() {
      circle(d=dp);
      translate([-dd, dd, 0])circle(d=hd, $fn=10);
      translate([dd, dd, 0])circle(d=hd, $fn=10);
      translate([-dd, -dd, 0])circle(d=hd, $fn=10);
      translate([dd, -dd, 0])circle(d=hd, $fn=10);
    }
    polygon(poly);
    for (i=[1:6])
      translate(poly[i-1]) rotate([0,0,i*60]) square([ww, 2]);
  }
}

module draw_text(t) {
translate([BoxThickness/2, FullBoxWidth/2, BoxHeight-FontSize-10])
  rotate([90,0,-90]) 
  linear_extrude(BoxThickness) 
  text(t, size=FontSize, halign="center", valign="center");
}

module carve_holes() {
    if (SHORT||CUT) { // cut-out the rear of the box
       translate([BoxLength-BoxThickness-0.1, BoxThickness, BoxThickness])
       cube([4*BoxThickness, FullBoxWidth-2*BoxThickness, BoxHeight-BeamHeight]);
    } else { // no vents on short/cut versions
       ventsblock(8, VentSize, [BoxLength*2/3,0,0]);
       ventsblock(8, VentSize, [BoxLength*2/3,FullBoxWidth-VentSize.y+2,0]);
       ventsblock(8, VentSize, [BoxLength*2/3,DiskWallY-VentSize.y/2+BoxThickness,0]);
    }
    diskboltholes(Disk1Position);
    diskboltholes(Disk2Position);
    for (foot=Feets) // Feets holes
       translate([foot[0], foot[1], -1]) cylinder(h=BoxThickness+2, d=FootSmallestDiameter + 0.25, $fn=30);

    // pi holes
    for (hole=RaspberryPiBplusHoles)
      translate([hole[0], hole[1], -1]) cylinder(h=BoxThickness+2, d=RaspberryPiBplusHolesDiameter+0.5, $fn=20);

  e = BoxThickness+RaspberryPiBplusX;
  h = RaspberryPiBplusZoffset+BoxThickness+RaspberryPiBplusBoardHeight-1.5;
// power socket
    for (sh=[RaspberryPiBplusPowerSocketDistToBoard,
       RaspberryPiBplusHatPowerSocketDistToBoard])
      translate ([RaspberryPiBplusPowerSocketDistToSide+e-RaspberryPiBplusPowerSocketWidth/2,
          -1, h+sh]) 
        cube([RaspberryPiBplusPowerSocketWidth,2*BoxThickness,RaspberryPiBplusPowerSocketHeight]);

// power button
    translate ([RaspberryPiBplusPowerButtonDistToSide+e-RaspberryPiBplusPowerButtonWidth/2,
          -1, h+RaspberryPiBplusPowerButtonDistToBoard-1]) 
      cube([RaspberryPiBplusPowerButtonWidth,2*BoxThickness,RaspberryPiBplusPowerButtonHeight]);
    
// hdmi socket
    translate ([RaspberryPiBplusHDMISocketDistToSide+e-RaspberryPiBplusHDMISocketWidth/2,
          -1, h+RaspberryPiBplusHDMISocketDistToBoard]) cube([RaspberryPiBplusHDMISocketWidth,2*BoxThickness,RaspberryPiBplusHDMISocketHeight]);

// sound socket
    translate ([RaspberryPiBplusSoundSocketDistToSide+e,
          -1, h+RaspberryPiBplusSoundSocketDiameter/2+RaspberryPiBplusSoundSocketDistToBoard])
      rotate([-90,0,0]) cylinder(h=2*BoxThickness,d=RaspberryPiBplusSoundSocketDiameter, $fn=20);

// led hole
  translate ([-1,e+RaspberryPiBplusLedHoleDistToSide, h+RaspberryPiBplusLedHoleDistToBoard])
      cube([2*BoxThickness,RaspberryPiBplusLedHoleWidth,RaspberryPiBplusLedHoleHeight]);

// power led hole
    translate ([-1,e+RaspberryPiBplusPowerLedHoleDistToSide, 
      h+RaspberryPiBplusPowerLedHoleDistToBoard])
      cube([2*BoxThickness,RaspberryPiBplusPowerLedHoleWidth,RaspberryPiBplusPowerLedHoleHeight]);

}

module cover_holder(pos=[0,0,0], rot=[0,0,0]) {
  h = 5;
  r = 6;
  translate([pos.x, pos.y, pos.z-h]) rotate(rot)
//    difference () {
      rotate_extrude(angle=90) 
        polygon([[0,0], [r,h],[0,h]]);
//      translate([r/2.5, r/2.5, h/2]) cylinder(h=h, r=2);
//    }
}

module draw_box(color="green") {
  difference() {
    union() {
      box([BoxLength, FullBoxWidth, BoxHeight], BoxThickness);
// disk wall
      translate ([BoxThickness-0.1, DiskWallY, 0.1]) color("blue") cube([DiskWallLength, BoxThickness, DiskWallHeight]);
// transversal beam
      if (!SHORT) translate ([DiskWallLength, 0, DiskWallHeight-BeamHeight]) cube([BoxThickness,FullBoxWidth,BeamHeight]);
// internal fillets
      fillet(DiskWallLength - BoxThickness, FilletR, [BoxThickness, DiskWallY+BoxThickness, BoxThickness]);
      fillet(DiskWallLength - BoxThickness, FilletR, [BoxThickness,DiskWallY, BoxThickness], [90,0,0]);
      fillet(BoxHeight - BoxThickness, FilletR, [BoxThickness,DiskWallY,DiskWallHeight+0.75], [0,90,-90]);
      fillet(BoxHeight - BoxThickness, FilletR, [BoxThickness,DiskWallY+BoxThickness,DiskWallHeight+0.75], [0,90,0]);
// text in front
      draw_text("Raspberry Pi Raid 1 case");
// cover holders
      cover_holder([BoxThickness,BoxThickness,DiskWallHeight], [0,0,0]);
      cover_holder([BoxThickness,FullBoxWidth-BoxThickness,DiskWallHeight], [0,0,-90]);
      cover_holder([BoxLength-BoxThickness,BoxThickness,DiskWallHeight], [0,0,90]);
      cover_holder([BoxLength-BoxThickness,FullBoxWidth-BoxThickness,DiskWallHeight], [0,0,180]);
    }
    carve_holes();
  }
}

module beam_part(l,w,h) {
  e = 0.5; // w/3
  e2 = e*0.75;
  t = 0.05;
  translate([0,0,h]) mirror([0,0,180]) union() {
    difference() {
      cube([l, w, h]);
      translate([-t,w-e2-t,-t]) cube([l+2*t, w, h/2]);
    }
    translate([l,w+e-e2-t,e]) rotate([0,-90,0]) linear_extrude(l) polygon([[0,0],[e,-e],[-e,-e]]);
  }
}

module draw_coverbeams(ld, wy, t, h, tol) {
  ldd = 10;
  ldn = floor(ld/(2*ldd-1));
  lds = (ld - ldn*ldd)/(ldn-1);

  for (p=[0:ldd+lds:ld]) {
    translate([t+p, wy-t, t]) union() {
      translate ([0,-tol+0.1,0]) beam_part(ldd,t,h+t);
      translate ([0,3*t+tol-0.1,0]) mirror([0,180,0]) beam_part(ldd,t,h+t);
    }
  }
}

module draw_cover(pos=[0,0,0], rot = [0,0,0]) {
  tol=0.25;
  t = BoxThickness;
  l = BoxLength;
  ld = DiskWallLength-2*(t+tol);
  w = FullBoxWidth;
  h = CoverHeight;
  wy = w-DiskWallY-2*t;
  translate(pos)   rotate(rot) union() {
    difference() {
      box([l-2*(t+tol), w-2*(t+tol), h], t);
      // fan grid
      translate([(RaspberryPiBplusLength-FanSize)/2+2*BoxThickness, 
          w-RaspberryPiBplusWidth/2-BoxThickness, 0]) 
  fangrid(FanSize);
    }
    translate([t, wy-tol, t]) cube([ld, t+2*tol, h-t]);
    draw_coverbeams(ld, wy, t, h, tol);
  }
}

module draw_disk(pos) {
  translate([pos.x, pos.y, pos.z - DiskThickness/2]) 
    color("red") cube([DiskLength, DiskWidth, DiskThickness]);
}

if (PRINT=="all") {
// for seing the box closed, not for exporting
  translate([0,0,FootHeight]) {
    draw_box();
    #draw_cover([BoxThickness,
      FullBoxWidth-BoxThickness,
      DiskWallHeight+CoverHeight-BoxThickness],
      [180, 0, 0]);
    draw_disk(Disk1Position);
    draw_disk(Disk2Position);
    draw_pi();
  }
  for (i=Feets) translate([i[0], i[1], 0]) foot();
} else if (PRINT=="box") {
// for exporting bot box only
  draw_box();
} else if (PRINT=="cover") {
// for exporting cover e
    draw_cover();
} else if (PRINT=="foot") {
// for exporting foot only
  foot();
}
