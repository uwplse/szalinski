////////////Filament adapter///////////
/////reuse your old spoolholders///////
/*author: Rudiger Vanden Driessche
date:17/09/2015


//help for cylindrical arc
//http://forum.openscad.org/How-to-create-an-cylindrical-arc-td11257.html

//license: Creative Commons - Attribution - Share Alike 

*/

/////////////Parameters///////////////////

/*[Roll]*/
roll_Dia=164;//164
roll_Width=98;//98
round_Dia=6.2;//rounding at top add 0.2 mm for tolerance
roll_Angle=5;//angle sidewall inside roll
/*Filament*/
fila_Outsidedia=190;//the outside diameter of the filament roll 
fila_Insidedia=155;//the inside diameter of the filament roll
fila_Dia=3;//the diameter for the holes
number_of_segments=4;// [1:1=no separator,2: 2=1 separator,4:4=3 separators]

/*[Holder]*/
sector_Angle=5; //(degrees to extrude)
holder_Thickness=5;
holder_sparedia=10;//this diameter is added to the filament Outside diameter to prevent filament to fall of

/*[Clip]*/
Clip_Brim=0.4;//clip mm to lock (minus the tolerance mm given at the round_Dia)
Clip_Lenght=10;//lenght clip

/*[Mouse Ears]*/
mouse_ear_diameter=30;//[30: 30for ABS,0:0 for PLA]
mouse_ear_thickness=0.5;

/*[Hidden]*/
safety=0.1;
holder_Dia=fila_Outsidedia+holder_sparedia;
holderBrimH=(holder_Dia-roll_Dia+round_Dia);
holderBrimW=holder_Thickness*2+round_Dia;
slopespoolW=cos(roll_Angle)*holder_Thickness;
slopespoolH=(roll_Dia-round_Dia-fila_Insidedia+holder_Thickness)/2;
innerspoolW=roll_Width-round_Dia*2-2*slopespoolH*sin(roll_Angle);
innerspoolWoffset=innerspoolW/2+round_Dia/2+slopespoolH*tan(roll_Angle);

//ears
ear_x1=holder_Dia/2; 
ear_y1=0;
ear_x2=holder_Dia/2; 
ear_y2=roll_Width+mouse_ear_diameter/4;
ear_x3=roll_Dia/2-mouse_ear_diameter/2; 
ear_y3=5;
ear_x4=roll_Dia/2-mouse_ear_diameter/2; 
ear_y4=roll_Width;
ear_z=mouse_ear_thickness;
earfn=6;


///////////render///////////////////
translate([-roll_Dia/2,-roll_Width/2-holder_Thickness,0])
spool();

//////////modules///////////////////////

module spool(){
    rotate(270,[1,0,0])
    rotate(-sector_Angle,[0,0,1])

rotate_extrude_angle_size(sector_Angle, 130)
translate([(roll_Dia-round_Dia)/2,0,0])
rotate(a=90,v=[0,0,1])
rotate(a=180,v=[1,0,0]){
   halfspool();
    translate([roll_Width+holder_Thickness*2,0,0])
   rotate(a=180,v=[0,1,0])
    halfspool();
}//end rotate
//mouse ears
mouse_ear (ear_x1, ear_y1, ear_z, mouse_ear_diameter);
mouse_ear (ear_x2, ear_y2, ear_z, mouse_ear_diameter);
mouse_ear (ear_x3, ear_y3, ear_z, mouse_ear_diameter);
mouse_ear (ear_x4, ear_y4, ear_z, mouse_ear_diameter);
}//end module

module partitie(){
    partlen=(holder_Dia-fila_Insidedia+holder_sparedia)/2;
    difference(){
       union() {
    square(size=[holder_Thickness,partlen],center=false);
    translate([holder_Thickness/2,partlen-fila_Dia,0])
            circle(d=10);
            }//end union
            {translate([holder_Thickness/2,partlen-fila_Dia,0])
            circle(d=3);
            }
        }
    
        
        

}//end module



module halfspool(){
    //holder_Thickness+round_Dia/2,roll_Dia/2-round_Dia/2
  translate([ holder_Thickness+round_Dia/2,0,0]){ 
union(){
    difference(){
translate([0,(holderBrimH/2+Clip_Lenght)/2-Clip_Lenght,0])
square(size=[holderBrimW,holderBrimH/2+Clip_Lenght],center=true);
    {
    translate([0,0,0])
     circle(d=round_Dia);
    translate([holder_Thickness/2+round_Dia/2,-Clip_Lenght/2,0])
    square(size=[holderBrimW/2+round_Dia-Clip_Brim,Clip_Lenght+safety],center=true);
    }//end minus
}//end difference

//sloped side holder
if (slopespoolH>Clip_Lenght){
translate([slopespoolH*sin(roll_Angle)+round_Dia/2,-slopespoolH*cos(roll_Angle),0])
    rotate(a=roll_Angle,v=[0,0,1])
square(size=[slopespoolW,slopespoolH],center=false);}
else{
translate([Clip_Lenght*sin(roll_Angle)+round_Dia/2,-Clip_Lenght*cos(roll_Angle),0])
    rotate(a=roll_Angle,v=[0,0,1])
square(size=[slopespoolW,Clip_Lenght],center=false);}


//filamentinnerspool
translate([innerspoolW/4+slopespoolH*sin(roll_Angle)+round_Dia/2,-slopespoolH*cos(roll_Angle)+holder_Thickness/2,0]){

square(size=[innerspoolW/2+safety,holder_Thickness],center=true);

}//end translate

}//end union
}//end translate


//partities
partOffset=innerspoolW/4+slopespoolH*sin(roll_Angle)+round_Dia+holder_Thickness;
if(number_of_segments==2){
translate([roll_Width/2+holder_Thickness/2,-slopespoolH*cos(roll_Angle),0])
 partitie();

}//end if 
if(number_of_segments==4){
translate([partOffset,-slopespoolH*cos(roll_Angle),0])
 partitie(); 
translate([roll_Width/2+holder_Thickness/2,-slopespoolH*cos(roll_Angle),0])
 partitie();
}//end if 
}//end module




module rotate_extrude_angle_size(angle, size) {
  module pie(a) {
    r=sqrt(2);
    hull() polyhedron(points=[[0,0,-r], [r,0,-r], [r*cos(a),r*sin(a),-r],[0,0,r], [r,0,r], [r*cos(a),r*sin(a),r]], faces=[[0,1,2,3,4,5]]);
  }//end hull

  intersection() {
    scale(size) {
      pie(angle);
  }//end scale
    rotate_extrude(convexity=10,slices = 100,$fn = 100) children();
  }//end intersection
}//end module



	


module mouse_ear (ear_x,ear_y,ear_z, ear_d){
    
	translate([ear_x, ear_y,0])
    cylinder(r=ear_d/2, h=ear_z, centre=true,$fn=earfn);


}