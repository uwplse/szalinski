d_bras=8;
d_bobine=200;
d_bobine_int=53;
l_bobine= 55;
ep_bobine=4;
fn=80;

module bobine()              {
difference()            {
cylinder(h = l_bobine, r=d_bobine/2, $fn=fn);
translate ([0,0,-0.5]) cylinder(h = l_bobine+1, r=d_bobine_int/2, $fn=fn);

difference() {
    translate ([0,0,ep_bobine]) cylinder(h = l_bobine-2*ep_bobine, r=d_bobine/2+1, $fn=fn);
  translate ([0,0,ep_bobine]) cylinder(h = l_bobine-2*ep_bobine, r=d_bobine_int/2+20, $fn=fn);  
            }
                        }
                        }
                        
module cone(){                        
 translate ([-6,-80,218]) rotate ([0,90,0]) import("/home/yann/Documents/fabnumerique/imprimante 3d/support bobine/Filament_Spool_Wall_Mount/Fila_Wall_M8_SuperCone.stl");
                }
    
    
   module trepier(){  

             translate ([-15,d_bobine/2,3]) rotate ([32,0,0]) cylinder(h = 150, r=d_bras/2, $fn=fn);   
   
    mirror([0,1,0])  translate ([-15,d_bobine/2,3]) rotate ([32,0,0]) cylinder(h = 150, r=d_bras/2, $fn=fn); 
                     }
  module axe (){                  
            cylinder(h = l_bobine*2, r=8/2, $fn=fn);
  }
                    


module coeur() {

difference(){    
translate ([-15-d_bras,0,d_bobine/1.7]) rotate ([0,90,0]) cylinder(h = d_bras*2, r=d_bobine_int/1.7, $fn=fn/8);    
translate ([-15-d_bras-0.5,0,50]) rotate ([0,90,0]) cylinder(h = d_bras*2+1, r=d_bobine_int, $fn=fn/8);    // enlevement de matière 
translate ([-15-d_bras-0.5,0,185]) rotate ([0,90,0]) cylinder(h = d_bras*2+1, r=d_bobine_int, $fn=fn/8);    // enlevement de matière 
translate ([-30,0,d_bobine/1.7]) rotate ([0,90,0]) axe();
trepier();    
translate ([-15-d_bras-3,0,d_bobine/1.7]) rotate ([0,90,0]) cylinder(h = 8, r=7.5, $fn=fn/13);    // ecrou M8
  
}   
}

module pied(){
difference(){
translate([-14.8,102,0]) rotate ([0,0,90]) hull() {
   translate([20,0,0])  cylinder(h = 10, r=d_bras*2.5, $fn=fn/10);   
  rotate ([0,-32,0])cylinder(h = 20, r=d_bras, $fn=fn/10); 
                                                }
translate([-37,90,-10])cube ([45,60,10]); // coupe du dessous
trepier();
 // vis M3                                               
translate([-5,125,-1]) cylinder(h = 20, r=1.6, $fn=fn); 
translate([-5,125,12]) cylinder(h = 10, r=4, $fn=fn);                                                 
translate([-24.3,125,-1]) cylinder(h = 20, r=1.6, $fn=fn);
 translate([-24.3,125,12]) cylinder(h = 10, r=4, $fn=fn);                                                        
                                            }
                                        }

color ("DarkSlateGray") translate ([0,0,d_bobine/1.7]) rotate ([0,90,0]) bobine();
color ("grey") cone();                       
trepier();
color ("Silver") translate ([-30,0,d_bobine/1.7]) rotate ([0,90,0]) axe();
coeur();
   //   rotate ([0,90,0]) coeur();   // position d'impression                             
pied();
mirror([0,1,0]) pied();                                        
    