// This is the overal width of the clip
ZExtrude = 35; // 
// This is the diameter of the top bar
topdia = 8; //
// This is the diameter of the bottom bar
bottomDiam = 6; //
// This is the distance between the top and bottom bar, as centres
spacebetween = 55;//
// This Chooses the thickness of the material
Thickness = 1.5;

linear_extrude(ZExtrude) {

Clip(topdia,bottomDiam,spacebetween,Thickness);

}
module Clip(topdia,bottomDiam,spacebetween,Thickness) {
	
	union(){
		click(topdia , Thickness);
		
		click(bottomDiam , Thickness, [0,-spacebetween],-90, false);
	
   
		Line([(topdia+Thickness)/2,0],[(bottomDiam+Thickness)/2,-spacebetween],Thickness);
		Line([(bottomDiam+Thickness)/2,-spacebetween],[(bottomDiam+Thickness)/2, -spacebetween-bottomDiam],Thickness);

	}
}
module click(size,thickness, XY = [0,0],Angle = 0, full = true) {
	
	YMovement = -size*0.7;
	CentrePoint = [0,YMovement/2];
	OuterDiameter = size+(thickness*2);
	ConstantDistance = (size+thickness)/2;
	
	
	translate (XY) {
		rotate ([0,0,Angle]) {
			
			difference() {

				union() {
					// point ();
					
					circle(d = OuterDiameter, $fn=50, center = true);
					
					translate(CentrePoint) {
						square([OuterDiameter,-YMovement], center = true);
					}
				
					point ([ConstantDistance,YMovement], thickness);
					point ([-ConstantDistance,YMovement], thickness);					
				
				}
							
				union() {
					// point ();
					
					circle(d = size, $fn=50, center = true);
					
					translate([0,YMovement]) {
						circle(d = size, $fn=50, center = true);
					}	
					
					if (full!=true){
						
						translate([-ConstantDistance,YMovement/2]) {
							square([ConstantDistance*2,ConstantDistance*4], center = true);
						}
											
					}
									
				}	
			}
		}
	}
}		
module Line( XY1 , XY2 , Thickness ) {
	
	Ad = XY1 [0] - XY2[0];
	Op = XY1 [1] - XY2[1];
	Hyp = sqrt(pow(Op,2) + pow(Ad,2) );
	Angle = atan(Op/Ad);
	
	translate (Mid (XY1,XY2)){
		rotate([0,0,Angle]){
			square ([Hyp,Thickness], center = true);
		}		
	}
	
	point(XY1,Thickness);
	point(XY2,Thickness);
}

function Mid (XYstart,XYfin) = (XYstart + XYfin) / 2;
module point (XY = [0,0] , Size = 1) {

	translate(XY) {
	
	circle(d = Size, $fn=50, center = true);
	
	}
}
