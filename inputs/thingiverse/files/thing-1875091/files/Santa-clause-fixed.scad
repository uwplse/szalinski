Render_Quality = 70; //[55:80]
$fn= Render_Quality;

/* [body-part 1]*/
// Which part whould you like to edit?
part = 1; //[ 1:body-part 1 assembled 2: head and beard, 3:hat, 4:body, 5:arms and hands, 6:giftbag, 7:none]
ScaleX_part = 1;//[1:5]
ScaleY_part = 1;//[1:5]
ScaleZ_part = 1;//[1:5]

/* [body-part 2]*/
    print = 2; //[1:none, 2:bottom]
ScaleX_print = 1;//[1:5]
ScaleY_print = 1;//[1:5]
ScaleZ_print = 1;//[1:5]

/*legs and shoes*/
   shoes = 2; // [1: none, 2:legs and shoes]
ScaleX_shoes = 1;//[1:5]
ScaleY_shoes = 1;//[1:5]
ScaleZ_shoes = 1;//[1:5]
module head(){
    translate([0,0,42])
    sphere(r=8);    

    translate([7,-3,44])
        sphere(r=1);          //left eye
    
    translate([7, 3, 44])
        sphere(r=1);          //right eye

    translate([7.5,0,41])
        sphere(r=2);        //nose

    difference(){
        translate([5,0,38])
        scale([0.4,1.2,1.1])
        sphere(r=6);          //body of the beard
     
         translate([4.5,0,50])
         scale([0.4,1.2,1.5])
         sphere(r=7);    //cut from the beard    
}
}

module hat(){  
     translate([0,0,48])
        scale([1,1,0.4])
        sphere(r=9);  //edge of the hat 
    difference(){
    translate([0,0,48])
    cylinder(h=17, r1=8, r2=0); //body of the hat
        
    translate([0,0,60])
    cylinder (h=5,r=3);     //top ball of the hat
    }
}
 
module body(){   
        translate([0,0,20])
        scale([1,1.3,1.2])
        sphere(r=12);        //main body
     
 difference(){
    translate([0,0,33])
        scale([1,1,0.4])
    sphere(r=8);     //body of the collar
 
   translate([9,0,33])
   cube([8,12,5],center=true);  //cut off the front collar
}  
       
    translate([10,0,28])
        rotate([0,90,0])
   sphere (r=1.5);     //top button
 
     translate([11.5,0,23])
      rotate([0,90,0])
    sphere (r=1.5);     //bottom button    
     
    translate([0,0,16])
     scale([1,1.2,0.3])
     sphere(r=14);  //belt on the body   
   }
   
   module arms(){
   translate([0,-12,27])
         rotate([45,0,0])
     cylinder(h=8, r1=3.5, r2=2.5); //left arm
                     
 translate([0,10,26])
         rotate([-32,50,-10])
             scale([1,1,1.2])
             cylinder(h=8, r1=3, r2=2.5);//rightarm
  
     translate([7,14,32])
         rotate([-32,0,-10])
             scale([1,1,1.2])
             sphere(r=3);//right hand
    
     translate([0,-19,34])
         rotate([45,0,0])
             scale([1,1,1.2])
             sphere(r=3);  //left hand      
 }
 
module giftbag(){   
    translate([-11,8,26])   
    sphere(r=13);  //body of the giftbag
        
       translate([7,14,33])
        rotate([0,-100,15])
    cylinder(h=13,r1=1,r2=4.5);  //handle of the giftbag

        difference(){
        translate([-12,8,39])
    scale([0.8,1,1])
     sphere(r=1.8);        //top ring for wire

    translate([-15,8,39])
        rotate([0,90,0])
    cylinder(h=5, r=1.3);  //punch through top ring 
    
}
}
  
  module body2(){
 difference(){
union(){     
    translate([0,0,20])
        scale([1,1.3,1.2])
        sphere(r=12);        //main body
    
     translate([0,0,16])
            scale([1,1.2,0.3])
                sphere(r=14);  //belt on the body   
 }
    translate([0,-6,2])
        cylinder(h=10, r=5.5);

    translate([0,6,2])
        cylinder(h=10, r=5.5);
     
      translate([0,0,26])
             cube([30,35,19], center = true);
}
}

module legs(){
    translate([0, -6,2])
        cylinder(h=10, r=5); //left leg

    translate([0,6,2])
        cylinder(h=10, r=5); //right leg
    difference(){
        union(){
    hull(){
        translate([0,-6,0])
        cylinder(h=2 ,r=5);   //left foot 
        
    translate([11.5,-5.5,4])
    sphere(r=5);               // front of the shoe    
}

     hull(){
         translate([0,6,0])
        cylinder(h=2 ,r=5);  //right foot
        
    translate([11.5,5.5,4])
    sphere(r=5);          //front of the shoe
    }
}
    translate([0,0,-5])
    cube([30,30,10], center = true);//cut the bottom
}
}


if(part == 1){
    scale([ScaleX_part, ScaleY_part, ScaleZ_part]){
       
difference(){
  union(){
     hat();
    body();
    arms();
    giftbag();
    legs(); 
      head();
  }
   translate([0,0,7])
  cube([40,35,17], center = true);
  }
  }
    }
if(part == 2){
    scale([ScaleX_part, ScaleY_part, ScaleZ_part]){
    head();
    }
      
difference(){
  union(){
     hat();
    body();
    arms();
    giftbag();
    legs(); 
  }
   translate([0,0,7])
  cube([40,35,17], center = true);
  //cut off the bottom
  }
  }

if(part == 3){
    scale([ScaleX_part, ScaleY_part, ScaleZ_part]){
    hat();
    }
    difference(){
        union(){
    head();
     body();
    arms();
    giftbag();
    legs();
        }
        translate([0,0,7])
  cube([40,35,17], center = true);
    }
        
}
if (part == 4){  
   scale([ScaleX_part, ScaleY_part, ScaleZ_part]){ 
        difference(){
       union(){
    body();
    giftbag();
    legs();
       }
              translate([0,0,-3])
  cube([80,85,37], center = true);
   }
    
   }
   head();
     hat();
    arms();
  
}
if (part == 5){
     scale([ScaleX_part, ScaleY_part, ScaleZ_part]){
         arms();
     }
     difference(){
         union(){
     head();
     body();
    hat();
    giftbag();
    legs();
         }
  translate([0,0,7])
  cube([40,35,17], center = true);
     }
}
if (part == 6){
     scale([ScaleX_part, ScaleY_part, ScaleZ_part]){
    giftbag();
     }
     difference(){
         union(){
         arms();
     head();
     body();
    hat();
    legs();
         }
     translate([0,0,7])
  cube([40,35,17], center = true);
     }
     
}


scale([ScaleX_print,ScaleY_print,ScaleZ_print]){
  
  if (print == 2){
      
      body2();
  }
  }
  
  scale([ScaleX_shoes,ScaleY_shoes,ScaleZ_shoes]){
  if (shoes == 2){
      legs();
  }
  }
  
 