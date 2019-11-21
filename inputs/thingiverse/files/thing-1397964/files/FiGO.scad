    //A = As is
    //B = measurement - wheel radius - 1"
    //C = length of  dog from their belly to their tail, minus 2"

/* [Global] */

  
/* [Parts] */

    part = "wheelchair_sim_"; // [wheelchair_sim_:Wheelchair Simulation,part_a_:Part A,part_b_:Part B, part_b2_:Part B2, part_c_:Part C,part_d_:Part D,part_e_:Part E,all_parts_:All Parts]

/* [Measurements] */

// Dog Width in inches
    A = 6;
// Dog Height in inches
    B = 8;
// Dog Length in inches
    C = 14;
// Weight of Dog in pounds(<10 pounds will have an extra support bar)
    D = 11;

/* [Materials] */

// in inches
    wheel_diameter = 4;
// in inches
    screw_diameter = 0.25;
// in inches (default slightly larger than 3/4" to accomodate print resolution)
    tube_outer_diameter = 0.776;
    

//15 for back tilt    
wheel_angle = 0;

/* [Hidden] */
    
    $fn=60;
    //128 = very high res
    

//tube_outer_radius = 0.388;

tube_outer_radius = tube_outer_diameter / 2;


    //Joint Piece Inner Readius Cutout (9.525 mm or 0.375 inch is exact size, 9.85mm or 0.388 inch is slightly larger for Makerbots)
    inner_radius = tube_outer_radius * 25.4;

    screwsize = screw_diameter * 12.7;
    wheelsize = wheel_diameter * 12.7;
    bar = D > 10;
    t_angle = 15;

    //Joint Piece Outer Radius
    //outer_radius = inner_radius * 1.57;
    outer_radius = 14.95425;

    //Cylinder Length
    cyllength = 25.4;

    //Torus Bend Parameters
    bend_radius = 1;
    angle_1 = -30;
    angle_2 = 60;

    //wheelchair sim
    chairlength = C * 25.4 - 50.8;
    //length of  dog from their belly to their tail, minus 2"
    chairwidth = A * 25.4;
    chairheight = B * 25.4 - wheelsize - 25.4;
    chairwheeldistance = 90;

///////////END PARAMETERS///////////  

module wheelchair(){
    
    union(){
     
    translate([ chairwidth, 0 ,0])
    rotate(a=90, v=[1,0,0])
    cylinder(r=inner_radius, h=chairlength, $fn=60) ;

    mirror(){
    
    rotate(a=90, v=[1,0,0])
    cylinder(r=inner_radius, h=chairlength, $fn=60) ;
    }
    
    rotate(a=90, v=[0,1,0])
    cylinder(r=inner_radius, h=chairwidth, $fn=60) ;
  
     rotate(a=wheel_angle, v=[1,0,0])    
    translate([ 0, -chairwheeldistance ,-chairheight])
    cylinder(r=inner_radius, h=chairheight, $fn=60) ;
    mirror (){  
            rotate(a=wheel_angle, v=[1,0,0])    
 
    translate([ -chairwidth, -chairwheeldistance ,-chairheight]) 
    cylinder(r=inner_radius, h=chairheight, $fn=60) ;
   }
    
    if (bar) { 
                if (wheel_angle) {
    translate([ 0, wheel_angle * 2 ,0])
   rotate(a=90, v=[0,1,0])
    translate([ chairheight, -chairwheeldistance ,0]) 
    cylinder(r=inner_radius, h=chairwidth, $fn=60) ;   
                }
   
                else {
      rotate(a=90, v=[0,1,0])
    translate([ chairheight, -chairwheeldistance ,0]) 
    cylinder(r=inner_radius, h=chairwidth, $fn=60) ;   
    }
}
}


 if (wheel_angle) {
    translate([ 0, wheel_angle * 2 ,0])

  color("black") 

intersection(){

    rotate(a=90, v=[0,1,0])
    translate([ chairheight + 30, -chairwheeldistance , -28])
    scale([1,1,0.25]) 
    sphere(r=wheelsize, $fn=60) ;
    
}
    translate([ 0, wheel_angle * 2 ,0])

  color("black") 

    mirror (){
    rotate(a=90, v=[0,1,0])
    translate([ chairheight + 30, -chairwheeldistance , - chairwidth -28]) 
     scale([1,1,0.25]) 
    sphere(r=wheelsize, $fn=60) ;

}

}

else {
    
   color("dimgrey") 

intersection(){

    rotate(a=90, v=[0,1,0])
    translate([ chairheight + 30, -chairwheeldistance , -28])
    scale([1,1,0.25]) 
    sphere(r=wheelsize, $fn=60) ;
    
}
  color("dimgrey") 

    mirror (){
    rotate(a=90, v=[0,1,0])
    translate([ chairheight + 30, -chairwheeldistance , - chairwidth -28]) 
     scale([1,1,0.25]) 
    sphere(r=wheelsize, $fn=60) ;

} 
}
}

module wheelchairwithbar(){
     
    wheelchair();

    rotate(a=90, v=[0,1,0])
    translate([ chairheight, -chairwheeldistance ,0]) 
    cylinder(r=inner_radius, h=chairwidth, $fn=60) ;

}

module bend(){
        
    // bend
    difference()
    {
    
    // torus          
    rotate_extrude()
    translate([bend_radius + outer_radius, 0, 0])
    circle(r=outer_radius, $fn=6);
        
    // torus cutout
    rotate_extrude()
    translate([bend_radius + outer_radius, 0, 0])
    circle(r=inner_radius);
        
    // lower cutout           
    rotate([0, 0, angle_1])
    translate([-100 * (((angle_2 - angle_1) <= 180)?1:0), -100, -50])
    cube([300, 100, 100]);
    
    // upper cutout
    rotate([0, 0, angle_2])
    translate([-100 * (((angle_2 - angle_1) <= 180)?1:0), 0, -50])
    cube([300, 100, 100]);
    
    }      
    }
    
     module bend2(){
        
        intersection(){
                rotate([0, 0, -30])
   translate([0,0,-50])

                cube([100, 100, 100]);

    union(){
    
    // bend
    difference()
    {
    
    // torus          
    rotate_extrude()
    translate([bend_radius + outer_radius, 0, 0])
           
    rotate([0, 0, 90])
    circle(r=outer_radius, $fn=6);
        
    // torus cutout
    rotate_extrude()
    translate([bend_radius + outer_radius, 0, 0])
        
    circle(r=inner_radius);
        
    // lower cutout           
    rotate([0, 0, angle_1])
    translate([-100 * (((angle_2 - angle_1) <= 180)?1:0), -100, -50])
    cube([300, 100, 100]);
    
    // upper cutout
    rotate([0, 0, angle_2])
    translate([-100 * (((angle_2 - angle_1) <= 180)?1:0), 0, -50])
    cube([300, 100, 100]);
    
    }      
    }
}
 
}

module strapholes(){
    
   translate([-15, 33, -50])
   cylinder(r=screwsize, h= 100);   
    
}


module straps1(){
    
    //straps
    
   difference(){     
       
   union(){   
      translate([-25.38, 28.9, -10])
      cube([20, 20, 20]);
 
   }
union(){
    rotate(a=-30, v=[1,0,0])
      translate([-40, -100, 20.926])
          cube([200, 200, 20]);
    
    rotate(a=30, v=[1,0,0])
      translate([-40, -100, -43.63])
          cube([200, 200, 22.7]);
    
          translate([-40, 39, -20])
             cube([200, 200, 50]);

}
   rotate(a= 10, v=[1,0,0])
   strapholes(); 
}
}



module straps2(){
     
   //straps
    
   difference(){     
       
   union(){   
      translate([-25.38, 28.9, -10])
      cube([12, 20, 20]);
 
   }
union(){
    rotate(a=-30, v=[1,0,0])
      translate([-40, -100, 20.926])
          cube([200, 200, 20]);
    
    rotate(a=30, v=[1,0,0])
      translate([-40, -100, -43.63])
          cube([200, 200, 22.7]);
    
}
    
          translate([-40, 39, -20])
             cube([200, 200, 50]);
   rotate(a=90, v=[0,1,0])
   translate([0, 33, -50])
   cylinder(r=screwsize, h= 205);    
    
    }
}

module straps3(){
    
    //straps
    
   difference(){     
       
   union(){   
      translate([-25.38, 28.9, -10])
      cube([20, 20, 20]);
 
   }
union(){
    rotate(a=-30, v=[1,0,0])
      translate([-40, -100, 20.926])
          cube([200, 200, 20]);
    
    rotate(a=30, v=[1,0,0])
      translate([-40, -100, -43.63])
          cube([200, 200, 22.7]);
    
          translate([-40, 39, -20])
             cube([200, 200, 50]);

}
    rotate(a= -10, v=[1,0,0])

   strapholes();   
}
}


module partA() {

    union() {
        
        
    // lower arm
    rotate([0, 0, angle_1])
    translate([bend_radius + outer_radius, 0.02, 0])
    rotate([90, 90, 0])
    difference() {
    cylinder(r=outer_radius, h=cyllength, $fn=6) ;
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength +5 );
        
        
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -0.02, 0])
    rotate([-90, 90, 0])
    difference() {
    cylinder(r=outer_radius, h=cyllength, $fn=6);
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength + 5);
        
    }
             
    bend2();

union(){
    rotate(a=-30, v=[0,0,1])    
  // translate([-25.4, 0, -10])
    straps1();

}
    }
    


}

module partB() {
   
    if (wheel_angle ==15){
    

 
        
    union(){
    rotate(a=120, v=[0,0,1])
 
    union() {
        
    // lower arm
    rotate([0, 0, angle_1])
        //tangle is 0
        
 
                translate([bend_radius + outer_radius  - 1.3, 0.02 +  6.8 , 0])
      
        
    rotate([90, 0,  wheel_angle])
    difference() {


    cylinder(r=outer_radius, h=cyllength + 8, $fn=6);
    translate([0, 0, -10])
    cylinder(r=inner_radius, h=cyllength +20);
        
       union(){
               


               rotate([0, 75,  0])

    translate([bend_radius + outer_radius  - 7, -38, 45])
    translate([0, 38, -50])

    cylinder(r=inner_radius, h=cyllength * 4);
       } 
        
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -38, 0])
    rotate([-90, 0, 0])
    difference() {
       
      
    cylinder(r=outer_radius, h=cyllength * 1.75, $fn=6 );

    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
        
        
    }

    difference(){
    bend();

    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);




        

    
union(){
    rotate(a=64, v=[0,0,1])
    translate([-47, -50, -25])
   cube(50,50,50);
    
    
}



        
       
    }
    
    
        
    }
    
}
          rotate(a=90, v=[0,1,0])    
          rotate(a=-90, v=[0,0,1])    

    translate([-12.62, -15.95, -15.95])
    straps3();

}


else  {
     union(){
    rotate(a=120, v=[0,0,1])
 
    union() {
        
    // lower arm
    rotate([0, 0, angle_1])
        //tangle is 0
        
 
                translate([bend_radius + outer_radius, 0.02  , 0])
      
        
    rotate([90, 0,  wheel_angle])
    difference() {


    cylinder(r=outer_radius, h=cyllength, $fn=6);
    translate([0, 0, -10])
    cylinder(r=inner_radius, h=cyllength +15);
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -38, 0])
    rotate([-90, 0, 0])
    difference() {
       
      
    cylinder(r=outer_radius, h=cyllength * 1.75, $fn=6 );

    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }

    difference(){
    bend();

    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }
        
    }
    
}
          rotate(a=90, v=[0,1,0])    
          rotate(a=-90, v=[0,0,1])    

    translate([-12.62, -15.95, -15.95])
    straps1();

}

}

module partB2() {
    mirror(){
   
    if (wheel_angle ==15){
    

 
        
    union(){
    rotate(a=120, v=[0,0,1])
 
    union() {
        
    // lower arm
    rotate([0, 0, angle_1])
        //tangle is 0
        
 
                translate([bend_radius + outer_radius  - 1.3, 0.02 +  6.8 , 0])
      
        
    rotate([90, 0,  wheel_angle])
    difference() {


    cylinder(r=outer_radius, h=cyllength + 8, $fn=6);
    translate([0, 0, -10])
    cylinder(r=inner_radius, h=cyllength +20);
        
       union(){
               


               rotate([0, 75,  0])

    translate([bend_radius + outer_radius  - 7, -38, 45])
    translate([0, 38, -50])

    cylinder(r=inner_radius, h=cyllength * 4);
       } 
        
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -38, 0])
    rotate([-90, 0, 0])
    difference() {
       
      
    cylinder(r=outer_radius, h=cyllength * 1.75, $fn=6 );

    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
        
        
    }

    difference(){
    bend();

    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);




        

    
union(){
    rotate(a=64, v=[0,0,1])
    translate([-47, -50, -25])
   cube(50,50,50);
    
    
}



        
       
    }
    
    
        
    }
    
}
          rotate(a=90, v=[0,1,0])    
          rotate(a=-90, v=[0,0,1])    

    translate([-12.62, -15.95, -15.95])
    straps3();

}


else  {
     union(){
    rotate(a=120, v=[0,0,1])
 
    union() {
        
    // lower arm
    rotate([0, 0, angle_1])
        //tangle is 0
        
 
                translate([bend_radius + outer_radius, 0.02  , 0])
      
        
    rotate([90, 0,  wheel_angle])
    difference() {


    cylinder(r=outer_radius, h=cyllength, $fn=6);
    translate([0, 0, -10])
    cylinder(r=inner_radius, h=cyllength +15);
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -38, 0])
    rotate([-90, 0, 0])
    difference() {
       
      
    cylinder(r=outer_radius, h=cyllength * 1.75, $fn=6 );

    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }

    difference(){
    bend();

    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }
        
    }
    
}
          rotate(a=90, v=[0,1,0])    
          rotate(a=-90, v=[0,0,1])    

    translate([-12.62, -15.95, -15.95])
    straps1();

}

}
}

module partC() {
   
    difference(){
           
    rotate(a=120, v=[0,0,1])
           
    union() {
        
    // lower arm
    rotate([0, 0, angle_1])
    translate([bend_radius + outer_radius, 0.02, 0])
    rotate([90, 0, 0])
        
    rotate([0, 0, 90])

    difference() {
    cylinder(r=outer_radius, h=cyllength - 5.4, $fn=6 );
    translate([0, 0,-10])
    cylinder(r=inner_radius, h=cyllength + 60 );
     
}
}
}

translate([25.36, 0, 0])
straps1();
  

}  

module partD() {

   difference(){
    
   union() {
        rotate(a=120, v=[0,0,1])

    // lower arm
    rotate([0, 0, angle_1])
    translate([bend_radius + outer_radius, 0.02, 0])
    rotate([90, 0, 0])
    rotate([0, 0, 90])

    difference() {
        
    cylinder(r=outer_radius, h=cyllength + 20, $fn=6 );
    translate([0, 0,10])
    cylinder(r=inner_radius, h=cyllength +25 );

    }
    }
    }  
     
   union(){  
   translate([50.76, 0, 0])
 
   straps1 ();

   translate([25.36, 0, 0])

   straps2();
   }

} 


module partE() {
    
    if (wheel_angle){

    translate ([0,0,- wheel_angle * 2.2])
    rotate (a=wheel_angle, v=[1,0,0]) 
   

difference(){
    rotate(a=120, v=[0,0,1])
    union() {
        
        if (bar) {
    // lower arm
    rotate([0, 0, angle_1])
    translate([bend_radius + outer_radius, 0.02, 0])
    rotate([90, 90, 0])
    difference() {
    cylinder(r=outer_radius, h=cyllength, $fn=6);
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength +5);
    }
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -43, 0])
    rotate([-90, 90, 0])
    difference() {
        

    cylinder(r=outer_radius, h=cyllength * 1.75  +25.4  , $fn=6);
       
        
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);

    // start wheel hole
    
    translate([0, 50, 60])
    rotate(a=90, v=[1,0,0])
    cylinder(r=screwsize, h= 205);
}

//end wheel hole
 difference(){

 if (bar) {
 bend2();
 }
 
    //glitch that makes no sense but needs to exist (sorry)
    cylinder(r=0, h=0);
    //end glitch


    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }
 }
    }

    }

  else{

    translate ([0,0,- wheel_angle * 2.2])
    rotate (a=wheel_angle, v=[1,0,0]) 
   

difference(){
    rotate(a=120, v=[0,0,1])
    union() {
        
        if (bar) {
    // lower arm
    rotate([0, 0, angle_1])
    translate([bend_radius + outer_radius, 0.02, 0])
    rotate([90, 90, 0])
    difference() {
    cylinder(r=outer_radius, h=cyllength, $fn=6);
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength +5);
    }
    }

    // upper arm
    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -43, 0])
    rotate([-90, 90, 0])
    difference() {
        

    cylinder(r=outer_radius, h=cyllength * 1.75  +25.4  , $fn=6);
       
        
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);

    // start wheel hole
    
    translate([0, 50, 60])
    rotate(a=90, v=[1,0,0])
    cylinder(r=screwsize, h= 205);
}

//end wheel hole
 difference(){

 if (bar) {
 bend2();
 }
 
    //glitch that makes no sense but needs to exist (sorry)
    cylinder(r=0, h=0);
    //end glitch


    rotate([0, 0, angle_2])
    translate([bend_radius + outer_radius, -40, 0])
    rotate([-90, 0, 0])
    translate([0, 0, -1])
    cylinder(r=inner_radius, h=cyllength *2 + 5);
    }
 }
    }

    }
}

         
///////////RENDER///////////  

print_part();
    
module print_part() {

if (part == "wheelchair_sim_") {      
  union(){
  //partA 
  translate([outer_radius,-outer_radius,0])
  rotate(a=120, v=[0,0,1])
  color("chartreuse") 
  partA();
 
  mirror(){
  translate([-chairwidth + outer_radius,-outer_radius,0])
  rotate(a=120, v=[0,0,1])
  color("Chartreuse") 
  partA();
  }
   
//partB 
  translate([ 0, -chairwheeldistance - outer_radius , -outer_radius])
  rotate(a=90, v=[0,1,0])
  color("Chartreuse") 
  partB();
  
  mirror(){
  translate([ -chairwidth, -chairwheeldistance - outer_radius , -outer_radius])
  rotate(a=90, v=[0,1,0])
  color("Chartreuse") 
  partB();
  }
  

 
//partC 
  translate([outer_radius , -chairwheeldistance - 80  , 0])
  rotate(a=90, v=[0,0,1])
  color("Chartreuse") 
  partC();
  
  mirror(){
  translate([-chairwidth + outer_radius , -chairwheeldistance - 80  , 0])     
  rotate(a=90, v=[0,0,1])
  color("Chartreuse") 
  partC();
  }
  
  //partD 
  translate([outer_radius , -chairlength , 0])
  rotate(a=90, v=[0,0,1])
  color("Chartreuse") 
  partD();
  
  mirror(){
  translate([-chairwidth + outer_radius , -chairlength , 0])
  rotate(a=90, v=[0,0,1])
  color("Chartreuse") 
  partD();
  }
 
//partE  
  translate([outer_radius , -chairwheeldistance  , -chairheight - outer_radius])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partE();
  
  mirror(){  
  translate([ - chairwidth + outer_radius , -chairwheeldistance  , -chairheight - outer_radius])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partE();
  }
  
  //wheelchair  
  translate([ 0, 0 ,0])
  color("LightGrey") 
  wheelchair();
  }
  
} else if (part == "part_a_") {
   rotate(a=-90, v=[1,0,0])
  translate([ -80,-30 , 25])
  rotate(a=120, v=[0,0,1])
  color("Chartreuse") 
  partA();
 
 
} else if (part == "part_b_") {         
   translate([ -90, -20 , 13])
  rotate(a=180, v=[1,0,0])
  color("Chartreuse") 
  partB();

	} 
    
    else if (part == "part_b2_") {         
   translate([ -90, -20 , 13])
  rotate(a=180, v=[1,0,0])
  color("Chartreuse") 
  partB2();

	} 
        
else if (part == "part_c_") {
translate([-40 , 10 , -3])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partC();
}

else if (part == "part_d_") {
    translate([30 , -35 , -3])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partD();
  }
  
else if (part == "part_e_") {
  translate([ -10, -35 , 29])
  rotate(a=90, v=[0,0,1])
  rotate(a=-90, v=[0,1,0])
  color("Chartreuse") 
  partE();	
  }

else if (part == "all_parts_") {

 union() {

//partA       
  rotate(a=-90, v=[1,0,0])
  translate([ -80,-30 , 25])
  rotate(a=120, v=[0,0,1])
  color("Chartreuse") 
  partA();
   
//partB 
  translate([ -90, -20 , 13])
  rotate(a=180, v=[1,0,0])
  color("Chartreuse") 
  partB();

//partC 
  translate([-30 ,25 , -3])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partC();
 
//partD 
  translate([50 , -35 , -3])
  rotate(a=90, v=[1,0,0])
  color("Chartreuse") 
  partD();
 
//partE 
  translate([ 0, -35 , 29])
  rotate(a=90, v=[0,0,1])
  rotate(a=-90, v=[0,1,0])
  color("Chartreuse") 
  partE();
  
  }	

}
}


//translate([ -90, -20 , 13])
// rotate(a=180, v=[1,0,0])
// color("Chartreuse") 
//partB();

//
//mirror (){ 
//    
//    translate([ -90, -20 , 13])
//  rotate(a=180, v=[1,0,0])
//  color("Chartreuse") 
//  partB();
//
//}



///////////END RENDER///////////  
//nov 2015: new hexagonal piece design for optimized printing
//dec 2015: created wheelchair sim, developed UI for Thingiverse's Customizer app (piece resizing still unavailable currently)
// Jan 2016: new strap system holes that straps screw on to
//feb24 update: back wheels can be angled backwards 15 degrees
//feb 28 update: angled screw holes 