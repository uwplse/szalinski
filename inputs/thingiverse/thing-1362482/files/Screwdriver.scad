include <write/Write.scad>

hexDiameter=8;
hexHolderThickness=4; //The thickness of the plastic surrounding the hex bit
centralNutDiameter=14;
handleHeight=58;
bitDepth=8.1;
width=(hexDiameter+hexHolderThickness)*cos(30);
message = "Happy DIY";
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

rotate ([0,90,0]) difference()
{
	handle();
	translate([0, 0, -0.1])  rotate([0,0,30]) bitHole();
	translate([0, 0, handleHeight-bitDepth+0.1]) rotate([0,0,30]) bitHole();
	translate([-width/2-2,-8, handleHeight/2]) rotate([0,90,0]) cylinder(h=width+4, r=centralNutDiameter/2, $fn=6);
}


module bitHole()
{
	cylinder(h=bitDepth , r=hexDiameter/2, $fn=6);
}

module longHolder()
{
	difference() {
		union(){
			rotate([0,0,30]) cylinder(h=handleHeight, r=(hexDiameter+hexHolderThickness)/2, $fn=6);
			translate([-width/2+0.1,0,45]) rotate([0,-90,0]) write(message,t=3,h=4,center=true,font=Font);
		}
		translate([0,0,handleHeight-bitDepth+0.1]) rotate([0,0,30]) bitHole();

	}
}

module handle()
{
	union()
	{
		rotate([0,0,30]) cylinder(h=handleHeight, r=(hexDiameter+hexHolderThickness)/2, $fn=6);
		translate([0,0,handleHeight/2]) rotate(a=[90,0,0]) longHolder();
		translate([0,0,handleHeight/2-35/2]) rotate([0,90,180]) equiTriangle(35,width);
	}
}

// Modules  improved from MCAD library : https://github.com/elmom/MCAD/blob/master/shapes.scad
module equiTriangle(side, height) {
  difference() {
    translate([-side/2,side/2,0]) cube([side, side, height], true);
    rotate([0,0,30]) dislocateBox(side, side*1.5, height+0.1);
    translate([-side,0,0])  rotate([0,0,60]) dislocateBox(side*1.5, side, height+0.1);
  }
}

module dislocateBox(w, h, d) {
  translate([0,0,-d/2]) cube([w,h,d]);
}