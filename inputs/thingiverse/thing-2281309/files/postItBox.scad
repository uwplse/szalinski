/**************************************************/
/* Fichier: postItBox.scad                        */
/* Crée par: Rom1 - CANEL - https://www.canel.ch  */
/* Date: 22 juillet 2017                          */
/* Licence: GNU GENERAL PUBLIC LICENSE v3         */
/* Programme: openscad                            */
/* Déscription: Boîte pour ranger des post-it ou  */
/*              ou des cartes de visites.         */
/**************************************************/

/*************/
/* Variables */
/*************/

thickness = 2;				// Épaisseur de la boîte

paper_width = 57;			// Dimension du papier (post-it, cartes, etc)
paper_length = 87;

box_height = 50;			// Hauteur de la boîte

slit = true;				// Prévoir l'ouverture
slit_width = 20;			// Largueur de l'ouverture

base_width = 67;			// Dimension du socle de la boîte
base_length = 97;
base_height = 2;

box_length = paper_length + thickness * 2; 
box_width = paper_width + thickness * 2;


/***********/
/* Modules */
/***********/

// Module dessinant l'ouverture
module slit(){
	translate([0, slit_width/2, 0]) cylinder(d=slit_width, h=thickness*3, center=false);
	translate([-slit_width/2, slit_width/2, 0]) cube([slit_width, box_height-slit_width/2, thickness*3]);
}

// Module dessinant le socle
module base(){
	cube([base_length, base_width, base_height]);
}

// Module dessinant la boîte
module container(){
	difference(){
		cube([box_length, box_width, box_height + thickness]);
		translate([thickness, thickness, thickness]) cube([paper_length, paper_width, box_height]);
		if (slit){
			rotate([90, 0, 0]) translate([(box_length/2), base_height, -(base_width - box_width)/2]) slit();
		}
	}
}


/********/
/* Main */
/********/

base();
translate([(base_length - box_length)/2, (base_width - box_width)/2, 0]) container();
