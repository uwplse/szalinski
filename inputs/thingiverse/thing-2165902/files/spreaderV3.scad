$fa = 5;
$fs = 0.35;
tol=0.05;

wired = 3.58 + 0.5;  // wire diameter plus some tolerance
wall = 2;	     // part thickness
// spread = 21.46;  // real ladder line
spread = 12 * 25.4;  // distance between the wire centers
height = 5;	   
spreadratio = ((spread/25.4)/(10*wall)); // semi-arbitrary ratio for trying to firm up the body based on length and wall variables
gapratio = 0.5;     // gap in terms of wire diameter
tip = wired*1.5;    // distance between wire edge and part edge

// zip tie dimensions
zipd = 1;
zipw = 2.5;
//zipoff = zipw/2;           // minimum recommended lip width
//zipoff = (wall+zipw/2)/2;  // compromise
zipoff = tip-zipw-wired/2;   // at the edge of the wire

gap=gapratio * wired;
len = spread + tip*2 + wired;
tiplen = tip*2+wired/2;
tipinside = tiplen-wall-wired/4;
tipoutside = gap/2+wall;
h2 = height + tol*2;


translate([tiplen-spreadratio,-wall/2-spreadratio,0]) cube([spread-tip*2+(2*spreadratio),wall+2*spreadratio,height]);  // spreader body
translate([0,0,0]) holder();
translate([len,0,0]) rotate([0,0,180]) holder();

module holder() 
{
  difference() {
    union() {
      // tip outside
      translate([0,-tipoutside,0]) cube([tiplen,tipoutside*2,height]);
      // wire hole outside walls
      translate([tip,0,0]) cylinder(r=wired/2+wall, h=height);
      // a little thicker to fit the zip ties at the tips
      translate([0,-tipoutside-zipd,0]) cube([zipoff*2+zipw,(tipoutside+zipd)*2,height]);
    }
    // tip insides
    translate([-tol,-gap/2,-tol]) cube([tipinside+tol,gap,h2]);
    // wire hole inside
    translate([tip,0,-tol]) cylinder(r=wired/2, h=h2);
    // rounded gap end
    translate([tipinside,0,-tol]) cylinder(r=gap/2, h=h2);
    // guide to help the wire in
    translate([-wired/5,0,-tol]) cylinder(r=wired/2, h=h2);
    //  translate([len-tipinside,0,-tol]) cylinder(r=gap/2, h=h2);
    // round the tip inside corners
    corner(tiplen,-(gap/2+wall),90,wall);
    corner(tiplen,gap/2+wall,180,wall);
    // slots for zip tie
    translate([zipoff,tipoutside,-tol]) cube([zipw,zipd+tol,h2]);
    translate([zipoff,-tipoutside-zipd-tol,-tol]) cube([zipw,zipd+tol,h2]);
  }
}

module corner(x,y,rot,corner)
{
  translate([x,y,0]) rotate([0,0,rot])
  difference() {
    translate([-tol, -tol, -tol*2]) 
      cube([corner+tol, corner+tol, height+tol*4]);
    translate([corner,corner,-tol*2])
      cylinder(r=corner, h=height+tol*4);
  }
}
