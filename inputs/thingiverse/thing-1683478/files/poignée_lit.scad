/**************************************************/
/* Crée par: Rom1 - CANEL - https://www.canel.ch  */
/* Date: 17 juillet 2017                          */
/* Liscence: Creative Commons: (BY SA)            */
/*           Attribution - Partage dans les Mêmes */
/*           Conditions 4.0 International.        */
/* Programme: openscad                            */
/* Déscription: Poignée pour un lit Ikea          */
/**************************************************/


/*************/
/* Variables */
/*************/

/* 1: Poignée */
/* 2: Encoche */
/* 0: les 2 pièces */
pieces = 0;

/* Dimention de la poignée */
hauteur = 70;
diametre = 20;

/* Ouverture pour l'encoche */
ouverture_x_min = 4;
ouverture_x_max = 7;
ouverture_z = 20;

/* Type encoche     */
/* 1: rectangulaire */
/* 2: rond          */
enc = 1;

/* Epaisseur de l'encoche */
epaisseur = 4;


/***********/
/* Modules */
/***********/

/* Poignée */
module poignee(){
	difference(){
		cylinder(hauteur, d=diametre);
		translate([-ouverture_x_min/2, 0, hauteur/2-ouverture_z/2]) cube([ouverture_x_min, diametre, ouverture_z]);
		translate([-ouverture_x_max/2, -diametre, hauteur/2-ouverture_z/2]) cube([ouverture_x_max, diametre, ouverture_z]);
	}
}

/* Encoche */
module encoche(){
	if(enc == 1){
		cube([ouverture_z-2, diametre/6, epaisseur]);
	}
	if(enc == 2){
		cylinder(ouverture_z-2, d=epaisseur, $fn=50);
	}
}

/***********************/
/* Programme principal */
/***********************/

if(pieces == 1){
	poignee();
}
if(pieces == 2){
	encoche();
}
if(pieces == 0){
	translate([-diametre/2-5, 0, 0]) poignee();
	translate([5, -(ouverture_z-2)/2, 0]) rotate([0, 0, 90]) encoche();
}