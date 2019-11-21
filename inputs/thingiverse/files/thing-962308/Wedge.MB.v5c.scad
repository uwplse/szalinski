/** Create Wedge **/
/*      
Universal Adjustabel Wedge by Chris Schaefer is licensed under the Creative Commons - Attribution - Non-Commercial license. 
*/

// MB Interface

/* [Slope] */
// from leg to leg
Slope_Length=120;
// how high is the gap? equals the wedge hight
Gap_Height=10;

/* [Wedge Size] */
// how wide is the wedge? along the gap
Wedge_X=30;
// length of the wedge, along the slope
Wedge_Y=40;

// Should the wedge have edges to prevent rolling off?
/* [Edge] */
// the width will be added around the wedge
Edge_Width=3.0;
// the hight will be added to the gap size.
Edge_Height=2.0;


// Interface End
/* [Hidden] */
// Length
LEN=Slope_Length; 
// Gap 
GAP=Gap_Height;

// Block size
/* [Block Size] */
// width (width at the max hight)
X=Wedge_X;
// length (length along the slope)      
Y=Wedge_Y;

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


 
 
module wedge () {
    // Wedge with the right slop
        // shift and rotate it into place
            translate ( [-EDGE,-0,GAP] )
            rotate ([0,90,0])
        // wedge
        linear_extrude(height = X+2*EDGE)
         polygon( points=[[-EDGE_H,-EDGE],[-EDGE_H,LEN],[GAP,-EDGE]]  );
    
 }
 
// limit the block to the wedge, gives it the right slope.
intersection () 
 {
      block ();
      wedge ();
  }
  
