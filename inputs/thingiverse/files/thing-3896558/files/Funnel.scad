/* [Geometry] */
FunnelOuterDiameter_bot = 49.7;
FunnelOuterDiameter_top = 75;
FunnelHeight_out = 20;
FunnelHeight_in = 2.5;
FunnelThickness_in = 0.5;
FunnelThickness_rim = 4;
FunnelThickness_top = 1;
rimChamferLength = 1;

/* [Hidden] */
$fa = 1; // increase to speed up the computation (and end up with a rougher model)

RimHeight = FunnelHeight_out*FunnelThickness_rim/((FunnelOuterDiameter_top-FunnelOuterDiameter_bot)/2);

echo(RimHeight=RimHeight);

rotate_extrude(angle = 360, convexity = 0) {
    polygon(points=[
        [(FunnelOuterDiameter_bot)/2-FunnelThickness_in, -FunnelHeight_in], 
        [FunnelOuterDiameter_bot/2, -FunnelHeight_in], 
        [FunnelOuterDiameter_bot/2, -rimChamferLength], 
        [FunnelOuterDiameter_bot/2+rimChamferLength, 0], 
        [FunnelOuterDiameter_bot/2+FunnelThickness_rim, 0], 
        [FunnelOuterDiameter_bot/2+FunnelThickness_rim, RimHeight],
        [FunnelOuterDiameter_top/2, FunnelHeight_out],
        [FunnelOuterDiameter_top/2-FunnelThickness_top, FunnelHeight_out],
        [FunnelOuterDiameter_bot/2-FunnelThickness_in, 0]
        ]);
}