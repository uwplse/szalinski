
$fn=60;

includeSideFeet = true;
includeTopFeet = false;

buildLid = false;
buildBase = true;

pcbThickness = 1.6;
pcbWidth = 135;
pcbHeight = 125;
pcbPadding = 4;

width = pcbWidth + (2*pcbPadding);
height = pcbHeight +(2*pcbPadding);
depth = 28;

pcbXOffset = 4.5;
pcbYOffset = 2.5;
pcbZOffset = 9; // 11 worked well, but +1 for extra display space.
baseThickness = 1.5;

module pcb() {
pcbThickness = 1.6;
    // PCB actually has corners chopped but not modelling that here.
    cube([135, 125, pcbThickness]);
        
    // Ethernet
    translate([93, -1, pcbThickness]) {
        cube([18, 14, 14]);
    }
    
    // Power
    translate([23, -2, pcbThickness]) {
        cube([9, 19, 11]);
    }
    
    // Hole 1
    translate([15, 107, pcbThickness]) {
        cylinder(d=4, h=22);
    }
    
    // Hole 2
    translate([120, 15, pcbThickness]) {
        cylinder(d=4, h=22);
    }
    
    // Antenna
    translate([63, 117, pcbThickness+10]) {
        cube([10, 30, 10]);
    }
}

module noCornersCube(width, height, depth, cornerRadius) {
    
    //cube([width, height, depth]);
    union() {
        linear_extrude(height=depth) {
            // Square with corners cut.
            polygon([
            [cornerRadius,0],
            [width-cornerRadius, 0],
            [width, cornerRadius],
            [width, height-cornerRadius],
            [width-cornerRadius, height],
            [cornerRadius, height],
            [0, height-cornerRadius],
            [0, cornerRadius],
            [cornerRadius,0]
            ]);
        }
        
    }
}

module roundedCube(width, height, depth, cornerRadius) {
    
    //cube([width, height, depth]);
    union() {
        translate([cornerRadius,cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);   
        }
        translate([width-cornerRadius,cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        translate([cornerRadius,height-cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        translate([width-cornerRadius,height-cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        
        noCornersCube(width, height, depth, cornerRadius);
    }
}



module pcbHole(x,y) {
    translate([x,y,0]) {
        // 4.2mm for a M3 heat fit 
        #cylinder(d=4.2, h=pcbZOffset);
    }
}

module pcbHoles() {
    translate([pcbXOffset, pcbYOffset,baseThickness]) {
        // Screws holes.
        pcbHole(15, 107); 
        pcbHole(120, 15);
    }
}

module pcbMount(x,y, h, d) {
    translate([x,y,0]) {
        cylinder(d=d, h=h);
    }
}

module pcbMounts() {
    translate([pcbXOffset, pcbYOffset,0]) {
        pcbMount(15, 107, pcbZOffset, 9); 
        pcbMount(120, 15, pcbZOffset, 9);
        
        // Extra support mounts.
        pcbMount(15, 15, pcbZOffset, 6);
        pcbMount(120, 107, pcbZOffset, 6);
    }
}

module ethernetAndPowerCutouts(){
    translate([pcbXOffset, pcbYOffset,pcbZOffset + pcbThickness]) {
        // Ethernet
        translate([92, -5, 0]) {
            cube([20, 14, 15]);
        }
        
        // P0wer
        translate([22, -5, 0]) {
            cube([11, 22, 13]);
        }
    }        
}

module antennaHole() {
    translate([width/2, height+5, 20]) {
        rotate([90,0,0]) {
            #cylinder(d=7, h=10);
        }
    }
}

// Give a very slight flat edge to the Antenna hole
// to prevent rotation.
module antennaFlatEdge() {
    translate([(width-10)/2, (height)-1.5, 20-4]) { 
        cube([10,1.5, 1.5]);
    }
}

module lidMount(x,y, offsetx, offsety) {

    
    translate([x,y,0]) {
        difference() {
            union() {
                // -1.5 for lid inner thickness.
                cylinder(d=8, h=depth-1.5);
            }
            union() {
                translate([0,0,-1]) {
                    cylinder(d=4.4, h=depth);
                }
            }
        }
    }
}

lidScrewOffset = 5;

module lidMounts() {
offset = lidScrewOffset;

    lidMount(offset ,offset ,-2.5,-2.5);
    lidMount(offset ,height-offset , -2.5, 2.5);
    lidMount(width-offset ,height-offset, 2.5,2.5);
    lidMount(width-offset ,offset,2.5,-2.5 );
}

module addMountingLug(x,y) {
    translate([x,y,0]) {
        difference() {
            cylinder(d=16, h=4);
            cylinder(d1=5, d2=9, h=4.1);
        }
    }
}

module addSiteMountingLugs() {
xLugOffset = 7;
    addMountingLug(-xLugOffset,20);
    addMountingLug(-xLugOffset,height-20);
    addMountingLug(width+xLugOffset,20);
    addMountingLug(width+xLugOffset,height-20);
}

module addTopMountingLugs() {
xLugOffset = 20;
yLugOffset = 7;
    
    addMountingLug(xLugOffset,-yLugOffset);
    addMountingLug(width-xLugOffset,-yLugOffset);
    addMountingLug(xLugOffset,height+yLugOffset);
    addMountingLug(width-xLugOffset,height+yLugOffset);
    
    
    // Center
    addMountingLug(width/2,height+yLugOffset);
    addMountingLug(width/2,-yLugOffset);
}

module bodyMain() {
    difference() {
        union() {
            roundedCube(width, height, depth, 6);
        }
        union() {
            translate([1.5, 1.5, 2]) {
                roundedCube(width-3, height-3, (depth-baseThickness)+0.01, 5);
            }
            
            pcbHoles();
            
            ethernetAndPowerCutouts();     
     
            antennaHole();
        }
    }
    antennaFlatEdge();
    
}


module body() {
    difference() {
        union() {
            bodyMain();
            pcbMounts();
            lidMounts();
            
            if (includeSideFeet) {
                // Mounting Lugs
                addSiteMountingLugs();
            }
            if (includeTopFeet) {
                addTopMountingLugs();
            }
        }
        union() {
            pcbHoles();
        }
    }
}

// ================================================================

lidDepth = 2;

module lidHole(x,y) {
    translate([x,y,-0.1]) {
        cylinder(d=3, h=lidDepth+20);
        cylinder(d1=5, d2=3, h=2);
    }
}

module lidHoles() {
    lidHole(lidScrewOffset,lidScrewOffset);
    lidHole(lidScrewOffset,height-lidScrewOffset);
    lidHole(width-lidScrewOffset,height-lidScrewOffset);
    lidHole(width-lidScrewOffset,lidScrewOffset);
}

module lid() {
     difference() {
        union() {
            // Main lid...
            roundedCube(width, height, lidDepth, 6);
            
            // Inner lip.
            translate([1.6, 1.6, lidDepth]) {
                roundedCube(width-3.2, height-3.2, 1.5, 6);
            }
            

        }
        union() {
            translate([5, 5, 1.5]) {
                // Inner lid cutout
                roundedCube(width-10, height-10, lidDepth+5, 6);
            }
            
            lidHoles();
           
        }
    }
}
    

translate([pcbXOffset, pcbYOffset,pcbZOffset]) {
   // %pcb();
}

if (buildBase) {
    body();
}

if (buildLid ) {
    translate([0,0,35]) {
        lid();
    }
}
