radius=20;
hoogte=1.8;
module camwheel(min,delta,offset)
{translate([0,0,offset])
  {linear_extrude(hoogte)
    polygon(
    [ for (a = [0 : 1 : 36]) [ (min+delta*(floor(a/2)%2)) * sin(a*10), (min+delta*(floor(a/2)% 2)) * cos(a*10) ] ]);
        } 
}
 module camwheel4(min,delta,offset)
{translate([0,0,offset])
  linear_extrude(hoogte)
    polygon(
    [ for (a = [1 : 1 : 36]) [(-floor(a/20)+min+delta*(floor(a/2)%2)) * sin(a*10),(-floor(a/20)+ min+delta*floor((a/2)% 2)) * cos(a*10) ] ]);
}
module camwheel5(min,delta,offset)
{translate([0,0,offset])
  linear_extrude(hoogte)
    polygon(
    [ for (a = [1 : 1 : 36]) [(-floor(a/6)%2+min+delta*(floor(a/2)%2)) * sin(a*10),(-floor(a/6)%2+ min+delta*floor((a/2)% 2)) * cos(a*10) ] ]);
}
  
module camwheel6(min,delta,offset)
{translate([0,0,offset])
  {linear_extrude(hoogte)
    polygon(
    [ for (a = [0 : 1 : 36]) [ (min-delta*(floor((floor(a/2)%6)/5))) * sin(a*10), (min-delta*(floor((floor(a/2)% 6)/5)))* cos(a*10) ] ]);
        } 
}
 module camwheel7(min,delta,offset)
{translate([0,0,offset])
  {linear_extrude(hoogte)
    polygon(
    [ for (a = [0 : 1 : 36]) [ (min+abs(4-floor(a/2)%9)*delta)* sin(a*10), (min+abs(4-floor(a/2)%9)*delta)* cos(a*10) ] ]);
        } 
}  $fn=180;
difference(){
union(){
 
        camwheel7(radius-1.65,0.625,1);
        camwheel6(radius+0.85,1.2,1+hoogte);
     
        camwheel5(radius,1.2,1+2*hoogte);
    camwheel4(radius,1.2,1+3*hoogte);
    // camwheel 3
    camwheel(radius-0.8,2.25,1+4*hoogte);
    camwheel(radius-0.8,1.625,1+5*hoogte);
    camwheel(radius,1.0,1+6*hoogte);
    cylinder(h=1,d=radius*2+1.7);}
    translate([0,0,-1])
    cylinder(h=18,d=radius*2-8);}
  difference(){ rotate([0,0,-27])
       color("red"){translate([radius*12.5/20,0,0])
       cylinder(h=1.15,d=16.5);
       }
        rotate([0,0,-27])
       color("red"){
       translate([radius*12.5/20,0,-0.15])
       cylinder(h=1.4,d=3.5);}}    
   