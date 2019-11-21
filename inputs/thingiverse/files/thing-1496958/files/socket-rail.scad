// Total length of rail
railLength = 140; //[20:5:500]
// Should a hanger be included?
includeHanger = 1; //[0,1]
// Should Rail Length be increased by 24mm to accomodate the hanger?
hangerAddsLength = 1; //[0,1]

module dragons() {
    // All variables beyond this point can be tuned, but may result in a rail that is incompatible with the clips it's designed to work with.
}

//  Items tagged with "compatibility" will create a rail that does not work with commercial clips.
//  All values here are designed to create something that's pretty close to a commercially available rail system.

// Lips that socket clips attach to
overhangDepth = 2; // Warning: compatibility
overhangHeight = 2; // Warning: compatibility
stopDepth = 1;
stopLength = 5;
toothDepth = .3;
toothPitch = 1;

// The hanger inset
hangerLength = 20;
hangerThickness = 2;
hangerBorder = 2;
hangerEndOffset = 2;
hangerSlotWidth = 5;
hangerSlotRadius = hangerSlotWidth/2;
hangerFlairBorder = 1;
hangerSlotFlairWidth = 9;
hangerSlotFlairRadius = hangerSlotFlairWidth /2;

// Overall dimensions
length = includeHanger && hangerAddsLength ? railLength + hangerLength + hangerBorder : railLength;
height = 9;
width = 20; // Does not include lips/stops. Warning: compatibility

booleanFudgeFactor = 0.001 * 1; // Thanks customizer! I didn't realize I needed to do this and was doing a full render to see my booleans. 

difference() {
    union() {
        // Body
        cube([length, width, height]);

        // Base lips
        // Doesn't print well due to overhang. Not functional except maybe to make base wider.
        // translate([0,-overhangDepth,height-overhangHeight]) cube([length, overhangDepth, overhangHeight]);
        // translate([0,width,height-overhangHeight]) cube([length, overhangDepth, overhangHeight]);

        // Toothed lips
        translate([length,0,0]) rotate([0,0,180]) toothedLip(length);
        translate([0,width,0]) toothedLip(length);

        // Stops
        translate([0,-overhangDepth-stopDepth,0]) cube([stopLength, width+2*(overhangDepth+stopDepth), overhangHeight]);

        translate([length-stopLength,-overhangDepth-stopDepth,0]) cube([stopLength, width+2*(overhangDepth+stopDepth), overhangHeight]);
    }
    if (includeHanger) {
        hanger();
    }
}

module toothedLip(length) {
    cube([length, overhangDepth-toothDepth, overhangHeight]);
    for( i = [0 : toothPitch : length-toothPitch]) {
        translate([i,overhangDepth-toothDepth,0]) tooth();
    }
}

module tooth() {
    linear_extrude(height=overhangHeight, slices=2) polygon([[0,0],[toothPitch, 0],[toothPitch/2, toothDepth]],[[0,1,2]]);
}

module hanger() {
    hangerWidth = width - (2*hangerBorder);
    translate([hangerBorder + hangerEndOffset, (width-hangerWidth)/2, hangerThickness]) cube([hangerLength,hangerWidth, height-hangerThickness+booleanFudgeFactor]);
    translate([hangerBorder + hangerEndOffset + hangerSlotRadius, width/2, -booleanFudgeFactor]) cylinder(h = hangerThickness+(2*booleanFudgeFactor), r=hangerSlotRadius, $fn=60);
    translate([hangerBorder + hangerEndOffset + hangerLength - hangerSlotFlairRadius - hangerFlairBorder, width/2, -booleanFudgeFactor]) cylinder(h = (hangerThickness+2*booleanFudgeFactor), r=hangerSlotFlairRadius, $fn=60);
    hangerSlotLength=hangerLength - hangerSlotRadius - hangerSlotFlairRadius - hangerFlairBorder;
    translate([hangerBorder + hangerEndOffset + hangerSlotRadius, (width - hangerSlotWidth)/2, -booleanFudgeFactor]) cube([hangerSlotLength,hangerSlotWidth,hangerThickness + (2*booleanFudgeFactor)]);
}