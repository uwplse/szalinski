//------------parameters---------------------------
// overall size of X dimension
gridX=100;  
// overall size of Y dimension
gridY=100;  
// X border size
borderX=10;  
// Y border size
borderY=10;  
// width of solid part of grid
meshSolid=0.5;
// width of blank part of grid 
meshSpace=2;  
// thickness in Z direction
thickness=1.5;  

//-------------------------------------------------
meshX=gridX-(borderX*2);
meshY=gridY-(borderY*2);
nX=meshX/(meshSolid+meshSpace);
nY=meshY/(meshSolid+meshSpace);

difference() {
cube (size=[gridX,gridY,thickness],center=true);
cube (size=[meshX,meshY,thickness],center=true);
}

for (i=[0:nX]) {
	 	 translate([-(meshX/2)+i*(meshSolid+meshSpace),-meshY/2,-thickness/2]) cube(size=[meshSolid,meshY,thickness],center=false);
}

for (i=[0:nY]) {
	 	translate([-meshX/2,-(meshY/2)+i*(meshSolid+meshSpace),-thickness/2]) cube(size=[meshX,meshSolid,thickness],center=false);

}
