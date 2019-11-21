/* Permet de contruire un support pour les bouttons du boitier NES
By jeff le 10/2017
*/

//-------------------Declaration des variables

/* [Basic] */
//Buttons's depth (in mm)
_depth_button = 6; //[6:0.5:15]
//Buttons 's diameter (in mm)
_diameter_button = 1; //[1:0.5:8]

/* [LED] */
//Diameter LED (in mm)
_diameter_led = 5; //[3,5]
//LED's hat (Remove losing lighting in the case)
_led_hat = "yes"; //[yes,no]

/* [hidden] */
_epaisseur = 1.6;
_epaisseur_patte = 2;
_largeur = 38;
_hauteur_base_axe = 4;
_ajustement = 2.5;

//-------------------!Déclaration des variables





//-------------------Contruction de la forme

//Base fixe
base();

//Plaque variable
translate([0,_depth_button-_ajustement,0]){
	reglage(0);
}

//-------------------!Contruction de la forme






//Base horizontale
module base(){
	translate([-_largeur/2,2,-_epaisseur]){
		cube(size = [_largeur,20,_epaisseur], center = false);
	}	
	//Patte d'arret
	translate([-28/2,15,-3-_epaisseur]){
		cube(size = [28,3,3], center = false);
	}
}//!module base

//Module de plaque percée
module reglage(_profondeur){

difference(){ //Soustraction de la base avec les trous des bouttons

	
	union(){
		//Patte verticale
		translate([-_largeur/2,_profondeur,0]){
			cube(size = [_largeur,_epaisseur_patte,12], center = false);
		};
		
		//Chapeau LED
		if(_led_hat == "yes"){
		
			translate([-15,-_epaisseur,_hauteur_base_axe]){
				rotate([90,0,0]){
					*cylinder(h=_epaisseur*2,r1=(_diameter_led/2),r2=(_diameter_led/2),center=true);
					polyhole(6,_diameter_led+1.5);
				}
			};
			
		}//!if
	
	}
	;
	
	




	//Trous a droite
	translate([6.1,1,_hauteur_base_axe]){
		trou_bouton(_diameter_button);
	}

	//Trous a gauche
	translate([-6.1,1,_hauteur_base_axe]){
		trou_bouton(_diameter_button);
	}

	//Trous LED
	translate([-15,1,_hauteur_base_axe]){
		rotate([90,0,0]){
			polyhole(_epaisseur*100,_diameter_led+0.5);
		}
	}

};


}//!Module reglage

//Module de trou des bouttons
module trou_bouton(_diametre){

	rotate([90,0,0]){
		*cylinder(h=_epaisseur*2,r=(_diametre/2),center=true);
		polyhole(_epaisseur*2,_diametre);
		translate([0,20/2,0]){
			cube(size = [_diametre,20,_epaisseur*2], center = true);
		}
		
	}//!rotate

}//!trou_bouton

//Module de trou
module polyhole(_h, _d) {
    _n = max(round(20 * _d),3);
    cylinder(h = _h, r = (_d / 2) / cos (180 / _n), $fn = _n,center = true);
}//!Module de trou


//Module de trou
module polyhole2(_h, _d1,_d2) {
    _n = max(round(20 * _d1),3);
    cylinder(h = _h, r1 = (_d1 / 2) / cos (180 / _n),r2 = (_d2 / 2) / cos (180 / _n), $fn = _n,center = true);
}//!Module de trou


	














