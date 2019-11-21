 
//  Created by Jeshua Lacock on 11/16/2012.
//  Copyright 2012 3DTOPO INC. All rights reserved.
//  http://3DTOPO.com

switchHolesAboveSlotHoles = 71.0;	// The height of the top switch holes above the T Slot holes on center 
									// this determines the height of the switch above the T Slot
thickness = 7.0;  //Plate thickness
baseWidth = 70.0; //This is what attaches to the T slot.

switchHolesWidth = 21.5; //The width of the switch holes on center
switchHolesHeight = 10.5; //The height of the switch holes on center

tSlotHoleDiameter = 7.0/2;
switchHoleDiameter = 3.7/2;

// You shouldn't need to adjust these
tSlotHoleHeight = (tSlotHoleDiameter * 2);
height = switchHolesAboveSlotHoles - 1 + (tSlotHoleHeight * 2);
topWidth = switchHolesWidth + 10.0;  //needs to be wide enough for the switch holes
holeResolution = 20; //The higher the number, the smoother the holes, but the longer it takes to render

color("SeaGreen")

rotate([0,90,0]) {

difference() {

  ////////////////////////////////// Main Mount ////////////////////////////////// 
  polyhedron(
    points=[ [(thickness/2),(baseWidth/2),0],[(thickness/2),-(baseWidth/2),0],[-(thickness/2),-(baseWidth/2),0],[-(thickness/2),(baseWidth/2),0], // the four points at base
           [(thickness/2),(topWidth/2),height], [-(thickness/2),(topWidth/2),height], [(thickness/2),-(topWidth/2),height], [-(thickness/2),-(topWidth/2),height]  ],                                 
    triangles=[ 	[0,1,4],[1,2,6],[2,3,5],[3,0,4],
 				[3,4,5],[6,2,7], [4,1,6], [2,5,7],
				[5,6,7], [5,4,6], // two triangles for top base
              	[1,0,3], [2,1,3] ] // two triangles for bottom base
   );

  ///////////////////////////////// T Slot Holes /////////////////////////////////
  union() {
     for (y = [-1, 1]) {
        translate([0, (baseWidth/2 - (tSlotHoleHeight * 1.5)) * y, tSlotHoleHeight]) {
           rotate([0,90,0]) {
              cylinder (h = thickness + 1, r=tSlotHoleDiameter, center = true, $fn=holeResolution);
           }
        }
     }
  }

  ////////////////////////////// Switch Hole Slots //////////////////////////////
  // Note: even though my switches only have 2 holes, the 4 holes 
  // allow for it to be mounted facing either direction
  union() {

     for (z = [0, switchHolesHeight]) { //loop for top and bottom holes
        for (y = [-1, 1]) { //loop for left and right holes
           for (slot = [-1, -0.5, 0, 0.5, 1]) { //loop to make the slots
              translate([0, y * (switchHolesWidth/2), (tSlotHoleHeight + switchHolesAboveSlotHoles) + (slot * switchHoleDiameter) - z]) {
                 rotate([0,90,0]) {
                    cylinder (h = thickness + 1, r=switchHoleDiameter, center = true, $fn=holeResolution);
                 }  
              }
           }
        }
     }
  }
}
}

