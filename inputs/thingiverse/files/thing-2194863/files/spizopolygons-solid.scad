$fn=300;
heightt=90; //mm
rotation=360; //degree
diameter=60; //Polygon diameter mm
base=2; // mm
poly =6; // Number of polygon sides

// External shape

linear_extrude(height = heightt, center = false, convexity = 10, twist = rotation)
circle(d=diameter,center=true,$fn=poly);



