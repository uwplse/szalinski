// - Outer diameter of the stem
StemOD = 18;
// - Length of stem
StemZ = 40;
// - Outer diameter of rim
RimOD = 80;
// - Height of rim
RimZ = 30;
// - Thickness of walls
T = 1.6;
// - Conical section slope angle
Slope = 40;

/* [Hidden] */
//Points given an inverted funnel
Z0  = 0;
OR0 = RimOD/2;
IR0 = OR0-T;
Z1  = RimZ;
Z2  = Z1+ (RimOD-StemOD)*0.5*tan(Slope);
echo(Z2);
Z3  = Z2+ StemZ;
OR3 = StemOD/2;
IR3 = OR3-T;

L = (OR0-IR3) / cos(Slope);
SliceAng=35;
Slice = 2*OR0*sin(SliceAng);

//rotate to put the layer start point in an ugly location.
rotate(SliceAng-90) 
difference() {
    union() {
        difference() {
            //main body
            rotate_extrude($fn=100) 
                TwoDProfile();
            //breather slice subtraction
            SliceBlock(SliceAng);
        }
        //breather slice addition
        intersection() {
            scale([cos(SliceAng),1,1])
                rotate([90,0])
                    linear_extrude(Slice, center=true)
                        TwoDProfile();
            SliceBlock(SliceAng);
        }
    }
    //tapered tip
    translate([-OR3, -RimOD/2, Z3])
        rotate([0,30,0])
            cube(RimOD);
}

module TwoDProfile() {
    //rim
    translate([IR0,0])
        square([T, Z1]);
    //stem
    translate([IR3, Z2])
        square([T, Z3-Z2]);
    //cone
    difference() {
        translate([IR3, Z2])
        rotate(-Slope-90)
        mirror()
            square([T,L]);
        translate([OR0,0])
            square([2*T, Z3]);
    }
}

module SliceBlock(a=40) {
    intersection() {
        rotate(-a) cube(Z3);
        rotate(a-90) cube(Z3);
    }
}

echo(str("FileName: Funnel",StemOD,"x",RimOD));

