//Stem Adapter for Cuisinart AFP-7
// 2017 / Ryan Stachurski / http://stachurski.us/


//----------------------Variables of your choice----------------------------------------

//Length from bottom of part up to the bottom of the middle flange
lower_Shaft_Height = 20;      //not sure where to measure for this exactly...

//Radius of the lower part of the shaft
lower_Shaft_Radius = 9;       //guessing (formerly extending same radius upward)

//Width of the void in the lower shaft
lower_Shaft_Void_1 = 11;     //edge length of square1 cross section void

//Width of the void in the lower shaft (rotated 45 degrees)
lower_Shaft_Void_2 = 12;     //edge length of square2

//Height of the flange in the middle of the part
mid_Flange_Height = 3;        //guessing here...

//Radius of the flange in the middle of the part
mid_Flange_Radius = 10.2;     //same as radius on slicing tool collar 

//Length from the top of the middle flange to the top of the part
upper_Shaft_Height = 37;      //length of collar on slicing tool

//Width of the void in the upper shaft
upper_Shaft_Void_1 = 13.5;     //edge length of square1 cross section void in slicing collar 

//Width of the void in the upper shaft (rotated 45 degrees)
upper_Shaft_Void_2 = 15;       //edge length of square2

//Length from the bottom of the part to top of the void inside the part (except the pin hole)
void_Height = 50;            //length of big void inside part except for the pin 

//Radius of the safety pin hole in top of the part 
pin_Radius = 3;



//***************************************************************** NEW ********************
module lowerShaft(){
  difference(){
      
      union(){
          upperShaft();
          midFlange();
          cylinder(lower_Shaft_Height, lower_Shaft_Radius, lower_Shaft_Radius, $fn=300);   
          
      } //end union
      
      intersection(){
          translate([-lower_Shaft_Void_1 / 2, -lower_Shaft_Void_1 / 2, 0])
            cube([lower_Shaft_Void_1,lower_Shaft_Void_1,void_Height]);
      
          rotate([0,0,45])
            translate([-lower_Shaft_Void_2 / 2, -lower_Shaft_Void_2 / 2, 0])
                cube([lower_Shaft_Void_2,lower_Shaft_Void_2,void_Height]);
      } //end lowerShaftVoid intersection
    
      cylinder(lower_Shaft_Height+mid_Flange_Height+upper_Shaft_Height, pin_Radius, pin_Radius, $fn=300);
          
  } //end difference
} //end lowerShaft

module midFlange(){
  
  translate([0,0,lower_Shaft_Height])  
        cylinder(mid_Flange_Height, mid_Flange_Radius, mid_Flange_Radius, $fn=300);
    
} //end midFlange

module upperShaft(){

      intersection(){
          translate([-upper_Shaft_Void_1 / 2, -upper_Shaft_Void_1 / 2, lower_Shaft_Height+mid_Flange_Height])
            cube([upper_Shaft_Void_1,upper_Shaft_Void_1,upper_Shaft_Height]);
      
          rotate([0,0,45])
            translate([-upper_Shaft_Void_2 / 2, -upper_Shaft_Void_2 / 2, lower_Shaft_Height+mid_Flange_Height])
                cube([upper_Shaft_Void_2,upper_Shaft_Void_2,upper_Shaft_Height]);
      } //end lowerShaftVoid intersection
    
    
} //end upperFlange

//Draw the Lower Shaft
lowerShaft();

//Draw the Mid Flange
//midFlange();              //This module was relocated inside the lowerShaft() module to facilitate cutting the center of the part

//Draw the Upper Shaft
//upperShaft();             //This module was relocated inside the lowerShaft() module to facilitate cutting the center of the part



