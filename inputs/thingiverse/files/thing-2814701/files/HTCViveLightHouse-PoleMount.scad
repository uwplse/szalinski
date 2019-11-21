// Slide mount for HTC Vive lighthouses
// This uses the wall mounts that come with the vive

BuildPoleMount();

poleRadius = 8; // Set this to the radius of the pole you want to mount it on
usedPoleRadius = poleRadius * 1.07;

// Thickness of the plastic around the pole and bracket - 2 should be fine for most cases
surround = 2; // Thickness of the parts around the pole and base

/* [Hidden] */
// Approximate size of the lighthouse wall brackets
bThickness = 5;
bWidth = 44;
bLength = 50;

module BaseClip(housingSurround=2){
    
    
    // Mount around it
    housingOverlap = 4; // What it clips under
    housingThickness = (housingSurround * 2) + bThickness;
    housingWidth = (housingSurround * 2) + bWidth;
    housingLength = (housingSurround * 2) + bLength;
    
    translate([0, -(bWidth+(housingSurround*2))/2, 0]){        
        difference(){
            cube([housingThickness, housingWidth, housingLength]);
            translate([housingSurround, housingSurround, housingSurround]){
                cube([bThickness-1, bWidth, bLength+20]);
            }
            translate([housingSurround, housingSurround, housingSurround+25]){
                cube([bThickness, bWidth, bLength]);
            }
            translate([housingSurround, housingSurround+housingOverlap, housingSurround+housingOverlap]){
                cube([50, (bWidth - (housingOverlap * 2)), bLength+20]);
            }
            translate([housingSurround, housingSurround+(housingOverlap/2), housingSurround+housingOverlap+25]){
                cube([50, (bWidth - (housingOverlap)), bLength+20]);
            }
        }
    }
}

module PoleClip(holeSurround=2){
    
    difference(){
        cylinder(h=40, r=(usedPoleRadius + holeSurround), center=false);
        translate([0, 0, -1]){
            cylinder(h=50, r1=usedPoleRadius, r2=usedPoleRadius*0.95, center=false);
        }        
    }       
}

module BuildPoleMount(){
    union(){
        difference(){            
            rotate([0, -20, 0]){
                BaseClip(surround);
            }
            // Top cut
            translate([-50, -50, 45]){
                cube([50, 100, 40]);
            }
        }
        translate([-(16+poleRadius), 0, 0]){
                PoleClip(surround);
        }
        difference(){
            // Connecting bit
            translate([-(16+poleRadius), -(bWidth+(surround*2))/2, 0]){
                cube([50, bWidth+(surround * 2), 40]);
            }
            rotate([0, -20, 0]){
                translate([4+bThickness, -bWidth, -10]){
                    cube([40, bWidth*2, 80]);
                }
                translate([0, -bWidth, 2]){
                    cube([20, bWidth*2, 40]);
                }
            }
            // Side curves
            translate([-(16+poleRadius), bWidth/2+surround, -1]){
                cylinder(h=60, r=bWidth/2 - usedPoleRadius, center=false);
            }
            translate([-(16+poleRadius), -(bWidth/2+surround), -1]){
                cylinder(h=60, r=bWidth/2 - usedPoleRadius, center=false);
            }
            // Redo the pole hole
            translate([-(16+poleRadius), 0, -1]){
                cylinder(h=50, r1=usedPoleRadius, r2=usedPoleRadius*0.95, center=false);
            }          
        } 
    }   
}









