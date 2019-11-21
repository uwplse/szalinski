
$fn=50;
//Shape size
inradius      = 10;
outradius     = 20;
// size of the biggest ring
lengthBigRing = 4;
// size of the smallest ring
lengthSmaRing = 2.25;
// diameter of the capter
probediam     = 18;
tolerance     = 0.5;
//thickness
thickness     = 5;
// hole radius
bolt_hole     = 2.5;
// Probe offset from screw
yoffset       = 29 ;
// Probe offset from screw
xoffset       = 25;

// Please note, in Marlin the offsets should be
// X_PROBE_OFFSET_FROM_EXTRUDER  0
// Y_PROBE_OFFSET_FROM_EXTRUDER  -yoffset (default = 40.25)

module cutter(r,height){
     difference(){
      cube([r+5,r+5,2.5*height]);
      cylinder(h=6*height,r=r,center=true);
     }//difference
   }
module cube_left_round(width, depth, height, r){ 
  difference() {
    cube([width, depth, height]);
    translate([r, depth-r,-height]) mirror([1,0,0]) cutter(r,height);
  }//difference
}//module

module probe_holder(thickness=thickness, inradius=inradius, outradius=outradius, 
  xoffset = xoffset, yoffset=yoffset, probediam=probediam+tolerance){
  width = xoffset + probediam/2 + lengthBigRing;
  depth = yoffset + probediam + 2*lengthBigRing;
  
  yprobe = yoffset + probediam/2 + lengthBigRing;
  xprobe = xoffset;
  //yoffset = 29 + lengthBigRing + (probediam+tolerance)/2 ;
    
  difference(){
    //shape
    union(){
      difference(){
        cube_left_round(width, depth, thickness, outradius);
        translate([2*bolt_hole+lengthSmaRing,-2,-thickness])
          cube_left_round(width, yoffset+2, 2.5*thickness, inradius);
        translate([xoffset,yprobe,-thickness])
          cutter(r=probediam/2+lengthBigRing, height=2.5*thickness);
        translate([xoffset,yprobe,-thickness])
          mirror([0,1,0])cutter(r=probediam/2+lengthBigRing, height=2.5*thickness);
      }//difference
      translate([bolt_hole,0,thickness/2])cylinder(h=thickness,r=bolt_hole+lengthSmaRing,center=true);
    }//union
    // Make hole
    translate([bolt_hole,0,0])cylinder(h=3*thickness,r=bolt_hole,center=true);
    translate([xoffset,yprobe,0])cylinder(h=3*thickness,d=probediam,center=true);
  }//difference
}//module

probe_holder();


