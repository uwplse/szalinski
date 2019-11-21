//Version 1.01
// preview[view:west, tilt:top]
/* [Renderoptions] */
//Quality
Renderquality = 20;
//Render lid
Lid = "off"; //[on:Render Lid on,off:Do not Render lid]
//Text invert
Txt = "side"; //[up:Text standing out,down:Text inverted, side:Text on side]
//Text on side


/* [Parameters] */
//Boxlength
l1= 70;    
//Boxwidth
w1= 50;     
//Boxheight
h1= 20;     
//øholes
d1= 7.5;    
//Holesdepth
h2 = 10;     
//Lidheight
h3 = 7;     
//Distance from Boxcenter to holecenter
holedistance1=17;  
//Distance between holes
betweenholes= 11;   
//Edgewidth
Edge= 6;            
//Cornerradius
Radius= 2;       
//Proportion Standoff to Boxwidth 1/x
Proportion  =2; //[1:0.1:2.4]      
//Distance between upper edge of Box and Nozzle Standoff
standoffdiff = 9;

/* [Text] */
//Textfont might be added in later Version


//Textsize
Textsize= 5.5;
//Vertical from Boxcenter to Text
textshift1 = 3;
//Horizonzal from Boxcenter to Text
textshift2 = 0.5;
//Horizontal for Text on side if enabled
textshift3 = 1;
//Textheight
Texth = 0.5;
//Text
Text1= " .25";  
Text2= " .3";
Text3= " .35";
Text4= " .4";
Text5= ".6";
Text6= ".8";



/* [Hidden] */
Bohrungsabstand1= holedistance1;
Rand= Edge;
Absatzteil = Proportion;
//textfont = "Rockwell:style=Bold";
textfont= "Tahoma:style=Bold";

//Render
color("green")
 if (Lid=="on"){
difference(){
Deckel();
Ecken3();}
Ecken2();
}

 if (Txt== "up"){
 union(){
 color("yellow")
union(){
unterteil();
Absatz();}
 color("blue")
 
 color("red")
 Beschr2();}
 }else if(Txt== "down"){
 difference(){
 color("yellow")
union(){
unterteil();
Absatz();}
 color("blue")
 bohrungen();
 color("red")
 Beschr3();}}
if (Txt== "side"){
difference(){
union(){
unterteil();
Absatz();}
Beschr();
}
}
//Modules 
module unterteil(){
    difference(){
base();
innen();
Ecken();

;
}   
}
module base(){
color("green")
translate([0,0,h1/2]){
  cube([w1,l1,h1], center= true); 
}
}

module innen(){

color("red")
    translate ([0,0,h1/2+h1/5]){
    cube([w1-Rand/2,l1-Rand/2,h1], center = true);
    }
    
}

module Ecken(){
    
    translate([-w1/2+Radius/2,l1/2-Radius/2,0])
    rotate([0,0,90])
    Eckenradius();
    
    translate([w1/2-Radius/2,l1/2-Radius/2,0])
        rotate([0,0,0])
    Eckenradius();
    
    translate([-w1/2+Radius/2,-l1/2+Radius/2,0])
        rotate([0,0,-180])
    Eckenradius();
    
    translate([w1/2-Radius/2,-l1/2+Radius/2,0])
        rotate([0,0,-90])
    Eckenradius();
}



module Eckenradius(){
    translate([-Radius/2,-Radius/2,-1])
    difference(){
        cube([Radius+0.2,Radius+0.1,h1+2]);
        translate([0,0,-0.5])
        cylinder( h1+3, r=Radius, $fn=25);}
}
module Absatz(){
difference(){
  translate([w1/2-w1/2/Absatzteil,0,h1/2]){
  cube([w1/Absatzteil-Rand/2,l1-2,h1-standoffdiff], center= true);} 
bohrungen();}
}

module bohrungen(){
    
    translate ([Bohrungsabstand1,-d1+l1/2,0])
    bohrung();
    translate ([Bohrungsabstand1,-d1+l1/2-betweenholes,0])
    bohrung();
    translate ([Bohrungsabstand1,-d1+l1/2-betweenholes*2,0])
    bohrung();
    translate ([Bohrungsabstand1,-d1+l1/2-betweenholes*3,0])
    bohrung();
    translate ([Bohrungsabstand1,-d1+l1/2-betweenholes*4,0])
    bohrung();
    translate ([Bohrungsabstand1,-d1+l1/2-betweenholes*5,0])
    bohrung();
}
module bohrung(){
   
    translate([0,0,h2/2+h1-5/2-h2+0.5])
    cylinder(h2,d1/2,d1/2,center=true,$fn= Renderquality);
    
}

  module Beschr(){
      
      rotate([0,-90,180]){
      translate([textshift3,textshift2,0.1+(w1/2-Texth)])
    
    linear_extrude(Texth){
        
    translate([textshift1,5*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text1), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,3*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text2), size = Textsize, font = textfont, halign= "center"); translate([textshift1,betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text3), size = Textsize, font = textfont, halign= "center");   
    translate([textshift1,-betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text4), size = Textsize, font = textfont, halign= "center"); 
    translate([textshift1,-1.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text5), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,-2.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text6), size = Textsize, font = textfont, halign= "center"); 
    }
}}
module Beschr2(){
    translate([2,textshift2,h1-3])
    
    linear_extrude(Texth){
        
    translate([textshift1,5*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text1), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,3*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text2), size = Textsize, font = textfont, halign= "center"); translate([textshift1,betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text3), size = Textsize, font = textfont, halign= "center");   
    translate([textshift1,-betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text4), size = Textsize, font = textfont, halign= "center"); 
    translate([textshift1,-1.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text5), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,-2.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text6), size = Textsize, font = textfont, halign= "center"); 
    }
}
module Beschr3(){
    translate([2,textshift2,h1-3])
    
    linear_extrude(Texth*3){
        
    translate([textshift1,5*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text1), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,3*betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text2), size = Textsize, font = textfont, halign= "center"); translate([textshift1,betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text3), size = Textsize, font = textfont, halign= "center");   
    translate([textshift1,-betweenholes/2,0])
        rotate([0,0,-90])
        text(str(Text4), size = Textsize, font = textfont, halign= "center"); 
    translate([textshift1,-1.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text5), size = Textsize, font = textfont, halign= "center");
    translate([textshift1,-2.5*betweenholes,0])
        rotate([0,0,-90])
        text(str(Text6), size = Textsize, font = textfont, halign= "center"); 
    }
}

module Deckel(){
    difference(){    
    translate ([0,80,h3/2]){
    cube([w1+Rand,l1+Rand,h3], center = true);}
     translate ([0,80,h3/2+Rand/2]){
    cube([w1,l1,h3], center = true);}
    
}
}

module Ecken2(){
    
    translate([-w1/2+Radius/2,80+l1/2-Radius/2,0])
    rotate([0,0,90])
    Eckenradius2();
    
    translate([w1/2-Radius/2,80+l1/2-Radius/2,0])
        rotate([0,0,0])
    Eckenradius2();
    
    translate([-w1/2+Radius/2,80+-l1/2+Radius/2,0])
        rotate([0,0,-180])
    Eckenradius2();
    
    translate([w1/2-Radius/2,80+-l1/2+Radius/2,0])
        rotate([0,0,-90])
    Eckenradius2();
}
module Ecken3(){
    
    translate([-w1/2+Radius/2-Rand/2,80+l1/2-Radius/2+Rand/2,0])
    rotate([0,0,90])
    Eckenradius3();
    
    translate([w1/2-Radius/2+Rand/2,80+l1/2-Radius/2+Rand/2,0])
        rotate([0,0,0])
    Eckenradius3();
    
    translate([-w1/2+Radius/2-Rand/2,80+-l1/2+Radius/2-Rand/2,0])
        rotate([0,0,-180])
    Eckenradius3();
    
    translate([w1/2-Radius/2+Rand/2,80+-l1/2+Radius/2-Rand/2,0])
        rotate([0,0,-90])
    Eckenradius3();
}
module Eckenradius2(){
    translate([-Radius/2,-Radius/2,])
    difference(){
        cube([Radius+0.2,Radius+0.1,h3]);
        translate([0,0,-0.5])
        cylinder( h3+2, r=Radius, $fn=25);    
}}
module Eckenradius3(){
    translate([-Radius/2,-Radius/2,-1])
    difference(){
        cube([Radius+0.2,Radius+0.1,h3+2]);
        translate([0,0,-0.5])
        cylinder( h3+2, r=Radius, $fn=25);    
}}