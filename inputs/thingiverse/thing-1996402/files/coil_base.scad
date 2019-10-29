$fn=50;
difference(){
union(){
cylinder(2,25,25);
cylinder(10,20,20);
terminals();    
posts();    
}
cylinder(10,19,19);
translate([0,0,-3]){cylinder(3,30,30);}
translate([0,0,22]){cylinder(3,35,35);}
}


module posts(){
    primary(20,-1,0,0,15,0);
primary(1,20,0,0,15,90);
primary(-1,-20,0,0,15,-90);
primary(-20,1,0,0,15,180);
    d=14.2;
primary(d,d,0,0,15,45);
primary(d,-d,0,0,15,-45);
primary(-d,-d,0,0,15,-90-45);
primary(-d,d,0,0,15,180-45);
    
    
}
module terminals(){
 w=50;
 d=50; 
 translate([-w/2,0,0]){   
  difference(){   
  union(){   
  cube([w,d,2]);    
  translate([0,d-4,0]){
      difference(){
      rotate([15,0,0]){cube([w,4,14]);}
        diam=7.8/2;
       translate([40,-3,8]){
          rotate([-75,0,0]){cylinder(5,diam,diam);}
      }
      translate([25,-3,8]){
          rotate([-75,0,0]){cylinder(5,diam,diam);}
      }    
      translate([10,-3,8]){
          rotate([-75,0,0]){cylinder(5,diam,diam);}
      }
      }
      }
      
  }
  for(i=[0:4:40]){
  translate([i+4,0,0]){cube([2,40,2]);}
  }
  }
  
 }
}

module primary(x,y,z,a,b,c){
    translate([x,y,z]){primary_post(a,b,c);}
    }
module primary_post(x,y,z){
   rotate([x,y,z]){
   difference(){
       h=25;
    cube([5,2,h]); 
    for(i=[8:4:h-4]){   
    wire_hole(2.5,0,i);
    }
   }      
   }
}

module wire_hole(x,y,z){
    
  translate([x,y,z]){
   rotate([-90,0,0]){cylinder(5,1,1);   }
  }
}