// Case Radius (main body radius)
caseRadius = 25;
// Case Quality (number of poligons for case, 10 will be looked like faceted body and 150 will be looked like smooth sphere)
caseQuality = 12; // [10:150]
// Case Hat Face (top will be cutted with this offset, must be relative with Case Radius)
caseHatFace = 4;

// Case Bracing (is screw bracing enabled)
caseBracingEnabled = 1; // [1:Yes, 0:No]
// Radius of Screw for Bracing (rod radius, not a cap radius)
caseBracingScrewRadius = 3;
// Radius of Screw Cap for Bracing (rod radius, not a cap radius)
caseBracingScrewCapRadius = 5;
// Screw Offset from Wall
caseBracingScrewHeight = 3;

// Radius of Wire
wireRadius = 3.5;
// Wire Hole Offset from Center
wireClousereOffset = 1;
// Wire Hole Type (gap - hole with gap at bottom of hole, none - just a hole, latch - part will be splited in two parts, with hole at cutting line)
wireBracingType = "gap"; // [gap, latch, none]

module copy_mirror(vec=[0,1,0]) 
{ 
    children(); 
    mirror(vec) children(); 
}

module copy_translate(vec=[0,1,0]) 
{ 
    children(); 
    translate(vec) children(); 
}

module case (radius, quality, hatFace = 0) {
    module main() {
        difference() {
            sphere(radius, $fn = quality);
            translate([0, 0, -radius]) {
                cube(radius * 2, true);
            }
        }   
    }
    
    module bracing(length, height, screwRadius, screwCapRadius, screwCapHeight) {
        cylinder(height, screwCapRadius, screwCapRadius, false);
        translate([0, -screwCapRadius, height - screwCapHeight]) {
            cube([length, screwCapRadius * 2, screwCapHeight], false);
        }
        translate([length, 0, height - screwCapHeight/2]) { 
            cylinder(screwCapHeight, screwCapRadius, screwCapRadius, true);
        }
        translate([0, -screwRadius, 0]) cube([length, screwRadius * 2, height], false);
        translate([length, 0, 0]) cylinder(height, screwRadius, screwRadius, false);
    }
    
    difference() {
        main(); 
        if (caseBracingEnabled) {
           translate([-radius / 3, 0, 0]) {
            copy_mirror() translate([0, radius / 2, 0]) bracing(radius / 3, caseBracingScrewHeight * 2, caseBracingScrewRadius, caseBracingScrewCapRadius, caseBracingScrewHeight);
        } 
        }
        translate([-radius, -radius, radius - hatFace]) cube(radius * 2, radius * 2, radius * 2);  
    }
}

module wire(radius, caseRadius, offset, withLatch = true, outerLatch = false) {
    latchJoinR = 3;
    
    union() {
        translate([0, 0, caseRadius/2 - radius/2 - offset]) {
            rotate([0, 90 , 0]) {
                cylinder(caseRadius * 2, radius, radius, true);
            }
        }
        
        if (wireBracingType == "gap") {
            cube([caseRadius * 2, 1, (caseRadius/2 - radius/2 - offset) * 2], true);     
        } 
        
        if (withLatch && wireBracingType == "latch") {            
           if (outerLatch) {
              latchJoinR = latchJoinR - 3;
           }
            
           copy_mirror() translate([-caseRadius, 0, caseRadius/2 - radius/2]) {
                rotate([75, 0, 0]) {
                    cube([caseRadius * 2, caseRadius, caseRadius * 2], false);
                    translate([caseRadius, 0, 0]) copy_mirror([1, 0, 0]) translate([-caseRadius * 0.5, 0, caseRadius * 0.4]) rotate([90, 0, 0]) {
                        if (!outerLatch) {
                            cylinder(caseRadius / 4, latchJoinR, latchJoinR); 
                        }
                        if (outerLatch) {
                            cylinder(caseRadius / 4, latchJoinR - 1, latchJoinR - 1); 
                        }
                    }
                }
            }
        }
    }
}

difference() {
    case(caseRadius, caseQuality, caseHatFace);
    wire(wireRadius, caseRadius, wireClousereOffset);
}

if (wireBracingType == "latch") {
   translate([0, 0, caseRadius - caseHatFace]) rotate([180, 0, 0]) translate([caseRadius * 2, 0, 0]) {
     difference() {  
         intersection() {
              case(caseRadius, caseQuality, caseHatFace);
              wire(wireRadius, caseRadius, wireClousereOffset, true, true);
         }  
         wire(wireRadius, caseRadius, wireClousereOffset, false);
     }
   }
}
