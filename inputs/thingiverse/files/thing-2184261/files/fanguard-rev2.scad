dFan    = 40;          // size of fan: 20,30,35,40,50,60,70,90,92,120
hGuard  = 6;          // height of fanguard
dGuard  = 46;        // size of guard
dCone   = 14;          // diameter of cone
hCone   = 25;          // height of cone
coneType= 3;           // 0-elipse, 1-parabola, 2,3,4-conus
hRim    = 3;           // thick of rim
t       = 0.9;         // thick of walls
hBars   = 0.57*hGuard; // heigth of bars

dScrew  = (dFan <= 40 ? 3  : 4  )  + 0.2;  // diameter of screw M3 or M4
dBolt   = (dFan <= 40 ? 5.5: 7.0)  + 0.7;  // diameter of bolt head
fixture =  dFan == 20 ? 16.2 :             // distance between screws
           dFan == 30 ? 24   :
           dFan == 35 ? 29   :
           dFan == 40 ? 32   :
           dFan == 50 ? 40   :
           dFan == 60 ? 50   :
           dFan == 70 ? 61   :
           dFan == 80 ? 71.5 :
           dFan == 92 ? 82.5 :
           dFan ==120 ? 105  : 0.8*dFan;


$fn   = 90;
zero  = 0.01;

dK    = fixture/sin(45);
hTor  = dGuard-dFan+2*t;   // height of toroid
kTor  = 2*hGuard/hTor;     //
dTor  = dFan -2*t +2*hTor; // diameter of toroid
dRim  = dTor-hTor+hRim;    // diamtere of toroid for rim



guard();



module guard()
{
   difference()
   {  union()
      {  intersection()
         {  translate([0,0,-hGuard])scale([1,1,kTor]) difference()
            {  toroid(dTor,hTor);
               translate([0,0,-hTor/4-zero/2]) 
                  cube([dTor+2*zero,dTor+2*zero,hTor/2+zero],center=true);
            }     

            hull()
            {  cube([dFan,dFan,zero],center=true);
               translate([0,0,max(0,hGuard-hRim)]) toroid(dRim,min(hGuard,hRim));
            }
         }
         difference()
         {  union() { cone();  bars();}
            cone(t);
         }
      }
      for(a=[45:90:315]) // holes for M3 screws
      {  translate([dK*cos(a)/2,dK*sin(a)/2,-zero]) 
            cylinder(d=dScrew,h=hGuard); 
         translate([dK*cos(a)/2,dK*sin(a)/2,1.5]) 
            cylinder(h=hGuard, d=dBolt);
      }    
   }
}  


module cone(tt=0)
{  k=1;
   translate([0,0,-(tt==0?0:0.5)]) scale(tt==0?1:(dCone-2*t)/dCone)
   {
   if(coneType==0)   
      difference()
      {   scale([1,1,2*hCone/dCone]) sphere(d=dCone);
          translate([-zero,-zero,-hCone/2-zero ]) 
             cube([dCone+2*zero,dCone+2*zero,hCone+zero],center=true);
      }
   else 
      rotate([0,180,0]) bulletshape(hCone,dCone,coneType-1);
   }
}
    

module bars()
{  l=(dFan+(hBars/hGuard)*(dTor-hTor-dFan))/2;
   
   translate([0,0,hBars])
   for(a=[0:90:270]) rotate([0,90,a]) translate([0,-t/2,0]) 
      difference() 
      {   rounded_box(hBars,t,l,2*t);   
          translate([hBars+zero,t+zero,l]) rotate([0,-90,90]) linear_extrude(height=t+2*zero) 
             polygon([[zero,zero],[zero ,hBars+2*zero],[-(l-dFan/2+t)+zero,-2*zero]]);
      }
}


module toroid(d,t) 
{ 
  translate([0,0,t/2]) rotate_extrude(convexity = 10) 
     translate([(d-t)/2, 0, 0]) circle(d=t); 
}


module rounded_box(l, r, t, d)
{  scale([l/(l+d), r/(r+d), 1/2]) translate([d/2, d/2, 0]) 
     minkowski() { cube([l,r,t]);  cylinder(d=d, h=t);}
}  


module bulletshape(y, x, needle=0)
{
    focus = pow(x,2)/16/y;
  	hCone = (y+2*focus)/sqrt(2);		
	delta = pow(needle/x,2)*4*y; 
       
    translate([0,0,-y])
   	rotate_extrude(convexity = 10) 
    scale([x/(x-2*needle),y/(y-delta)]) translate([0,-delta])
	difference()
    {  translate([needle,0])
        projection(cut=true)		
		 translate([0,0,focus*2]) 
           rotate([45,0,0])		
		     translate([0,0,-hCone/2]) 
               cylinder(h=hCone, r1=hCone, r2=0, center=true);   	

	   square([x+zero,y+zero] ); 
	}
}