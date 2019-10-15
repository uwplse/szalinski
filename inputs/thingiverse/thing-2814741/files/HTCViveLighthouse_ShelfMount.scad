// Slide mount for HTC Vive lighthouses
// This uses the wall mounts that come with the vive

BuildShelfMount();

// in mm
shelfThickness = 20; // SET THIS to the thickness of the shelf the mount will slot onto
// How thick the underneath bit and connector is
clampThickness = 5;
// How far under the shelf it'll go
clampLength = 40;

// Thickness of the plastic around the bracket
surround = 2;

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

module BuildShelfMount(){
    rotate([90, 0, 0]){
        union(){
            BaseClip(surround);
            
            // This is the bit underneath the shelf
            translate([-(clampThickness+shelfThickness), -(bWidth+surround*2)/2, ]){
                cube([clampThickness, bWidth+surround*2, clampLength]);
            }
            // Connecting piece
            translate([-(clampThickness+shelfThickness), -(bWidth+surround*2)/2, ]){
                cube([clampThickness+shelfThickness, bWidth+surround*2, clampThickness]);
            }
        }
    }    
}







