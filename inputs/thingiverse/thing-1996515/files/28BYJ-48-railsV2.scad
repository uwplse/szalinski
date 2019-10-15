w=28.5/2;
w2=31.5-28.5;//17.5x7;
$fn=64;
bh=30;
rh=37;
//translate([0,-80,-0]){motor_end();}
//pully_end();
//translate([0,15,0]){pully_end_tension();}
translate([0,-30,0]){chariault();}
module motor_end(){
difference(){
union(){
translate([-32,-20,-1]){cube([10,40,rh]);}    
translate([22,-20,-1]){cube([10,40,rh]);}
translate([-22,-20,-1]){cube([44,40,20]);}
    
}
motor();
translate([0,0,-1]){cylinder(19,w-2,w-2);}

bracket();
rod_mounts(-27,-20,bh);
rod_mounts(27,-20,bh);
}
}

module pully_end(){
    ps = 4.6/2;
 difference(){   
   union(){  
       translate([-33,-20,-1]){cube([12,10,rh]);}    
translate([21,-20,-1]){cube([12,10,rh]);}
   translate([-22,-20,-1]){cube([44,10,20]);}
   translate([-0,-15,-1]){cylinder(36,ps,ps);}
   }
   rod_mounts(-27,-20,bh);
rod_mounts(27,-20,bh);
 
    rod_mounts(0,-20,10,4.5);
}
    
    
    }
module pully_end_tension(){
    
 difference(){   
   union(){  
   translate([-22,-20,-1]){cube([44,10,20]);}
   translate([-33,-20,-1]){cube([12,10,rh]);}    
translate([21,-20,-1]){cube([12,10,rh]);}
   }rod_mounts(-27,-52,bh);
rod_mounts(27,-52,bh);
    rod_mounts(0,-20,10,10);
}
    
    
    }    
module chariault(){
    hh=24;
difference(){
union(){
translate([-32,-20,9]){cube([10,20,rh-10]);}    
translate([22,-20,9]){cube([10,20,rh-10]);}
translate([-22,-20,9]){cube([44,20,25]);}
    
}
rod_mounts(-27,-20,bh);
rod_mounts(27,-20,bh);
for(y=[0:2:20]){
   translate([4.5,-y,hh]){cube([1,1,10]);} 
    }
   translate([-7,-20,hh]){cube([5,20,10]);}     
   translate([-9,-20,hh]){cube([5,2,10]);}  
    translate([5.5,-20,hh]){cube([1,20,10]);} 
     translate([5.5,-12,hh]){cube([15,4,10]);} 
     translate([6.5,-13,hh]){rotate([0,0,45]){cube([2,1,10]);} }
      translate([7.0,-9,hh]){rotate([0,0,45]){cube([1,2,10]);} }
      translate([-22,-18,11]){cube([15,2,hh+2]);} 
      translate([-20,-20,11]){cube([11,2,hh+2]);} 
}    
 
    
}    
    
module motor(){
difference(){
cylinder(19,w,w);

}    
translate([-17.5/2,31.5/2-7,0]){cube([17.5,8,19]);}
translate([-3,31.5/2-7+5,19-5]){cube([6,7,5]);}
//bracket();
}
//42  d7
module bracket(){
translate([-21+7/2,-7/2,18]){
  difference(){
   union(){
    translate([0,7/2,0]){cylinder(1,7/2,7/2);}
    translate([0,0,0]){cube([42-7,7,1]);}
    translate([42-7,7/2,0]){cylinder(1,7/2,7/2);}
   
   translate([0,7/2,-5]){cylinder(5,1,2);}
   translate([42-7,7/2,-5]){cylinder(5,1,2);}
   }
  }
 }
}

module rod_mounts(x,y,z,rd=8.5){
    rw= rd/2;
   translate([x,y,z]){ rotate([-90,0,0]){cylinder(40,rw,rw);}}
    
    
    }