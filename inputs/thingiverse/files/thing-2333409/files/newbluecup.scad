 /*This is a redesign of my older thing (https://www.thingiverse.com/thing:468085), wich was inspired by the Original Bluebowl Goldconcentrator
Daniel Spielmann, May 2017
 */ 
use <write/Write.scad>
use <utils/build_plate.scad>
use <Write.scad>


// Outer diameter of bowl
outerdiameter = 150;
// Hight of the bowl
bowlhight = 70;    
// Bowl wall thickness
thick = 1.8;     
// Roundness $fn 
roundness =  80;   
// Conehight
conehight = 42;
// Conebottomdiameter Addition
conebottomdiameter = 16;
// Liphight
liphight = 0.3;  
// Liprim
Liprimdiameter = 0.6;  
// Adaptersize hosediameter
adaptersize = 16.2;
// Adapterlength
adapterlength = -15;
// Adapteroffset
adapteroffset = 6;
// Adapterhole
adapterhole = 12;
// Additional Wall Thickness
adapterwall = 1;
// Bottomconehight
bottomconehight =1.5;
// Flatbottomdistance
flatbottomdistance = 10;
// Steptop
step = 25;
// Centerholediameter
centerholediameter = 28; 
// Name
urtext = "DANNI";

urtext_height = 20; //[4:32]

//urfont= "orbitron"; //["Letters","BlackRose","orbitron","knewave","braille"] 

/* [Hidden] */ 
adapterpos = conehight-liphight-Liprimdiameter-adapteroffset; // Adapterposition
conediameter = centerholediameter+(thick);  


//urfont_dxf = str("write/",urfont,".dxf");

difference(){
 
 union(){   
    bowl();
    hoseadapter(); 
    cone();    
     
 
 
     
     
     
     
 } 
   center();
 
               
                          rotate([0,0,180]) {
                               translate([0,0,bowlhight/2])                   
                        writecylinder(text=urtext,h=urtext_height, t=(thick/3),where=[0,0,0], radius=(outerdiameter/2), font = "orbitron.dxf");
                              
                          } 
  
    
 
    }//diff
    
    
    


module bowl(){
      difference(){ 
            union(){ 
                          difference(){
                                    //wall
                    cylinder(  h=(bowlhight),d=(outerdiameter), $fn = roundness*1.5);
                    translate([0,0,-1])   
                    cylinder(  h=(bowlhight)+2,d=(outerdiameter-(2*thick)), $fn = roundness*1.5);

                                    } //wall             
                    bottomcone();        
                    cylinder(  h=(thick),d=(outerdiameter), $fn = roundness);                  
                                                                            
                        }//union
 
                    adapterhole(); 
                 
                        translate([0,0,thick]) 
                        writesphere(text="SPILIS Concentrator ", t=0.4,where=[0,0,thick/2], radius=(outerdiameter/2), font = "orbitron.dxf", west=20);
                                    
                                    
                    } 
} //modul
module hoseadapter(){
              difference(){   
        rotate([90,0,0]) {
              difference(){ 
    translate([(outerdiameter/2)-(adaptersize/2)-thick-adapterwall,adapterpos,0])
 cylinder(  h=((outerdiameter/2)+thick+adapterlength),d=adaptersize +thick+adapterwall, $fn = roundness);
            
    translate([(outerdiameter/2)-(adaptersize/2)-thick-adapterwall,adapterpos,0])            
  cylinder(  h=((outerdiameter/2)+(2*thick)+adapterlength),d=adaptersize, $fn = roundness);    
        }//diff
        }//rot
    cylinder(  h=(bowlhight)+2,d=(outerdiameter-(2*thick)), $fn = 100);
    }
}  //modul
  
module adapterhole(){
    
        rotate([90,0,0]) {
         
    translate([(outerdiameter/2)-(adaptersize/2)-thick-adapterwall,adapterpos,0])            
  cylinder(  h=((outerdiameter/2)+(2*thick)+adapterlength),d=adapterhole, $fn = roundness);
 
        }//rot

}  //modul
   

module center(){
    translate([0,0,-(2*thick)]) 
 cylinder(  h=(bowlhight)+(2*thick),d1=(centerholediameter),d2=(centerholediameter), $fn = roundness);
    

}//modul

module bottomcone(){
   
    translate([0,0,+thick])        
 cylinder(  h=(bottomconehight),d1=(outerdiameter)-(flatbottomdistance*2),d2=(centerholediameter)+(2*thick)+(2*step), $fn = roundness);

}//modul

module cone(){ 
    union(){
                    
                    translate([0,0,0])   
                    cylinder(  h=(conehight),d1=(conediameter+(2*conebottomdiameter)),d2=(conediameter), $fn = roundness);

                      
                    translate([0,0,conehight])   
                    cylinder(  h=(liphight),d=(conediameter), $fn = roundness);
    }

    rotate_extrude(angle = 360, $fn = roundness ) { 
    translate([conediameter/2,conehight+liphight,0]) 
    rotate([0,0,0]) { 
    circle($fn = roundness, r = Liprimdiameter);
      } //rot
  } //rotextr  
}//modul

