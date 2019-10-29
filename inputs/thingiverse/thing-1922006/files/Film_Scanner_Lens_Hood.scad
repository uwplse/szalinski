// Focal Distance is offset by 3mm as that is the thickness of the scanner top plates. You may need to adjust further if your glass sits back a little in the lens.
focalDistance = 50;

// Outer ring height - used to stabilize the camera and block light.
lensRingHeight = 15;

// Probably your true lens diameter.  Size of the opening in the lens hood.
lensInnerDiameter = 45; 

// Outer diameter of your lens, determines the size of the outer ring that surrounds it.
lensOuterDiameter = 55; 

// Determines how think you'd like the walls of the unit to be.
wallThickness = 2; 


translate([0,0,-3]){
    translate([0,0,focalDistance-3]){
        difference(){
            cylinder(h=2,d=lensOuterDiameter,$fn=50);
            translate([0,0,-1]){cylinder(h=5,d=lensInnerDiameter,$fn=50);}
        }
    }

    difference(){
        //outside
        union(){
            translate([0,0,focalDistance-3]){
                cylinder(h=lensRingHeight,d=lensOuterDiameter+wallThickness*2,$fn=50);
            }
            hull(){
                translate([0,0,focalDistance-lensRingHeight-3]){
                    cylinder(h=lensRingHeight,d=lensOuterDiameter+wallThickness*2,$fn=50);
                }
                translate([-100.8/2-wallThickness, -70.8/2-wallThickness,3]){
                    cube([100.8+wallThickness*2, 70.8+wallThickness*2, 5.125]);
                }
            }
        }
        
      //inside  
        union(){
            translate([0,0,focalDistance-2-3]){
                cylinder(h=lensRingHeight+10,d=lensOuterDiameter,$fn=50);
            }

            hull(){
                translate([0,0,focalDistance-lensRingHeight-3]){
                    cylinder(h=lensRingHeight,d=lensOuterDiameter,$fn=50);
                }
                translate([-100.8/2, -70.8/2,1]){
                    cube([100.8, 70.8, 5.125+2]);
                }
            }
        }
    }
}