include <RCAD/plus.scad>
use <RCAD/fillet.scad>

$fn=50;


track();
 //%translate([0,18]) track();

track_len=18.1;  //track hole to hole distance, key parameter
len=track_len+5.65;  
width=39.4;
thick=2.86*2; //6; //original 2.86*2

hasclaw=true;

module drop2x(x,y,z){
  for(pos=[x/2,-x/2]) 
    translate([pos,y,z])
         child();  
}

  
module track(){

    
difference(){
   union(){
      translate([0,0.29])
         Cube636(width,10.3+0.5,thick,rz=0.5,r=0.5); //center block

      //translate([19.75, 13.29])     import("track-m3x40.stl");
      //import("Track.stl");
   
     //locker arm
     lockarm=17;
     translate([-0.1,track_len/2, thick/2]) 
        ycylinder(d=thick,h=lockarm);

     translate([-0.1,(len-10)/2,0]) 
       if(hasclaw==true)
        fillet(r=6,steps=3)
        {
             translate([5,-1,thick-1-pad])
                Cube(3,1,4);
             translate([-5,-1,thick-1-pad])
                Cube(3,1,4);
           Cube636(lockarm,6,thick-1,rz=0,r=0.5);
         }
       else
           Cube636(lockarm,6,thick-1,rz=0,r=0.5);  
       
     // hanger arm base
     hanger=6;
     for(x=[12.5,-12.5])
       translate([x,-track_len/2,0]){
          up(thick/2)
            ycylinder(d=thick, h=hanger);
          translate([0,3,0])
           if(hasclaw==true)
            fillet(r=6,steps=3){
             translate([0,0,thick-1-pad])
               Cube(3,1,4);
             Cube636(hanger,7,thick-0.5,rz=0,r=1);
            }
           else
              Cube636(hanger,7,thick-0.5,rz=0,r=1);  
       }
   
   }
   
   //cut drive wheel slot
   fillet(r=6, steps=13){
     translate([0,0.052])
        up(-3)
          Cube(21.5,9.5, 3);
       Cube(12.924,4.97,thick+0.1);
      
   }
  
   
   
   holed=3.8;
   mholed=3.1;
   
   
   
   //+y M3 hole tite
   translate([0,track_len/2, thick/2]) 
      rotate([0,90,0])
        up(-55/2)
           cylinder(d=2.9,h=55);
   //M3 lose
   translate([0,-track_len/2,thick/2])
      rotate([0,90,0])
        up(-55/2)
           cylinder(d=3.2,h=55);
   
   
  //cut bottom slot
   up(thick-1)
   translate([16,0,0])
     rotate(12)
      Cube636(3,13,2.5,rz=0.5,r=0.3);
  
   up(thick-1)
   translate([-16,0,0])
     rotate(-12)
      Cube636(3,13,3,rz=0.5,r=0.5);
  
   
   up(thick-1.5)
   translate([9,0,0])
     rotate(-12)
      Cube636(3,13,3,rz=0.5,r=0.5);
  
   up(thick-1.5)
   translate([-9,0,0])
     rotate(12)
      Cube636(3,13,3,rz=0.5,r=0.5);
   
    
}


}


module ycylinder(d,h){

    rotate([0,90])
      up(-h/2)
        cylinder(d=d,h=h);
}
module xcylinder(d,h){

    rotate([90,0])
      up(-h/2)
        cylinder(d=d,h=h);
}