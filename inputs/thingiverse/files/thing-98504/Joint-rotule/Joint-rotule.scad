// Dimensions en mm
hauteur_piece = 11;
diametre_socle = 14.6;
epaisseur_socle = 2;
diametre_trou = 7.8;
diametre_trou_sommet = 6;
hauteur_cone = 3.5;
diametre_cylindre = 9.4;
hauteur_encoche = 7.5;
largeur_encoche = 3;
hauteur_clip = 4;
largeur_clip = 4.5;
epaisseur_clip = .75;

$fn=100; //resolution

module clip(){
intersection(){
translate(v=[0,0,hauteur_piece-hauteur_clip]){
hull(){
linear_extrude(height=1){circle(diametre_cylindre/2+epaisseur_clip);}
linear_extrude(height=hauteur_clip){circle(diametre_cylindre/2);}
}
}

translate(v=[0,0,hauteur_piece-hauteur_clip/2]){
cube([diametre_socle,largeur_clip,hauteur_clip], center=true);
}
}
}


module socle(){cylinder(h=epaisseur_socle,r=diametre_socle/2);}

module cylindre_exterieur(){
	cylinder(h=hauteur_piece,r=diametre_cylindre/2);
}

module cylindre_interieur(){
	cylinder(h=hauteur_piece-hauteur_cone,r=diametre_trou/2);
}

module cone_interieur(){
	translate(v=[0,0,hauteur_piece-hauteur_cone]){
		cylinder(h=hauteur_cone,r1=diametre_trou/2,r2=diametre_trou_sommet/2);
	}
}

module creu_interieur(){
	union(){
		cylindre_interieur();
		cone_interieur();
	}
}

module flex(){
	translate(v=[0,diametre_cylindre/2,hauteur_piece-hauteur_encoche+largeur_encoche/2]){
		rotate(a=90, v=[1,0,0]) {
			cylinder(h=diametre_cylindre,r=largeur_encoche/2);
			translate(v=[-largeur_encoche/2,0,0]){
				cube(size = [largeur_encoche,hauteur_encoche-largeur_encoche/2,diametre_cylindre], center=false);
			}
		}
	}
}

module base(){
	difference(){
		union(){
			cylindre_exterieur();
			socle();
			clip();
		}
		creu_interieur();
		flex();
	}
}

base();
