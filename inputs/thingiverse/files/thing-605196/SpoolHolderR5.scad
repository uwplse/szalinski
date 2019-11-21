/* [Parameters] */

// Holder Diameter
D = 25; 
// Holder Thickness
Th= 4;
// Spool Length
SL = 62; 
// Support Separation
SS = 3.2;
// Support Thickness
ST = 8;
// Support Height
SH = 30;
// Holder Length
HL = SL+3*Th;
// Edge Height
EH = 5;   //

/* [Hidden] */

sc = (EH+D)/(D);

module spoolHolder(){
union(){
	difference(){
		difference(){
			
			union(){	

					cylinder(h=HL,r=D/2,$fn=100, center = false);
					translate([-D/2,0,0]) cube(size = [D,D/4,HL]);
					translate([0,0,0]) scale([1, sc, 1]) 
						cylinder(h=Th,r=D/2,$fn=100);
					translate([0,0,SL+Th]) scale([1, sc, 1]) 
						cylinder(h=Th,r=D/2,$fn=100);
			}
			translate([0,Th/2,Th]) cylinder(h=HL-2*Th,r=D/2-Th,$fn=100);
		}
		translate([-1-D/2,0,-1]) cube(size = [D+2,D,HL + 2]);
	}

	translate([-D/2,-SH,HL]) cube([D,SH,Th]);	
	translate([-D/2,-SH,HL+Th+SS]) cube([D,SH,Th]);
	translate([-D/2,-SH,HL]) cube([D,ST,2*Th+SS]);
}
}

rotate([-90,0,0]) 
spoolHolder();

