//_______________________________________________________________________
//__/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/
/*
   Rubik's cube support   
   
   Dessiné par Jean-Pierre Perroud  -  (jpp)
   Version     1.3
   
   Date        24-01-2018
   Révison     28-01-2018 
   Remques     Support de table pour présenter le Rubilk's cube
               La pyramide est crée avec un cylindre dont $fn=3 
               pour avoir 3 faces ! 
               Attention, pour cubes standard, avec surfaces non arrondies !!!
*/            

//-----------------------------------------------------------------------
//--- VARIABLES 
/* [VARIABLES] */

O    =    0;   // Origine avec un O majuscule  (pas un 0)
T    =   40;   // Taille de la base ....  (rayon du cylindre ...)
$fn  =  100;   // Finition générale !!!
haut = 16.5;   // Hauteur de la pièce souhaitée ...
base =    0;   // [0:sans ouverture, 1:avec l'ouverture] 
               // 0 ou 1,  sans ou avec découpe. Si 1 alors 
               // ne pas oublier d'ajouter les supports à l'impression :)

//-----------------------------------------------------------------------
//--- DEBUT DU CODE

color("Red")                           // Juste pour le fun avec OpenSCAD  :)
difference(){
   translate    ([O, O, O])            // Cylindre tranformé en pyramide 
      cylinder  (T, T, T/3, $fn=3);    // avec $fn=3 pour avoir les 3 faces
   translate    ([O, O, -8])           // Cylindre tranformé en pyramide 
      cylinder  (T, T, T/3, $fn=3);     // avec $fn=3 pour faire l'extrusion 

   if (base){
      translate ([O, O, O-T/1.5])      // Spère pour le dessous si base = 1
         sphere (T/1, center=true);
   };

// Plateau pour découper la pyramide à la hauteur de ...
   translate   ([O, O, O+(T/2+haut)])  // Mise à la hauteur !
      cube     ([T*2,T*2,T],center=true);
   
};


//-----------------------------------------------------------------------
//--- FIN DU CODE  --  j-p perroud

//__/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/ __/
//_______________________________________________________________________