

// radius cylinder
ray_cyl = 30;
// height cylinder
haut_cyl = 50;

module toto() {
}


$fn = 24;
tol_trou = 1.5;
ray_trou = 2.5;
haut_trou = 15;
ep_pied = 3;
haut_pied = ray_cyl*3;


support();

pied_gauche();

pied_droit();

module support() {

	difference() {
		cylinder(r=ray_cyl,h=haut_cyl);
		cylinder(r=ray_trou+tol_trou/2,h=haut_trou);
		translate([0,0,haut_cyl-haut_trou])
		cylinder(r=ray_trou+tol_trou/2,h=haut_trou);
	}
}

module pied_gauche() {
	
	translate([ray_cyl+10,0,0]) {
		union() {
			hull() {
				cube([ray_cyl/3*4,ep_pied,3]);
				translate([ray_cyl/3*4/2,0,0])
				translate([0,haut_pied,3/2])
				cube([ray_trou*4,ray_trou*4,ep_pied], center = true);
			}
			translate([ray_cyl/3*4/2,0,0])
			translate([0,haut_pied+ray_trou*4/2,3/2])	
			cylinder(r=ray_trou*4/2,h=ep_pied,center=true);
			translate([ray_cyl/3*4/2,0,ep_pied])
			translate([0,haut_pied+ray_trou*4/2,ep_pied+3/2])
			cylinder(r=ray_trou,h=haut_trou,center=true);
		}
	}
}

module pied_droit() {
	
	translate([-(ray_cyl/3*4+ray_cyl+10),0,0]) {
		union() {
			hull() {
				cube([ray_cyl/3*4,ep_pied,3]);
				translate([ray_cyl/3*4/2,0,0])
				translate([0,haut_pied,3/2])
				cube([ray_trou*4,ray_trou*4,ep_pied], center = true);
			}
			translate([ray_cyl/3*4/2,0,0])
			translate([0,haut_pied+ray_trou*4/2,3/2])	
			cylinder(r=ray_trou*4/2,h=ep_pied,center=true);
			translate([ray_cyl/3*4/2,0,ep_pied])
			translate([0,haut_pied+ray_trou*4/2,ep_pied+3/2])
			cylinder(r=ray_trou,h=haut_trou,center=true);
		}
	}
}


































