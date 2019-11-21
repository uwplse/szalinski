DiaGrill = 40;
Length = DiaGrill + 2;
DiaScrew = 3;
DiaScrewHead = 7;
Thickness = 3.2;
$fn = 150;

union(){
	difference(){
// Mounting bracket
		union(){
			hull(){
				translate([DiaGrill/2.25, DiaGrill/2.25, 0])cylinder(d1=4*DiaScrew, d2=3*DiaScrew, h=Thickness, center=true);
				translate([DiaGrill/3, DiaGrill/3, 0])cylinder(d1=5.5*DiaScrew, d2=4.5*DiaScrew, h=Thickness, center=true);
			}
			hull(){
				translate([-DiaGrill/2.25, DiaGrill/2.25, 0])cylinder(d1=4*DiaScrew, d2=3*DiaScrew, h=Thickness, center=true);
				translate([-DiaGrill/3, DiaGrill/3, 0])cylinder(d1=5.5*DiaScrew, d2=4.5*DiaScrew, h=Thickness, center=true);
			}
			hull(){
				translate([DiaGrill/2.25, -DiaGrill/2.25, 0])cylinder(d1=4*DiaScrew, d2=3*DiaScrew, h=Thickness, center=true);
				translate([DiaGrill/3, -DiaGrill/3, 0])cylinder(d1=5.5*DiaScrew, d2=4.5*DiaScrew, h=Thickness, center=true);
			}
			hull(){
				translate([-DiaGrill/2.25, -DiaGrill/2.25, 0])cylinder(d1=4*DiaScrew, d2=3*DiaScrew, h=Thickness, center=true);
				translate([-DiaGrill/3, -DiaGrill/3, 0])cylinder(d1=5.5*DiaScrew, d2=4.5*DiaScrew, h=Thickness, center=true);
			}
// Outer circle
			cylinder(d1=DiaGrill+Thickness+3,d2=DiaGrill+Thickness, h=Thickness, center=true);
		}
// Inner circle
		cylinder(d=DiaGrill, h=Thickness*2, center=true);
// Screw
	// Inner hole
		translate([-DiaGrill/2.25, -DiaGrill/2.25, 0])cylinder(d=DiaScrew, h=2*Thickness, center=true);
		translate([-DiaGrill/2.25, DiaGrill/2.25, 0])cylinder(d=DiaScrew, h=2*Thickness, center=true);
		translate([DiaGrill/2.25, -DiaGrill/2.25, 0])cylinder(d=DiaScrew, h=2*Thickness, center=true);
		translate([DiaGrill/2.25, DiaGrill/2.25, 0])cylinder(d=DiaScrew, h=2*Thickness, center=true);
	// Screw head
		translate([-DiaGrill/2.25, -DiaGrill/2.25, Thickness/5])cylinder(d=DiaScrewHead, h=Thickness, center=false);
		translate([-DiaGrill/2.25, DiaGrill/2.25, Thickness/5])cylinder(d=DiaScrewHead, h=Thickness, center=false);
		translate([DiaGrill/2.25, -DiaGrill/2.25, Thickness/5])cylinder(d=DiaScrewHead, h=Thickness, center=false);
		translate([DiaGrill/2.25, DiaGrill/2.25, Thickness/5])cylinder(d=DiaScrewHead, h=Thickness, center=false);
	}

// Infill	
	difference(){
		for(i=[0:1:7]){
			translate([0,Length/2-i*Thickness*2.3])rotate([40,0,0])cube([Length, Thickness/2, Thickness*2], center=true);
		}
		difference(){
			cube([Length+500, Length+500, Thickness*2], center=true);
			cylinder(d=DiaGrill, h=Thickness*2, center=true);
		}
		translate([0,0,Thickness])cube([Length+30, Length+30, Thickness], center=true);
		translate([0,0,-Thickness])cube([Length+30, Length+30, Thickness], center=true);
	}

}