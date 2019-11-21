/**
 ** Title: coaster for pepper mill
 ** Author: Angel3D
 ** Date: 17.03.2019
 ** thingiverse url: https://www.thingiverse.com/thing:3500233
 **/
 
// define variables section
COASTER_ROUDNESS=64;             // perfection of a round object (32 = nice roundness)
COASTER_INNER_DIAMETER=55;       // inner diameter of coaster
COASTER_WALL_THICKNESS=4;        // thickness of coaster wall
COASTER_BOTTOM_THICKNESS=4;      // thickness of bottom
COASTER_OUTTER_DIAMETER_DIFF=10; // outter diameter of the base bottom part
                                 // values >0 let the base become a cone  
COASTER_WALL_HEIGTH=10;          // height of the walls, starting from top of base part     
ROUND_EDGES_THICKNESS=1;         // define thickness of round edges (ENABLE_ROUND_EDGES must be set to true to enable)
ENABLE_ROUND_EDGES=false;        // enalble or desable round edges
 
// display section
if (ENABLE_ROUND_EDGES) {
  minkowski(){
    coaster();
    sphere(ROUND_EDGES_THICKNESS);
  }
}
else {
  coaster();
}


// modules section
module coaster(){
  difference(){
    coasterBase();
    translate([0,0,COASTER_BOTTOM_THICKNESS/2]){
      coasterInner();   
    }
  }
}

module coasterInner() {
  cylinder(COASTER_WALL_HEIGTH,d=COASTER_INNER_DIAMETER+ROUND_EDGES_THICKNESS,center=true, $fn=COASTER_ROUDNESS);
}

module coasterBase(){
  cylinder(COASTER_BOTTOM_THICKNESS+COASTER_WALL_HEIGTH,d1=COASTER_INNER_DIAMETER+COASTER_OUTTER_DIAMETER_DIFF+(COASTER_WALL_THICKNESS*2),d2=COASTER_INNER_DIAMETER+(COASTER_WALL_THICKNESS*2),center=true, $fn=COASTER_ROUDNESS);
}