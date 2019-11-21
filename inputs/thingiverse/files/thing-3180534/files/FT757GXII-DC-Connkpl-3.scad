//FT757GXII DC Connector Housing
Heigth = 20;
Width = 16;
Length = 24;
Length1 = 3.6;
Length2 = 7.6;
Length3 = 10; //14-4
Length4 = 4;

Ro = 2;
slotbotwidth = 4.6;
slotbotheigth = 1.6;
slotmidwidth = 6.8;
slotmidheigth = 3.6;
dscrew = 3;
dscrew1 = dscrew * 0.6;
dscrewhead = 5.2;
hscrewhead = 2.8;//2.2;
dcable = 4.6;
dcable1 = 4.2;
gap=0.6;
module slotbottom()
{
 $fn = 50;
    cube([slotbotwidth,slotbotheigth,Length1]);   
translate([-(slotmidwidth-slotbotwidth)/2,-(slotmidheigth-slotbotheigth)/2,Length1])cube([slotmidwidth,slotmidheigth,Length2+Length3]);
translate([slotbotwidth/2,slotbotheigth/2,Length1+Length2]) cylinder(d=dcable,h=Length3);    
    }
    
module screw()
    {
        translate([Heigth/2-Ro,Width/2-Ro,Length1])cylinder(d=dscrew1,h=Length2+Length3);
    }
module slotsbottom()
{
 translate([1.4,1.6,0]) union(){
slotbottom();
translate([8.45,0,0])slotbottom();   
translate([(slotbotheigth+slotbotwidth)/2,6.14,0])rotate([0,0,90])slotbottom();   
translate([(slotbotheigth+slotbotwidth)/2+8.45,6.14,0]) rotate([0,0,90])slotbottom();
 }   
    }
    
module plug()
{
     $fn=50;
    difference(){
    minkowski()
    {
    cube([Heigth-2*Ro,Width-2*Ro,Length1+Length2+Length3-Ro]);
        cylinder(r=2,h=Ro);
    }
slotsbottom();
screw();
}
}

module cappin()
{
$fn=50;
difference()
    {
 translate([-(slotmidwidth-gap-slotbotwidth)/2,-(slotmidheigth-gap-slotbotheigth)/2,Length4])cube([slotmidwidth-gap,slotmidheigth-gap,Length3-gap]);
 }   
}

module capscrew()
{
  $fn = 50;
    translate([Heigth/2-Ro,Width/2-Ro,0])
    union()
    {
    cylinder(d=dscrew,h=Length4);
    cylinder(d1=dscrewhead, d2=dscrew,h=hscrewhead);
    }
}

module cappins()
{
 translate([1.4,1.6,0]) union(){
cappin();
translate([8.45,0,0])cappin();   
translate([(slotbotheigth+slotbotwidth)/2,6.14,0])rotate([0,0,90])cappin();   
translate([(slotbotheigth+slotbotwidth)/2+8.45,6.14,0]) rotate([0,0,90])cappin();
 }   

}
module caphole()
{
  translate([slotbotwidth/2,slotbotheigth/2,0])
 cylinder(d=dcable1,h=Length3+Length4);     
   
    }

module capholes()
{
  translate([1.4,1.6,0]) union(){
caphole();
translate([8.45,0,0])caphole();   
translate([0,6.14-1.4*gap+slotbotwidth/2,0])caphole();   
translate([8.45,6.14-1.4*gap+slotbotwidth/2,0])caphole();
 }   
   
    }
    
module cap()
{
 $fn=50;
 difference()
 {   
    union(){
    minkowski()
    {
    cube([Heigth-2*Ro,Width-2*Ro,Length4-Ro]);
        cylinder(r=2,h=Ro);
    }
cappins();
}    
capholes();
capscrew();
}
}

//Plug 
translate([-25,0,0])plug();
//cap
cap();
//Cap on top of plug View
//translate ([-25,0,Length1+Length2+Length3+Length4])mirror([0,0,1])cap();