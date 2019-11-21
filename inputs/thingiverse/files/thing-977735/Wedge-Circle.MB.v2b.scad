/** Create Wedge **/
/*      
Universal Adjustabel Wedge by Chris Schaefer is licensed under the Creative Commons - Attribution - Non-Commercial license. 
*/

// MB Interface

/* [Gap] */
// Bottom Pot Diameter
Diameter=300;
// how high is the gap? equals the wedge hight
Gap_Height=50;

/* [Wedge Size] */
// how wide is the wedge?
Wedge_Width=60;
// Depth of the wedge, going under the pot
Wedge_Depth=40;

// Should the wedge have edges to prevent rolling off?
/* [Edge] */
// the width will be added around the wedge
Edge_Width=5.0;
// the hight will be added to the gap size.
Edge_Height=5.0;


// Interface End
/* [Hidden] */
// Length
LEN=Diameter; 
// Gap 
GAP=Gap_Height;

// Block size
/* [Block Size] */
// width (width at the max hight)
X=Wedge_Width;
// length (length along the slope)      
Y=Wedge_Depth;

// edge around the block to stop rolling off
EDGE=Edge_Width;    // edge border thickness
EDGE_H=Edge_Height;  // hight of the edge

// ========================================================
// Block is:
module block () {
    // Block size
    cube(size = [ X, Y, GAP ], center = false);
    // Edge added
    translate([-EDGE, -EDGE, 0])
        difference ()
          {
            cube(size = [ X+2*EDGE, Y+2*EDGE, GAP+EDGE_H ], center = false);
            translate ([EDGE, EDGE,0])
              cube(size = [ X, Y, GAP+EDGE_H ], center = false);
          }
      }

module Circ () {
    color("red")
    rotate_extrude()
        translate([LEN/2-Y, 0])
           polygon( points=[[0,0],[0,GAP],[Y,GAP],[Y,0]]  );   
    color("blue")
    rotate_extrude()
        translate([LEN/2, 0])
           polygon( points=[[0,0],[0,GAP+EDGE_H],[EDGE,GAP+EDGE_H],[EDGE,0]]  );
}
module CircBlock () {
   color ("blue")
    rotate ([0,0,180]) 
        translate([-X/2, 0, 0]) cube(size = [ X, LEN/2+EDGE, GAP+EDGE_H ], center = false);
    rotate ([0,0,90]) 
        translate([-X/2, 0, 0]) cube(size = [ X, LEN/2+EDGE, GAP+EDGE_H ], center = false);
   rotate ([0,0,-90]) 
        translate([-X/2, 0, 0]) cube(size = [ X, LEN/2+EDGE, GAP+EDGE_H ], center = false);
}

module wedge () {
    // Wedge with the right slop
        // shift and rotate it into place
            translate ( [-LEN/2-EDGE,-LEN/2,GAP] )
            rotate ([0,90,0])
        // wedge
        linear_extrude(height = LEN+2*EDGE)
         polygon( points=[[-EDGE_H,-EDGE],[-EDGE_H,LEN+EDGE],[GAP,-EDGE]]  );
    
 }
 
// limit the block to the wedge, gives it the right slope.
intersection () 
 {
      Circ (); 
      CircBlock ();
     // block ();
     wedge ();
  }
  
