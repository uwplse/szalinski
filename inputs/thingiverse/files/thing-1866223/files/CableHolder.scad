/* [Basics] */
// - Size in diameter.
ScrewHole       = 4;
// - The width of the hole. To change the height, change Advanced->CableHoleRatio
CableHole       = 8.5;
// - Rotate the model for easyer print
RotateModel   = 0; // [1:Yes,0:No]

/* [Advanced] */
// - The amount of roof above the cable hole.
RoofHeight      = 2;
// - The amount of extra feet-height.
ExtraFeetHeight = 0;
// - Adds extra depth.
AddDepth        = 0;
// - The size of the walls around the screw holes.
WallThickness   = 2;
// - Change the roundness of the cable hole
CableHoleRatio  = 1.25;
// - Change the height of the hole. If 0 the model will be calculated through the Cable Hole Ratio
CableHoleHeight = 0;


/* Variables */
tCableHoleHeight = CableHoleHeight > 0 ? CableHoleHeight : CableHole / CableHoleRatio;
echo(tCableHoleHeight);
tWidth  = CableHole + ScrewHole*2 + WallThickness*4; //X
tDepth  = ScrewHole + WallThickness * 2; //Y
tHeight = tCableHoleHeight/2 + RoofHeight + ExtraFeetHeight; //Z
tCornerRadio = tDepth/2;

difference() {
   roundedCube(tWidth, tDepth, tHeight, tCornerRadio);
   if (RotateModel) {
        translate([0,tDepth,tHeight])
        rotate([180, 0, 0])
        cutouts();
   } else {
       cutouts();
   }
}


module roundedCube(){
    $fn=64;

    hull(){
        //LB Ring
        translate([tCornerRadio,tCornerRadio, 0])
            cylinder(r=tCornerRadio, h=tHeight);
        //RB Ring
        translate([tWidth-tCornerRadio,tCornerRadio, 0])
            cylinder(r=tCornerRadio, h=tHeight);
        //LT Ring
        translate([tCornerRadio, tDepth-tCornerRadio + AddDepth, 0])
            cylinder(r=tCornerRadio, h=tHeight);
        //RT Ring
        translate([tWidth-tCornerRadio, tDepth-tCornerRadio + AddDepth, 0])
            cylinder(r=tCornerRadio, h=tHeight);
    }
}

module cutouts() {
    $fn=64;
    pad = 0.1; // Padding to maintain manifold

    translate([ScrewHole/2+WallThickness, ScrewHole/2+WallThickness+AddDepth/2, -pad/2])
    cylinder(h=tHeight+pad, r=ScrewHole/2);
    
    translate([tWidth-ScrewHole/2-WallThickness, ScrewHole/2+WallThickness+AddDepth/2, -pad/2])
    cylinder(h=tHeight+pad, r=ScrewHole/2);
    
    rotate([-90, 0, 0])
    translate([ScrewHole+WallThickness*2+CableHole/2, -ExtraFeetHeight, -pad/2])
    resize([CableHole,tCableHoleHeight, tDepth+pad])
    cylinder(1);
    translate([ScrewHole+WallThickness*2, -pad/2, -pad/2])
    cube([CableHole,tDepth+pad,ExtraFeetHeight+pad]);
}
