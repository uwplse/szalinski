//Customized customizable Table Clip for having the Ability to 
//Mount Cables on the Frame of a Wanhao Duplicator i3
//Added a second notch to have more grip
//Made additional flat shape 
//Aut0mat3d 2017
//
//Source: http://www.thingiverse.com/thing:165773
//
//CUSTOMIZER VARIABLES
/* [Basic] */
//Round or Flat (1=Flat)
Flat=1;//[0:1]
//Table thickness in /10mm
Table_Thickness=13;//[10:1000]
//Clip Thickness in mm
Clip_Thickness=2;//[2:4]
//Length in mm
Length=25;//[10:50]
//Clip width in mm
Clip_Width=15;//[10:30]
//Max cable diameter in mm
Cable_Diameter=4.5;//[3:20]
//CUSTOMIZER VARIABLES END

$fs=0.2;
if (Flat == 1)
{
    cube ([Clip_Thickness,Length,Clip_Width]);
    translate ([(Table_Thickness/10)+Clip_Thickness+0.5,0,0]) cube ([Clip_Thickness,Length,Clip_Width]);
    cube ([(Table_Thickness/10)+Clip_Thickness*3+Cable_Diameter,Clip_Thickness,Clip_Width]);
    translate ([(Table_Thickness/10)+(Clip_Thickness*2)+Cable_Diameter+0.5,0,0]) cube ([Clip_Thickness,Length,Clip_Width]);
    translate ([Clip_Thickness-0.5,Length-1,0]) cylinder(h=Clip_Width,r=1);
    translate ([Clip_Thickness-0.5,((Length/3)*1),0]) cylinder(h=Clip_Width,r=0.9); //second 
    translate ([(Table_Thickness/10)+Clip_Thickness+1.0,Length-1.5]) cylinder(h=Clip_Width,r=1);
    translate ([((Table_Thickness/10)+Clip_Thickness+1.2),((Length/3)*1)]) cylinder(h=Clip_Width,r=0.9);//second
    //translate ([(Table_Thickness/10)+Clip_Thickness*2.5+Cable_Diameter,Length-(Clip_Thickness*0.7),0]) cylinder(h=Clip_Width,r=Clip_Thickness*0.75);
    translate ([(Table_Thickness/10)+Clip_Thickness*2+0.75+Cable_Diameter,Length-1.2,0]) cylinder(h=Clip_Width,r=1.5);
}

if (Flat == 0)
{
    cube ([Clip_Thickness,Length,Clip_Width]);
    translate ([(Table_Thickness/10)+Clip_Thickness+0.5,0,0]) cube ([Clip_Thickness,Length,Clip_Width]);
    cube ([(Table_Thickness/10)+Clip_Thickness*3+Cable_Diameter,Clip_Thickness,Clip_Width]);
    translate ([Clip_Thickness-0.5,Length-1,0]) cylinder(h=Clip_Width,r=1);
    translate ([Clip_Thickness-0.5,((Length/3)*1),0]) cylinder(h=Clip_Width,r=0.9); //second 
    translate ([(Table_Thickness/10)+Clip_Thickness+1.0,Length-1.5]) cylinder(h=Clip_Width,r=1);
    translate ([((Table_Thickness/10)+Clip_Thickness+1.2),((Length/3)*1)]) cylinder(h=Clip_Width,r=0.9);//second
    translate ([(Table_Thickness/10)+Clip_Thickness*3+Cable_Diameter,Length-Clip_Thickness/2,0]) cylinder(h=Clip_Width,r=Clip_Thickness/2);
    translate ([(Table_Thickness/10)+Clip_Thickness*3+Cable_Diameter,Length/2,0]) difference () {
        cylinder(h=Clip_Width,r=Length/2);
        translate ([0,0,-0.5])cylinder(h=Clip_Width+1,r=Length/2-Clip_Thickness);
        translate ([-Length/2,-Length/2,-0.5]) cube([Length/2,Length,Clip_Width+1]);
        }
    }        
