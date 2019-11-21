
/*Customizer Variables*/
//phone width
width=82; //[10:150]
//phone height
heightFromBootm=155; //[50:250]
//height of bottom sides
holderHeight=55; //[10:100]

// fingers width channel
fingerSize=12; //[5:20]
// wall width
wall=1; //[0.2:0.2:2]
margine=4; //[0.5:0.5:10]
depth=8; //[2:20]

fingerHold=1; //[0:No,1:Yes]

onlyHalf=0; //[0:No,1:Yes]

/*[Hidden]*/
$fn=80;

difference()
{
render() base();
translate([margine+fingerSize/2,width/2-fingerSize/2+wall,-wall]) cube([heightFromBootm-2*margine-fingerSize,fingerSize,3*wall]);
if (fingerHold==0) translate([margine,margine+wall,-wall]) cube([holderHeight-2*margine,width/3-margine,3*wall]);    
translate([margine,width-width/3+wall,-wall]) cube([holderHeight-2*margine,width/3-margine,3*wall]);   

translate([margine+fingerSize/2,width/2+wall,-2*wall]) difference() { 
  cylinder(r=fingerSize/2, h=20); 
  translate([25,0,0]) cube(50, center=true); 
} 

translate([heightFromBootm-margine-fingerSize/2,width/2+wall,-2*wall]) difference() { 
  cylinder(r=fingerSize/2, h=20); 
  translate([-25,0,0]) cube(50, center=true); 
} 

if (onlyHalf==1)
translate([-5*wall,width/2+3*wall,-5*wall]) cube([heightFromBootm*1.5,width,depth*2]);

}



module base()
{
cube([holderHeight,width+2*wall,wall]);
translate([0,wall+width/2-margine-fingerSize/2,0]) cube([heightFromBootm-fingerSize/2-margine,fingerSize+2*margine,wall]);
cube([holderHeight,wall,depth]);    
translate([0,width+wall,0]) cube([holderHeight,wall,depth]);
cube([wall,2*wall+width,depth]);

if (onlyHalf==0)    
translate([heightFromBootm-margine-fingerSize/2,width/2+wall,0]) difference() { 
  cylinder(r=(fingerSize+2*margine)/2, h=wall); 
  translate([-25,0,0]) cube(50, center=true); 
} 

    
}