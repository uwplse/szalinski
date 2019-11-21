 module M3_hole(pos, h) {
     translate(pos-[0,0,1])
     cylinder(r=3.5/2, h+1, $fn=50);
     translate(pos-[0,0,-h+2])
     cylinder(r=6/2, 3, $fn=6);
     
 };
 
 module HolderHole(pos,h) {
     translate(pos-[0,0,1])
     cube([3,8,h+2]);
 }

 $fn=50;
 translate([0,2,0])
 difference(){
     minkowski(){
         cube([80,170,8-4]);
         cylinder(r=2,h=8-4);
     }
     // Viti
     hp1=[10,(170-152)/2,0];
     #M3_hole(hp1,9);
     hp2=hp1+[0,152,0];
     M3_hole(hp2,9);
     hp3=hp1+[52,152,0];
     M3_hole(hp3,9);
     hp4=hp1+[52,0,0];
     M3_hole(hp4,9);
     
     // Buco prese
     translate(hp4+[-30,10,-1]) 
          minkowski(){
            cube([30-2,50-2,10]);
            cylinder(r=2,h=1);
          }
     
     // Busco scheda comandi
     translate(hp1-[2,1,1]) 
          minkowski(){
            cube([55,154,6]);
            cylinder(r=2,h=1);
          }
          
     // Holder hole
    h1 = [-2,(170-101-16)/2,0];      
    HolderHole(h1,8);      
    HolderHole(h1+[0,101+8,0],8);      
    HolderHole(h1+[80+1,101+8,0],8);      
    HolderHole(h1+[80+2,0,0],8);      
          
          
 }
 
 
 // Buchi distanza 152 ( M3 con datro esagonarle) Z distanza est 52.
 
