//first layer calibration print
buildVolumeX=250;
buildVolumeY=210;
buildVolumeZ=210;

calibrationCubeX=20;
calibrationCubeY=20;


layerHeight=.2;

//front left square
translate([calibrationCubeX/2 - buildVolumeX/2 ,calibrationCubeY/2-buildVolumeY/2,0])
cube([calibrationCubeX,calibrationCubeY,layerHeight],center=true);

//rear right square
translate([-calibrationCubeX/2 + buildVolumeX/2 ,-calibrationCubeY/2+buildVolumeY/2,0])
cube([calibrationCubeX,calibrationCubeY,layerHeight],center=true);

//front right square
translate([-calibrationCubeX/2 + buildVolumeX/2 ,calibrationCubeY/2-buildVolumeY/2,0])
cube([calibrationCubeX,calibrationCubeY,layerHeight],center=true);

//rear left square
translate([calibrationCubeX/2 - buildVolumeX/2 ,-calibrationCubeY/2+buildVolumeY/2,0])
cube([calibrationCubeX,calibrationCubeY,layerHeight],center=true);

//center square
cube([calibrationCubeX,calibrationCubeY,layerHeight],center=true);