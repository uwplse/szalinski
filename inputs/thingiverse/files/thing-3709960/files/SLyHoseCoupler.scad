// **  Sylvain.Lathuy@gmail.com   2019  **
// ** Made lip optional ALittleSlow 2019 **
// A Parametric Hose Coupler
// 
// Flexible hose coupler with a lip to hide the hose extremity.
// Can be used as an adapter using 2 different hose diameters.
//
// Current values are for a flexible hose 8/11 mm
// ---- Customizable parameters:

A_InnerDiameter  = 8.0;
A_OuterDiameter  = 11.0;
A_DentHeight     = 0.6;
A_IncludeLip      = "Yes"; //[Yes, No]

B_InnerDiameter  = 8.0;
B_OuterDiameter  = 11.0;
B_DentHeight     = 0.6;
B_IncludeLip      = "Yes"; //[Yes, No]

Thickness        = 1.2;

// ---- Object Definition
module HoseConnection(innerDiameter, outerDiameter, couplingInnerDiameter, 
        couplingOuterDiameter, dentHeight, thickness, includeLip) {
    InnerRadius = 0.5 * innerDiameter;
    OuterRadius = 0.5 * outerDiameter;
    RingRadius = OuterRadius + thickness;
    LipLength = includeLip == "Yes" ? OuterRadius + thickness : thickness;
    DentLength = OuterRadius;
    BaseLength = OuterRadius + thickness + InnerRadius;
    couplingInnerRadius = min(InnerRadius, 0.5 * couplingInnerDiameter);   
    couplingRingRadius = max(RingRadius, 0.5 * couplingOuterDiameter + thickness);
    Points = [
        // ring lip
        [couplingRingRadius, 0.0],
        [RingRadius, LipLength],
        [OuterRadius + (includeLip == "Yes" ? 0.65 : 0) * (RingRadius - OuterRadius), 
            LipLength + (includeLip == "Yes" ? 0.4 : 0) * (RingRadius - OuterRadius)],
            [OuterRadius + 0.35 * (RingRadius - OuterRadius), 
            LipLength + 0.4 * (RingRadius - OuterRadius)],
        [OuterRadius, LipLength],
        [OuterRadius, thickness],
        [InnerRadius, thickness],
        [InnerRadius, BaseLength],
        // dents
        [InnerRadius + dentHeight, BaseLength + 0.1 * DentLength],
        [InnerRadius, BaseLength + DentLength],
        [InnerRadius + dentHeight, BaseLength + 1.1 * DentLength],
        [InnerRadius, BaseLength + 2.0 * DentLength],
        [InnerRadius + dentHeight, BaseLength + 2.1 * DentLength],
        [InnerRadius, BaseLength + 3.0 * DentLength],
        // tip
        [InnerRadius-0.35*thickness, BaseLength + 3.0 * DentLength + 0.4*thickness],
        [InnerRadius-0.65*thickness, BaseLength + 3.0 * DentLength + 0.4*thickness],
        [InnerRadius-thickness, BaseLength + 3.0 * DentLength],
        [InnerRadius-thickness, BaseLength],
        [couplingInnerRadius-thickness, 0.0]
        ];
    rotate_extrude($fn=120) polygon(points=Points);
}

// ---- Object Declaration
HoseConnection(A_InnerDiameter, A_OuterDiameter,
    B_InnerDiameter, B_OuterDiameter, A_DentHeight, Thickness, A_IncludeLip);
rotate([180.0, 0.0, 0.0]) HoseConnection(B_InnerDiameter, B_OuterDiameter,
    A_InnerDiameter, A_OuterDiameter, B_DentHeight, Thickness, B_IncludeLip);
