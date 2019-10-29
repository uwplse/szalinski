// diametre  exterieur de la piece de calibration --- external dimensions of the calibration part
diametre = 180 ;
// diametre de la buse --- diameter of the nozzle
buse= 0.4; 
// hauteur de la couche (rentrer la meme dans votre trancheur pour faire 1 couche) ---height of the layer (bring the same into your slicer to make a single layer)
hauteur=0.2 ;          
                       





difference (){
cylinder ( d=diametre, h=hauteur , center = true,$fn=50 ); 
cylinder ( d=diametre-buse, h=hauteur*10, center = true,$fn=50 ); 
           }