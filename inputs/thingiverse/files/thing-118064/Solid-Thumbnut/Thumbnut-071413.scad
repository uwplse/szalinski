//Thumbscrew by John Davis 7-14-13
//Polyhole module by nophead

/*[Dimensions of thumbscrew]*/
//Thumbnut diameter
Thumbnut_Diameter = 16;
//Thumbnut height
Thumbnut_Height = 7;
//Thickness of knurled portion
Knurling_Thickness = 3.5;
//Number of knurls
Knurls = 15;
//Hole diameter (before threading)
Hole_Diameter = 3.5;


/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;


/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 


difference() {
	union () {
		translate([0,0,Knurling_Thickness-Padding])
		cylinder (h = Thumbnut_Height-Knurling_Thickness, r = (Thumbnut_Diameter-Knurling_Thickness)/2);
		difference() {
			union() {
				cylinder(h =Knurling_Thickness, r = Thumbnut_Diameter/2-Knurling_Thickness/2);
				rotate_extrude ()
				translate([Thumbnut_Diameter/2-Knurling_Thickness/2,Knurling_Thickness/2,0])
				circle(r=Knurling_Thickness/2+Padding);
			}
			for (i = [0:Knurls-1]) {
				rotate([0,0,(360/Knurls)/2+i*(360/Knurls)])
				translate([Thumbnut_Diameter/2,0,-Padding])
				cylinder(r=Knurling_Thickness/3, h=Knurling_Thickness+2*Padding);
			}
		}
	}
	
	//Hole for threaded shaft
	rotate([0,0,30])
	translate([0,0,-Padding])
	polyhole(Thumbnut_Height+2*Padding, Hole_Diameter*0.85);//Hole is shrunk to allow extra material for tapping
	
	//Recess as indicator
	hull(){
		translate([Hole_Diameter/2+Knurling_Thickness/3,0,0])
		cylinder(r=Knurling_Thickness/4, h=Knurling_Thickness/2, center=true);
		translate([Thumbnut_Diameter/2-3*Knurling_Thickness/4,0,0])
		cylinder(r=Knurling_Thickness/4, h=Knurling_Thickness/2, center=true);
	}
}

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}
