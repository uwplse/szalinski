/*
    Textbox
    variable_name = value;
    Dropdown box
    Numbers
    variable_name = value; // [0,1,2,3,4]
    Text
    variable_name = value; // [yes,no]
    Labeled value
    variable_name = value; // [10:S,20:M,30:L]
    Slider or range
    max only (min is zero)
    variable_name = value; // [40]
    min and max
    variable_name = value; // [1:10]
    min, step, max
    variable_name = value; // [1:0.5:10]
*/

//width of shifter  
width=125;
//diameter of shifter  
diameter=20;
//height of shifter  
height=150;
//shifter thread size  [3/8"=9.525   7/16"=11.1125  1/2"=12.7    9/16"=14.2875 ] 
hole=7.9375;



difference(){
    union(){
        
     translate([0,width/7,height/2]){
           rotate(a=90, v=[1,0,0] , $fn=50){
           cylinder(width,diameter,diameter, center=true);}
           } 
           
           translate([0,0,0]){
           rotate(a=90, v=[0,0,1] , $fn=50){
           cylinder(height,2*hole,2*hole, center=true);}
           } 
           
   
       }         
    
    union(){ 
        
          translate([0,0,-height/2]){
           rotate(a=90, v=[0,0,1] , $fn=50){
           cylinder(height,hole,hole,       center=true);}
           } 
           
           translate([0,width/4,height/3]){
           rotate(a=90, v=[0,1,0] , $fn=50){
           cylinder(height,1.5*hole,1.5*hole, center=true);}
           } 
            
           translate([0,width/2,height/3]){
           rotate(a=90, v=[0,1,0] , $fn=50){
           cylinder(height,1.5*hole,1.5*hole, center=true);}
           } 
           
           translate([0,width/2.75,height/3]){
           rotate(a=90, v=[0,1,0] , $fn=50){
           cylinder(height,2*hole,2*hole, center=true);}
           } 
           
           translate([0,-width/4,height/3]){
           rotate(a=90, v=[0,1,0] , $fn=50){
           cylinder(height,1.5*hole,1.5*hole, center=true);}
           } 
    }
  }
   