///////////////////////////////////////////
/// OpenSCAD File by Ken_Applications /////
///////////////////////////////////////////

///The 4 Main Parameters below////////
///are for you to experiment with. ///
/////////// Enjoy ////////////////////

Slide_length = 60    ;
Slide_width = 30     ;
clearance = 0.1      ;//Clearance gap between parts... 0.1 default, 
carriage_length= 20   ;

////////////////////////////////////
//Viewing Parameters
$fn = 100    ;// Number of facets
View_parts = 4   ;//////.. 1=View Rail  2=View carriage 3= carriage for printing 4=assembly

////////////////////////////////////









/////..Below Calculations ..////
Slide_height=Slide_width/4;// the slide height is fixed at 1/4 of width
r=Slide_width*0.018;//ratio for size of radius
podfcl=Slide_width*0.22;//position of dovtail from center line
rfbt=(Slide_width/4)*0.3333333;//ratio for base thickness
bcr=Slide_width*0.1625;//blue circle radius


if (View_parts ==1) base_rail_extruded ();
if (View_parts ==2)move_carriage ();
if (View_parts ==3)print_carriage();
if (View_parts ==4)base_rail_extruded ();
if (View_parts ==4) move_carriage ();
   
///////////////////////////////////////////
/////// The Module's used /////////////////
module left_hand_rail(){
difference(){
    rotate(a=-60, v=[0,0,1])
    square([Slide_height*3,Slide_width*0.15],center=true);
    translate([0,(Slide_height*1.5)-r,0]) square([Slide_width,Slide_height*2],center=true);
    translate([0,-(Slide_height*1.5)+r,0]) square([Slide_width,Slide_height*2],center=true);
     }
}



module left_and_right_hand_rail(){
mirror(v= [0, 1, 0] ) { 
translate([podfcl,0,0]) offset(r=r) left_hand_rail();
}
 
translate([-podfcl,0,0]) offset(r=r) left_hand_rail();
}

module base_rail_without_recess(){
 union(){   
square([Slide_width/2,Slide_width/8],true);
 left_and_right_hand_rail(); 
   translate([0,-rfbt,0])  square([Slide_width,Slide_height/3],center=true);
 
 }  
}

module base_rail(){
 difference(){
  base_rail_without_recess();
   translate([0,Slide_width*.126,0])  circle(bcr);
   translate([-Slide_width*0.314,-Slide_width*0.039,0]) rotate(a=45, v=[0,0,1]) square(r*1.4,true);
 translate([Slide_width*0.314,-Slide_width*0.039,0]) rotate(a=45, v=[0,0,1]) square(r*1.4,true);
 }   
    
}


module add_bit (){
    difference(){
    translate([0,Slide_height-rfbt*2,0])  square([Slide_width,Slide_height],center=true); 
    translate([0,Slide_height-clearance-rfbt*2,0]) color("green") square([Slide_width-clearance*3,Slide_height-clearance],center=true);
    } 
}

module top_rail(){
   
  offset(r=-clearance)  
      difference(){
      translate([0,Slide_height-rfbt*2,0])square([Slide_width,Slide_height],center=true); 
      base_rail_without_recess();
    }

  union()
    add_bit();
    
    //fill in bottom gap
    translate([-Slide_width*0.492,-Slide_height*0.166,0]) square([Slide_width*0.165,clearance+0.2],false);
    translate([Slide_width*0.322,-Slide_height*0.166,0]) square([Slide_width*0.165,clearance+0.2],false);
    
 
 }
 
module top_rail_chamfered (){
 difference(){
    top_rail(); 
     
   //draw the chamfer squares
   translate([-Slide_width*0.314,-Slide_width*0.049,0]) rotate(a=45, v=[0,0,1]) square(r*2.6,true);
   translate([Slide_width*0.314,-Slide_width*0.049,0]) rotate(a=45, v=[0,0,1]) square(r*2.6,true);
   translate([-Slide_width*0.5,Slide_width*0.22,0]) rotate(a=45, v=[0,0,1]) square(r*2.6,true);
   translate([Slide_width*0.5,Slide_width*0.22,0]) rotate(a=45, v=[0,0,1]) square(r*2.6,true);
 
 }
 }
 
module base_rail_extruded (){   
translate([0,0,Slide_height/2]) rotate(a=90,v=[1,0,0])linear_extrude(0,0,Slide_length) base_rail();
}
 
module move_carriage (){
   color("Green")translate([0,-0,Slide_height/2]) rotate(a=90,v=[1,0,0])linear_extrude(0,0,carriage_length) top_rail_chamfered();
  }
 
  
 
  
module print_carriage(){
   
 rotate(a=180,v=[0,1,0]) translate([Slide_width+rfbt,0,-rfbt-Slide_height])  move_carriage(); 
   
 } 
 
 
 




//Animate_carriage=1; // 1=Animate  0= No Animation
//if (Animate_carriage==1) translate([0,$t*-Slide_length*1.1,0]) move_carriage();
//if (Animate_carriage==0) move_carriage(); 
 
 






















