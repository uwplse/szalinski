// Grid of holes © Glyn Cowles Nov 2016
//------------parameters---------------------------
// overall size of X dimension
gridX=100;  
// overall size of Y dimension
gridY=100;  
// X border size
borderX=2;  
// Y border size
borderY=2;  
// Hole Diameter
holeDiameter=10;
// Number of holes in x
holesX=8;
// Number of holes in y
holesY=8;
// thickness in Z direction
thickness=2;  
// Resolution
$fn=20;
//preview[view:south,tilt:top]
//-------------------------------------------------

meshX=gridX-(borderX*2);
meshY=gridY-(borderY*2);
meshSpaceX=(meshX-holesX*holeDiameter)/(holesX+1); // space between in x dir
//echo (meshSpaceX);
meshSpaceY=(meshY-holesY*holeDiameter)/(holesY+1); //  y

dx=holeDiameter+meshSpaceX;
dy=holeDiameter+meshSpaceY;

difference() {  
    translate([-borderX,-borderY],0) cube (size=[gridX,gridY,thickness]);
    translate([meshSpaceX+holeDiameter/2,meshSpaceY+holeDiameter/2,0]) 
    for (i=[0:holesX-1]) {
        for (j=[0:holesY-1]) {
	 	translate([dx*i,dy*j,0]) cylinder(d=holeDiameter,h=thickness);

    }
}
}
