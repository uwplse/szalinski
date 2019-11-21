border = 4; // border around slots
cornerRadius = 3;
text = "SD cards";
font = "Liberation Sans";
$fn = 200; // render quality

sdhcSlots = 3;
sdhcY = 25; // 24 wide
sdhcX = 3; // 2.1 thick
sdhcZ = 16; // half of 32 high

microsdSlots = 6; // this is doubled
microsdY = 12; // 11 wide
microsdX = 1.5; // 1 thick
microsdZ = 9; // 15 high

holderX = border + sdhcX*sdhcSlots + border*sdhcSlots + microsdX*microsdSlots + border*microsdSlots;
holderY = sdhcY + 2*border;
holderZ = sdhcZ + border;

// put it all together
difference() {
    completeHolder();
    embossedText();
}

// functions
module completeHolder() {
    translate([holderY-cornerRadius,cornerRadius,holderZ]) {
        rotate([180,0,180]) {
            difference() {
                // rounded box
                roundedBox(holderX, holderY, holderZ, cornerRadius);

                // sdhc slot holes
                rotate([90,0,90])
                    slots(sdhcY, sdhcX, sdhcZ, sdhcSlots);

                // microsd slot holes
                translate([sdhcY-microsdY, sdhcX*sdhcSlots + border*sdhcSlots, 0])
                    rotate([90,0,90])
                        slots(microsdY, microsdX, microsdZ, microsdSlots);
                        
                translate([sdhcY-2*microsdY-cornerRadius/2, sdhcX*sdhcSlots + border*sdhcSlots, 0])
                    rotate([90,0,90])
                        slots(microsdY, microsdX, microsdZ, microsdSlots);
            }
        }
    }
}

module embossedText() {
    translate([holderY-1,holderX/2,holderZ/2]) {
        rotate([90,0,90]) {
            linear_extrude(height=2) {
                text(text=text, font=font, valign="center", halign="center", size=(sdhcSlots+microsdSlots)*0.75);
            }
        }
    }
}

module roundedBox(length, width, height, radius) {
    dRadius = 2*radius;
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    }
}

module slots(Y,X,Z,numslots) {
    if (numslots > 0) {
        for (i = [0 : numslots-1]) {
            translate([i*(border+X), 0])
                translate([border-cornerRadius, -border,-cornerRadius])
                    translate([0,0,border])
                        cube(size=[X, Z+border, Y]);
        }
    }
}
