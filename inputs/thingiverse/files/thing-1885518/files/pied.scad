Taille_du_carre_en_mm  = 20 ;
Resolution = 120 ;

$fn= Resolution ;

carree = Taille_du_carre_en_mm * 1.04 ; //arc compensation  

difference() {

                union(){

                         translate ([0,0,carree/2 ])cylinder (r1=carree * 1.5  , r2= carree /1.2 , h=carree ) ; 
 
                          cylinder(r1=carree * 1.5 , r2=carree * 1.5 , h= carree / 2 );
                        }


           translate ([- carree / 2 , - carree / 2,carree/2])cube([carree,carree,carree * 10]) ;


}


