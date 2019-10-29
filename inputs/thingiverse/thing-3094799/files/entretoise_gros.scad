/*
  Entretoises de fixation mouvements (ancien lecteur de CD/DVD)
  Projets DIY - 02/20016 - http://www.projetsdiy.fr
  v1
*/

$fn = 50;
hauteur = 16;       //Hauteur de l'entretoise
   

module entretoise(diam_centreur){
  difference(){
    union(){
      cylinder(r=4,h=hauteur,$fn=6);   //Corps entretoise
      translate([0,0,hauteur]) cylinder(r=diam_centreur / 2,h=2,center=true); //Centreur
      translate([0,0,hauteur - 2]) cylinder(r= diam_centreur / 2 + 2, h=2);   //Colerette
      cylinder(r=6,h=2); 
    }
    cylinder(r=2.3, h=30);                      //Passage de vis
  }
}

for (a=[0:30:90]){
    //translate([a, 0,0]) entretoise(5.6);        //4 entretoises avec petit centreur
    translate([a, 0,0]) entretoise(7.3);       //4 entretoises avec gros centreur
}