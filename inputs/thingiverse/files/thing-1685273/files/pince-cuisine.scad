/**************************************************/
/* Fichier: pince_cuisine.scad                    */
/* Crée par: Rom1 - CANEL - https://www.canel.ch  */
/* Date: 22 juillet 2017                          */
/* Liscence: Creative Commons: (BY SA)            */
/*           Attribution - Partage dans les Mêmes */
/*           Conditions 4.0 International.        */
/* Programme: openscad                            */
/* Déscription: Pince paramétrable pour mettre	  */
/*              des services de cuisine.          */
/**************************************************/


/*************/
/* Variables */
/*************/

epaisseur = 2;						// Epaisseur de couche

/* Diamétre & angle du ressort */
angle = 30;							// Angle de la pince (MAX 55°)
diametre = 25;						// Diamètre du ressort

/* Ouverture pour enfiler le service */
ouverture_service_x = 4;		// Epaisseur du service
ouverture_service_y = 15;		// Longueur de la petite encoche
ouverture_service_z = 22;		// Hauteur du service

longueur_encoche = 35;	// Longueur totale de l'encoche	


/* Paramètre avancé*/
$fn = 36;      // Résolution de l'anneau
hauteur = ouverture_service_z+2*epaisseur;	// Hauteur de la pince


/***********/
/* Modules */
/***********/

/* La moitier de la partie ressore de la pince */
module ressore(
			ar,					// Angle ressort
			dia,					// Diamètre ressort
			ep,					// Epaisseur
			h						// Hauteur
){
	// Calcule la distance opposée de la moitier de l'angle
	function opp(alpha) = tan(alpha)*dia/2;

	difference(){
		cylinder(h, d=dia+ep);
		cylinder(h, d=dia-ep);
		linear_extrude(h)
			polygon([[0, 0], [0, dia], [opp(ar), dia]], [[0,1,2]]);
mirror([1,0,0])
		linear_extrude(h)
			polygon([[0, 0], [0, dia], [opp(ar), dia]], [[0,1,2]]);
	}
}

/* L'encoche */
module encoche(
			osx,					// Ouverture pour le service x
			osy,					// Ouverture pour le service y
			osz,					// Ouverture pour le service z
			ep,					// Epaisseur de couche
			l						// Longueur de l'encoche
){
	cube([ep, l, osz+2*ep]);
	difference(){
				cube([osx+2*ep, osy, osz+2*ep]);
		translate([ep,0,ep])
			cube([osx, osy, osz]);
	}
}

/* Le ressort + les 2 encoches	 */
module pince(
			aa,					// Angle ressort
			dia,					// Diamètre ressort
			ep,					// Epaisseur
			h,						// Hauteur
			osx,					// Ouverture pour le service x
			osy,					// Ouverture pour le service y
			osz,					// Ouverture pour le service z
			l						// Longueur de l'encoche
){
	ressore(aa, dia, ep, h);

	rotate([0, 0, 180+aa/2])
		translate([0, -l-dia/2+ep/2, 0])
			mirror([0,0,0])
				encoche(
					osx,
					osy,
					osz,
					ep,
					l
				);

	rotate([0, 0, -aa/2])
		translate([0, l+dia/2-ep/2, 0])
			mirror([0,1,0])
				encoche(
					osx,
					osy,
					osz,
					ep,
					l
				);
}

/***********************/
/* Programme principal */
/***********************/



	pince(
		angle,
		diametre,
		epaisseur,
		hauteur,
		ouverture_service_x,
		ouverture_service_y,
		ouverture_service_z,
		longueur_encoche
	);