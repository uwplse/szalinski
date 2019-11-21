//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//makes a male to female coupling for joining two rods together
//there is a hole for a screw in the female end
//and a contact point for a screw on the mail end

//diameter of male end of the coupling (mm)
male_diam=5.8;
//length of male end of the coupling (mm)
male_h=10;
//inner diameter of female end of coupling (mm)
fem_diam=13.5;
//depth of female coupling (mm)
fem_h=12;
//screw size (mm)
screw_diam=3.45;
//how much plastic is between features, determines outer diameter of female end (mm)
thick=3;



module hide_variables() {
	// just a placeholder to hide variables from customizer
}

$fs=0.5;
$fa=1;

//radius of male end
male_rad=male_diam/2;
//radius of female end
fem_rad=fem_diam/2;

//outer surface of female end
fem_o_rad=fem_rad+thick;
fem_o_h=fem_h+thick+fem_rad;
//screw radius
screw_rad=screw_diam/2;
//depth of divot on male end
div_h=1.5;


union() {
	//female end of coupling
	difference() {
		//outer surface
		cylinder(r=fem_o_rad, h=fem_o_h, center=false);
		//inner surface
		cylinder(r=fem_rad, h=fem_h, center=false);
		translate([0, 0, fem_h]) cylinder(r1=fem_rad, r2=0, h=fem_rad, center=false);
		//screw hole
		translate([0, 0, fem_h/2]) rotate([0, 90, 0]) cylinder(r=screw_rad, h=fem_o_rad+1, center=false);
	}
	//Male end of coupling
	difference() {
		//male shaft
		translate([0, 0, fem_o_h]) cylinder(r=male_rad, h=male_h, center=false);
		//screw divot
		translate([male_rad, 0, fem_o_h+male_h/2]) rotate([0, -90, 0]) cylinder(r1=screw_rad, r2=0, h=div_h, center=false);
	}
}








