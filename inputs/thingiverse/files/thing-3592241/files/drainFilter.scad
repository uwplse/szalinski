// Filter for easy drain.
// An easy drain is one of these long drains found in more modern shower
// https://www.google.com/search?q=easy+drain
// This filter is desiged to fit under the easy drain and allow as much water
// to be passed through and at the same time block hairs

// Size of the extruder
extruderSize = 0.4;          // [0.3, 0.4, 0.5]

// Number of lines to use for vertical walls
verticalWallLines = 3;       // [2,3,4,5]

// Tickness of horizontal planes
horizontalPlaneTickness = 1;

hexaconThickness = 1.8;

// Diameter of the drain. Some tolerance will be added (see drainGap) to ensure it will fit your drain easely.
drainSize = 42;

// Size of the rim, this stops the filter from falling into the drain)
edgeRimWidth  = 2;

// Height of the insert into the drane
insertHeight = 5;

// Maximum height of the filter
maxFilterHeight = 12;       

// Circular Size of hexacon
holeSize = 8;               

// Offset of the ring to finetune the model
ringOffset = 1;


/* [Hidden] */

// gap to keep between the drain and the filter
drainGap = 1;

// Calculated drain size with gap included
drainSizeTolerance = drainSize - drainGap;             

vertWallThickness = extruderSize * verticalWallLines;

// Radius of the drain
drianR = drainSizeTolerance / 2;

// size of the rim when used in diameter circular objects
edgeRimSize  = edgeRimWidth * 2;
// height of the rim
edgeRimHeight = edgeRimSize / 2;

pi=3.141592653589793238;
$fn=180;

base();
ring();
top();
//color([0,0,1]) {
//    cylinder(h=maxFilterHeight, d=10);
//}

module base() {
    // Support for ring, mainly used for correct printing
    color([0.5,0.6,1]) {
        rotate_extrude()
           translate([drianR, 0, 0])
               polygon(points=[
                    [-vertWallThickness,-insertHeight],
                    [-vertWallThickness,edgeRimHeight],
                    [edgeRimWidth,0.5], [edgeRimWidth,0],
                    [0,0],[0,-insertHeight]]);
    }

    // Litle seperators to ensure some water can seep under the filter
    // so the easy drain will always empty
    degreesSep = 15;    
    for (i = [0 : (360/degreesSep)]) {
        rotate([0,0,i*degreesSep]) {
            translate([drianR+0.1,0,0])
            rotate([0,90,0])
                rotate([0,0,90])
                    color([0,0,0]) {
                        cylinder(d=0.5, h=edgeRimWidth-0.3, $fn=6);
                    }
        }
    }
}



function centerEdge() 
     = (holeSize/2) * sin(360 / 6); // distance center to Edge perpendicular    



module top() {
    dx = centerEdge(); 

     // Honeycob structure top
    items = ceil(drainSizeTolerance / (dx * 2 + horizontalPlaneTickness) / 2) + 1;
    color([1,0.6,0.5]) {
        translate([0, 0, maxFilterHeight - horizontalPlaneTickness+0.001]) {
            

            linear_extrude(height=horizontalPlaneTickness) {
                // Ring around
                difference() {
                    circle(d=drainSizeTolerance+0.001);          
                    circle(d=drainSizeTolerance-vertWallThickness*2);  
                }
                
                difference()
                {
                    circle(d=drainSizeTolerance);                  
                    for (x = [-items/2-1:items/2]) {
                        for (y = [-items*2-1:items*2]) {                    
                            translate([
                            x*(holeSize+holeSize/2) + ((holeSize+holeSize/2)/2) * abs(y%2),                 
                            y*dx + (dx*2) * abs(y%2)])
                                circle(d=holeSize-hexaconThickness, $fn=6);
                        }
                    }
                }    
            }
        }
    }

}


module ring() {
    dx = centerEdge(); 
    itemsAround = floor(drainSizeTolerance * pi / (holeSize + dx));
    itemsInHeight = floor (maxFilterHeight / (dx*2));    
    angle = 360 / itemsAround;   
    calculatedHeight = dx*itemsInHeight + edgeRimHeight;
    color([0.6,1,0.5]) {
        difference() 
        {
        
            difference() {
            cylinder(h=maxFilterHeight, d=drainSizeTolerance);
                translate([0,0,-0.001])
            cylinder(h=maxFilterHeight+0.002, d=drainSizeTolerance-vertWallThickness*2+0.001);
            }
//            linear_extrude(height=maxFilterHeight) {
//                difference() {
//                    circle(d=drainSizeTolerance);          
//                    circle(d=drainSizeTolerance-vertWallThickness*2+0.001);  
//                }
//            }

            for (z = [-2: itemsInHeight+2]) {
                translate([0, 0, z * dx + edgeRimHeight])
                    rotate([0, 0, angle/2 * (z % 2)])
                        for (rot = [0: itemsAround]) {
                            rotate([0, 0, angle * rot])
                                translate([0,drianR,edgeRimHeight*0.9 + ringOffset])
                                    rotate([90,0,0])
                                        linear_extrude(height=horizontalPlaneTickness*2)
                                            circle(d=holeSize-hexaconThickness, $fn=6);
                        }
             }
        }
    }
}