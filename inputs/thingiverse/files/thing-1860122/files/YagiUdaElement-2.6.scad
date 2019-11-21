/*
 Yet Another Parametric Yagi Uda Element Holder on
 http://www.thingiverse.com/thing:1860122
 by fpetrac
 
 Remix of Customisable Yagi-uda element holde on http://www.thingiverse.com/thing:1858412 by sankaba69 
 
 Licensed under the Creative Commons
  Ver: YagiUdaElement_1.1
  RevLog:
  YagiUdaElement_1.0 first released
  YagiUdaElement_1.1 change screw to bolt varible and modul name; changed the element hole tollerance from 25% to 10%;  in module bolt_hole changed the tollerance of slot form 25% to 10%, best fit on UNI 5737
  YagiUdaElement_2.0 Simplified model chose.
  YagiUdaElement_2.1 improved text definition, change the shape of element
  YagiUdaElement_2.5 added: clamp joined elements.
  YagiUdaElement_2.6 minor update.
*/



/* [EleJoinMode] */
EleJoinMode=0; //[0:through, 1:Simplified, 2:Clamp]

/* [Main body] */
Main_body_lenght=60; // lenght of the part
Main_body_width=60; //width of the part
Main_body_height=30; //heigth of the part

/* [Element options] */
Boom_diameter=20; //boom diameter
//element diameter
Element_diameter=8; //element diameter
//Set to 0 to disable
Element_window_spacing=20; //size of the window from element

/* [bolt options UNI 5737] */
//element bolt hole diameter M size
Element_bolt_hole_diameter=4; //[4,5,6,7,8]
//boom bolt hole diameter M size
bolt_hole_diameter=4; //[4,5,6,7,8] 


/* [Split options] */
Add_split=true; //add split
Split_spacing=1; //split lenght

/* [Text options] */
Your_text= "YAPYH"; //text
//Spacing on text
Text_spacing = 1.2; //[0.7:0.1:1.5]
//Text size incrase of from 0 no text to 14 max size
Text_size = 5; //[0:0.5:14]

/* [Shape] */

//Shape of Boom (number of edge)
Boom_Shape=64; //[3,4,6,8,16,32,64,128]
//Shape of Element (number of edge)
Elem_Shape=64; //[3,4,6,8,16,32,64,128]
$fn=64; //num of polygons

//MAIN
 difference() {
    base(Main_body_lenght,Main_body_width,Main_body_height);
    hole(EleJoinMode);     
      
}
 
module hole(EleJoinMode){ 
//Boom
    translate([Main_body_lenght*1/6,0,0])
      rotate([0,0,45])
        cylinder(Main_body_height+0.1,d=Boom_diameter,center=true, $fn=Boom_Shape); //boom hole
//Element
    rotate([90,0,0]){
      translate([-Main_body_lenght*1/4,0,0]) {
        cylinder(Main_body_width+0.1, d=Element_diameter*1.10, center=true,$fn=Elem_Shape);} //el hole
    }
//Windows
    rotate([90,0,0]){
        translate([-Main_body_lenght*3/8,0,0])
          cube([Main_body_lenght*1/4+2,Main_body_height+2,Element_window_spacing],true); //el window
    }
//Split Windows
    if(Add_split)
      translate([Main_body_lenght*1/6,0,0]) {cube([Split_spacing, Main_body_width+.1, Main_body_height+.1], true);}

//Label
    translate([Main_body_lenght/2-1,0,0]){
      rotate([90,0,90]) {
        linear_extrude(height = 2, center = true, convexity = 10, twist = 0)
          text(Your_text, size=Text_size, font="Liberation Sans:style=Bold",halign="center", valign="center",spacing=Text_spacing );}}
          
//Beem bolt
    if(EleJoinMode==0){
      rotate([0,-90,0]){
        translate([0,Main_body_width*-2/6,-Main_body_lenght*1/4])
          rotate([0,0,-90]) 
            bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght/2,slot=Main_body_width/40,pos=0.6);
         translate([0,Main_body_width*2/6,-Main_body_lenght*1/4])
          rotate([0,0,90]) 
            bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght*1/2,slot=Main_body_width/40); 
        }
     //Element bolt hole
      translate([-Main_body_lenght*1/4,Main_body_width*-2/6]){
        bolt_hole(Element_bolt_hole_diameter,Main_body_height+0.1);} //el bolt hole1
      translate([-Main_body_lenght*1/4,Main_body_width*2/6]){
        bolt_hole(Element_bolt_hole_diameter,Main_body_height+0.1);} //el bolt hole2   
     }
 
    if(EleJoinMode==1){
     rotate([0,-90,0]){
       translate([0,Main_body_width*-2/6,-Main_body_lenght*1/5])rotate([0,0,-90])bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght*3/5,slot=Main_body_width/40);
       translate([0,Main_body_width*2/6,-Main_body_lenght*1/5])rotate([0,0,90])bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght*3/5,slot=Main_body_width/40); 
        }
     }

    if(EleJoinMode==2){
      rotate([0,-90,0]){
        translate([0,Main_body_width*-2/6,-Main_body_lenght*1/4])
          rotate([0,0,-90]) 
            bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght/2,slot=Main_body_width/40,pos=0.6);
         translate([0,Main_body_width*2/6,-Main_body_lenght*1/4])
          rotate([0,0,90]) 
            bolt_hole(x=bolt_hole_diameter,l=Main_body_lenght*1/2,slot=Main_body_width/40); 
        }
      translate([-Main_body_lenght*1/4,Main_body_width*-2/6,-Main_body_height*1/4])
        rotate([0,0,-90])
          bolt_hole(Element_bolt_hole_diameter,Main_body_height/2+0.1,Main_body_width/40,1/10); //el bolt hole1
      translate([-Main_body_lenght*1/4,Main_body_width*2/6,-Main_body_height*1/4])
        rotate([0,0,90])
          bolt_hole(Element_bolt_hole_diameter,Main_body_height/2+0.1,Main_body_width/40,1/10); //el bolt hole2
    }

}

module base(Main_body_lenght,Main_body_width,Main_body_height){
    minkowski(){
        cube([Main_body_lenght-14,Main_body_width-14,Main_body_height],true); 
        cylinder(h=.01,d=14);
        }
}
module bolt_hole(x=4,l=10,slot=0,pos=1/2){
    //from UNI 5737
    S= x==4 ? 7 : x==5? 8 : x==6? 10 :x==7? 11 : x==8? 13: 0;
    A= x==4 ? 3.2 : x==5? 4.0 : x==6? 5.0 :x==7? 5.5 : x==8? 6.5: 0;
    
    tollD=1.10; //diameter tollerance
    tollA=1.50; //hight tollerance
    sixfudge = 1/cos(180/6);
   union(){
    cylinder(l, d=x*tollD, center=true, $fn=64);
    translate([0,0,l/2-A/2])cylinder(l/2, d=x, center=true, $fn=64);//range over the nut 
    translate([0,0,l*pos-A/2]){
        cylinder(tollA*A, r=tollD*sixfudge*S/2, center=true, $fn=6); //nut
        if(slot!=0)
            translate([slot*S,0,0])cube(size = [abs(2*slot*S),tollD*S,A*tollA], center = true); //nut slot
    }
    translate([-0,0,-l/2])cylinder(0.5*A, r=tollD*sixfudge*S/2, center=true, $fn=64);//site of the bolt head
  }
    
}

//bolt_hole(8,55,1);