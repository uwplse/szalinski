bitSize=7.5; // this is the maximum diameter of the bit in mm
bitLength=30;//defines the amount the bit will be embedded in the driver
driverRadius=7; //radius of the driver
driverHeight=35; //height of the driver (currently is the height of the body, i am too lazy to fix it to be the overall height of the driver... sorry
numOfGrips=6;// number of cut outs for your fingers to grab
gripRadius=2;// defines the radius of the figer holds
gripHeight=30;//defines the length of the finger holds
bevelRadius=2;// this defines the curve at the bottom
SmoothingAmount=5;// this is the smoothing factor on the rounded caps 

module driverBase(){
	hull(){
		for(i=[1:SmoothingAmount])
		{
  			translate([0,0,+bevelRadius-bevelRadius*cos(i*90/SmoothingAmount)])cylinder(r=(driverRadius-bevelRadius+bevelRadius*sin(i*90/SmoothingAmount)),h=(driverHeight-2*bevelRadius+2*bevelRadius*cos(i*90/SmoothingAmount)));
		}
	}
}

module grips(){
	for(i=[1:numOfGrips])
	{
	hull(){
		for(n=[1:SmoothingAmount])
			translate([driverRadius*sin(i*360/numOfGrips),driverRadius*cos(i*360/numOfGrips),(driverHeight-gripHeight)/2+gripRadius*sin(n*90/SmoothingAmount)]) cylinder(r=gripRadius*sin(n*90/SmoothingAmount),h=gripHeight-2*gripRadius+2*gripRadius*cos(n*90/SmoothingAmount));
		}
	}
}
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
module head(){
translate([0,0,driverHeight+.1*driverRadius]) scale([1,1,.4]) sphere(driverRadius);
}
difference(){
union(){
driverBase();
head();
}
grips();
translate(0,0,bitLength)hexagon(bitSize/2,bitLength*2);
}