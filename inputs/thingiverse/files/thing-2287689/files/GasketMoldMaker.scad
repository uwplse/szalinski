// Customizable gasket mold maker v1.1
// By DrLex
// Released under Creative Commons - Attribution License

/* [General] */
// Inner diameter of the gasket (millimeters). To account for inaccuracies of printing and molding, you may want to set this to slightly less than the exact value.
InnerDiameter = 10.4; //[6:0.1:100]
// Outer diameter of the gasket. Again, adding a fraction of a mm here could be a good idea.
OuterDiameter = 16.1; //[7:0.1:102]
// The height of the gasket. For a perfectly square or circular profile, this needs to be (OD-ID)/2.
Thickness = 2.8; //[0.1:0.1:40]
// The shape of the gasket cross-section. In general, rounded square is probably preferable.
Shape = "rounded square"; // [square, rounded square, ellipse]
// Instead of a closed two-mold ‘sandwich’, make a single open mold. The upside is that you only need to print one mold and it will cure faster. The downside is that one side of your gasket will inevitably be square-shaped, and it could be more difficult to remove from the mold.
SingleMold = "no"; //[yes, no]

/* [Advanced] */
// For larger IDs, hollow areas will be created to save material. This is the wall thickness for those areas. You can set it to 0 to make them go all the way through.
InsideWallThickness = 0.8; //[0:0.1:10]

// (The following options are only applicable if SingleMold = no.) The number of vent channels in the top mold. You may want to use more for larger gaskets to reduce curing time.
VentChannels = 4; //[0:16]

// Size of the vent channels. If you want to try injection molding, set the number of channels to 2 and make them large enough to inject silicone through them.
VentChannelSize = 1.2; //[1:0.1:4]

// Tolerance on the alignment cone. You should tweak this such that the molds fit together with no gap in between, and no horizontal play between the halves.
AlignConeTolerance = 0.22; //[0:0.02:0.4]

/* [Hidden] */
GasketCenterRadius = (InnerDiameter + OuterDiameter) / 4;
GasketRadiusX = (OuterDiameter - InnerDiameter) / 4;
GasketRadiusZ = (SingleMold == "no" ? Thickness / 2 : Thickness);
SquishFactor = GasketRadiusZ / GasketRadiusX;

MoldRadius = OuterDiameter / 2 + 1.6;
MoldThickness = GasketRadiusZ + 0.8;

module gasket() {
    rotate_extrude(convexity = 10, $fn = 64)
    translate([GasketCenterRadius, 0, 0])
    if(Shape == "ellipse") {
        scale([1, SquishFactor, 1]) circle(r = GasketRadiusX, $fn = 24);
    }
    else if(Shape == "square") {
        scale([1, SquishFactor, 1]) square(2 * GasketRadiusX, center=true);
    }
    else { // rounded square
        hull() {
            if(SquishFactor > 1.0) {
                Shift = GasketRadiusZ - GasketRadiusX;
                translate([0, Shift, 0]) circle(r = GasketRadiusX, $fn = 24);
                translate([0, -Shift, 0]) circle(r = GasketRadiusX, $fn = 24);
            }
            else {
                Shift = GasketRadiusX - GasketRadiusZ;
                translate([Shift, 0, 0]) circle(r = GasketRadiusZ, $fn = 24);
                translate([-Shift, 0, 0]) circle(r = GasketRadiusZ, $fn = 24);
            }
        }
    }
}

module pieSlices() {
    H = Thickness + 1;
    difference() {
        cylinder(r = InnerDiameter/2 - 1.6, h=H);
        cylinder(r = 4.5, h=H);
        translate([-InnerDiameter/2, -0.75, 0]) cube([InnerDiameter, 1.5, H]);
        translate([-0.75, -InnerDiameter/2, 0]) cube([1.5, InnerDiameter, H]);
        if(InnerDiameter >= 35) {
            rotate([0, 0, 45]) {
                translate([-InnerDiameter/2, -0.75, 0]) cube([InnerDiameter, 1.5, H]);
                translate([-0.75, -InnerDiameter/2, 0]) cube([1.5, InnerDiameter, H]);
            }
        }
        if(InnerDiameter >= 50) {
            difference() {
                cylinder(r = InnerDiameter*0.354 + 0.75, h=H);
                cylinder(r = InnerDiameter*0.354 - 0.75, h=H);
            }
        }
    }
}

union() {
    difference() {
        translate([0, 0, -MoldThickness]) cylinder(h = MoldThickness, r = MoldRadius, $fa=6);
        gasket();
        if(InnerDiameter > 14 ) {
            translate([0, 0, -MoldThickness + InsideWallThickness]) pieSlices();
        }
        if(SingleMold == "no") {
            // Gap for easier opening
            translate([0, MoldRadius, 0]) cube([MoldRadius, 1.6, 1], center=true);
        }
    }
    if(SingleMold == "no") {
        // Create alignment cone with margin for the alignment hole
        cylinder(h = 2.0 - AlignConeTolerance, r1 = 3 - AlignConeTolerance, r2 = 1.0, $fn = 24);
    }
}

if(SingleMold == "no") {
    VentChannelHalfLength = GasketRadiusX + 1;
    translate([5 + 2 * MoldRadius, 0 ,0])
    difference() {
        translate([0, 0, -MoldThickness]) cylinder(h = MoldThickness, r = MoldRadius, $fa=6);
        gasket();
        if(InnerDiameter > 14 ) {
            translate([0, 0, -MoldThickness + InsideWallThickness]) pieSlices();
        }
        for(i=[0 : VentChannels - 1]) {
            rotate([0, 0, i*(360/VentChannels)]) translate([GasketCenterRadius+VentChannelHalfLength, 0, -VentChannelSize/4]) cube(size=[2*VentChannelHalfLength, VentChannelSize, VentChannelSize], center=true);
        }
        // Make this cone slightly larger than necessary to avoid Z-fighting
        translate([0, 0, -3]) cylinder(h = 3.5, r1 = 0, r2 = 3.5, $fn = 24);
        //translate([0, 0, -3]) cylinder(h = 3.0, r1 = 0, r2 = 3.0, $fn = 24);
    }
}