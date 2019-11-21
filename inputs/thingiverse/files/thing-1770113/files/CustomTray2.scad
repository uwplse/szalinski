// preview[view:north east, tilt:top]
include <MCAD/boxes.scad>  // Include Boxes library to get easy rounded boxes

// Width of box
width = 96; // [24:12:144]

// Depth of box
depth = 84; // [24:12:144]

// Height of box
height = 20; // [8:80]

// Do you want ventilation fins? (your soap will last longer)
vents = 1; // [1:Yes,0:No]

// Do you want holes?
holes = 0; // [1:Yes,0:No]

// Do you want a tube mount?
mount = 0; // [1:Yes,0:No]

// Diameter of tube to mount this on
d = 17.7; // [6:0.1:40]

/* [Hidden] */

h = height+20;
r = d/2;
f = d/7;
t = d/6;
os = t;
a = 44;
detail = 40;

// Difference will construct a main shape and subtract cut outs
difference() {
    
  //***********
  // Main Shape
  //***********
    
  union(){    
    
    // Main mount cylinder solid
    if (mount == 1) {
      translate([0,0,h/2]) {
        rcylinder(r+t,r+t,h,2,true,$fn=detail);
      } // End translate
    } // End if mount
    
    // Soap cup
    difference() {      
      
      // Soap cup solid  
      translate([0,-width/2-t-os,height/2]) {
        roundedBox([depth, width, height], 4, false, $fn=40);
      }
      
      // Soap cup cut out
      translate([0,-width/2-t-os,(height/2)+width/25]) {
        roundedBox([depth-width/11, width-width/11, height], 4, false, $fn=40);
      }
      
     
      // Holes in the soap cup
      if (holes == 1) {
        for (spaceD =[-depth/2+12:12:depth/2-3]) {
          for (spaceW =[r+10:12:width-1]) {
            translate([spaceD,-spaceW+2.5-os,-1]) {
              cylinder(width/10, 3, 5, false, $fn=detail);
            } // End translate
          } // End for spaceW
        } // End for spaceD
      } // End if holes
        
    } // End difference soap cup
   
    // Ventilation fins
    if ((vents==1) && (depth>=48) && (width>=48)) {
      difference() {

        union(){    
            
          // Big fins
          rotate([90,0,180]) {
            for (spaceW =[r+10+4.5:12:width-5]) {
              translate([-depth/3.8,width/15,-spaceW+1-os]) {
                linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0], [0,-3], [depth/1.5,-3], [depth/1.5,40],[depth/1.5-5,40]]);
              } // End translate
            } // End for spaceW
          } // End rotate
    
          // Small fins
          rotate([90,0,0]) {
            for (spaceW =[r+10+4.5:12:width-5]) {
              translate([depth/7-1,width/15,spaceW-1+os]) {
                linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
polygon(points=[[0,0],[0,-3],[depth/3.5,-3],[depth/3.5,15],[depth/3.5-5,15]]);
              } // End translate
            } // End for spaceW
          } // End rotate
        } // End union
    } // End difference
  } // End if vents
 
  } // End union



  // Cut outs from mounting cylinder
  
  if (mount==1) {
    // Cut out center cylinder
    translate([0,0,-1]) {
      cylinder(h+2, r, r, false, $fn=detail);
    }
  
    // Cut out right wall
    rotate([0,0,a]) {
      translate([0,r,h/2]) {
        cube([t, d, h+2],true);   
      }
    }

    // Cut out left wall
    rotate([0,0,-a]) {
      translate([0,r,h/2]) {
        cube([t, d, h+2],true);   
      }
    }

    // Cut out center wall
    translate([0,r,h/2]) {
      cube([d/1.18, d, h+2],true);   
    }
  }  
} // End difference
  
  module rcylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}
  
