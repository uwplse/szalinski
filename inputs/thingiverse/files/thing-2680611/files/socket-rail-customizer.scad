// Total length of rail
railLength = 140; //[20:5:500]
// Should a hanger be included?
includeHanger = 1; //[0,1]
// Should Rail Length be increased by 24mm to accomodate the hanger?
hangerAddsLength = 1; //[0,1]
// Add dovetail to the beginning of rail and remove beginning stop and hanger.
includeDovetailBegin = 0; //[0,1]
// Add dovetail to the end of rail and remove end stop.
includeDovetailEnd = 1; //[0,1]
// Tolerance of dovetail, the dovetail end will be this much smaller. Adjust to fit your printer
dovetailTolerance=0.2;
// Add 2 screw holes, remove the hanger
addScrewHole = 0; //[0,1]
//Add side mount, for use in shallow drawers to point long sockets sideway. Cancels hanger and screwhole
addSideMount = 1;//[0,1]
// screw dimension, adjust based on your screw
screwCapWidth=8;
screwCapHeight=4;
screwStemWidth=5;

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

// Dovetail dimension
dovetailWidthShort=7;
dovetailWidthLong=12;
dovetailLength=10;

//screwhole offset
screwHoleOffset=dovetailLength+10;  // to make sure it does not fall into dovetail

//side mount dimension
sideMountThickness = 7;
sideMountHeight = 16;
clipEndThickness = 3;

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
        if(!includeDovetailBegin){
            translate([0,-overhangDepth-stopDepth,0]) cube([stopLength, width+2*(overhangDepth+stopDepth), overhangHeight]);
        }
        if(!includeDovetailEnd){
            translate([length-stopLength,-overhangDepth-stopDepth,0]) cube([stopLength, width+2*(overhangDepth+stopDepth), overhangHeight]);
        }
        if(includeDovetailEnd){
            translate([length,width/2,0])dovetail(dovetailTolerance);

        }
        if(addSideMount){
            sidemount();    
        }    
    } // End union, begin difference
    if(!includeDovetailBegin){
        if(!addScrewHole){
            if(!addSideMount){
                if (includeHanger) {
                    hanger();
                }
            }
        }
    }
    if(includeDovetailBegin){
        translate([0,width/2,0])dovetail(0);
    }
    if(!addSideMount){
        if(addScrewHole){
            translate([screwHoleOffset,width/2,0])screwhole();
            translate([length-screwHoleOffset,width/2,0])screwhole();
        }
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

module sidemount() {
    difference(){
        translate([0,width-sideMountThickness+hangerThickness+clipEndThickness,height+sideMountHeight-4])
        rotate(a=[0,90,0])
        linear_extrude (height=length)
        polygon([[0,0],[0,sideMountThickness],[sideMountHeight-4,sideMountThickness],[ sideMountHeight,0]]);
    
    translate([20,width-sideMountThickness+hangerThickness+clipEndThickness-1, height+sideMountHeight-2-screwCapWidth])
    rotate(a=[270,0,0])
    screwhole();
        
    translate([length-20,width-sideMountThickness+hangerThickness+clipEndThickness-1, height+sideMountHeight-2-screwCapWidth])
    rotate(a=[270,0,0])
    screwhole();
    }

}

module dovetail(tolerance) {
    linear_extrude (height=height)
    polygon([[0,(dovetailWidthShort/2)-tolerance],[dovetailLength-tolerance,(dovetailWidthLong/2)-tolerance],[dovetailLength-tolerance,-(dovetailWidthLong/2)+tolerance],[0,-(dovetailWidthShort/2)+tolerance]]);
}

module screwhole(){
    union(){
        cylinder(h=screwCapHeight,r1=screwCapWidth/2,r2=screwStemWidth/2);
        cylinder(h=height,r=screwStemWidth/2);
    }
}