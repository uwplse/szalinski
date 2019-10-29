/* Permet de contruire un support pour les bouttons du boitier NES
By jeff le 10/2017
*/

//-------------------Declaration des variables

/* [Basic] */
//Buttons 's diameter (in mm)
_diameter_small = 10;
_diameter_big = 20;
_height = 30;

/* [Hole] */
_hole_depth = 10;
_diameter_hole = 10;

/* [hidden] */


//-------------------!Déclaration des variables





//-------------------Contruction de la forme

//Base fixe
difference(){
	base();

	trou();
	

	
}




//-------------------!Contruction de la forme






//Base horizontale
module base(){
	
	$fn=50;
	hull(){
		//Boule a la base
		translate([0,0,_height-_diameter_big/2])sphere(r=_diameter_big/2);
		//forme du haut
		translate([0,0,0.5]) polyhole(1,_diameter_small+2);
		*translate([0,0,_diameter_small/2]) sphere(r=_diameter_small/2);
	}
  	
}//!module base

module trou(){
	translate([0,0,_hole_depth/2]){
		polyhole(_hole_depth,_diameter_hole);
	}
}


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


	














