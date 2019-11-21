e    = 0.3;   // tolerance

dIn  = 16.0;  // inner diameter
dOut = 24.0;  // outer diameter
h    = 12.0;  // height
v    = 8.0;   // slot depth
t    = 0.5;   // thick of pipe

o    = 7.0;   // curve
$fn  = 200;
zero = 0.0001;

module slot()
{   difference() 
    {  cylinder(d=dIn+e,  h=v);
       cylinder(d=dIn-2*t-e,h=v);
    }   
}

module endcap()
{
   difference()
   { 
     scale([dOut/(dOut+o),dOut/(dOut+o),h/(h+o)]) 
        minkowski() { cylinder(d=dOut,h=h); translate([0,0,o/2]) sphere(d=o);}
     translate([0,0,h-v+zero]) slot();
    }

}

endcap();
