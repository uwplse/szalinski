// Customizable Cup Holder Generator( Parametric)
// by Joao Laurindo, March 2018
// https://www.thingiverse.com/thing:2812261
// Customizable Cup Holder Generator( Parametric) is licenced under Creative Commons :
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// http://creativecommons.org/licenses/by-nc-sa/4.0/

// Local library
//use<Write.scad>

//For Thingiverse
use <write/Write.scad> 
// preview[view:north west, tilt:top diagonal]





$fa=1*1;// 1 while design
$fs=1.5*1;//1.5 while design
//or
//$fn = 50*1;//50 while design


//variaveis globais

//made to hold:
purpose = "Cup"; //[first:Cup,second:Tumbler,both:Bottle]

//Part to Print:
part = "all";//[all:All,cHolder_only:Cup Holder Only,latch_only:Latch Only,text_only:Text Only]


//Cup
holder_thickness = 5;//[3:0.5:50]
diameter_1 = 80;
radius_1 = diameter_1/2;
diameter_2 = 75;
radius_2 = diameter_2/2;
diameter_3 = 40;
radius_3 = diameter_3/2;
diameter_4 = 40;
radius_4 = diameter_4/2;


height_1 = 110;//[5:250]

height_2 = 5;//[5:250]
total_height = height_1 + height_2;

//If you selected Bottle
height_bottom_lid = 5;//[3:0.5:20]


//Trava Transversal
delta = 0.0001*1; // para efeito de cortes e estabilidade sistema, multiplicado por 1 para nao aparecer no customizer

// I suggest larger than 10mm
handle_width = 30;//[5:0.5:100]

handle_thickness = 6;// [5:0.5:30]
handle_distance = 10;//// [10:0.5:100] 

tamTrava = 2*1;    
tamanhoqY = 6*1; // minimo 5mm para descontar 2*offsetDimLT e ser>0.
offsetDimLT = 2*1;
internal_separation_thickness = 2*1;// clearence da garra 
latch_edge_thickness = 10;//[10:0.5:30]

//latch Clearance
latch_clearance = 0.3;//[0.2:0.05:0.4]
scale_factor = (2*(tamTrava+2*offsetDimLT+internal_separation_thickness)+handle_thickness+2*latch_clearance) / (2*(tamTrava+2*offsetDimLT+internal_separation_thickness)+handle_thickness);// calculo da folga


//Holder e Trava
fillet = latch_edge_thickness/2;// para boxHolder, pode travar tb em 4mm por exemplo
espessuraXholder = handle_distance+handle_thickness; 
espessuraYholder = handle_width+latch_edge_thickness; 

/* [Add Text] */
//If you want, put some text here:
text= "Text Here";
type_of_font="knewave.dxf";//[knewave.dxf:Knewave,BlackRose.dxf:Black Rose,orbitron.dxf:Orbitron,Letters.dxf:Letters,braille.dxf:Braille]
//The height(size) of the letters in mm
letter_height = 4;
// The extrude of the letters in mm
letter_thickness = 1;
text_bold=1;//
up_text = 0;//[0:0.5:100]
down_text = 0;//[0:0.5:100]

//-------------------------------------------------------------//
//inicia os trabalhos ;-)
//cupHolder(radius_4,radius_3,radius_2,radius_1,holder_thickness,handle_distance,total_height);


if (part =="all"){
    cupHolder(radius_4,radius_3,radius_2,radius_1,holder_thickness,handle_distance,total_height);
         // quando part == "latch_only"
     translate([-(radius_1+holder_thickness+25),0,total_height])
     rotate([0,180,0])
     latchOnly(handle_thickness,total_height,true);
    
    
    }
    
else if (part == "cHolder_only"){    

cupHolder(radius_4,radius_3,radius_2,radius_1,holder_thickness,handle_distance,total_height);
        }
 
else if (part == "text_only"){    

        textOnly();
    
    }

        
 else{
     // quando part == "latch_only"
     translate([0,0,total_height])
     rotate([0,180,0])
     latchOnly(handle_thickness,total_height,true);
     
     }       


module latchCentered(handle_thickness,AlturaPortaCopo,trava){
      
    deslocX =(tamTrava+2*offsetDimLT+internal_separation_thickness+handle_thickness/2+2*fillet)+(radius_1+holder_thickness-2*fillet);
    deslocY = (latch_edge_thickness+tamanhoqY/2)-(latch_edge_thickness+tamanhoqY+handle_width+2*fillet)/2;
    
    
    translate([deslocX,deslocY,0]) latch(handle_thickness,AlturaPortaCopo,trava);
    
    }

module cupHolder(radius_4,radius_3,radius_2,radius_1,espessuraCil,distAlca,total_height){
    

offsetDim = 4; 
    
raioExterno = espessuraCil + radius_1;


  union(){ 
     if(text!="Text Here"){

        textOnly();
    } 
    difference(){
        difference(){
            union(){
                echo("scale_factor is =",scale_factor);
                scale([scale_factor,scale_factor,1]){// folga do encaixe;
                latchCentered(handle_thickness,total_height,false);
                }
                cylinder(h=total_height,r1=raioExterno,r2=raioExterno);//cilindro externo
                    }


        translate([0,0,height_2])
         if (purpose == "Cup") {
            radius_3 = radius_2;
            radius_4 = radius_2;
            cylinder(h=total_height+delta - height_2,r1=radius_2,r2=radius_1);// cilindro interno para subtrair     
        } else if (purpose == "Bottle") {
            radius_2 = radius_1;
            radius_3 = radius_1;
            radius_4 = radius_1;
            cylinder(h=total_height+delta - height_2,r1=radius_2,r2=radius_1);// cilindro interno para subtrair
        }
            else{
              cylinder(h=total_height+delta - height_2,r1=radius_2,r2=radius_1);// cilindro interno para subtrair
              }  
	            
        
                    }
                    
        if (purpose == "Cup") {
            radius_3 = radius_2;
            radius_4 = radius_2;
            cylinder(h=height_2+delta,r1=radius_4,r2=radius_3); //cilindro tampo de baixo    
        } else if (purpose == "Bottle") {
            radius_2 = radius_1;
            radius_3 = radius_1;
            radius_4 = radius_1;
            cylinder(h=height_2+delta,r1=radius_4,r2=radius_3); //cilindro tampo de baixo
        } else{
               cylinder(h=height_2+delta,r1=radius_4,r2=radius_3); //cilindro tampo de baixo  
        }
                }

   
       if (purpose == "Bottle") {
           
           difference(){
               cylinder(h=height_bottom_lid+delta,r1=raioExterno,r2=raioExterno); //cilindro tampo de baixo 
               cylinder(h=height_bottom_lid+2*delta,r1=raioExterno/5,r2=raioExterno/5); //cilindro tampo de baixo 
               
               
               }
           
            
           
       }     
    
                
    } 

}


module boxHolder(X,Y,qY,distanciaBordaTrava,handle_distance,fillet){
  
boxHolderX = X+handle_distance;
boxHolderY = Y;
            
  translate([-(boxHolderX+2*fillet)/2+handle_thickness/2+handle_distance,(Y/2+fillet)-(distanciaBordaTrava+qY/2),0])          
  linear_extrude(height = total_height)
  offset(r = fillet) {
            square([boxHolderX,boxHolderY],center=true);
                     }    
}



module latch(handle_thickness,AlturaPortaCopo,trava){
    
larguraX = 2*(tamTrava+2*offsetDimLT+internal_separation_thickness)+handle_thickness;
larguraY = latch_edge_thickness+tamanhoqY+handle_width;    

difference(){
    // chama modulo para box
    boxHolder(larguraX,larguraY,tamanhoqY,latch_edge_thickness,handle_distance,fillet);
    
  
        union(){
            difference(){
                linear_extrude(height = AlturaPortaCopo){
                offset(r = offsetDimLT) {
                        
                    union(){    
                        square([larguraX-2*offsetDimLT,tamanhoqY-2*offsetDimLT],center=true);
                        
                        translate([(larguraX)/2 - (tamTrava/2+offsetDimLT),0,0])
                        square([tamTrava,tamanhoqY+2*tamTrava], center = true); 
                        
                        translate([-(larguraX)/2 +(tamTrava/2+offsetDimLT),0,0])
                        square([tamTrava,tamanhoqY+2*tamTrava], center = true);             
                           }            
                                        }
                                                        }
        
                        linear_extrude(height = AlturaPortaCopo/10){
                            offset(r = offsetDimLT) {
                            union(){    
                                square([larguraX-2*offsetDimLT,tamanhoqY-2*offsetDimLT],center=true);
                                
                                translate([(larguraX)/2 - (tamTrava/2+offsetDimLT),0,0])
                                square([tamTrava,tamanhoqY+2*tamTrava], center = true); 
                        
                                translate([-(larguraX)/2 +(tamTrava/2+offsetDimLT),0,0])
                                square([tamTrava,tamanhoqY+2*tamTrava], center = true);             
                                   }            
                                                    }
                                                   }
        
                        }
         
            if(!trava){    
                // Para tamanho Alca
                    linear_extrude(height = AlturaPortaCopo){
                        offset(r = offsetDimLT) {
                        translate([0,+(handle_width+offsetDimLT)/2,0])        
                        square([handle_thickness-2*offsetDimLT,handle_width],center=true);       
                                                }
                                                            }
                       }
               
                       //Para tamanho Borda
                    linear_extrude(height = AlturaPortaCopo){
                        translate([0,-(latch_edge_thickness+tamanhoqY)/2+tamanhoqY/2,0])        
                        square([handle_thickness,latch_edge_thickness+tamanhoqY],center=true);       
                    
                                                            }
                
                
               
                }       
             }
         
    
}

module textOnly(){
                color("red")
            writecylinder(text,[0,0,0],holder_thickness+radius_1,total_height,face="front", font=type_of_font,t=letter_thickness,h=letter_height,bold=text_bold,west=90,up=up_text,down=down_text);
    
    
    
    }


//apenas o latch
module latchOnly(handle_thickness,AlturaPortaCopo,trava){

larguraX = 2*(tamTrava+2*offsetDimLT+internal_separation_thickness)+handle_thickness;
larguraY = latch_edge_thickness+tamanhoqY+handle_width;    

union(){
            difference(){
                linear_extrude(height = AlturaPortaCopo){
                offset(r = offsetDimLT) {
                        
                    union(){    
                        square([larguraX-2*offsetDimLT,tamanhoqY-2*offsetDimLT],center=true);
                        
                        translate([(larguraX)/2 - (tamTrava/2+offsetDimLT),0,0])
                        square([tamTrava,tamanhoqY+2*tamTrava], center = true); 
                        
                        translate([-(larguraX)/2 +(tamTrava/2+offsetDimLT),0,0])
                        square([tamTrava,tamanhoqY+2*tamTrava], center = true);             
                           }            
                                        }
                                                        }
        
                        linear_extrude(height = AlturaPortaCopo/10){
                            offset(r = offsetDimLT) {
                            union(){    
                                square([larguraX-2*offsetDimLT,tamanhoqY-2*offsetDimLT],center=true);
                                
                                translate([(larguraX)/2 - (tamTrava/2+offsetDimLT),0,0])
                                square([tamTrava,tamanhoqY+2*tamTrava], center = true); 
                        
                                translate([-(larguraX)/2 +(tamTrava/2+offsetDimLT),0,0])
                                square([tamTrava,tamanhoqY+2*tamTrava], center = true);             
                                   }            
                                                    }
                                                   }
        
                        }
         
            if(!trava){    
                // Para tamanho Alca
                    linear_extrude(height = AlturaPortaCopo){
                        offset(r = offsetDimLT) {
                        translate([0,+(handle_width+offsetDimLT)/2,0])        
                        square([handle_thickness-2*offsetDimLT,handle_width],center=true);       
                                                }
                                                            }
                       }
               
                       //Para tamanho Borda
                    linear_extrude(height = AlturaPortaCopo){
                        translate([0,-(latch_edge_thickness+tamanhoqY)/2+tamanhoqY/2,0])        
                        square([handle_thickness,latch_edge_thickness+tamanhoqY],center=true);       
                    
                                                            }
                
                
               
                }       
            }
        
