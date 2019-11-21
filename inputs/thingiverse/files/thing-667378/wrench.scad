
// André Groß
// www.andre-gross.de
// andregro (a) students. uni-mainz.de


nut = 6;
height = 150;
handleHeight = 60;
handleDiameter = 12;
shaftDiameter = 6;
wrench(nut,height,handleHeight,handleDiameter,shaftDiameter);
module wrench(nut,height,handleHeight,handleDiameter,shaftDiameter) {
	difference(){
		union(){
			cylinder(h=nut*3,r=nut/2+2,$fn=20);
			translate([0,0,nut*3])cylinder(h=nut,r1=nut/2+2,r2=shaftDiameter/2,$fn=20);
			cylinder(h=height,r=shaftDiameter/2,$fn=20);
			translate([0,0,height-handleHeight-nut])cylinder(h=nut,r1=shaftDiameter/2,r2=handleDiameter/2,$fn=20);
			for (i=[0:3]) {
				rotate(i*45)translate([-handleDiameter/12,-handleDiameter/2,height-handleHeight])cube([handleDiameter/6,handleDiameter,handleHeight]);
			}
			translate([0,0,height])sphere(handleDiameter/2,$fn=40);
		}
		cylinder(h=nut,r=nut/2,$fn=6);
		cylinder(h=nut*2,r=nut/3,$fn=20);
	}
}
