//Hook for IKEA LACK shelf

//options:
$fn=360; //quality for round parts
hooklength=50; //length from bottom of shelf tot inner top of hook part
hookwidth=16; //13 - 35
screwhole=1; //1 or 0 


//do not change
hookthick=6; //thickness of bottom section
shelfthick=47; //inner size of LACK shelf
blockthick=6; //depth of gap in LACK shelf (can be 8mm for smaller shelf, measure before you print)


union(){
 difference(){
  union(){
//top block part
   cube([shelfthick-3,blockthick,hookwidth]);
//bottom block part
   cube([hooklength+shelfthick,hookthick,hookwidth]);
   }

//tapered screwhole
   union(){
    translate([(shelfthick-3)/2,0,hookwidth/2]){
     rotate([-90,0,0]){
         if(screwhole==1){
      cylinder(r1=4,r2=3,h=blockthick); 
         }    
     }
    }

//camouflage hole in shelf
    union(){
     translate([shelfthick-3,4,0]){
      cube([3,hookthick,hookwidth+1]);
      translate([0,-4,0]){
       cube([3,hookwidth,2]);
      }
      translate([0,-4,hookwidth-2]){
       cube([3,hookwidth,2]);
      }
     }
    }
   }
  }
  difference(){
//hook part
   union(){
    translate([hooklength+shelfthick-3,12.5,0]){
     difference(){
      cylinder(d=25,h=hookwidth);
      union(){    
       cylinder(d=25-(2*hookthick),h=hookwidth+1);
       union(){
       translate([-12.5,-6.5,-1]){    
        cube([12.5,13,hookwidth+2]);
        }
       }
      }
     }
    }
   }
   difference(){
    union(){
     translate([hooklength+shelfthick-3,(2*hookthick)+12.5,hookwidth/2]){
     rotate([90,0,0]){

//roundoff hook
      difference(){ 
       cylinder(d=2*hookwidth,h=hookthick);
       cylinder(d=hookwidth+1,h=hookthick);
       }
      }
     }
    }
    translate([hooklength+shelfthick-3,(hookthick)+12.5,-hookwidth/2]){
     cube([hookwidth,hookthick,2*hookwidth]);
     }
    }
   }
  }