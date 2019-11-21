/*
 * Bearing generator v1.0
 * 
 * http://www.thingiverse.com/thing:1729699
 *
 * By: Maxstupo
 */
 
// (The outer diameter for the outer ring, in mm):
outerDiameter = 22;

// (The inner diameter for the inner ring, in mm):
innerDiameter = 8;

// (The thickness of the outer ring, in mm):
outerRingThickness = 5;

// (The thickness of the inner ring, in mm):
innerRingThickness = 4;

// (The height of the bearing, in mm):
height = 7;

// (How deep the races carved into the rings, in mm):
ballEngageAmount = 1.5;

// (The number of ball bearings):
ballCount = 8;

// (The space between the balls and the races, in mm):
ballTolerance = 0.5;

// (If true no ball bearings will be generated):
genPlaceHolder = false; // [true,false]

// (If true the outer ring will have a fillet):
filletOuterRing = true; // [true,false]

// (If true the inner ring will have a fillet):
filletInnerRing = false; // [true,false]

// (The amount to fillet):
filletAmount = 1; // [0:0.1:2]

/* [Misc] */
facetsRings = 25; // [20:100]
facetsBalls = 25; // [20:100]  
facetsRaces = 25; // [20:100]

ballDiameter = ((outerDiameter - outerRingThickness) - (innerDiameter + innerRingThickness)) / 2 + ballEngageAmount;

module hollowCone(dia1,dia2,height,thickness=1,fn=50) {
    difference() {
        cylinder(d=dia1,d2=dia2,h=height,$fn=fn);
        cylinder(d=dia1-thickness,d2=dia2-thickness,h=height,$fn=fn);
    }
}



if(genPlaceHolder) {
   
   difference() {
       cylinder(h=height,d=outerDiameter,$fn=facetsRings,center=true);
       cylinder(h=height,d=innerDiameter,$fn=facetsRings,center=true);
       
    
       if (filletOuterRing) {
           fHeight=height/2;
           // Fillet top of outer ring.
           translate([0,0,fHeight / 2]) hollowCone(outerDiameter+2,outerDiameter-2,fHeight,filletAmount,facetsRings); 
           
           // Fillet bottom of outer ring.
           translate([0,0,-fHeight - fHeight/2]) hollowCone(outerDiameter-2,outerDiameter+2,fHeight,filletAmount,facetsRings);
       }
       
           
        if (filletInnerRing) {
            fHeight=height/2;
 
            // Fillet top inner of inner ring.
            translate([0,0, fHeight/2]) hollowCone(innerDiameter +filletAmount-2,innerDiameter+filletAmount+2,fHeight,filletAmount,facetsRings); 
    
            // Fillet bottom inner of inner ring.
            translate([0,0,-fHeight - fHeight/2]) hollowCone(innerDiameter +filletAmount+2,innerDiameter+filletAmount-2,fHeight,filletAmount,facetsRings); 
        }
   }
} else{ 

    union() {
        difference() {
                
            // Create two rings.
            union() {
                // Create outer ring.
                difference() {
                    color("green") cylinder(h=height , d=outerDiameter, $fn=facetsRings, center=true);
                    cylinder(h=height, d=outerDiameter - outerRingThickness, $fn=facetsRings, center=true);
                
                  
                    if (filletOuterRing) {
                        fHeight=height/2;
                        // Fillet top of outer ring.
                      translate([0,0,fHeight / 2]) hollowCone(outerDiameter+2,outerDiameter-2,fHeight,filletAmount,facetsRings); 
                       
                        // Fillet top inner of outer ring.
                       translate([0,0, fHeight/2]) hollowCone(outerDiameter +filletAmount- outerRingThickness-2,outerDiameter+filletAmount- outerRingThickness+2,fHeight,filletAmount,facetsRings); 
                        
                        // Fillet bottom of outer ring.
                        translate([0,0,-fHeight - fHeight/2]) hollowCone(outerDiameter-2,outerDiameter+2,fHeight,filletAmount,facetsRings); 
                        
                        // Fillet bottom inner of outer ring.
                        translate([0,0,-fHeight - fHeight/2]) hollowCone(outerDiameter +filletAmount- outerRingThickness+2,outerDiameter+filletAmount- outerRingThickness-2,fHeight,filletAmount,facetsRings); 
                    }
                }
                
                // Create inner ring.
                difference() {
                    color("green") cylinder(h=height , d=innerDiameter + innerRingThickness, $fn=facetsRings, center=true);
                    cylinder(h=height, d = innerDiameter, $fn=facetsRings, center=true);
             
                 
                    if (filletInnerRing) {
                        fHeight=height/2;
                        // Fillet top of inner ring.
                        translate([0,0,fHeight / 2]) hollowCone(innerDiameter+innerRingThickness+2,innerDiameter+innerRingThickness-2,fHeight,filletAmount,facetsRings); 
                       
                        // Fillet top inner of inner ring.
                        translate([0,0, fHeight/2]) hollowCone(innerDiameter +filletAmount-2,innerDiameter+filletAmount+2,fHeight,filletAmount,facetsRings); 
                        
                        // Fillet bottom of inner ring.
                        translate([0,0,-fHeight - fHeight/2]) hollowCone(innerDiameter+innerRingThickness-2,innerDiameter+innerRingThickness+2,fHeight,filletAmount,facetsRings); 
                        
                        // Fillet bottom inner of inner ring.
                        translate([0,0,-fHeight - fHeight/2]) hollowCone(innerDiameter +filletAmount+2,innerDiameter+filletAmount-2,fHeight,filletAmount,facetsRings); 
                    }
                } 
                 
            }
            
                // Create the inner and outer races for the balls to roll in.
                rotate_extrude(convexity=10, $fn=facetsRaces)
                translate([(ballDiameter / 2 + (innerDiameter + (innerRingThickness)) / 2) - ballEngageAmount / 2, 0, 0])
                circle(d=ballDiameter + ballTolerance, $fn=facetsRaces);  
                
        }


       
        /* -------------- CREATE BALL BEARINGS --------------- */
        for (i = [0 : (360 / ballCount) : 360]) {
            distance = (ballDiameter / 2 + (innerDiameter + (innerRingThickness)) / 2) - ballEngageAmount / 2;
            
            x = distance * cos(i);
            y = distance * sin(i);
            
            color("red") translate([x, y, 0]) sphere(d=ballDiameter, $fn=facetsBalls, center=true);
        }
        
    }
}