// Customizable Paint Holder

/* [General Settings] */
// Number of Paint Bottles per Row
NumPerRow=6;

// Number of Rows
NumRows=4;

// Diameter of the Paint Bottle
BottleDiameter=26   ;

/* [Advanced Settings] */
// Height increment for each Row 
RowStepSize=12;

// Thickness of wall around paint bottle "hole"
WallThickness=3;

// Depth of Paint Bottle Hole
HoleDepth=15;

// ignore variable values
/* [Hidden] */
CircleSegments=75;
$fa=360/CircleSegments;//360/$fa = Max Facets Number
$fs=0.2; //prefered facet length 

_CubeY=2+WallThickness+BottleDiameter;
echo ("_CubeY=",_CubeY);
for(r=[1:NumRows]){
    difference(){
        translate([0,(r-1)*_CubeY,-3]) // Move everything up by 2 to allow cutting of 2mm of the bottom later
        PaintHolderRow(
            NumBottles=NumPerRow
            ,Dia=BottleDiameter
            ,StepSize=(r-1)*RowStepSize
            ,WallT=WallThickness
            ,HoleZ=HoleDepth
            ,AddToY=(r<NumRows?4:0));
        translate([0,0,-3]) // Move everything 
        cube([300,300,3]);
    }
}
module PaintHolderRow(
    NumBottles=2
    ,Dia=15
    ,StepSize=0
    ,WallT=3
    ,HoleZ=20
    ,AddToY=0){
    echo ("StepSize=",StepSize);

        difference(){
            roundedCube([
            (NumBottles*Dia)+((NumBottles+1)*WallT)
            ,Dia+2*WallT+AddToY
            ,HoleZ+StepSize+WallT+3]
            ,radius=2);
            for(n=[1:NumBottles]){
            
            translate([(n-1)*(Dia+WallT)+Dia/2+WallT
                        ,WallT+Dia/2
                        ,WallT+StepSize+3])
                
            round_edges_cylinder(
                radius = Dia/2
                , height = HoleZ+0.01 
                , edge_radius = 2
                , topbottom = [1, 0]
                ,center = true);
          /*#rounded_cylinder(                       r=Dia                       ,h= HoleZ+0.01                     ,n=50);*/
         }
                
     }
}

// r[adius], h[eight], [rou]n[d]
// Example: rounded_cylinder(r=10,h=30,n=11,$fn=60);
module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
      _roundR=min(n,r/2-0.01); // If radius of rounding is  too big, limit it automatically
    offset(r=_roundR) offset(delta=-_roundR) square([r,h]);
    square([_roundR,h]);
  }
}
module roundedCube(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}

module round_edges_cylinder(radius = 5, height = 15, edge_radius = 2, topbottom = [1, 1], center = true){
	trans = (center == false) ? [radius, radius, 0] : [0, 0, 0];
	height = (topbottom[1]) ? height - edge_radius : height;
	trans2 = (topbottom[1]) ? [0, 0, edge_radius] : [0, 0, 0];
	
	translate(trans){
		union(){
			translate(trans2) cylinder(height, radius, radius);
			if(topbottom[0]){
				difference(){
					translate([0, 0, height+trans2[2]-edge_radius])cylinder(edge_radius, radius+edge_radius, radius+edge_radius);	
					rotate_extrude() translate([radius+edge_radius, height+trans2[2]-edge_radius]) circle(edge_radius);
				}
			}
			if(topbottom[1]){
				translate(trans2) cylinder(height, radius, radius);
				translate([0, 0, 0]) cylinder(edge_radius, radius-edge_radius, radius-edge_radius);	
				rotate_extrude() translate([radius-edge_radius, edge_radius]) circle(edge_radius);
			}
		}
	}
}
	
