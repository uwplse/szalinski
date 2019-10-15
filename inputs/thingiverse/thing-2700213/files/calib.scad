// cotes exterieur de la piece de calibration --- external dimensions of the calibration part
cote = 180 ;
// diametre de la buse --- diameter of the nozzle
buse= 0.4; 
// hauteur de la couche (rentrer la meme dans votre trancheur pour faire 1 couche) ---height of the layer (bring the same into your slicer to make a single layer)
hauteur=0.2 ;          
                       





difference (){
hull(){
for (i = [0:90:270])
    {  
  rotate([0, 0, i])
 translate ([(cote/2)-(cote/20),(cote/2)-(cote/20),0])
cylinder ( d=cote/10, h=hauteur , center = true,$fn=120 ); 
     }
       }

hull(){
for (i = [0:90:270])
   {  
  rotate([0, 0, i])
 translate ([(cote/2)-(cote/20)-buse,(cote/2)-(cote/20)-buse,0])
cylinder ( d=cote/10, h=hauteur*10, center = true,$fn=120 ); 
   }
      }
             }