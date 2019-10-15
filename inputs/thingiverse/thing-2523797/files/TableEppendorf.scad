

//Eppaisseur
e = 4;
//jeu
j=0.1;
// DIametre du Tube
DiameterTube=16;

//Diametre externe
DiameterCover=18;

//Hauteur de l'eependorf
Heigth=60;

//Espace entre 2 tube
Spacing=max(e,(DiameterCover-DiameterTube)+e);
//Nombre d'eppendorf dans une rangée
NbRow=5;

//diametre de l'aimant
Ad=2;
//Profondeur de l'aimant
Ap=3;

//Nombre de rangee
NbCol=4;

//Eppaisseur du pied
P=min(Spacing,10);

if(P>Spacing) {
    echo("<font color='red'> Error : the P Foot Size  should not be bigger or equal to spacing between Eppendorf");
}

module PlaqueFer() {
	cube([Ad+j,Ad+j,Ap+j],center=true);
	//cylinder(Ap+j,Ad/2+j,Ad/2+j, center=true);
}

module Aimant(){
	cylinder(Ap+j,Ad/2+j,Ad/2+j,center=true,$fn=100);
}
module Unit() {
    union()
	{difference(){ 
	
        cube([DiameterCover+Spacing,DiameterCover+Spacing,e], center=true);
        cylinder(e,(DiameterTube+j)/2,(DiameterTube+j)/2,center=true);
        translate([(DiameterCover+Spacing)/2,0,0])
            cube([e+j,e+j,e],center=true);
		translate([0,(DiameterCover+Spacing)/2,0])
            cube([e+j,e+j,e],center=true);
		
		
	}
	translate([-(DiameterCover+Spacing)/2,0,0])
            cube([e,e,e],center=true);
	translate([0,-(DiameterCover+Spacing)/2,0])
            cube([e,e,e],center=true);
	
	}	
}

module Row(){
for(i=[0:NbRow-1])
{
    translate([i*(DiameterCover+Spacing),0,0])
        Unit();
}
}

module HolePlate()
{	difference() {
		union(){
			for(i=[0:NbCol-1]){
				translate([0,i*(DiameterCover+Spacing),0])
					Row();
				}	
			}
		L1=-(DiameterCover+Spacing-P)/2;			
		L2=-L1+(NbCol-1)*(DiameterCover+Spacing);
		L3=-L1+(NbRow-1)*(DiameterCover+Spacing);
		translate([L1,L1,-(e/2)])		PlaqueFer();
			
		translate([L1,L2,-(e/2)])	PlaqueFer();
			
		translate([L3,L2,-(e/2)])	PlaqueFer();
			
		translate([L3,L1,-(e/2)])	PlaqueFer();
		}
	
}



module Pied() {
	difference() {
		cube([P,P,Heigth]);
		translate([P/2,P/2,Heigth])
			Aimant();
	}
}


module Table() {
HolePlate();

translate([-(DiameterCover+Spacing)/2,
    -(DiameterCover+Spacing)/2,e/2])
        Pied();


translate([(NbRow-0.5)*(DiameterCover+Spacing)-P,
    -(DiameterCover+Spacing)/2,e/2])
        Pied();

translate([-(DiameterCover+Spacing)/2,
    (NbCol-0.5)*(DiameterCover+Spacing)-P,e/2])
        Pied();

translate([(NbRow-0.5)*(DiameterCover+Spacing)-P,
    (NbCol-0.5)*(DiameterCover+Spacing)-P,e/2])
        Pied();
}

Table();

//Unit();





