




// you can select which parts to select
parts_to_select = 4; // [1:frontbody, 2:backbody, 3: All legs, 4:preview, 5:allparts, 6:Spider for print]

// you can select the type of the eyes
eyes_to_select = 1; //[1:eyes1, 2:eyes2,  3:eyes3 ,4:eyes4, 5:no eye!
// you can render the the quality of your project
teeth_to_select = 1;//[1:teeth1, 2:teeth2, 3:no teeth.

select_quality = 50;    // [20:low,40:medium,50:High,80: SuperHigh]

select_color = 1 ;//[1: "MintCream", 2: "DimGray", 3: "Black", 4:"Purple",5:"DodgerBlue", 6:"DarkGreen".

// you can change the size of your spider
project_size = 100;//[ 100: 300]


  






//body
//front body

//module leg

 module legs(distanceX,distanceY,distanceZ, rotX,rotY,rotZ, length, high, width) {
    
     translate([distanceX, distanceY, distanceZ]) 
       rotate([rotX,rotY,rotZ]) {       
     
 resize([length,high,width])
union(){
difference(){


union(){
hull(){
  translate([0,0,7.5])
    rotate([0,30,0])
      cylinder(r=2,h=5);
  cylinder(r=2.3,h=5);
}
  translate([0,0,7.5])
    rotate([0,30,0])
      cylinder(r1=2,r2=3.5,h=17);
 }
 translate([-20,-50,21])
   cube([100,100,20]);
 

}
translate([8,0,20])
    rotate([0,-5,0])
      cylinder(r1=3,r2=3.3,h=12);
translate([7,0,30])
    rotate([0,-15,0])
      cylinder(r=2.5,h=15);
translate([3.5,0,43])
    rotate([0,-30,0])
      cylinder(r=2,h=23);
translate([-8,0,63])
    rotate([0,-33,0])
      cylinder(r1=1.5,r2=2,h=4);
difference(){
translate([-10,0,66.2])
    rotate([0,-33,0])
      cylinder(r1=2,r2=1,h=4);
translate([-17,-5,65.4])
    cube([5,100,100]);
}
}
}
}


//front body
module frontbody(){

scale(1.2,1.2,1.2){
union(){
    //You can change the type of eyes
    if (eyes_to_select == 1) {
        
        translate([-6.7,0,0])
        eyes1();
    }
    if (eyes_to_select == 2) {
        translate([-6.7,0,0])
        eyes2();
    }
    if (eyes_to_select == 3) {
        
        translate([6.3,0,0])
        eyes3();
    }
     if (eyes_to_select == 4) {
        
        translate([6.3,0,0])
        eyes4();
    }
    if (eyes_to_select == 5) {
        
    }
difference(){
hull(){
  translate([0,0,-4]){
    difference(){
  union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
     }
    }

  translate([49,0,-13])
    cube([50,50,30], center=true);

   }
  }
  translate([0,0,6.2]){
    difference(){
      union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
 }
}
translate([49,0,6.95])
cube([50,50,30], center=true);

  }
 }
}

translate([60,3.5,-3])
  rotate([0,-90,190]){
    scale(0.9,0.9,0.9){

  cylinder(r1=2,r2=3,h=5);
 }
}
translate([60,-3.5,-3])
  rotate([0,-90,170]){
     scale(0.9,0.9,0.9){

  cylinder(r1=2,r2=3,h=5);
 }
}
translate([4,-4,0])
legs(34,9,-3,45,-98,-90,22,7.5,65);
legs(39.5,7,-3,10,-98,-90,25,6.5,50);
legs(43,8,-3,-20,-98,-90,22,6,50);
legs(47,10,-3,-55,-98,-90,22,6.5,60);
legs(53,-9,-3,-40,-98,205,17,6.5,30);
mirror([0,1,0]){
  union(){
legs(36,7,-3,45,-98,-90,22,6.5,65);
legs(39.5,7,-3,10,-98,-90,22,6.5,50);
legs(43,8,-3,-20,-98,-90,22,6,50);
legs(47,10,-3,-55,-98,-90,22,6.5,60);
legs(53,-9,-3,-40,-98,205,17,6.5,30);  
      }
  }
}
}
}
}




//back body
module backbody(){
scale(1.1,1.1,1.1){
difference(){
 union(){
 difference(){
  translate([10,0,-3]){
   hull(){
    difference(){
      hull(){
      translate([3,0,0])
          sphere(r=18);
      translate([5,0,0])
        sphere(r=18);
     }
    translate([0,0,-23])
      cube([50,50,30], center=true);
}
    translate([-39,0,8]){
      difference(){
       union (){
         hull(){
    translate([45,0,-3])
      sphere(r=18);
    translate([38,0,-3])
      sphere(r=18);    
 }
}
    translate([45,0,4])
      cube([50,50,30], center=true);

    }
   }
  }
 }
hull(){
  translate([0,0,-4]){
    difference(){
  union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
     }
    }

  translate([49,0,-13])
    cube([50,50,30], center=true);

   }
  }
  translate([0,0,6.2]){
    difference(){
      union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
 }
}
translate([49,0,6.95])
cube([50,50,30], center=true);

  }
 }
}

}



}
  
translate([-50,-50,-20.5])
    cube([100,100,5]);
}
}
}



module test(){
color("MintCream")
   scale([1.1,1.1,1.1])
     union(){

//back body
translate([10,0,-3]){
  hull(){
    difference(){
      hull(){
      translate([3,0,0])
          sphere(r=18);
      translate([5,0,0])
        sphere(r=18);
     }
    translate([0,0,-23])
      cube([50,50,30], center=true);
}
    translate([-39,0,8]){
      difference(){
       union (){
         hull(){
    translate([45,0,-3])
      sphere(r=18);
    translate([38,0,-3])
      sphere(r=18);    
 }
}
    translate([45,0,4])
      cube([50,50,30], center=true);

    }
   }
  }
 }
 

//You can change the type of eyes
    if (eyes_to_select == 1) {
        
        translate([-6.7,0,0])
        eyes1();
    }
    if (eyes_to_select == 2) {
        translate([-6.7,0,0])
        eyes2();
    }
    if (eyes_to_select == 3) {
        
        translate([6.3,0,0])
        eyes3();
    }
     if (eyes_to_select == 4) {
        
        translate([6.3,0,0])
        eyes4();
    }
    if (eyes_to_select == 5) {
        
    }
difference(){
hull(){
  translate([0,0,-4]){
    difference(){
  union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
     }
    }

  translate([49,0,-13])
    cube([50,50,30], center=true);

   }
  }
  translate([0,0,6.2]){
    difference(){
      union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
 }
}
translate([49,0,6.95])
cube([50,50,30], center=true);

  }
 }
}

     translate([60,3,-2])
  rotate([20,-115,190]){
    scale(0.9,0.9,0.9){

  cylinder(r1=2,r2=3,h=5);
 }
}
translate([60,-3,-2])
  rotate([-20,-115,170]){
     scale(0.85,0.85,0.85){

  cylinder(r1=2,r2=3,h=5);
 }
    
}
}

//left legs
union(){
//legs1

legs(34,10,-3,45,-98,-90,20,6.5,60);

//legs2
legs(38,10,-3,10,-98,-90,22,5,50);

//legs3

legs(43,10,-3,-20,-98,-90,22,5,50);

//legs4

legs(47,10,-3,-55,-98,-90,22,6.5,60);

//arm1
legs(53,-9,-3,-40,-98,205,17,6.5,30);

}

//right side
mirror([0,1,0]){
  union(){
//legs5

legs(34,10,-3,45,-98,-90,20,6.5,60);

//legs6
legs(38,10,-3,10,-98,-90,22,5,50);

//legs7

legs(43,10,-3,-20,-98,-90,22,5,50);

//legs8

legs(47,10,-3,-55,-98,-90,22,6.5,60);

//arm2
legs(53,-9,-3,-40,-98,205,17,6.5,30);
  }
 
 }
}
}
module legs_for_print(){
scale(1.1,1.1,1.1)
union(){

//legs1
translate([-34,-12,21]){
rotate([90,44,0])


legs(34,10,-3,45,-98,-90,20,6.5,60);


translate([31.4,3,-20.5])
cylinder(r=2,h=5.5);
translate([31.4,4,-21])
cylinder(r=10,h=1);
}
//legs2
translate([-15,-11,2]){
rotate([95,10,0])


legs(38,10,-3,10,-98,-90,22,5,50);


translate([39.1,2,-1.5])
cylinder(r=1.6,h=5.5);
translate([39.1,3,-2])
cylinder(r=10,h=1);
}
//legs3
translate([-13,15,-19]){
rotate([100,-20,0])
legs(43,10,-3,-20,-98,-90,22,5,50);
translate([36.85,1.3,19.5])
cylinder(r=1.75,h=5.5);
translate([36.85,2.3,19])
cylinder(r=10,h=1);
}
//legs4
translate([-20,15,-39]){
rotate([100,-55,0])
legs(47,10,-3,-55,-98,-90,22,6.5,60);

translate([18.5,1.3,39.5])
cylinder(r=2,h=5.5);
translate([18.5,2.3,39])
cylinder(r=10,h=1);
}

translate([-10,0,0])
union(){
//legs5
translate([-34,-12,21]){
rotate([90,44,0])


legs(34,10,-3,45,-98,-90,20,6.5,60);


translate([31.4,3,-20.5])
cylinder(r=2,h=5.5);
translate([31.4,4,-21])
cylinder(r=10,h=1);
}
//legs6
translate([-15,-11,2]){
rotate([95,10,0])


legs(38,10,-3,10,-98,-90,22,5,50);


translate([39.1,2,-1.5])
cylinder(r=1.6,h=5.5);
translate([39.1,3,-2])
cylinder(r=10,h=1);
}
//legs7
translate([-13,15,-19]){
rotate([100,-20,0])
legs(43,10,-3,-20,-98,-90,22,5,50);
translate([36.85,1.3,19.5])
cylinder(r=1.75,h=5.5);
translate([36.85,2.3,19])
cylinder(r=10,h=1);
}
//legs8
translate([-20,15,-39]){
rotate([100,-55,0])
legs(47,10,-3,-55,-98,-90,22,6.5,60);

translate([18.5,1.3,39.5])
cylinder(r=2,h=5.5);
translate([18.5,2.3,39])
cylinder(r=10,h=1);
}
}
//arm1
translate([-20,-13,-47.7]){
rotate([100,-105,0])
legs(53,-9,-3,-40,-98,205,17,6.5,30);
translate([-5.7,4.5,48.2])
cylinder(r=1.7,h=5.5);
translate([-5.7,5.5,47.7])
cylinder(r=10,h=1);
}
//arm2
translate([-20,10,-47.7]){
rotate([100,-105,0])
legs(53,-9,-3,-40,-98,205,17,6.5,30);
translate([-5.7,4.5,48.2])
cylinder(r=1.7,h=5.5);
translate([-5.7,5.5,47.7])
cylinder(r=10,h=1);
}

//left tooth
translate([45,-10,0.9])
union(){
translate([0,5,0])
  
    scale([0.7,0.7,0.7]){
hull(){
  cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,-30,0])
  cylinder(r=3,h=6);
  }
hull(){
  translate([0,0,5])
    rotate([0,-30,0])
      cylinder(r1=3,r2=4,h=6);
  translate([-3,0,10])
    rotate([0,-30,0])
      cylinder(r1=4,r2=1,h=6);
}
  translate([-5.6,0,14.5])
    rotate([0,-30,10])
      cylinder(r1=1.1, r2=0.1, h=5);
}

//right tooth
  translate([0,-5,0])
    
 scale([0.7,0.7,0.7]){    
 hull(){
  cylinder(r1=2,r2=3,h=5);
    translate([0,0,5])
      rotate([0,-30,0])
  cylinder(r=3,h=6);
 }
 hull(){
  translate([0,0,5])
    rotate([0,-30,0])
      cylinder(r1=3,r2=4,h=6);
  translate([-3,0,10])
    rotate([0,-30,0])
      cylinder(r1=4,r2=1,h=6);
 }

  translate([-5.6,0,14.5])
    rotate([0,-30,-10])
      cylinder(r1=1.1, r2=0.1, h=5);
  
 }
 //left tooth

translate([-7,22,-0.1])
  rotate([0,-20,180]){
   scale(0.8,0.8,0.8){
hull(){
  rotate([0,20,0])
    cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,20,0])
  cylinder(r=2.5,h=4);

   translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-94.5,-75,-3])
     cube([105,100,6]);
  }
  
  }
  }
  hull(){
  translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-108.5,-8,-3])
    rotate([0,0,-20])
     cube([100,100,6]);
  
 }
  }
  translate([-9.1,0,9.9])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2,h=0.1);
  }
  translate([-13,0,8.5])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2.3,h=5);
}
}

//right tooth
  translate([-7,15,-0.1])
    rotate([0,-20,180]){
      scale(0.8,0.8,0.8){
hull(){
  rotate([0,20,0])
    cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,20,0])
  cylinder(r=2.5,h=4);

   translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-94.5,-75,-3])
     cube([105,100,6]);
  }
  
  }
  }
  hull(){
  translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-108.5,-8,-3])
    rotate([0,0,-20])
     cube([100,100,6]);
  
 }
  }
  translate([-9.1,0,9.9])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2,h=0.1);
  }
  translate([-13,0,8.5])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2.3,h=5);
}
}
translate([-0,15,-0.1])
cylinder(r=1,h=4);
translate([4.5,15,-0.1])
cylinder(r=1,h=2.9);
translate([-0,22,-0.1])
cylinder(r=1,h=4);
translate([4.5,22,-0.1])
cylinder(r=1,h=2.9);

translate([-1,-5,-0.9])
cylinder(r=5,h=1);
 translate([-1,5,-0.9])
cylinder(r=5,h=1);
}
translate([-38,-20,-0])
cube([90,50,1]);
}
}
// eyes NO.1
module eyes1() {
scale(1.1,1.1,1.1){
union(){
  translate([60.5,-2,2.4])
    sphere(r=1.3);
  translate([60.5,2,2.4])
    sphere(r=1.3);
  translate([59,3,3.8])
    sphere(r=1);
  translate([59,-3,3.8])
    sphere(r=1);
  translate([62,1,0.8])
    sphere(r=0.8);
  translate([62,-1,0.8])
    sphere(r=0.8);
  translate([61.4,2.5,0.8])
    sphere(r=0.8);
  translate([61.4,-2.5,0.8])
    sphere(r=0.8);
}
}
}
// eyes NO.2
module eyes2() {
scale(1.1,1.1,1.1){
union(){
  translate([59,-2.3,1.3])
    sphere(r= 3);
  translate([59,2.3,1.3])
    sphere(r= 3);
  translate([57.6,-5.9,2])
    sphere(r= 2.3);
  translate([57.6,5.9,2])
    sphere(r= 2.3);
 
 
}
}
}

// eyes NO.3
module eyes3() {
scale(0.9,0.9,0.9){
union(){
  translate([59,-2.3,2.5])
    sphere(r= 2.5);
  translate([59,2.3,2.5])
    sphere(r= 2.5);
  translate([55.7,-4.5,4.6])
    sphere(r= 2);
  translate([55.7,4.5,4.6])
    sphere(r= 2);
  translate([56,-7.5,2.5])
    sphere(r= 2);
  translate([56,7.5,2.5])
    sphere(r= 2);
  translate([60,-4.5,0])
    sphere(r= 2);
  translate([60,4.5,])
    sphere(r= 2);
 
 
}
}
}

// eyes NO.4
module eyes4() {
scale(0.9,0.9,0.9){
union(){
  translate([61,-2.3,0])
    sphere(r= 1.5);
  translate([61,2.3,0])
    sphere(r= 1.5);
  translate([58.7,-2.5,2.1])
    sphere(r= 2);
  translate([58.7,2.5,2.1])
    sphere(r= 2);
  translate([56,-7.5,2.5])
    sphere(r= 2);
  translate([56,7.5,2.5])
    sphere(r= 2);
  translate([58.5,-6,1])
    sphere(r= 2);
  translate([58.5,6,1])
    sphere(r= 2);
 
 
}
}
}
//teeth 1
module teeth1(){
//left tooth
translate([59,3,-2])
  rotate([0,-90,190]){
   scale(0.7,0.7,0.7){
hull(){
  cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,-30,0])
  cylinder(r=3,h=6);
  }
hull(){
  translate([0,0,5])
    rotate([0,-30,0])
      cylinder(r1=3,r2=4,h=6);
  translate([-3,0,10])
    rotate([0,-30,0])
      cylinder(r1=4,r2=1,h=6);
}
translate([-5.6,0,14.5])
    rotate([0,-30,0])
      cylinder(r1=1.1, r2=0.1, h=5);
}
}
//right tooth
  translate([59,-3,-2])
    rotate([0,-90,170]){
      scale(0.7,0.7,0.5){
 hull(){
  cylinder(r1=2,r2=3,h=5);
    translate([0,0,5])
      rotate([0,-30,0])
  cylinder(r=3,h=6);
 }
 hull(){
  translate([0,0,5])
    rotate([0,-30,0])
      cylinder(r1=3,r2=4,h=6);
  translate([-3,0,10])
    rotate([0,-30,0])
      cylinder(r1=4,r2=1,h=6);
 }

  translate([-5.6,0,14.5])
    rotate([0,-30,0])  
      cylinder(r1=1.1, r2=0.1, h=5);
 }
}
}

//teeth 2
module teeth2(){
//left tooth

translate([59,3,-3])
  rotate([0,-120,190]){
   scale(0.8,0.8,0.8){
hull(){
  rotate([0,20,0])
    cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,20,0])
  cylinder(r=2.5,h=4);

   translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-94.5,-75,-3])
     cube([105,100,6]);
  }
  
  }
  }
  hull(){
  translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-108.5,-8,-3])
    rotate([0,0,-20])
     cube([100,100,6]);
  
 }
  }
  translate([-9.1,0,9.9])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2,h=0.1);
  }
  translate([-13,0,8.5])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2.3,h=5);
}
}

//right tooth
  translate([59,-3,-3])
    rotate([0,-120,170]){
      scale(0.8,0.8,0.8){
hull(){
  rotate([0,20,0])
    cylinder(r1=2,r2=3,h=5);
  translate([0,0,5])
    rotate([0,20,0])
  cylinder(r=2.5,h=4);

   translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-94.5,-75,-3])
     cube([105,100,6]);
  }
  
  }
  }
  hull(){
  translate([-6,0,0.5])
  rotate([90,-40,0]){
 difference(){
  rotate_extrude(convexity = 30)
translate([10, 0, 0])
circle(r = 2.3,$fn=50); 
  translate([-30,-87,-3])
  cube([100,86,6]);
  translate([-108.5,-8,-3])
    rotate([0,0,-20])
     cube([100,100,6]);
  
 }
  }
  translate([-9.1,0,9.9])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2,h=0.1);
  }
  translate([-13,0,8.5])
  rotate([0,70,0])
  cylinder(r1=0.2, r2=2.3,h=5);
}
}
}
//spider
module preview(){
color("MintCream")
   scale([1.1,1.1,1.1])
     union(){

//back body
translate([10,0,-3]){
  hull(){
    difference(){
      hull(){
      translate([3,0,0])
          sphere(r=18);
      translate([5,0,0])
        sphere(r=18);
     }
    translate([0,0,-23])
      cube([50,50,30], center=true);
}
    translate([-39,0,8]){
      difference(){
       union (){
         hull(){
    translate([45,0,-3])
      sphere(r=18);
    translate([38,0,-3])
      sphere(r=18);    
 }
}
    translate([45,0,4])
      cube([50,50,30], center=true);

    }
   }
  }
 }

//front body
// you can change the type of the teeth
    if (teeth_to_select == 1) {
       
        translate([-1,0,0])
        teeth1();
    }
    if (teeth_to_select == 2) {
        
        translate([-1,0,1])
        teeth2();
    }
//You can change the type of eyes
    if (eyes_to_select == 1) {
        
        translate([-6.7,0,0])
        eyes1();
    }
    if (eyes_to_select == 2) {
        translate([-6.7,0,0])
        eyes2();
    }
    if (eyes_to_select == 3) {
        
        translate([6.3,0,0])
        eyes3();
    }
     if (eyes_to_select == 4) {
        
        translate([6.3,0,0])
        eyes4();
    }
    if (eyes_to_select == 5) {
        
    }
hull(){
  translate([0,0,-4]){
    difference(){
  union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
     }
    }

  translate([49,0,-13])
    cube([50,50,30], center=true);

   }
  }
  translate([0,0,6.2]){
    difference(){
      union (){
    hull(){
  translate([49,0,-3])
    sphere(r=15);
  translate([38,0,-3])
    sphere(r=13);    
 }
}
translate([49,0,6.95])
cube([50,50,30], center=true);

  }
 }
}



//left legs
union(){
//legs1

legs(34,10,-3,45,-98,-90,20,6.5,60);

//legs2
legs(38,10,-3,10,-98,-90,22,5,50);

//legs3

legs(43,10,-3,-20,-98,-90,22,5,50);

//legs4

legs(47,10,-3,-55,-98,-90,22,6.5,60);

//arm1
legs(53,-9,-3,-40,-98,205,17,6.5,30);

}

//right side
mirror([0,1,0]){
  union(){
//legs5

legs(34,10,-3,45,-98,-90,20,6.5,60);

//legs6
legs(38,10,-3,10,-98,-90,22,5,50);

//legs7

legs(43,10,-3,-20,-98,-90,22,5,50);

//legs8

legs(47,10,-3,-55,-98,-90,22,6.5,60);

//arm2
legs(53,-9,-3,-40,-98,205,17,6.5,30);
  }
 
 }
}
}
module Spider_for_print2(){
    difference(){
            rotate([0,0,0])
        translate([-30,0,17])
        test();
          
	    translate([-45,-65,-7.5])
            cube([125,130,3]);
          }
            
          
        translate([-16.5,0,-4])
            cylinder(r=5,h=3.5);
        translate([24,0,-4])
            cylinder(r=3,h=8.2);
        translate([10,0,-4])
            cylinder(r=2,h=11);
        translate([57.5,18.7,-4])
            cylinder(r=2,h=4.8);
        translate([57.5,-18.7,-4])
            cylinder(r=2,h=4.8);
       //left tooth
        translate([70,-10,-2])
        union(){
         translate([0,5,0])
  
        scale([0.7,0.7,0.7]){
        hull(){
         cylinder(r1=2,r2=3,h=5);
        translate([0,0,5])
            rotate([0,-30,0])
            cylinder(r=3,h=6);
            }
         hull(){
        translate([0,0,5])
            rotate([0,-30,0])
            cylinder(r1=3,r2=4,h=6);
        translate([-3,0,10])
            rotate([0,-30,0])
         cylinder(r1=4,r2=1,h=6);
           }
        translate([-5.6,0,14.5])
            rotate([0,-30,10])
         cylinder(r1=1.1, r2=0.1, h=5);
            }

        //right tooth
          translate([0,-12,0])
            
         scale([0.7,0.7,0.7]){    
         hull(){
          cylinder(r1=2,r2=3,h=5);
            translate([0,0,5])
              rotate([0,-30,0])
          cylinder(r=3,h=6);
         }
         hull(){
          translate([0,0,5])
            rotate([0,-30,0])
              cylinder(r1=3,r2=4,h=6);
          translate([-3,0,10])
            rotate([0,-30,0])
              cylinder(r1=4,r2=1,h=6);
         }

          translate([-5.6,0,14.5])
            rotate([0,-30,-10])
              cylinder(r1=1.1, r2=0.1, h=5);
          
         }
                

          }
          //left tooth
        translate([74,0,0])
          union(){
            translate([-7,22,-0.1])
              rotate([0,-20,180]){
               scale(0.7,0.7,0.7){
            hull(){
              rotate([0,20,0])
                cylinder(r1=2,r2=3,h=5);
              translate([0,0,5])
                rotate([0,20,0])
              cylinder(r=2.5,h=4);

               translate([-6,0,0.5])
              rotate([90,-40,0]){
             difference(){
              rotate_extrude(convexity = 30)
            translate([10, 0, 0])
            circle(r = 2.3,$fn=50); 
              translate([-30,-87,-3])
              cube([100,86,6]);
              translate([-94.5,-75,-3])
                 cube([105,100,6]);
              }
              
              }
              }
              hull(){
              translate([-6,0,0.5])
              rotate([90,-40,0]){
             difference(){
              rotate_extrude(convexity = 30)
            translate([10, 0, 0])
            circle(r = 2.3,$fn=50); 
              translate([-30,-87,-3])
              cube([100,86,6]);
              translate([-108.5,-8,-3])
                rotate([0,0,-20])
                 cube([100,100,6]);
              
             }
              }
              translate([-9.1,0,9.9])
              rotate([0,70,0])
              cylinder(r1=0.2, r2=2,h=0.1);
              }
              translate([-13,0,8.5])
              rotate([0,70,0])
              cylinder(r1=0.2, r2=2.3,h=5);
            }
            }

            //right tooth
              translate([-7,15,-0.1])
                rotate([0,-20,180]){
                  scale(0.7,0.7,0.7){
            hull(){
              rotate([0,20,0])
                cylinder(r1=2,r2=3,h=5);
              translate([0,0,5])
                rotate([0,20,0])
              cylinder(r=2.5,h=4);

               translate([-6,0,0.5])
              rotate([90,-40,0]){
             difference(){
              rotate_extrude(convexity = 30)
            translate([10, 0, 0])
            circle(r = 2.3,$fn=50); 
              translate([-30,-87,-3])
              cube([100,86,6]);
              translate([-94.5,-75,-3])
                 cube([105,100,6]);
              }
              
              }
              }
              hull(){
              translate([-6,0,0.5])
              rotate([90,-40,0]){
             difference(){
              rotate_extrude(convexity = 30)
            translate([10, 0, 0])
            circle(r = 2.3,$fn=50); 
              translate([-30,-87,-3])
              cube([100,86,6]);
              translate([-108.5,-8,-3])
                rotate([0,0,-20])
                 cube([100,100,6]);
              
             }
              }
              translate([-9.1,0,9.9])
              rotate([0,70,0])
              cylinder(r1=0.2, r2=2,h=0.1);
              }
              translate([-13,0,8.5])
              rotate([0,70,0])
              cylinder(r1=0.2, r2=2.3,h=5);
            }
            }
            
            translate([-1,15,-4.1])
            cylinder(r=1,h=9);
            translate([3.5,15,-4.3])
            cylinder(r=1,h=6.9);
            translate([-1,22,-4.1])
            cylinder(r=1,h=9);
            translate([3.5,22,-4.3])
            cylinder(r=1,h=6.9);
            translate([-7,15,-4.1])
            cylinder(r=1.5,h=5);
            translate([-7,22,-4.1])
            cylinder(r=1.5,h=5);

            
        }
          translate([70,-5,-4])
            cylinder(r=1.5,h=2);
        translate([70,-22,-4])
            cylinder(r=1.5,h=2);
          translate([75,-46,-4.5])
            cylinder(r=7,h=1);
          translate([35,-57.5,-4.5])
            cylinder(r=7,h=1);
          translate([4,-60,-4.5])
            cylinder(r=7,h=1);
           translate([-38,-53.5,-4.5])
            cylinder(r=7,h=1);
          translate([75,46,-4.5])
            cylinder(r=7,h=1);
          translate([35,57.5,-4.5])
            cylinder(r=7,h=1);
          translate([4,60,-4.5])
            cylinder(r=7,h=1);
           translate([-38,53.5,-4.5])
            cylinder(r=7,h=1);
          translate([-40,-30,-4.5])
            cube([120,60,1]);
            
         }
          
            




//you can choose the color of your spider
//you can choose the part of your spider
scale_factor = 156*1; 

$fn= select_quality;

  if (select_color == 1){
        color("MintCream"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}

	if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,90]){
        
        }
        
    }
            
        if (parts_to_select == 6) {
		rotate([0,0,0])
            Spider_for_print2();
        }
       }
      }
        
  
  
if (select_color == 2){
        color("DimGray"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}

	if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,90]){
        
        }
        
    }

        if (parts_to_select == 6) {
		rotate([0,0,0])
          Spider_for_print2();
        }
        }   
    } 
            
            
        
     if (select_color == 3){
        color("black"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}

	if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,90]){
        
        }
        
    }
     
        if (parts_to_select == 6) {
		rotate([0,0,0])
          Spider_for_print2();
         }
        }
        }    
            
            
       
  
  if (select_color == 4){
        color("purple"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}

		if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,90]){
        
        }
        
    }
   
        if (parts_to_select == 6) {
		
          rotate([0,0,0])
         Spider_for_print2();
         }
        }
        }    
            
   
  
    if (select_color == 5){
        color("DodgerBlue"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}
	
	if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,0]){
       
        }
        
    }
     
         if (parts_to_select == 6) {
		
          Spider_for_print2();
         }
        }
        }   
            
       
      if (select_color == 6){
        color("darkgreen"){
            
            scale(project_size/scale_factor,project_size/scale_factor,project_size/scale_factor)


	if (parts_to_select == 1) {
		translate([-50,0,13])
        frontbody();
	}
	if (parts_to_select == 2) {
		translate([-13,0,17])
        backbody();
	}

	if (parts_to_select == 3) {
		legs_for_print();
	}
    if (parts_to_select == 4) {
		rotate([0,0,0])
        translate([-30,0,17])
        preview();
	}
    if (parts_to_select == 5) {
        translate([0,60,13]) frontbody();
		translate([-50,60,15])    backbody();
		translate([]) legs_for_print();
        rotate([0,0,90]){
        
        }
        
    }
     
        if (parts_to_select == 6) {
		rotate([0,0,0])
        Spider_for_print2();
            
         }
        }
        }
    



    

	