
//  Outer diameter
OD_inch = 0.865;
//  Inner diameter
ID_inch = 0.685;
Lip_Thickness = 0.4;
//  Number of prongs
N = 3;
//  Distance from prong edge to center
D = 1;
//  Prong diameter
PD = 2.5;
Prong_Thickness=0.2;
//  Facets for circles
$fn=64;

anti_rollout();

module anti_rollout() {
	intersection() {
		cylinder(h=Lip_Thickness*3, r=25.4*OD_inch/2, center=true);
		union() {
			difference() {
				cylinder(h=Lip_Thickness, r=1.01*25.4*OD_inch/2);
				cylinder(h=Lip_Thickness*3, r=25.4*ID_inch/2, center=true);
			}
			for (a=[0:N-1]) rotate([0,0,360*a/N]) hull() {
					translate([0,D+PD/2,0]) cylinder(h=Prong_Thickness,r=PD/2);
					translate([0,25.4*ID_inch/2,0]) cylinder(h=Prong_Thickness,r=PD/2);
			}
		}
	}
}
