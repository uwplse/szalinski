// This is the angle in degrees at which there will be a faceton the vase. The number of facets is 360/thetaStep.
thetaStep = 10;
// The size of the bubbles. There is one bubble per thetaStep in each layer of the vase.
bubbleSize = 20;
// The "resolution" of each bubble. This is the $fn value for the sphere. Use low values or wait a long time!
bubbleRes = 5;
// The minimum radius of the vase.
radMin = 100;
// The height of each layer in the vase.
layerHeight = 10;
// The number of cycles of sinewave from bottom to top of the vase.
waveCycles = 0.8;
// The amplitude of the sinewave. The maximum radius of the vase is radMin + waveAmp.
waveAmp = 100;
// The sum total height of all of the layers. The number of layers is totalLayerHeight/layerHeight.
totalLayerHeight = 390;
// The angle that each layer is rotated through around the z axis.
twist = 0;

function cylToCar(r, theta, z) = [r*cos(theta), r*sin(theta), z];

module bubbleDisk( thetaStep, rad, height, bubbleSize, bubbleRes)
{
	union()
		{
		translate([0, 0, height])cylinder( r1 = rad, r2 = rad, h = 2*bubbleSize + 0.001, center = true, $fn = 100);
		for (theta=[0:thetaStep:360])
			{
			translate(cylToCar(rad, theta, height))sphere(r = bubbleSize, center = true, $fn = bubbleRes);
			}
		}
}

module bubbleVase( thetaStep, radMin, layerHeight, bubbleSize, waveAmp, waveCycles, totalLayerHeight, layerHeight, bubbleRes )
{
	union()
		{
		for( height= [0:layerHeight:totalLayerHeight])
			{
			rotate( a = [0, 0, height * twist/layerHeight])bubbleDisk( thetaStep, radMin + waveAmp/2 + waveAmp*sin(waveCycles*height), height, bubbleSize, bubbleRes);
			}
		}
}

bubbleVase( thetaStep, radMin, layerHeight, bubbleSize, waveAmp, waveCycles, totalLayerHeight, layerHeight, bubbleRes);