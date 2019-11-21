/* Permet de contruire un élément modulable a associer 
avec un boitier Raspberry
By jeff le 10/2017
*/
 

//Declaration des variables

/* [Basic] */
// Which face of the enclosure to generate
_show = "box"; // ["box":Enclosure, "cover":Cover's enclosure] 

//Interior WIDTH in (mm).
_largeur_interieur = 150; //[60:200]
//Interior HEIGHT (mm).		
_hauteur_interieur = 40;	//[1:200]
//Interior DEPTH in (mm).		
_profondeur_interieur = 100; //[1:200]
//Printer Thickness. Not affect the width, height, depth values.	

/* [Advanced] */
//Enclosure thickness (mm)
_epaisseur = 1.6;	//[0.8:0.2:8]

//Rails's entraxe. Keep 50mm for raspberry's enclosure compatibility
_entraxe_rails = 50;
//Top rails generation
_up_rail = "yes";		//[[yes,no]
//Bottom rails generation
_down_rail = "yes";		//[yes,no]

//Top grid generation
_up_grid = "no";		//[yes,no]
//Bottom grid generation
_down_grid = "no";		//[[yes,no]
//! Déclaration des variables

/* [Cover] */
//HEIGHT
_hauteur_pattes = 5;
//HEIGHT size
_longueur_pattes_hauteur = 200;//[200]
//WIDTH size
_longueur_pattes_largeur = 200;//[200]
//Hole's diameter (wires ?). 0 to delete hole
 _diametre_trou = 20;

// Calcul/ajustement des variables

	//Centre de la largeur du modele
	_milieu_largeur = ((_largeur_interieur + (_epaisseur*2))/2); 

	//Centre de la profondeur du modele
	_milieu_profondeur = (_profondeur_interieur/2); 

	// Largeur de la grille
	_largeur_grid = _largeur_interieur-10;

	// Profondeur de la grille		
	_profondeur_grid = _profondeur_interieur-((_profondeur_interieur*20)/100);
	
// ! Calcul des variables

//Construction de la BOX
if (_show == "box"){
//---------CONSTRUCTION DES RAILS  ----------

//Rail d'assemblage du bas
if (_down_rail == "yes"){
	translate([(_largeur_interieur+_epaisseur)/2,0,_epaisseur*-1]){ //Centrage des rails
		translate([_entraxe_rails/2,0,0]) 
		{
			linear_extrude (height=_profondeur_interieur+_epaisseur)railfemelle(); //1er rail
		}
		translate([_entraxe_rails/2*-1,0,0]) 
		{
			linear_extrude (height=_profondeur_interieur+_epaisseur)railfemelle(); //2ieme rail
		}
	}
}

//Rail d'assemblage du haut
if (_up_rail == "yes"){
	translate([(_largeur_interieur+_epaisseur)/2,_hauteur_interieur+_epaisseur,_epaisseur*-1]){ //Centrage des rails
		translate([_entraxe_rails/2,0,0]) 
		{
			linear_extrude (height=_profondeur_interieur+_epaisseur)railmale(); //1er rail
		}
		translate([_entraxe_rails/2*-1,0,0]) 
		{
			linear_extrude (height=_profondeur_interieur+_epaisseur)railmale(); //2ieme rail
		}
	}
}

//---------FIN CONSTRUCTION DES RAILS  ----------



//---------CONSTRUCTION DE LA BOX---------

//Extrusion de base
	difference(){ //Soustraction de la base avec la grille

		difference(){ //Soustraction de la base exterieur avec la base interieur
			
			//Extrusion Exterieur
			face(_largeur_interieur+_epaisseur,_hauteur_interieur+_epaisseur,_profondeur_interieur,"blue");
		
			//Extrusion Interieure
			translate([_epaisseur/2,_epaisseur/2,0]){
				face(_largeur_interieur,_hauteur_interieur,_profondeur_interieur);
			}
		};
			
		
		//Grille basse à soustraire
		if (_down_grid == "yes"){
			rotate([90,0,0]){
				translate([_milieu_largeur,_milieu_profondeur,-(_epaisseur+1)])
				{
					grid(_largeur_grid, _profondeur_grid, _epaisseur+1, 5, 3);
				}
			};
		}
		
		//Grille haute à soustraire
		if (_up_grid == "no"){
			rotate([90,0,0]){
				translate([_milieu_largeur,_milieu_profondeur,-(_hauteur_interieur+_epaisseur)])
				{
					grid(_largeur_grid, _profondeur_grid, _epaisseur, 5, 3);
				}
			};
		}
	}
   
//Base arrière  (cul du modele)  

difference(){

	translate([0,0,_epaisseur*-1]){
		face(_largeur_interieur+_epaisseur,_hauteur_interieur+_epaisseur,_epaisseur,"red");
	};
	
	//Trou a l'arriere
	translate([_milieu_largeur-(_entraxe_rails/2),(_hauteur_interieur+_epaisseur)/2,_epaisseur*-1]){
		cylinder(h=_epaisseur*2,r=2.5,center=true);
	};
	
	translate([_milieu_largeur+(_entraxe_rails/2),(_hauteur_interieur+_epaisseur)/2,_epaisseur*-1]){
		cylinder(h=_epaisseur*2,r=2.5,center=true);
	};
	
	translate([_milieu_largeur,(_hauteur_interieur+_epaisseur)/2,_epaisseur*-1]){
		cylinder(h=_epaisseur*2,r=2.5,center=true);
	};
	
}
//---------FIN CONSTRUCTION DE LA BOX---------

}

//Fin de la box

//Construction du couvercle
if (_show == "cover"){



difference(){ //Soustraction de la base avec la grille

	
			//Base
			color("Yellow",0.80){
				cube(size = [_largeur_interieur+(_epaisseur*2),_hauteur_interieur+(_epaisseur*2),_epaisseur], center = true);
			};
			
			//Trou pour passage de cable
			if (_diametre_trou>0){
				echo ("Hole cover");
				if (_diametre_trou >= _hauteur_interieur){	//Limitation du diametre_trou
					echo ("Hole cover oversize");
					_diametre_trou = _hauteur_interieur -1;
				
					cylinder(h=_epaisseur*2,r=(_diametre_trou/2),center=true);	
				}else{
			
					cylinder(h=_epaisseur*2,r=(_diametre_trou/2),center=true);
			
			
				}
			};
			
	
	}//!Difference
	
difference(){
	//Pattes
	
	union(){
	
				//Limitation de la longueur des pattes en largeur
		if(_longueur_pattes_largeur >= _largeur_interieur){
		_longueur_pattes_largeur = _largeur_interieur + _epaisseur*2;

			//Pattes du haut
			translate([0,(_hauteur_interieur+_epaisseur)/2,0]) patte("haut",_longueur_pattes_largeur); 
			
			translate([0,-(_hauteur_interieur+_epaisseur)/2,0]) patte("haut",_longueur_pattes_largeur); 
		}else{
		
			translate([0,(_hauteur_interieur+_epaisseur)/2,0]) patte("haut",_longueur_pattes_largeur); 
			
			translate([0,-(_hauteur_interieur+_epaisseur)/2,0]) patte("haut",_longueur_pattes_largeur);
		
		
		}
		
		//Limitation de la longueur des pattes hauteur
		if (_longueur_pattes_hauteur >= _hauteur_interieur) {
			_longueur_pattes_hauteur = _hauteur_interieur;

			//Patte coté
			translate([(_largeur_interieur+_epaisseur)/2,0,0]) patte("cote",_longueur_pattes_hauteur); //Centrage de la face
			
			translate([-(_largeur_interieur+_epaisseur)/2,0,0]) patte("cote",_longueur_pattes_hauteur); //Centrage de la face
			
		} else {
			translate([(_largeur_interieur+_epaisseur)/2,0,0]) patte("cote",_longueur_pattes_hauteur); //Centrage de la face
			
			translate([-(_largeur_interieur+_epaisseur)/2,0,0]) patte("cote",_longueur_pattes_hauteur); //Centrage de la face
		
		}
	};

	
	
	color("blue",0.80){
			translate([-1*(_entraxe_rails/2), 0, (_hauteur_pattes/2)+_epaisseur]) {
				cube(size = [20,_hauteur_interieur+(_epaisseur*2),_hauteur_pattes+_epaisseur], center = true);
			}
		};
	
	
	color("blue",0.80){
			translate([1*(_entraxe_rails/2), 0, (_hauteur_pattes/2)+_epaisseur]) {
				cube(size = [20,_hauteur_interieur+(_epaisseur*2),_hauteur_pattes+_epaisseur], center = true);
			}
		};
	
	
	
	}//!Difference
	
	
	
};//If Général

//Fin du couvercle







//---------LES MODULES----------
//Permet de construire une face
module face(_largeur_M,_hauteur_M,_epaisseur_M,_color){
  
    color(_color,0.80){
		cube(size = [_largeur_M,_hauteur_M,_epaisseur_M], center = false);
    }
 }
 
 //Permet de construire un rail femelle
 module railfemelle(){
     polygon(points=[
	 
		//Coller ici les points
		[0,0],
		[-6.05,0],
		[-6.05,-6.741],
		[-2.126,-6.741],
		[-4.538,-2.42],
		[4.537,-2.42],
		[2.126,-6.741],
		[6.05,-6.741],
		[6.05,0]
		//!Coller ici les points

]);
     }
	 
//Permet de construire un rail male
 module railmale(){
     polygon(points=[
	 
		//Coller ici les points
		[0,5.68],
		[-3.75,5.68],
		[-1.25,1.2],
		[-1.92,0],
		[1.92,0],
		[1.25,1.2],
		[3.75,5.68],
		[0,5.68]
		//!Coller ici les points

]);
     }
	 

//Modules principal du nid d'abeille
module grid(_largeur_g,_hauteur_g,_profondeur_g,_diam_trou,_epaisseur_arete){ //A appeler

	translate([-1*_largeur_g/2,-1*_hauteur_g/2,0]){
		difference(){
			face(_largeur_g,_hauteur_g,_profondeur_g,"Blue");
			hexgrid([_largeur_g,_hauteur_g+_diam_trou,_profondeur_g],_diam_trou,_epaisseur_arete);
		}
	}	
}

//Sous module nid d'abeille
module hexgrid(box, holediameter, wallthickness) {

// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 
//Example : hexgrid([25, 25, 1.5], 1, 0.5);
//Example : hexgrid([box_x, box_y, box_z], diametre_trou, epaisseur aretes);

    a = (holediameter + (wallthickness/2))*sin(60);
    for(x = [holediameter/2: a: box[0]]) {
        for(y = [holediameter/2: 2*a*sin(60): box[1]]) {
            translate([x, y, 0]) hex(holediameter, wallthickness, box[2]);
            translate([x + a*cos(60), y + a*sin(60), 0]) hex(holediameter, wallthickness, box[2]);

        }
    }
        
}

module hex(hole, wall, thick){
    hole = hole;
    wall = wall;
    difference(){
        rotate([0, 0, 30]) cylinder(d = (hole + wall), h = thick, $fn = 6);
        translate([0, 0, -0.1]) rotate([0, 0, 30]) cylinder(d = hole, h = thick + 0.2, $fn = 6);
    }
}

module patte_haute(){
	rotate([90,0,0]){
		//Patte du haut
		translate([0,_hauteur_pattes/2+_epaisseur,(_hauteur_interieur+_epaisseur)/2]){ //Centrage de la face
				{
					color("Purple",0.50){
						cube(size = [30,_hauteur_pattes+_epaisseur,_epaisseur], center = true);
					}
					
				}

		}
	};
}

//Module  qui permet de contruire une patte sur le coté
module patte(_sens,_longueur_p){

	//rotate([90,0,90]){
		//Patte de gauche
		
		if(_sens == "cote"){
			
			rotate([90,0,90]){	
			
				translate([0,_hauteur_pattes/2+_epaisseur,0]){ //Centrage de la face		
						color("Purple",0.50){
							cube(size = [_longueur_p,_hauteur_pattes+_epaisseur,_epaisseur], center = true);
						}
						
				}
			}			

		}
		
		if(_sens == "haut"){
			
			rotate([90,0,0]){	
			
				translate([0,_hauteur_pattes/2+_epaisseur,0]){ //Centrage de la face		
						color("Purple",0.50){
							cube(size = [_longueur_p,_hauteur_pattes+_epaisseur,_epaisseur], center = true);
						}
						
				}
			}			

		}
		
		
		
//	}

}

//---------FIN DES MODULES----------
