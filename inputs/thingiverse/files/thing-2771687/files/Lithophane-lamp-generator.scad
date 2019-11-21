/*
 * Customizable Lithophane lamp  - https://www.thingiverse.com/
 * by MGiorgio Slovakia - https://www.thingiverse.com/
 * created 2018-01-20
 * version v1.0
 *
 * v1.2 - 2018-02-02: adjust some holes diameter and set hexagon holes to round
 *                      
 *                      
 * v1.1 - 2018-01-23: correct some carculating issue
 *                      Add new part lamp holder bottom cover 
 *                      Made on the bottom part little bit longer for screw
 *
 *
 * v1.0 - 2018-01-20:
 *  - initial design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

/* [Parts] */

Part = 0; //[0:all_part, 1:Bottom, 2:Leg, 3:Pillar_1, 4:Pillar_2, 5:Pillar_3, 6:Pillar_4, 7:Top, 8:Roof, 9:lamp_holder_bottom, 10 :lamp_hold_bot_cover]

/* [Lamp_main_Parameters] */
// Height of the model (be careful to keep the aspect bottom and top thickness + heightest picture size) Roof has separate settings additional
height = 120;



// Witdh of the model (be careful to keep the aspect pillar thickness widthest picture +25 must be for side 1 and 3 )
width1 = 95;

// Witdh of the model (be careful to keep the aspect pillar thickness widthest picture +25 must be for side 2 and 4 )
width2 = 95;

// Max thickness of the bottom, top 
thickness = 2; //[2:5]

// Witdh of the border bottom, pillars, top both side
border_width = 2; //[2:5]


/* [Picture_size_setting] */

//Picture_settings = 0; //[0:all_picture_same, 1:all_picture_difference]

/* [Picture_1_setting] */

Picture_1_height = 100;

Picture_1_width = 67;

// Min thickness of the picture (= white)
//Picture_1_thickness = 2; //[2:10]

// Witdh of the border
Picture_1_border_width = 3; //[2:10]

// Thickness of the border
Picture_1_border_thickness = 2;  //[2:10]


/* [Picture_2_setting] */

Picture_2_height = 100;

Picture_2_width = 67;

// Min thickness of the picture (= white)
//Picture_2_thickness = 2; //[2:10]

// Witdh of the border
Picture_2_border_width = 3; //[2:10]

// Thickness of the border
Picture_2_border_thickness = 2; //[2:10]


/* [Picture_3_setting] */

Picture_3_height = 100;

Picture_3_width = 67;

// Min thickness of the picture (= white)
//Picture_3_thickness = 2; //[2:10]

// Witdh of the border
Picture_3_border_width = 3; //[2:10]

// Thickness of the border
Picture_3_border_thickness = 2; //[2:10]

/* [Picture_4_setting] */

Picture_4_height = 100;

Picture_4_width = 67;

// Min thickness of the picture (= white)
//Picture_4_thickness = 2; //[2:10]

// Witdh of the border
Picture_4_border_width = 3; //[2:10]

// Thickness of the border
Picture_4_border_thickness = 2; //[2:10]


/* [Border] */

// Add a border ?
border_tolerance = 1; 

picture_border_thickness_tolerance = 0.5; //[0:0.1:1]


/* [LAMP-Settings] */

Lamp_position = 0; //[0:in_bottom, 1:in_top]

// Cut out on botton part if you have in bottom part
Lamp_cut_out = 60;


// Cut out on socket you must give diameter
socket_diameter = 28;

// socket-height
socket_height = 35;


/* [Roof-Settings] */

Roof = 1; //[0:no, 1:yes]

Roof_height = 30; 

// Cut out on botton part if you have in bottom part
Hook = 1; //[0:no, 1:yes]



// Witdh of the transition between the picture and the border
// border_transition_ratio = 0.33; //[0.01:0.01:0.99]


/* [Hidden] */

// Thickness for bottom if is 0 no step between picture holder and edge
border_thickness = 2; //[0:10]



 
 if(Part == 1 )        // Bottom
  { 
    
     
      
    difference(){
      union(){        // bottom main part
                     translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,180] ) cube([10, 10, 3]);
          
          
          //Picture side 1
        translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
              
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
          
           translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),thickness])  color("Red") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),(thickness+(height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness))])  color("Green") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
        
         //Picture side 2 
          translate([(width1/2-border_thickness),-(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
          translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness])rotate([00,0,-90]) color("Blue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
   
             translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_2_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
               translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
      
          
          
        //Picture side 3
        
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
  
     
     translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance)+(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
    
 
            translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])  color("Red") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_3_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
       
     
     
       
       
      
       //Picture side 4
      
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-90])color("LightBlue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
   
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_4_height/2-2*picture_border_thickness_tolerance-thickness)]);
  
      
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
         
         
   if(Lamp_position == 0){
  
  translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),thickness]) cylinder(r=(3),h=5, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),thickness]) cylinder(r=(3),h=5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),thickness]) cylinder(r=(3),h=5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),thickness]) cylinder(r=(3),h=5, $fn = 100);
          
       }   
      
   }
    
     
      
  
      
      // bottom main part
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
  

      //Picture side 1
          translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness-border_width ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width+1)]);
  
      
      //Picture side 2 
      translate([(width1/2-border_thickness-Picture_2_border_thickness-border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance), (Picture_2_border_width+1)]);
      
        //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance/2 ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width+1)]);
         //Picture side 4


translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width+1)]);




if(Lamp_position == 0){
  
 
      cylinder(r=(Lamp_cut_out/2),h= (thickness));
     
     translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness+5, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness+5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness+5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness+5, $fn = 100);  
     }
 
   }     
 }
 
 if(Part == 2)  // LEG
 {
   difference(){
      union(){
          
                            translate([-(width1/2),-(width2/2),-thickness])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),(-thickness-3)]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,180] ) cube([10, 10, 3]);
   
          
     translate([-(width1/2 ),-(width2/2),(-thickness-10)]) cube([width1, 2.5, 10]);
     translate([(width1/2),-(width2/2),(-thickness-10)]) rotate([0,0,90] ) cube([width2, 2.5, 10]);
    translate([-(width1/2),(width2/2),(-thickness-10)]) rotate([0,0,-90] )  cube([width1, 2.5, 10]);
   translate([(width1/2 ),(width2/2 ),(-thickness-10)]) rotate([0,0,180] ) cube([width2, 2.5, 10]);       
          
          }
              translate([-(width1/2 ),-(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
    
          
          
          
          
          
if(Lamp_position == 0)

 {
   translate([0,0,-thickness])   cylinder(r=(Lamp_cut_out/2+9+picture_border_thickness_tolerance),h= (thickness), $fn = 100);
     
  //   translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);  
     }

          }
          
   }
 
  if(Part == 3)  // Pillar 1
 {
   difference(){
      union(){
     
              translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness+3])rotate([00,0,90]) cube([10, 10, height-(thickness+3)*2]);
     
                 translate([(width1/2-border_thickness),-(width2/2-12 ),thickness+3]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
                  
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness+3])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
            translate([(width1/2-(width1-Picture_1_width)/2) ,-(width2/2-border_thickness-Picture_1_border_thickness-2*border_width-picture_border_thickness_tolerance ),(height-thickness-3 )]) rotate([0,90,180]) color("Green") cube([(height-2*thickness-6), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
      
    translate([(width1/2-border_thickness) ,(-width2/2+(width2-Picture_2_width)/2),(thickness+3)]) rotate([0,0,90])  color("LightGreen") cube([(Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height-2*thickness-6)]);
         
      
         
          
          }


        translate([(width1/2-10 ),-(width2/2-2 ),thickness]) rotate([0,0,-45])  cube([15,15,height-(thickness+3),] );
 
      
          
      translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),3]) cylinder(r=(1.3),h=20, $fn = 100);
  
          translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-20-(thickness+3)*2])       cylinder(r=(1.3),h=28, $fn = 100); 
  
                       
              translate([(width1/2-(width1-Picture_1_width)/2) ,-(width2/2-border_thickness-Picture_1_border_thickness- border_width-picture_border_thickness_tolerance/2),(height-thickness-3)])   rotate([0,90,180]) cube([(height-thickness-3), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width)]);
     
            translate([(width1/2-border_thickness-border_width-picture_border_thickness_tolerance/2) ,(-width2/2+(width2-Picture_2_width)/2),(thickness)]) rotate([0,0,90])  cube([  (Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance),(height)]);
  
      
     
  
          
          }
     }
 
     if(Part == 4)  // Pillar 2
 {
      difference(){
      union(){
     
             translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness+3]) rotate([0,0,180] ) cube([10, 10, height-(thickness+3)*2]);
          
            translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness+3])rotate([00,0,-90]) color("LightBlue") cube([(width2/2-Picture_2_width/2-12), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
    
    
          translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness ),thickness+3])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
      
                        translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(width2/2-(width2/2-Picture_2_width/2)-Picture_2_border_width),(thickness+3)]) rotate([00,-90,-90])  color("LightGreen") cube([(height-2*(thickness+3)), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
    
      
     
               translate([(width1/2-(width1/2-Picture_3_width/2)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),(thickness+3)]) rotate([00,-90,00]) color("Green") cube([(height-2*(thickness+3)), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
         
    
          
          }
          
              translate([(width1/2-2 ),(width2/2-10 ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2]);
    
            translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3),h=50, $fn = 100);
  
              translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);
  
       
        //Picture side 2 
      translate([(width1/2-border_thickness-border_width-picture_border_thickness_tolerance/2-Picture_2_border_thickness) ,(width2/2-(width2/2-Picture_2_width/2)-Picture_2_border_width),(thickness+3)]) rotate([90,-90,-180])  cube([(height-2*(thickness+3)), (Picture_2_border_thickness+picture_border_thickness_tolerance/2), (Picture_2_border_width)]);
  
         
                  
         
          
        //Picture side 3
 translate([(width1/2-(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance ),(thickness+3)]) rotate([00,-90,00])  cube([(height-2*(thickness+3)), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width)]);
          
     
     
     
          }
          
          }
          
   if(Part == 5)  // Pillar 3
 {
      difference(){
      union(){
   
                           translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness+3]) rotate([0,0,-90] )  cube([10, 10, height-(thickness+3)*2]);
    
               
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness+3]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
   
   
        
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness+3]) rotate([00,00,-90])color("Blue") cube([((width2/2-Picture_4_width/2-12)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
     
    
                 translate([(-width1/2+(width1/2-Picture_3_width/2)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),(height-(thickness+3))]) rotate([00,90,00]) color("LightGreen") cube([(height-2*(thickness+3)), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
        
    
    
               translate([(-width1/2+border_width) ,(width2/2-(width2/2-Picture_4_width/2)),(height-(thickness+3))]) rotate([0,90,-90])  color("Green") cube([(height-2*(thickness+3)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
    
         


       
         
          }
   
            translate([-(width1/2-2 ),(width2/2-10 ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2]); 
     
      
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);

translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-25]) cylinder(r=(1.3),h=30, $fn = 100);

     
        
                //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2))  ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance ),(height-(thickness+3))]) rotate([00,90,00])  cube([(height-2*(thickness+3)), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width)]);
   
       
        
translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(width2/2-(width2/2-Picture_4_width/2)),(height-(thickness+3))]) rotate([00,90,-90])  cube([(height-2*(thickness+3)), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width)]);
        
       
          
          }
   }
   
   
          
 if(Part == 6)  // Pillar 4
 {
      difference(){
      union(){
                translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness+3]) cube([10, 10, height-(thickness+3)*2]);
     
                translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness+3]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
             
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness+3])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
   
   
           
          
              translate([(-width1/2+(width1/2-Picture_1_width/2)) ,-(width2/2-border_thickness ),(height-(thickness+3))]) rotate([00,90,00]) color("Green") cube([(height-2*(thickness+3)), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
              
               translate([-(width1/2-border_thickness) ,-(width2/2
         -(width2/2-Picture_4_width/2)-(Picture_4_border_width) ),(height-(thickness+3))]) rotate([0,90,-90])  color("Green") cube([(height-2*(thickness+3)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
    
          
      
        
     
          
          }
     
     
      translate([-(width1/2-2 ),-(width2/2+11.4  ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2,] );
     
           translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3),h=50, $fn = 100);    
         translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-(thickness+3)*2-20])       cylinder(r=(1.3),h=50, $fn = 100);
         translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3),h=50, $fn = 100);
         translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3),h=50, $fn = 100);
   
                       
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);
        translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);
        translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);
        translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3),h=30, $fn = 100);
  
        
              translate([(-width1/2+(width1/2-Picture_1_width/2)) ,-(width2/2-border_thickness-border_width ),(height-(thickness+3))]) rotate([00,90,00]) cube([(height-2*(thickness+3)), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width)]);
    
     
      
          
          
    translate([-(width1/2-border_thickness-border_width) ,-(width2/2-border_thickness
         -(width2/2-Picture_4_width/2)-(Picture_4_border_width) ),(height-thickness-3)])  rotate([0,90,-90])  cube([(height-2*(thickness+3)), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width)]);

 
  
  
           
          
           
          }
 
  }
 
 if(Part == 7)  // Top
  { 
   translate([(0),(0),height]) rotate([0,180,180]){ 
     
      
    difference(){
      union(){        // Top main part
                     translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,180] ) cube([10, 10, 3]);
          
          
          
          //Picture side 1
        translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
              
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
          
           translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),thickness])  color("Red") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
        
         //Picture side 2 
          translate([(width1/2-border_thickness),-(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
          translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness])rotate([00,0,-90]) color("Blue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
   
             translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_2_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
               translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
      
          
          
        //Picture side 3
        
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
  
     
     translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance)+(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
    
 
            translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])  color("Red") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_3_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
       
     
     
       
       
      
       //Picture side 4
      
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-90])color("LightBlue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
   
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_4_height/2-2*picture_border_thickness_tolerance-thickness)]);
  
      
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
         
      
    
    
      }
      
      
      // Top main part
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, $fn = 100);
  

      //Picture side 1
          translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness-border_width ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width+1)]);
  
      
      //Picture side 2 
      translate([(width1/2-border_thickness-Picture_2_border_thickness-border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance), (Picture_2_border_width+1)]);
      
        //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance/2 ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width+1)]);
         //Picture side 4


translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width+1)]);



if(Roof == 1)
{
      cylinder(r=(Lamp_cut_out/2),h= (thickness));
}

if(Lamp_position == 1)

 {
      cylinder(r=(Lamp_cut_out/2),h= (thickness), $fn = 100);
     
     translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);  
     }

   }     
 }
}
 
if(Part == 8)  // Roof
  { 
      translate([(0),(0),height]) {
    difference(){
      union(){   



          translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
          if(width1 <= width2)
          { 
   translate([0,0,thickness])  rotate([00,00,45])      cylinder(Roof_height,width1/2+6,00,$fn=4);
          
}
if(width2 < width1)
          { 
   translate([0,0,thickness])  rotate([00,00,45])      cylinder(Roof_height,width2/2+6,00,$fn=4);
 }
    if(Hook == 1) 
     {
    translate([0,0,Roof_height+4])  rotate([00,90,0]) {
         rotate_extrude(convexity = 6, $fn = 100)
translate([7, 0, 0])
circle(r = 2.5, $fn = 100);}
              
}
  }     
 
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true );
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100 );
  
           
          if(width1 <= width2)
          { 
   translate([0,0,0])  rotate([00,00,45])      cylinder(Roof_height,width1/2+5,00,$fn=4);
          
}
if(width2 < width1)
          { 
   translate([0,0,0])  rotate([00,00,45])      cylinder(Roof_height,width2/2+5,00,$fn=4);
          
}
  
  }
}
}

//Roof_height = 30; 

// Cut out on botton part if you have in bottom part
// Hook = 0; //[0:no, 1:yes]
// cylinder(20,20,00,$fn=4);
 
 if(Part == 9)  // lamp_holder_bottom
  { 
   translate([0,0,-thickness]) {    
    difference(){
      union(){   
  cylinder(r=(Lamp_cut_out/2+9),h= (thickness), $fn = 100);
     
 

translate([0,0,0]) cylinder(r=(socket_diameter/2+3),h=thickness+socket_height, $fn = 100);


   }  

translate([0,0,0]) cylinder(r=(socket_diameter/2),h=thickness+socket_height, $fn = 100);
   
   translate([(0),00,socket_height/2+thickness]) rotate([00,90,0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=socket_diameter+10, center= true, $fn = 100 );
   
 translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness, $fn = 100);     
 }
 
 }
}

if(Part == 10)  // lamp_hold_bot_cover
  { 
   translate([0,0,-thickness]) {    
    difference(){
      union(){   
  
       translate([0,0,-9.5])  cylinder(r=(Lamp_cut_out/2+9),h= (2), $fn = 100);
     
 

translate([0,0,-7.5]) cylinder(r=(Lamp_cut_out/2+9),h=7.5, $fn = 100);


   }  

translate([0,0,-7.5]) cylinder(r=(Lamp_cut_out/2+9-1.5),h=7.5, $fn = 100);
  
  translate([Lamp_cut_out/2+9-1.5,0,-5]) rotate([00,90,0]) cylinder(r=(3),h=7.5, $fn = 100);
   
   translate([(0),00,socket_height/2+thickness]) rotate([00,90,0]) cylinder(r=(1.3),h=socket_diameter+10, center= true, $fn = 100 );
   
 translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2, $fn = 100);     
 }
 
 }
 difference(){
      union(){   
   translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(3),h=7.5, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(3),h=7.5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(3),h=7.5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(3),h=7.5, $fn = 100);     
          
}
translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=7.5, $fn = 100);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=7.5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=7.5, $fn = 100);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=7.5, $fn = 100); 
}
 }









//rotate([00,40,-50])                       cylinder(r=2,h=30,center=true);
     //translate([0,0,-10])rotate([00,40,-50])

        //rotate([00,140,-45])  cylinder(r=2,h=25,center=true); 9:lamp_holder_bottom]




echo("height  for Picture 1 h1=", height - Picture_1_height - picture_border_thickness_tolerance - thickness, " and w1=",width1-Picture_1_width-picture_border_thickness_tolerance-24);
echo("height  for Picture 2 h2=", height - Picture_2_height - picture_border_thickness_tolerance - thickness, " and w2=",width2-Picture_2_width-picture_border_thickness_tolerance-24);
echo("height  for Picture 3 h3=", height - Picture_3_height - picture_border_thickness_tolerance - thickness, " and w3=",width1-Picture_3_width-picture_border_thickness_tolerance-24);
echo("height  for Picture 4 h4=", height - Picture_4_height - picture_border_thickness_tolerance - thickness, " and w4=",width2-Picture_4_width-picture_border_thickness_tolerance-24);

echo("height  for Picture  =", (height/2-Picture_1_height/2-thickness ));

//(height/2-Picture_1_height/2-2*picture_border_thickness_tolerance)
   // echo(str("WARNING: " , message, ""));
 //  echo("height to small for Picture 1!!");





///// PART 0 Complett setting


if(Part == 0 )  //PART 0 Complett setting

 
 //if(Part == 1 )        // Bottom
  { 
    
     
      
    difference(){
      union(){        // bottom main part
                     translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,180] ) cube([10, 10, 3]);
          
          
          //Picture side 1
        translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
              
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
          
           translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),thickness])  color("Red") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),(thickness+(height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness))])  color("Green") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
        
         //Picture side 2 
          translate([(width1/2-border_thickness),-(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
          translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness])rotate([00,0,-90]) color("Blue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
   
             translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_2_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
               translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
      
          
          
        //Picture side 3
        
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
  
     
     translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance)+(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
    
 
            translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])  color("Red") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_3_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
       
     
     
       
       
      
       //Picture side 4
      
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-90])color("LightBlue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
   
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_4_height/2-2*picture_border_thickness_tolerance-thickness)]);
  
      
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
         
      
    
    
      }
      
      
      // bottom main part
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
  

      //Picture side 1
          translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness-border_width ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width+1)]);
  
      
      //Picture side 2 
      translate([(width1/2-border_thickness-Picture_2_border_thickness-border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance), (Picture_2_border_width+1)]);
      
        //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance/2 ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width+1)]);
         //Picture side 4


translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width+1)]);




if(Lamp_position == 0)

 {
      cylinder(r=(Lamp_cut_out/2),h= (thickness));
     
     translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3/2),h=thickness);  
     }

   }     
 //}
 
 //if(Part == 2)  // LEG
 //{
   difference(){
      union(){
          
                            translate([-(width1/2),-(width2/2),-thickness])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),(-thickness-3)]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),(-thickness-3)]) rotate([0,0,180] ) cube([10, 10, 3]);
   
          
     translate([-(width1/2 ),-(width2/2),(-thickness-10)]) cube([width1, 2.5, 10]);
     translate([(width1/2),-(width2/2),(-thickness-10)]) rotate([0,0,90] ) cube([width2, 2.5, 10]);
    translate([-(width1/2),(width2/2),(-thickness-10)]) rotate([0,0,-90] )  cube([width1, 2.5, 10]);
   translate([(width1/2 ),(width2/2 ),(-thickness-10)]) rotate([0,0,180] ) cube([width2, 2.5, 10]);       
          
          }
              translate([-(width1/2 ),-(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),(-thickness-3)]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),(-thickness-3)]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
    
          
          
          
          
          
if(Lamp_position == 0)

 {
   translate([0,0,-thickness])   cylinder(r=(Lamp_cut_out/2+9+picture_border_thickness_tolerance),h= (thickness));
     
  //   translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
 //    translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);  
     }

          }
          
  // }
 
 // if(Part == 3)  // Pillar 1
 //{
   difference(){
      union(){
     
              translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness+3])rotate([00,0,90]) cube([10, 10, height-(thickness+3)*2]);
     
                 translate([(width1/2-border_thickness),-(width2/2-12 ),thickness+3]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
                  
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness+3])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
            translate([(width1/2-(width1-Picture_1_width)/2) ,-(width2/2-border_thickness-Picture_1_border_thickness-2*border_width-picture_border_thickness_tolerance ),(height-thickness-3 )]) rotate([0,90,180]) color("Green") cube([(height-2*thickness-6), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
      
    translate([(width1/2-border_thickness) ,(-width2/2+(width2-Picture_2_width)/2),(thickness+3)]) rotate([0,0,90])  color("LightGreen") cube([(Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height-2*thickness-6)]);
         
   
          
          }


        translate([(width1/2-10 ),-(width2/2-2 ),thickness]) rotate([0,0,-45])  cube([15,15,height-(thickness+3),] );
 
          
          translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-(thickness+3)*2])       cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);
          
      translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
        
  
                       
              translate([(width1/2-(width1-Picture_1_width)/2) ,-(width2/2-border_thickness-Picture_1_border_thickness- border_width-picture_border_thickness_tolerance/2),(height-thickness-3)])   rotate([0,90,180]) cube([(height-thickness-3), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width)]);
     
            translate([(width1/2-border_thickness-border_width-picture_border_thickness_tolerance/2) ,(-width2/2+(width2-Picture_2_width)/2),(thickness)]) rotate([0,0,90])  cube([  (Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance),(height)]);
  
      
     
  
          
          }
  //   }
 
 //    if(Part == 4)  // Pillar 2
 //{
      difference(){
      union(){
     
             translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness+3]) rotate([0,0,180] ) cube([10, 10, height-(thickness+3)*2]);
          
            translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness+3])rotate([00,0,-90]) color("LightBlue") cube([(width2/2-Picture_2_width/2-12), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
  
    
    
          translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness ),thickness+3])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
      
                        translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(width2/2-(width2/2-Picture_2_width/2)-Picture_2_border_width),(thickness+3)]) rotate([00,-90,-90])  color("LightGreen") cube([(height-2*(thickness+3)), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
    
      
     
               translate([(width1/2-(width1/2-Picture_3_width/2)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),(thickness+3)]) rotate([00,-90,00]) color("Green") cube([(height-2*(thickness+3)), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
         
    
          
          }
          
              translate([(width1/2-2 ),(width2/2-10 ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2]);
    
            translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);
  
              translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
  
       
        //Picture side 2 
      translate([(width1/2-border_thickness-border_width-picture_border_thickness_tolerance/2-Picture_2_border_thickness) ,(width2/2-(width2/2-Picture_2_width/2)-Picture_2_border_width),(thickness+3)]) rotate([90,-90,-180])  cube([(height-2*(thickness+3)), (Picture_2_border_thickness+picture_border_thickness_tolerance/2), (Picture_2_border_width)]);
  
         
                  
         
          
        //Picture side 3
 translate([(width1/2-(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance ),(thickness+3)]) rotate([00,-90,00])  cube([(height-2*(thickness+3)), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width)]);
          
     
     
     
          }
          
 //         }
          
//   if(Part == 5)  // Pillar 3
 //{
      difference(){
      union(){
   
                           translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness+3]) rotate([0,0,-90] )  cube([10, 10, height-(thickness+3)*2]);
    
               
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness+3]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
   
   
        
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness+3]) rotate([00,00,-90])color("Blue") cube([((width2/2-Picture_4_width/2-12)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
     
    
                 translate([(-width1/2+(width1/2-Picture_3_width/2)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),(height-(thickness+3))]) rotate([00,90,00]) color("LightGreen") cube([(height-2*(thickness+3)), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
        
    
    
               translate([(-width1/2+border_width) ,(width2/2-(width2/2-Picture_4_width/2)),(height-(thickness+3))]) rotate([0,90,-90])  color("Green") cube([(height-2*(thickness+3)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
    
         


       
         
          }
   
            translate([-(width1/2-2 ),(width2/2-10 ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2]); 
     
      
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);

translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);

     
        
                //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2))  ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance ),(height-(thickness+3))]) rotate([00,90,00])  cube([(height-2*(thickness+3)), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width)]);
   
       
        
translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(width2/2-(width2/2-Picture_4_width/2)),(height-(thickness+3))]) rotate([00,90,-90])  cube([(height-2*(thickness+3)), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width)]);
        
       
          
          }
 //  }
   
   
          
 //if(Part == 6)  // Pillar 4
 //{
      difference(){
      union(){
                translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness+3]) cube([10, 10, height-(thickness+3)*2]);
     
                translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness+3]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
             
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness+3])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), height-(thickness+3)*2]);
   
   
           
          
              translate([(-width1/2+(width1/2-Picture_1_width/2)) ,-(width2/2-border_thickness ),(height-(thickness+3))]) rotate([00,90,00]) color("Green") cube([(height-2*(thickness+3)), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
              
               translate([-(width1/2-border_thickness) ,-(width2/2
         -(width2/2-Picture_4_width/2)-(Picture_4_border_width) ),(height-(thickness+3))]) rotate([0,90,-90])  color("Green") cube([(height-2*(thickness+3)), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
    
          
      
        
     
          
          }
     
     
      translate([-(width1/2-2 ),-(width2/2+11.4  ),thickness+3]) rotate([0,0,45])  cube([15,15,height-(thickness+3)*2,] );
     
           translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);    
         translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),height-(thickness+3)*2-20])       cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);
         translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);
         translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),height-(thickness+3)*2-20]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=50,center=true);
   
                       
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
        translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
        translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
        translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=30,center=true);
  
        
              translate([(-width1/2+(width1/2-Picture_1_width/2)) ,-(width2/2-border_thickness-border_width ),(height-(thickness+3))]) rotate([00,90,00]) cube([(height-2*(thickness+3)), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width)]);
    
     
      
          
          
    translate([-(width1/2-border_thickness-border_width) ,-(width2/2-border_thickness
         -(width2/2-Picture_4_width/2)-(Picture_4_border_width) ),(height-thickness-3)])  rotate([0,90,-90])  cube([(height-2*(thickness+3)), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width)]);

 
  
  
           
          
           
          }
 
 // }
 
 //if(Part == 7)  // Top
  //{ 
   translate([(0),(0),height]) rotate([0,180,180]){ 
     
      
    difference(){
      union(){        // Top main part
                     translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
                    translate([-(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),-(width2/2-border_thickness ),thickness]) rotate([0,0,90] ) cube([10, 10, 3]);
                     translate([-(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,-90] )  cube([10, 10, 3]);
                     translate([(width1/2-border_thickness ),(width2/2-border_thickness ),thickness]) rotate([0,0,180] ) cube([10, 10, 3]);
          
          
          
          //Picture side 1
        translate([-(width1/2-border_thickness-10 ),-(width2/2-border_thickness ),thickness]) color("LightBlue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
              
          translate([(width1/2-border_thickness-10 ) ,-(width2/2-border_thickness-(Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_1_width/2-12+Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
          
           translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),thickness])  color("Red") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_1_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_1_border_width)]);
   
        
         //Picture side 2 
          translate([(width1/2-border_thickness),-(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-270])color("LightBlue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
          translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(width2/2-border_thickness-10 ),thickness])rotate([00,0,-90]) color("Blue") cube([(width2/2-Picture_2_width/2-12+Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
    
   
             translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_2_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
               translate([(width1/2-border_thickness-Picture_2_border_thickness-2*border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_2_border_width)]);
      
          
          
        //Picture side 3
        
    translate([-(width1/2-border_thickness-10 ),(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness]) color("LightBlue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
  
     
     translate([(width1/2-border_thickness-10 ) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance)+(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])rotate([00,0,180]) color("Blue") cube([(width1/2-Picture_3_width/2-12+Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
    
 
            translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),thickness])  color("Red") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_3_height/2-2*picture_border_thickness_tolerance-thickness)]);
   
             translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-(Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance) ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])  color("Green") cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_3_border_width)]);
       
     
     
       
       
      
       //Picture side 4
      
           translate([-(width1/2-border_thickness),(width2/2-border_thickness-10 ),thickness]) rotate([00,00,-90])color("LightBlue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
     
       
          translate([-(width1/2-border_thickness-Picture_4_border_thickness-2*border_width-picture_border_thickness_tolerance ) ,(-width2/2+border_thickness+10 ),thickness])rotate([00,0,-270]) color("Blue") cube([(width2/2-Picture_4_width/2-12+Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), 3]);
   
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),thickness]) rotate([00,0,-90]) color("Red") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (height/2-Picture_4_height/2-2*picture_border_thickness_tolerance-thickness)]);
  
      
               translate([(-width1/2+border_thickness) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  color("Green") cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+2*border_width+picture_border_thickness_tolerance), (Picture_4_border_width)]);
      
         
      
    
    
      }
      
      
      // Top main part
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true);
  

      //Picture side 1
          translate([(-width1/2+(width1/2-Picture_1_width/2+Picture_1_border_width)) ,-(width2/2-border_thickness-border_width ),((height/2-Picture_1_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_1_width-2*Picture_1_border_width), (Picture_1_border_thickness+picture_border_thickness_tolerance), (Picture_1_border_width+1)]);
  
      
      //Picture side 2 
      translate([(width1/2-border_thickness-Picture_2_border_thickness-border_width-picture_border_thickness_tolerance) ,(-Picture_2_border_width+Picture_2_width/2),((height/2-Picture_2_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_2_width-2*Picture_2_border_width), (Picture_2_border_thickness+picture_border_thickness_tolerance), (Picture_2_border_width+1)]);
      
        //Picture side 3
 translate([(-width1/2+(width1/2-Picture_3_width/2+Picture_3_border_width)) ,(width2/2-border_thickness-border_width-Picture_3_border_thickness-picture_border_thickness_tolerance/2 ),((height/2-Picture_3_height/2-2*picture_border_thickness_tolerance))])   cube([(Picture_3_width-2*Picture_3_border_width), (Picture_3_border_thickness+picture_border_thickness_tolerance), (Picture_3_border_width+1)]);
         //Picture side 4


translate([(-width1/2+border_thickness+border_width+picture_border_thickness_tolerance/2) ,(-Picture_4_border_width+Picture_4_width/2),((height/2-Picture_4_height/2-2*picture_border_thickness_tolerance))]) rotate([00,0,-90])  cube([(Picture_4_width-2*Picture_4_border_width), (Picture_4_border_thickness+picture_border_thickness_tolerance), (Picture_4_border_width+1)]);



if(Roof == 1)
{
      cylinder(r=(Lamp_cut_out/2),h= (thickness));
}

if(Lamp_position == 1)

 {
      cylinder(r=(Lamp_cut_out/2),h= (thickness));
     
     translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=thickness);  
     }

   }     
 }
//}
 
//if(Part == 8)  // Roof
  //
if(Roof == 1) 
 { 
      translate([(0),(0),height]) {
    difference(){
      union(){   



          translate([-(width1/2),-(width2/2),0])    cube([width1, width2, thickness]);
          
          if(width1 <= width2)
          { 
   translate([0,0,thickness])  rotate([00,00,45])      cylinder(Roof_height,width1/2+6,00,$fn=4);
          
}
if(width2 < width1)
          { 
   translate([0,0,thickness])  rotate([00,00,45])      cylinder(Roof_height,width2/2+6,00,$fn=4);
 }
    if(Hook == 1) 
     {
    translate([0,0,Roof_height+4])  rotate([00,90,0]) {
         rotate_extrude(convexity = 6, $fn = 100)
translate([7, 0, 0])
circle(r = 2.5, $fn = 100);}
              
}
  }     
 
      translate([-(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true );
translate([(width1/2 ),-(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([-(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);
      translate([(width1/2 ),(width2/2 ),thickness]) rotate([0,0,45])  cube(15, center=true);

                
        translate([-(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([(width1/2-border_thickness-6 ),-(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([-(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100);
translate([(width1/2-border_thickness-6 ),(width2/2-border_thickness-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=30,center=true, convexity = 6, $fn = 100 );
  
           
          if(width1 <= width2)
          { 
   translate([0,0,0])  rotate([00,00,45])      cylinder(Roof_height,width1/2+5,00,$fn=4);
          
}
if(width2 < width1)
          { 
   translate([0,0,0])  rotate([00,00,45])      cylinder(Roof_height,width2/2+5,00,$fn=4);
          
}
  
  }
}
//
}


 
 //if(Part == 9)  // lamp_holder_bottom
 // { 
   translate([0,0,-thickness]) {    
    difference(){
      union(){   
  cylinder(r=(Lamp_cut_out/2+9),h= (thickness));
     
 

translate([0,0,0]) cylinder(r=(socket_diameter/2+3),h=thickness+socket_height);


   }  

translate([0,0,0]) cylinder(r=(socket_diameter/2),h=thickness+socket_height);
   
   translate([(0),00,socket_height/2+thickness]) rotate([00,90,0]) cylinder(r=(1.3+picture_border_thickness_tolerance/2),h=socket_diameter+10, center= true );
   
 translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),0]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=thickness);     
 }
 
 }
//}

//if(Part == 10)  // lamp_hold_bot_cover
 // { 
   translate([0,0,-thickness]) {    
    difference(){
      union(){   
  
       translate([0,0,-9.5])  cylinder(r=(Lamp_cut_out/2+9),h= (2));
     
 

translate([0,0,-7.5]) cylinder(r=(Lamp_cut_out/2+9),h=7.5);


   }  

translate([0,0,-7.5]) cylinder(r=(Lamp_cut_out/2+9-1.5),h=7.5);
  
  translate([Lamp_cut_out/2+9-1.5,0,-5]) rotate([00,90,0]) cylinder(r=(3),h=7.5);
   
   translate([(0),00,socket_height/2+thickness]) rotate([00,90,0]) cylinder(r=(1.3),h=socket_diameter+10, center= true );
   
 translate([(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2);
     translate([(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2);
     translate([-(Lamp_cut_out/2-6 ),-(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2);
     translate([-(Lamp_cut_out/2-6 ),(Lamp_cut_out/2-6 ),-9.5]) cylinder(r=(1.5+picture_border_thickness_tolerance/2),h=2);     
 }
 
 }
}




 




