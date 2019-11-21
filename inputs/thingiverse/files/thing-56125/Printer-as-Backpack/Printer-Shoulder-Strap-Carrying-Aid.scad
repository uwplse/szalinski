/*
2013 Lukas Süss aka mechadense

Printer Shoulder Strap Carrying Aid
or
Printer as Backpack


Tired of carrying your printer with one hand?
Convert your lasercutted wood printer in a backpack.
Screw two of these onto the upper front frame of your printer and add two shoulder straps.

1) Measure your printers upper frontframe dimensions.
2) Print two or four pieces with high infill.
3) screw-mount two of them onto your printers upper front frame
   and optionally two on your printers lower front frame. 
4) Attatch shoulder straps.
5) Take your printer on a stroll.

Note: 
1) The standard parameters are for an ultimaker (top & bottom) and a belt of 24mm width.
2) Some back cushioning might be needed.

*/

$fa=5*1;
$fs=0.25*1;

// edge roundings
b = 2; 
// side edge breakings
b2 = 1.5; 

// length of hook downward portion (how far wood goes down inward)
hback = 4; 
// total hight of printer wood front
hfront = 32;
// main piece wall thickness
t = 5;
// thickness of the wood of your printer
twood = 6; 
// with of your sholderstrap
strapwidth = 24; 

// total piece height
h = strapwidth+2*t;

// diameter of the rounded ends for the straps
dstrapround = 8;
rstrapround=dstrapround/2;

// channel thickness for shoulder strap to go through
tstrapgap = 2;
// diameter of screws
dbore = 3.1; 

hole = false;
f = 0.61803*1;
s = 0*1;
//######################
/* 
twood=6; hback=4; hfront=35; // ultimaker top
twood=6; hback=33; hfront=33; // ultimaker bottom
*/


difference()
{
  hull() // main body
  {
    r2box(b,b,hfront+t,2*t+twood,h-2*b2);
    r2box(b,b,hfront+t-2*b,2*t+twood-2*b,h);
  }
  // slot cut
  translate([t,0,0]) cube([hfront+t,twood,h*1.2],center=true);

  // back cutoff
  translate([t+hback,t,0]) cube([hfront+t,twood+t*2,h*1.2],center=true);

  translate([hfront/2-h/5,0,+(h/2-h/4)]) rotate(90,[1,0,0]) cylinder(r=dbore/2,h=100,center=true);
  translate([hfront/2-h/5,0,-(h/2-h/4)]) rotate(90,[1,0,0]) cylinder(r=dbore/2,h=100,center=true);
  //translate([hfront/2-h/5*2,0,0]) rotate(90,[1,0,0]) cylinder(r=dbore/2,h=100,center=true);
}

  // strap rounding ends
  translate([-(hfront+t)/2+rstrapround +s,-rstrapround-twood/2-t-tstrapgap,0])
    softend();
  translate([+(hfront+t)/2-dstrapround/2 -h/2 ,-dstrapround/2-twood/2-t-tstrapgap,0])
    scale([-1,1,1]) softend();

  if(hole==false) // closing
  {
    hull()
    {
      translate([-(hfront+t)/2+rstrapround +s,-rstrapround-twood/2-t-tstrapgap,0])
        conn();
      translate([+(hfront+t)/2-dstrapround/2 -h/2 ,-dstrapround/2-twood/2-t-tstrapgap,0])
         scale([-1,1,1]) conn();
    }
  }

  // sideward loop connectors
  hull()
  {
    translate([-(hfront+t)/2+rstrapround +s,-twood/2,h/2-t/2]) rotate(90,[1,0,0]) 
      cylinder(r=t/2,h=t+tstrapgap+t/2);
    translate([(+(hfront+t)/2-dstrapround/2 -h/2),-twood/2,h/2-t/2]) rotate(90,[1,0,0]) 
      cylinder(r=t/2,h=t+tstrapgap+t/2);
  }
  hull()
  {
    translate([-(hfront+t)/2+rstrapround +s,-twood/2,-(h/2-t/2)]) rotate(90,[1,0,0]) 
      cylinder(r=t/2,h=t+tstrapgap+t/2);
    translate([(+(hfront+t)/2-dstrapround/2 -h/2),-twood/2,-(h/2-t/2)]) rotate(90,[1,0,0]) 
      cylinder(r=t/2,h=t+tstrapgap+t/2);
  }



module softend(b=b2)
{
  hull()
  {
    cylinder(r=rstrapround-b,h=h,center=true);
    cylinder(r=rstrapround,h=h-2*b,center=true);

    translate([dstrapround*f/2,-t/2+rstrapround,0]) cube([dstrapround*f,t,h-2*b],center=true);
    translate([dstrapround*f/2,-t/2+rstrapround,0]) cube([dstrapround*f,t-2*b,h],center=true);
  }
}
module conn(b=b2)
{
  hull()
  {
    translate([dstrapround*1.20/2,-t/2+rstrapround,0]) cube([dstrapround*1.20,t,h-2*b],center=true);
    translate([dstrapround*1.20/2,-t/2+rstrapround,0]) cube([dstrapround*1.20,t-2*b,h],center=true);
  }
}


//###################################

module r2box(rx,ry,x,y,z)
{
  union()
  {
     cube([x,y-2*ry,z],true);
     cube([x-2*rx,y,z],true);
     translate([x/2-rx,y/2-ry,0])
       scale([1,ry/rx,1]) cylinder(r=rx,h=z,center=true);
     translate([-x/2+rx,y/2-ry,0])
       scale([1,ry/rx,1]) cylinder(r=rx,h=z,center=true);
     translate([-x/2+rx,-y/2+ry,0])
       scale([1,ry/rx,1]) cylinder(r=rx,h=z,center=true);
     translate([x/2-rx,-y/2+ry,0])
       scale([1,ry/rx,1]) cylinder(r=rx,h=z,center=true);
  }
}