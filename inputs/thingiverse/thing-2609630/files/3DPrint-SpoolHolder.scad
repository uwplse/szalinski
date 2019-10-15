/* Permet de contruire un spool holder parametric
By jeff le 10/2017
*/

//-------------------Declaration des variables

/* [Basic] */
//Interior Spool's diameter (in mm)
_diameter_spool = 70; //
//Axe's diameter (in mm)
_diameter_hole_center = 8.5;	//[1:0.5:100]



/* [Advanced] */
//Thickness (in mm)
_epaisseur = 7;//[1:1:150]

//Arms's quantity
_nb_rayon = 3;	//[2:1:10]

//EndStop's diameter (in mm)
_diametre_anneau = 10;	//[0:1:100]
//EndStop's thickness (in mm)
_epaisseur_anneau = 2;	//[1:1:10]
//EndStop's quantity
_nb_anneau = 3;	//[0:1:100]



/* [hidden] */



// Write no if your are generating this this with openscad.
//You will have more option
_thingiverse = "no"; //[yes,no]





//-------------------!Déclaration des variables





//-------------------Contruction de la forme

//Base fixe
base();

//Anneau de butée
if (_nb_anneau>0){
	
	if (_thingiverse == "no"){
		for (_i=[0:(360/_nb_anneau):360])
			rotate([0,0,_i]){
				anneau();
			}
			;
	}else{
	
		rotate([0,0,0]){anneau();}
		rotate([0,0,90]){anneau();}
		rotate([0,0,180]){anneau();}
		rotate([0,0,270]){anneau();}		
	
	}
}


//-------------------!Contruction de la forme






//Module de base
module base(){

	difference(){ //Anneau exterieur

		polyhole(_epaisseur,_diameter_spool);

		
		polyhole(_epaisseur+10,_diameter_spool - 10 );

	}
		
	difference(){ 

		union(){
			polyhole(_epaisseur,_diameter_hole_center+5);
			
			if (_thingiverse == "no"){
				for (_i=[0:(360/_nb_rayon):360])
					
					rotate([0,0,_i]){
						bras();
					};

			}else{
				
				rotate([0,0,0]){bras();}
				rotate([0,0,90]){bras();}
				rotate([0,0,180]){bras();}
				rotate([0,0,270]){bras();}
			
			}//!if
		
		
		};
	
		polyhole(_epaisseur+10,_diameter_hole_center );

	}
	
}//!module base

//Module des anneaux stop
module anneau(){
	translate([_diameter_spool/2,0,(_epaisseur/2)-(_epaisseur_anneau/2)]){
		polyhole(_epaisseur_anneau,_diametre_anneau);
	}
}//!Module anneaux

//Module de trou
module polyhole(_h, _d) {
    _n = max(round(20 * _d),3);
    cylinder(h = _h, r = (_d / 2) / cos (180 / _n), $fn = _n,center = true);
}//!Module de trou

//Module des rayons
module bras(){
	translate([(_diameter_spool-1)/2,1,(_epaisseur/2)*-1]){
		rotate([0,0,180]){
			cube(size = [((_diameter_spool-1)/2),2,_epaisseur], center = false);
		}
	}
}//!Module bras








