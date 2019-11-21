//Wader

lengteweg = 20;

breed = 105;
breedteweg=86.5;
hoogte = 20;
hoogteweg=10;

cilinderbev=11; 
cilinderbevgat=13;

diktebev=5; // gat=7
diktebevgat=6;
lengtebev=18; // gat=15
plekbev=27; // vanaf buitenrand


difference()
 {
     union()
    {
     cube([breed,lengteweg,hoogte]);
    
    translate([plekbev,lengteweg+(lengtebev)/2,0])
    cylinder(r=(cilinderbev)/2,h=hoogteweg,$fn=144);
    
     translate([plekbev-diktebevgat/2,(lengteweg),0])
     cube([diktebev,5,hoogteweg]); 
        
   

   
    }
     union()
    {
     translate([(breed-breedteweg)/2,0,hoogteweg])
     cube([breedteweg,lengteweg,hoogteweg]);
     
     translate([breed-plekbev,lengteweg-(lengtebev-1)/2,0])
    cylinder(r=(cilinderbevgat)/2,h=hoogte,$fn=144);
        
     translate([breed-plekbev-diktebevgat/2,(lengteweg-3),0])
       cube([diktebevgat,3,hoogteweg]); 
        
   
   

    }
 }
 
    
  module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
       }
   
   translate([0,-30,0])    
   prism(breed,  30,hoogteweg);