use <write/Write.scad>

label = "ExcelFil";
spool_diameter = 31.2;
holder_diameter = 4.5;
brand = str(label, " ", spool_diameter, "mm / ", holder_diameter, "mm");

$fn = 300*1;
font = "orbitron.dxf";

difference(){
	union(){
		cylinder(r=spool_diameter*1.4/2, h=3);
		cylinder(r=spool_diameter/2, h=11);		
	}
	cylinder(r=holder_diameter/2*1.05, h=20);
	color("green") 
		writecylinder(brand,[0,0,0],spool_diameter*1.45/2,3,face="top", t=1, h=spool_diameter/2*1.2-spool_diameter/2);
}