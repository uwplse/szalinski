slotBorder = 3; // border around slots

microsdSlots = 4;
microsdWidth = 12; // 11 wide
microsdThickness = 2; // 1 thick
microsdDepth = 8; // half of 15 high
microsdHolderDepth = slotBorder + microsdThickness*microsdSlots + slotBorder*microsdSlots;

sdhcSlots = 5;
sdhcWidth = 26; // 24
sdhcThickness = 3; // 2.1
sdhcDepth = 16; // half of 32
sdhcHolderDepth = slotBorder + sdhcThickness*sdhcSlots + slotBorder*sdhcSlots;

holderWidth = sdhcWidth + 2*slotBorder;
holderHeight = sdhcDepth + slotBorder;

// makes solid holder block
module basicBlock(holderDepth) {
    linear_extrude(height=holderWidth, convexity=2)
        polygon(points = [ [0, 0],
            [holderDepth, 0],
            [holderDepth, holderHeight],
            [0, holderHeight] ]);
}

// makes slot holes
module slots(width,thickness,numslots) {
    for (i = [0 : numslots-1]) {
        translate([i*(slotBorder+thickness), 0])
            translate([slotBorder, slotBorder,0])
                translate([0,0,slotBorder])
                    cube(size=[thickness, holderHeight, width]);
    }
}

// generate both parts
module SDCardHolder() {
    // sdhc
    translate([-sdhcHolderDepth/2,holderWidth/2,0])
        rotate([90,0,0])
            difference() {
                basicBlock(sdhcHolderDepth);
                slots(sdhcWidth, sdhcThickness, sdhcSlots);
            }

    // microsd
    translate([sdhcHolderDepth, 0, 0])
        translate([-sdhcHolderDepth/2,holderWidth/2,0])
            rotate([90,0,0])
            difference() {
                basicBlock(microsdHolderDepth);
                slots(microsdWidth, microsdThickness, microsdSlots);
            }
}

SDCardHolder();
