height=80; //total body height
r_sir=9.6; //syringe radius
spessore_camera=0.5; //internal wall thickness in contact with syringe (keep low to permit heat exchange)
r_est=r_sir+8;
y_cube=2*r_est+5;
x_cube=4*r_est+12; //+12 per bilanciare le distanze tra le camere
cut=height+10;
eccentricita=6;
dist_cam=3;

use<barretta.scad>;
use<tubo esternoDD pieno.scad>;

difference(){

union(){
    
  
    cube([x_cube,y_cube,height],center=true);
    

    
    
//barrette per fissaggio
translate([-x_cube/2-5,0,0])
barretta();
rotate([0,180,0])
translate([-x_cube/2-5,0,0])
barretta();
    
    
//tubi entrata e uscita liquido
rotate([-90,0,0])
translate([-dist_cam-10,height/2-12,-44])
   tuboesterno(5,18,4.5,5,30);

rotate([-90,0,0])
translate([-x_cube/2+12,-height/2+12,-44])
   tuboesterno(5,18,4.5,5,30);
    
rotate([-90,0,0])
translate([+x_cube/2-12,+height/2-12,-44])
   tuboesterno(5,18,4.5,5,30); 

rotate([-90,0,0])
translate([+dist_cam+10,-height/2+12,-44])
   tuboesterno(5,18,4.5,5,30);
   
}

//copiato qua

//passaggio siringa
         translate([r_est+dist_cam-eccentricita,0,0])
         cylinder(h=cut,r=r_sir,$fn=100,center=true);
 
    translate([-r_est-dist_cam+eccentricita,0,0])
         cylinder(h=cut,r=r_sir,$fn=100,center=true);
 
 //tagli per i tubi di entrata/uscita
 rotate([-90,0,0])
translate([-dist_cam-10,height/2-12,-60])
  cylinder(h=47,r=3.5,$fn=100);
 
 rotate([-90,0,0])
translate([-x_cube/2+12,-height/2+12,-60])
     cylinder(h=47,r=3.5,$fn=100);
 
 rotate([-90,0,0])
translate([+x_cube/2-12,+height/2-12,-60])
      cylinder(h=47,r=3.5,$fn=100);
 
 rotate([-90,0,0])
translate([+dist_cam+10,-height/2+12,-60])
 cylinder(h=47,r=3.5,$fn=100);

//CAMERE INTERNE E cilindri che tagliano l'eccesso dei tubi di entrata all'interno delle camere
 translate([r_est+dist_cam,0,0])
  difference(){
      cylinder(h=height-5,r=r_est,$fn=100,center=true);
      translate([-eccentricita,0,0])
      cylinder(h=height-5,r=r_sir+spessore_camera,$fn=100,center=true);
  }
  
  translate([-r_est-dist_cam,0,0])
  difference(){
      cylinder(h=height-5,r=r_est,$fn=100,center=true);
      translate([eccentricita,0,0])
      cylinder(h=height-5,r=r_sir+spessore_camera,$fn=100,center=true);
 }

}