//Parameters
//Diameter of cable (mm)
cablediam = 4.8;
//Length label (part right of the cable without edge, mm) 
lablength = 16;
//Width label (without edge, mm)
labwidth = 8;  
//Overall thicknes of the part (mm)
thickness = 1.2;  
//Text on label (use spaces for aligning)
labeltext = "";  
//Font, correct spelled and with capitals
textfont = "Arial Black"; 
//Text appearance, 0=raised, 1=sunk, 2 = hole 
textappear=0;   


//Modules

module rim()
{
  difference()
  {
    cube([lo,wo,th]);
    translate([wr,wr,-0.5*th])
      cube([li+sp,wi+sp*2, th*2]);
  }
}

module labelplate()
{
  translate([wr+sp+cd+th, wr+sp,0])
    cube([li-cd-th,wi, th]);  
}  

module labeltext()
{
  translate([wr+sp+cd+th*3, wr+sp+wi*(1-sf)/2,0])
    linear_extrude(height = th*1.5)
      text(labeltext, size = wi*sf, font = textfont);
}  

module chull(cdh,wih,tcb)
{
  hull()  
  {
    translate([0,0,-tcb])
      cube([cdh, wih,cdh/2]);   
    translate([cdh/2,wih/2,cdh/2])
      rotate([90,0,0])  
        cylinder(d=cdh, wih, center=true); 
  }
}  

module cablehull()
{
  translate([wr+sp,wr+sp,0])
    difference()
    {
      chull(cd+th*2, wi,0);
      translate([th,-wi/2,th])
        chull(cd,wi*2, th*2);
    }  
}  



//main
//secondary parameters

sp = 0.5;          //space between label and outerrim
wi = labwidth;     //inner length
cd = cablediam;    //cable diameter
th = thickness;    //thickness plate
wr = wi/4;         //width outer rim
wo = labwidth + sp*2 + wr*2; //total width 
li = lablength + cd + th*2;  //inner length
lo = li + sp + wr*2;   //total length  
sf = 0.6;              //factor of wi for textsize
$fn=16;

rim();
if (textappear==0)
{
  labelplate();
  labeltext();
} 
else  
{
  difference()
  {
    labelplate();
    //-0.001 is irritating but for clean preview
    translate([0,0,(2-textappear)*th/2-0.001])  
      labeltext();
  } 
}  
cablehull();






