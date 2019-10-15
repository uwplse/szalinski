use <write/Write.scad>
text="BATMAN"; //input name here!


difference(){
	hull(){
		cube([80,16,2],center=true);
	
		translate([40,8,0])cylinder(r=2,h=2,center=true,$fn=20);
		translate([-40,8,0])cylinder(r=2,h=2,center=true,$fn=20);
		translate([40,-8,0])cylinder(r=2,h=2,center=true,$fn=20);
		translate([-40,-8,0])cylinder(r=2,h=2,center=true,$fn=20);
	}

	translate([-36,0,0])cube([4,12,10],center=true);
}

translate([-24,0,0])rotate([0,0,90])
union(){
	translate([0,3,1])scale([1.75,1,1])write("W",t=2,h=10,center=true,font="orbitron.dxf");
	translate([0,-5,1])scale([1,1,1])write("BOTHELL",t=2,h=3.5,center=true,font="orbitron.dxf");
}

translate([11,0,1])write(text,t=2,h=10,center=true,font="orbitron.dxf");