// number of faces in circle, will take longer to render if higher
$fn=30;        
// Thickness of the top
Thick=3;       
// mm per circle
ThreadFeed=3;    
// Diameter as in picture mm + a bit of margin
Diameter = 28.4;  
// total height of the cap including the thickness of the top
CapHeight=16;    
// make the thread stick out a bit more
ExtraThreadHeight=0.2;  
// an extra infill at the top of the cap might make it close better
DoTop="no"; // [yes,no]  
// if the cutout is used you can clearly see the inside
ShowCutout="no"; // [yes,no]

module GrooveObject(depth=2)
{
    translate([-ExtraThreadHeight,0,0])rotate([0,-90,0])cylinder(r1=2,r2=0.4,h=depth,center=true);
 //  cube([2,2,1],center=true);
}

module Thread(feed=3,depth=2,startHeight=5,endHeight=10,rad=14.2)
{
    dh=endHeight-startHeight;
    
    steps=ceil($fn*dh/feed);
    
  
    echo(steps);
    for(i=[0:steps])
    {
         angle=i*360/$fn;
         h=startHeight+dh*i/steps;
         x=cos(angle)*rad;
         y=sin(angle)*rad;
        
         a2=(i+1)*360/$fn;
         h2=startHeight+dh*(i+1)/steps;
         x2=cos(a2)*rad;
         y2=sin(a2)*rad;
        
         color("Green")
         hull()
         {
            translate([x,y,h]) rotate([0,0,angle]) GrooveObject(depth);       
            translate([x2,y2,h2]) rotate([0,0,a2]) GrooveObject(depth);   
         }      
        
    }
}

module Cap()
{
  color("LightBlue")
  difference()
  {
    cylinder(d=Diameter+1.6*2,h=CapHeight);
    translate([0,0,Thick])cylinder(d=Diameter,h=CapHeight); 
  }
  if (DoTop=="yes")
  {
      translate([0,0,Thick])cylinder(d1=Diameter-2,d2=Diameter-4.5,h=1);
  }
  Thread(feed=ThreadFeed,depth=2,startHeight=Thick,endHeight=CapHeight-2.5,rad=Diameter/2);
}

difference()
{
   Cap();
   if (ShowCutout=="yes")
   {
       cube([30,30,30]);
   }
}