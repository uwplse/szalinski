/* Permet de contruire une tige permettant d'enlever le RPI ou autre
By jeff le 10/2017
*/
 

//Declaration des variables

//HEIGHT (mm).		
_height = 20; //[1:200]





//Base
translate([0,0,-2]){

	cylinder(h=2,r1=10,,r2=7,center=false);

	translate([0,0,-1]){
		cylinder(h=1,r1=10,r2=10,center=false);
	}
}


//Tige
cylinder(h=_height,r=2,center=false);

