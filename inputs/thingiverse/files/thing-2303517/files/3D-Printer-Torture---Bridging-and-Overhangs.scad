/* [A - Model] */
// Number of layers
numberLayers = 4; // [2:7]
// Radius of largest layer
objectRadius = 50; // [20:5:300]
// Height of each layer
layerHeight = 15; // [1:20]

/* [B - Lines] */
lineThickness = 3; // [1:5]
// Number of sides a cross cut of the line will have.
resolution = 15; // [4:30]

/* [C - Layer 1] */
// Layer 1 - Number of Points
numPointsLayer1 = 3; // [3:10]
// Layer 1 - Offset Angle From X Axis
offsetAngle1 = 0; // [0:5:90]
// Layer 1 - Span (# of Previous Layers to connect to)
span1 = 0; // [0:7]
// Layer 1 - Color
color1 = "Indigo"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [D - Layer 2] */
// Layer 2 - Number of Points
numPointsLayer2 = 4; // [3:10]
// Layer 2 - Offset Angle From X Axis
offsetAngle2 = 15; // [0:5:90]
// Layer 2 - Span (# of Previous Layers to connect to)
span2 = 1; // [0:7]
// Layer 2 - Color
color2 = "Blue"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [E - Layer 3] */
// Layer 3 - Number of Points
numPointsLayer3 = 5; // [3:10]
// Layer 3 - Offset Angle From X Axis
offsetAngle3 = 30; // [0:5:90]
// Layer 3 - Span (# of Previous Layers to connect to)
span3 = 1; // [0:7]
// Layer 3 - Color
color3 = "Moccasin"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [F - Layer 4] */
// Layer 4 - Number of Points
numPointsLayer4 = 6; // [3:10]
// Layer 4 - Offset Angle From X Axis
offsetAngle4 = 45; // [0:5:90]
// Layer 4 - Span (# of Previous Layers to connect to)
span4 = 1; // [0:7]
// Layer 4 - Color
color4 = "Crimson"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [G - Layer 5] */
// Layer 5 - Number of Points
numPointsLayer5 = 7; // [3:10]
// Layer 5 - Offset Angle From X Axis
offsetAngle5 = 60; // [0:5:90]
// Layer 5 - Span (# of Previous Layers to connect to)
span5 = 1; // [0:7]
// Layer 5 - Color
color5 = "Peru"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [H - Layer 6] */
// Layer 6 - Number of Points
numPointsLayer6 = 8; // [3:10]
// Layer 6 - Offset Angle From X Axis
offsetAngle6 = 75; // [0:5:90]
// Layer 6 - Span (# of Previous Layers to connect to)
span6 = 1; // [0:7]
// Layer 6 - Color
color6 = "Moccasin"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

/* [I - Layer 7] */
// Layer 7 - Number of Points
numPointsLayer7 = 9; // [3:10]
// Layer 7 - Offset Angle From X Axis
offsetAngle7 = 0; // [0:5:90]
// Layer 7 - Span (# of Previous Layers to connect to)
span7 = 1; // [0:7]
// Layer 7 - Color
color7 = "LightSeaGreen"; //  [Indigo,Blue,ForestGreen,Crimson,Peru,Moccasin,LightSeaGreen,LightCyan,Linen,Azure]

layerData = [
	[0,0,0,0],
	[numPointsLayer1,offsetAngle1,span1,color1],
	[numPointsLayer2,offsetAngle2,span2,color2],
	[numPointsLayer3,offsetAngle3,span3,color3],
	[numPointsLayer4,offsetAngle4,span4,color4],
	[numPointsLayer5,offsetAngle5,span5,color5],
	[numPointsLayer6,offsetAngle6,span6,color6],
	[numPointsLayer7,offsetAngle7,span7,color7]
	];

ringCount = numberLayers;
ringGap = objectRadius / ringCount;

translate([0,0,(layerHeight*ringCount)+(lineThickness/2)])
	rotate([180,0,0])
		connectTheDots(ringCount);

module connectTheDots(ringCount)
{	
	for(i=[1:ringCount])
	{
		radius1 = i * ringGap;
		pointAngle1 = 360 / layerData[i][0];
		offsetAngle1 = layerData[i][1];
		numLayersConnect = i - layerData[i][2] < 1 ? 1 : i - layerData[i][2];
		
		for(j=[0:layerData[i][0]-1])
		{
			x1 = radius1 * cos((j * pointAngle1 + offsetAngle1 * i));
			y1 = radius1 * sin((j * pointAngle1 + offsetAngle1 * i));
			z1 = (i - 1) * layerHeight;

			for(k=[i:-1:numLayersConnect])
			{
				radius2 = k * ringGap;
				pointAngle2 = 360 / layerData[k][0];
				offsetAngle2 = layerData[k][1];
				
				for(l=[0:layerData[k][0]-1])
				{
					x2 = radius2 * cos((l * pointAngle2 + offsetAngle2 * k));
					y2 = radius2 * sin((l * pointAngle2 + offsetAngle2 * k));
					z2 = k * layerHeight;
					depth = lineThickness;

					color(layerData[i][3])
						line(x1,y1,z1,x2,y2,z2,depth);
				} // End for(l)
			} // End for(k)
		} // End for(j)
	} // End for(i)
} // End connectTheDots()

module line(x1,y1,z1,x2,y2,z2,depth)
{
	hull($fn=resolution)
	{
		translate([x1,y1,z1])
			sphere(d=depth,center=true,$fn=resolution);
		translate([x2,y2,z2])
			sphere(d=depth,center=true,$fn=resolution);
	} // End hull()
} // End line()
