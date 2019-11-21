o   =  0.5;     // tolerance for M3 hole

dWheel = 20.0;  // diameter
hWheel =  4.0;  // height
hShim  =  2.0;  // height of shim

dM3    = 3.0 + o;         // diameter M3
hNut   = 2.4 + o;         // height of nut
dNut   = 5.5/cos(30) + o; // diameter of nut

dShim  = dNut + 2*hShim;
dT2    = dNut + hShim;

hS     = 1;   
nm     = 5;   

$fn    = 80;
e      =  0.01;    // small number for overlapp

module Scale()
{ l=(dWheel-dShim)/2;
  translate([0,0,hWheel-hS+e])
    for(i=[0:nm*2-1])
	 rotate(360/nm/2*i+18) 
        translate([-dWheel/2+ l/2,0,hS/2]) cube([l,hS,hS],center=true);
}

module Arms()
{ l=dWheel/4;
  for(i=[1:nm])
  {  rotate(360/nm*(i-0.5))
     {  translate([0,-13,0]) 
        difference()
         {   scale([1,2]) cylinder(r=l,h=hWheel-hS);
             translate([0,0,0.6]) 
             linear_extrude(height = hWheel-hS-0.6) 
             translate([-3.5,-6.0]) text(str(i),font="DejaVu Sans Mono:style=Bold", size=9);
         } 
     }
  }  
}
    
    
module ThumbWheelM3()
{ difference()
  { union()
    {  cylinder(h=hWheel, d=dWheel);
	   translate([0,0,hWheel]) cylinder(h=hShim, d1=dShim, d2=dShim-hShim);
       Arms(); 
    }
	cylinder(h=hWheel+hShim+e, d=dM3);
	cylinder(h=hNut, d1=dNut-0.2, d2=dNut, $fn=6);
    Scale(); 
  } 
}

module digits()
{
    mirror()
    linear_extrude(height = hWheel-hS-0.6) 
    { text("1234512345",font="DejaVu Sans Mono", size=8.5); 
      translate([0,10])
      text("1234512345",font="DejaVu Sans Mono", size=8.5); 
    }
}

ThumbWheelM3();
//digits();
 
