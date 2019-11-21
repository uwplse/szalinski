// Thickness of the gauge
GaugeThickness     = 2;
// Width of railnops
GleisnoppenStaerke = 1.2;
// Height of railnops
GleisnoppenHoehe   = 1.2;
// Do you want a handle to hold the gauge?
DrawHandle         = true;
// The handle diameter
HandleDiameter     = 5;
// The length of the handle
HandleLength       = 30;
// Rail norm
RailNorm = "N"; // [Z,N,TT,H0,S,0]

// Print overhead area as well
OverheadArea = false;

if (RailNorm == "Z") Nem102Lehre(6.5, 20, 14, 18, 4, 6, 18, 24, 16, 13, 27);
else if (RailNorm == "N") Nem102Lehre(9.0, 27, 18, 25, 6, 8, 25, 33, 22, 18, 37);
else if (RailNorm == "TT") Nem102Lehre(12, 36, 24, 43, 8, 10, 33, 43, 28, 22, 48);
else if (RailNorm == "H0") Nem102Lehre(16.5, 48, 32, 42, 11, 14, 45, 59, 38, 30, 65);
else if (RailNorm == "S")  Nem102Lehre(22.5, 66, 44, 57, 15, 19, 60, 78, 50, 38, 87);
else if (RailNorm == "0")  Nem102Lehre(32, 94, 63, 82, 21, 27, 85, 109, 68, 52, 120);

module Nem102Lehre(G, B1, B2, B3, H1, H2, H3, H4, B4, B5, H5)
{
    translate([-B1/2, 0, 0]) {
            linear_extrude(height=GaugeThickness) {
                polygon(points=[[(B1-B3)/2,0],
                                [(B1-B3)/2,H1],
                                [0,H1],
                                [0,H3],
                                [(B1-B2)/2,H4],
                                [(B1-B2)/2 + B2,H4],
                                [B1,H3],
                                [B1,H2],
                                [B1 - (B1-B3)/2, H2],
                                [B1 - (B1-B3)/2, 0],
                                [B1 - (B1-G)/2, 0],
                                [B1 - (B1-G)/2, -GleisnoppenHoehe],
                                [B1 - (B1-G)/2 - GleisnoppenStaerke, -GleisnoppenHoehe],
                                [B1 - (B1-G)/2 - GleisnoppenStaerke, 0],
                                [(B1-G)/2 + GleisnoppenStaerke, 0],
                                [(B1-G)/2 + GleisnoppenStaerke, -GleisnoppenHoehe],
                                [(B1-G)/2, -GleisnoppenHoehe],
                                [(B1-G)/2, 0]
                
                ]);
                if (OverheadArea) {
                    polygon(points=[[(B1-B4)/2, H3],
                                    [(B1-B4)/2, H5-(B4-B5)/2],
                                    [(B1-B4)/2+(B4-B5)/2, H5],
                                    [(B1-B4)/2+(B4-B5)/2+B5, H5],
                                    [(B1-B4)/2+B4, H5-(B4-B5)/2],
                                    [(B1-B4)/2+B4, H3]
                    ]);
                }
        }
    }
    if (DrawHandle) {
        translate([0, H4/2, 0])
            cylinder($fn=20, r=HandleDiameter/2, h=HandleLength+GaugeThickness);
    }
}
