border = 4; // border around slots
cornerRadius = 3;

sdhcSlots = 7;
sdhcY = 26; // 24 wide
sdhcX = 3; // 2.1 thick long
sdhcZ = 16; // half of 32 high

microsdSlots = 4;
microsdY = 12; // 11 wide
microsdX = 2; // 1 thick
microsdZ = 8; // half of 15 high

holderX = border + sdhcX*sdhcSlots + border*sdhcSlots + microsdX*microsdSlots + border*microsdSlots;
holderY = sdhcY + 2*border;
holderZ = sdhcZ + border;

translate([holderY-cornerRadius,cornerRadius,holderZ]) {
    rotate([180,0,180]) {
        difference() {
            // rounded box
            if ((sdhcSlots > 0) && (microsdSlots > 0)) {
                roundedBox(holderX+border, holderY, holderZ, cornerRadius);
            }
            else {
                roundedBox(holderX, holderY, holderZ, cornerRadius);
            }

            // sdhc slot holes
            rotate([90,0,90])
                slots(sdhcY, sdhcX, sdhcZ, sdhcSlots);

            // microsd slot holes
            translate([sdhcY-microsdY, border + sdhcX*sdhcSlots + border*sdhcSlots, 0])
                rotate([90,0,90])
                    slots(microsdY, microsdX, microsdZ, microsdSlots);
        }
    }
}

// functions
module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01, $fn=200);
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
