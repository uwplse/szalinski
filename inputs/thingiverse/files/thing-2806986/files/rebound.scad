$fn=100;
TOPOD=50;
BOTTOMOD=70;
HEIGHT=70;
CENTERID=30;
BOTTOMTHICK=10;
BOTTOMHOLEDIA=15;

difference()
{
    difference()
    {
        cylinder(h=HEIGHT,d1=BOTTOMOD,d2=TOPOD);
        translate([0,0,BOTTOMTHICK])
        {
           cylinder(h=HEIGHT,d=CENTERID); 
        } 
    };
    translate([0,0,-1]) 
    {
      cylinder(h=(HEIGHT+1),d=BOTTOMHOLEDIA); 
    }; 
};