
/* [Parameters] */

parts = 3; // [3:both, 1:box_only, 2:lid_only]
addHandleHoles = 0; // [0:no, 1:yes]

width = 45;
depth = 35;
height = 25;

/* [Hidden] */
$fn = 32;
plankThickness = 1.2;
plankWidth = 5;
plankGap = 0.5;
gapDepth = 0.4;
ropeGap = 5;
ropeR = 1.1;

// preview[view:north east, tilt:top diagonal]

module crate(w, h, d, addHandle) {
    
    if (addHandle) {
        
        difference() {
        difference() {
        
        crateMain(w,h,d);
        
        translate([-w/2,d/2+ropeGap/2,h-(plankWidth/2)])
        rotate([0,90,0])
        cylinder(r=ropeR, h=w*2);
        }
        translate([-w/2,d/2-ropeGap/2,h-(plankWidth/2)])
        rotate([0,90,0])        
        cylinder(r=ropeR, h=w*2);
    }
    }
    else {
        crateMain(w,h,d);
    }

}

module crateMain(w, h, d) {
    
    pnumH = floor(h / plankWidth);
    modPlankH = (h - ((pnumH-1) * plankGap)) / pnumH;

union() { 
    difference() {
    
    difference() {
        difference() {
            difference() {   
                difference() {
                    union() {
                        for (i = [0:pnumH-1]) {
                            translate([0, 0, i * (modPlankH + plankGap)])
                            cube([w, d, modPlankH]);
                        }
                        
                        translate([gapDepth,gapDepth,0])
                        cube([w-(2*gapDepth), d-(2*gapDepth), h]);
                    }
                
                    translate([-(10-gapDepth), plankThickness, 0])
                    cube([10, plankGap, h*2]);
                }
            translate([-(10-gapDepth), d-plankGap-plankThickness, 0])
            cube([10, plankGap, h*2]);
          }
            translate([w-gapDepth, plankThickness, 0])
            cube([10, plankGap, h*2]);
            }
        translate([w-gapDepth, d-plankGap-plankThickness, 0])
        cube([10, plankGap, h*2]);
    }    

    translate([plankThickness, plankThickness, plankThickness])
    cube([w-(plankThickness*2), d-(plankThickness*2), h*2]);
}

        mid = d/2;
        offset = mid * 0.6;

        // vertical planks
        translate([-plankThickness,mid+offset-plankWidth/2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([-plankThickness,mid-offset-plankWidth/2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([w,mid+offset-plankWidth/2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([w,mid-offset-plankWidth/2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);  
}
}

module lid(w, d) {
    
    pnumD = floor(d / plankWidth);
    modPlankD = (d - ((pnumD - 1) * plankGap)) / pnumD;
    
    
    
    union() {
        difference() {
        cube([w,d,plankThickness]);
    
        union() {
        for (i=[1:pnumD]) {
            translate([-w/2, i*modPlankD, plankThickness-plankGap])
            cube([w*2, plankGap, 10]);
        }
        translate([0, 0, plankThickness*3])
        cube([w, d, 10]);
        }
    }
        mid = w/2;
        offset = mid * 0.6;
        
        translate([mid+offset - plankWidth/2,0,plankThickness])
        cube([plankWidth, d, plankThickness+0.01]);

        translate([mid-offset - plankWidth/2,0,plankThickness])
        cube([plankWidth, d, plankThickness+0.01]);
    }    
}

module crateOld(w, h, d) {
    
    pnumH = round(h / plankWidth);
    modPlankH = h / pnumH;
    
    union() {
        difference() {
            cube([w,d,h]);
            translate([plankThickness,plankThickness,plankThickness])
            cube([w - (plankThickness*2), 
                d - (plankThickness*2), 
                h*2]);
        }
        
        for (i = [0:pnumH-2]) {
            translate([-(w/2), 0, (i+1) * modPlankH])
            cube([w*2, 10, plankGap]);
        }
        
        // vertical planks
        translate([-plankThickness, d-plankWidth-2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([-plankThickness,2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([w,d-plankWidth-2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);
        
        translate([w,2,0])
        cube([plankThickness+0.01, plankWidth, h+plankThickness]);    
    }
}

module lidOld(w, d) {

    union() {
        cube([w,d,plankThickness]);
        
        mid = w/2;
        offset = mid * 0.6;
        
        translate([mid+offset - plankWidth/2,0,plankThickness])
        cube([plankWidth, d, plankThickness+0.01]);

        translate([mid-offset - plankWidth/2,0,plankThickness])
        cube([plankWidth, d, plankThickness+0.01]);
    }
}



module fullCrate(w, h, d, addHandle, parts) {
    
    if (parts > 0) {    
        if (parts % 2 == 1) {
        
        crate(w, h, d, addHandle);
        }
        
        if (parts > 1) {
            translate([0,d+5,0])
            lid(w, d);
        }
    }
}





fullCrate(width, height, depth, addHandleHoles, parts);
 
