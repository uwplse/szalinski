/* 7-Hex container for small pieces (eg. Board Game)
With lid

I suggest printing the lid with zero top layers and
20% Honeycomb infill

*/

// Which one would you like to see?
part = "both"; // [container:Container Only,lid:Lid Only ,both:Cube and Cylinder]

//inner Height of container
iH = 25;
//floor Height (thickness)
fH = 4;

//inner diamter of each cell
iD = 44;
//Wall width
wW = 2.4;

//lid height (solid part)
lH = 3;
//lid lip height
llH = 4;
//lid lip epsilon/gap
lle = 0.5;
//lid lip overhang, for removal
llo = 1.0;


/* [Hidden] */
e=0.1;
hexRatio = sqrt(3)/2;

if(part != "lid")
	container(iH,fH);

//I made this a little too big and had to crop to my print bed size
//intersection(){ cube([122,128,100],center=true);

if(part != "container")
	translate([0,0,iH+lH+20]) color([0.3,1,0.9])
		lid();
//}
module lid(){
	
	intersection(){
		
	difference(){
	//same shape with thicker walls
	container(llH,lH,wW=wW*hexRatio/2,wM=wW*2);	
	//original shape with +e thicker walls
	translate([0,0,lH+e])
		container(llH,0,wW,wM=lle*2);
	}
	//crop outer edge
	container(0,llH+lH+lle);
	}
	//slightly larger lip to grab onto
	container(0,lH/2,wW=wW+llo);
}

//@param wM wallModifer, increases wall but not layout 
module container(innerHeight, floorHeight,wW=wW,wM=0){
	//central bin
	translate([0,0,-fH])
		hexTube(floorHeight+innerHeight,iD-wM/2, wW+wM,floorHeight);
	//other bins
	for(a = [0:360/6:360]){
		rotate([0,0,a])
		translate([0,iD*hexRatio+wW,-fH])
			hexTube(floorHeight+innerHeight,iD-wM/2, wW+wM,floorHeight);
	}
}

module hexTube(h,d,w,floorHeight=0)
{
	difference(){
		hex(h, d=d+w*2);
		if(h>floorHeight)
			translate([0,0,floorHeight>0?floorHeight:-e])
				hex(h+e*2, d=d);
	}
}

module hex(h,d){
	cylinder(h, d=d, $fn=6);
}



