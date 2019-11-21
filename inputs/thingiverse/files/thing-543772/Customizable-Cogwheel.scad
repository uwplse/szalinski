numberOfTheetOfLargeWheel = 30;
innerRadiusOfLargeWheel=7.265; 
outerRadiusOfLargeWheel=8.305;
topLandWidthOfLargeWheel=0.2;
spaceWidthOfLargeWheel=0.2;
depthOfLargeWheel=1.45;
cutoutRadius=0.925;

numberOfTheetOfInnerWheel = 9;
innerRadiusOfInnerWheel=1.8; 
outerRadiusOfInnerWheel=2.8;
topLandWidthOfInnerWheel=0.2;
spaceWidthOfInnerWheel=0.2;
depthOfInnerWheel=4.97;


module oneTooth(pos,angle,r, r2, circularThickness, spaceWidth) {
	translate(pos){
		rotate(a = angle) {
			polygon(points=[[0,-circularThickness/2],[r,-circularThickness/2],[r2,-spaceWidth/2],[r2,spaceWidth/2],[r,circularThickness/2],[0,circularThickness/2]]);
		}
	}
}

module cogwheel(numTeeth, r, r2, topLandWidth, spaceWidth, depth, cutout_radius) {
	circularThickness=r*sin(360/numTeeth)-topLandWidth;
	$fs = 0.5;
	linear_extrude(depth){
		difference() {
			union(){
				circle(r);
				for(i = [0:numTeeth-1]) {
					oneTooth([0,0,0],(360*i/numTeeth), r, r2, circularThickness, spaceWidth);
				}
			}
			circle(cutout_radius);
		}
	}
}

cogwheel(numTeeth=numberOfTheetOfLargeWheel, r=innerRadiusOfLargeWheel, r2=outerRadiusOfLargeWheel, topLandWidth=topLandWidthOfLargeWheel, spaceWidth=spaceWidthOfLargeWheel, depth=depthOfLargeWheel, cutout_radius=cutoutRadius);

cogwheel(numTeeth=numberOfTheetOfInnerWheel, r=innerRadiusOfInnerWheel, r2=outerRadiusOfInnerWheel, topLandWidth=topLandWidthOfInnerWheel, spaceWidth=spaceWidthOfInnerWheel, depth=depthOfInnerWheel, cutout_radius=cutoutRadius);

