$fn = 50;

pozice_x = 0; /* rozsah -100mm +100mm */
pozice_y = 0; /* rozsah -100mm +100mm */
pozice_z = 0; /* rozsah  -80mm  +70mm */



module lozisko(vnitrni, vnejsi, delka, barva)
{
   color(barva) 
   {
      difference()
      {
        translate([0,0,0]) cylinder(h=delka, d=vnejsi, center=true);
        translate([0,0,0]) cylinder(h=delka*1.1, d=vnitrni*1.05, center=true);
      }
   }
}

module hotend(barva1)
{
   color("red") translate([0,0,50]) cylinder(h=150, d=4, center=true);
   color(barva1) 
   {
      difference()
      {
        union()
        {
         translate([0,0,0]) cylinder(h=50, d=6, center=true);
         translate([0,0,24]) cylinder(h=20, d=10, center=true);
         translate([0,0,32]) cylinder(h=3.7, d=16, center=true);
         translate([0,0,23.4]) cylinder(h=3.7, d=16, center=true);
         translate([0,0,20]) cylinder(h=1, d=16, center=true);
         translate([0,0,14]) cylinder(h=1, d=20, center=true);
         translate([0,0,11]) cylinder(h=1, d=20, center=true);
         translate([0,0,8]) cylinder(h=1, d=20, center=true);
         translate([0,0,5]) cylinder(h=1, d=20, center=true);
         translate([0,0,2]) cylinder(h=1, d=20, center=true);
         translate([0,0,-1]) cylinder(h=1, d=20, center=true);
         translate([0,0,-4]) cylinder(h=1, d=20, center=true);
         translate([0,0,-7]) cylinder(h=1, d=20, center=true);
         translate([0,0,-10]) cylinder(h=1, d=20, center=true);
         translate([0,0,-13]) cylinder(h=1, d=20, center=true);
         translate([0,0,-16]) cylinder(h=1, d=20, center=true);
         translate([0,3,-24]) cube([20,22,10], center=true);
         translate([0,0,-29]) cylinder(h=8, d1=2, d2=15, center=true);
        }
        translate([0,0,0]) cylinder(h=70, d=1, center=true);
        translate([0,0,20]) cylinder(h=50, d=5, center=true);
      }
   }
}

module osa_y(barva1, barva2, barva3)
{
   color(barva1) 
   {
     translate([0,30,-15]) cylinder(h=502, d=8, center=true);
     translate([0,-30,-15]) cylinder(h=502, d=8, center=true);
   }
   color(barva2) 
   {
     translate([0,0,-259]) difference()
     {
       translate([0,0,0]) cube([30,100,10], center=true);
       union()
       {
         translate([0,30,0]) cylinder(h=11, d=8.2, center=true); 
         translate([0,0,0]) cylinder(h=11, d=6.2, center=true); 
         translate([0,-30,0]) cylinder(h=11, d=8.2, center=true); 
         translate([0,40,0]) cube([1,40,11], center=true);
         rotate([0,90,0]) translate([0,40,0]) cylinder(h=31, d=4.2, center=true); 
         translate([0,-40,0]) cube([1,40,11], center=true);
         rotate([0,90,0]) translate([0,-40,0]) cylinder(h=31, d=4.2, center=true); 
       }
     }
   }
}

module pojezd_y(barva)
{
   color(barva) 
   {
     difference()
     {
       translate([7,0,0]) cube([35,80,40], center=true);
       union()
       {
         rotate([90,0,0]) translate([15.5,0,0]) cylinder(h=81, d=16, center=true); 
         translate([25,15,0]) cube([30,80,41], center=true); 
         translate([-7,0,0]) cube([10,30,41], center=true); 
         translate([0,0,0]) cube([20,30,10], center=true); 
         translate([0,30,0]) cylinder(h=42, d=15, center=true); 
         translate([0,-30,0]) cylinder(h=42, d=15, center=true); 
         translate([15,-33,0]) cylinder(h=42, d=4, center=true); 
         translate([0,10,10]) rotate([0,90,0]) cylinder(h=30, d=5, center=true);
         translate([0,10,-10]) rotate([0,90,0]) cylinder(h=30, d=5, center=true);
         translate([0,-10,10]) rotate([0,90,0]) cylinder(h=30, d=5, center=true);
         translate([0,-10,-10]) rotate([0,90,0]) cylinder(h=30, d=5, center=true);
       }
     } 
   }
}

module kladka(barva1, barva2, barva3, barva4)
{
   color(barva1)
   {
     rotate([90,0,0]) difference()
     {
       union()
       {
         translate([0,0,0]) cylinder(h=10, d=15, center=true); 
         translate([0,0,4.5]) cylinder(h=1, d=18, center=true); 
         translate([0,0,-4.5]) cylinder(h=1, d=18, center=true); 
       }
       translate([0,0,0]) cylinder(h=11, d=6, center=true); 
     }
   }
   color(barva2)
   {
     rotate([90,0,0]) translate([0,0,0]) cylinder(h=15, d=5, center=true);
   }
   color(barva3)
   {
     rotate([90,0,0]) difference()
     {
       union()
       {
         translate([0,-15,0]) cube([10,1,14], center=true); 
         translate([0,-5,6.5]) cube([10,20,1], center=true); 
         translate([0,-5,-6.5]) cube([10,20,1], center=true); 
       }
       translate([0,0,0]) cylinder(h=14.5, d=6, center=true); 
       rotate([90,0,0]) translate([0,0,15]) cylinder(h=2, d=6, center=true);
    }
   }
   color(barva4)
   {
     translate([0,0,-23]) cylinder(h=24, d=5, center=true);
     translate([0,0,-13]) cylinder(h=3, d=10, center=true, $fn=6);
     translate([0,0,-31]) cylinder(h=3, d=10, center=true, $fn=6);
   }
}

module nema17(barva1,barva2,barva3)
{
  color(barva1)
  {
    intersection()
    {
      difference()
      {
        union()
        {
          translate([0,0,16]) cube([42,42,8],center=true);
          translate([0,0,-16]) cube([42,42,8],center=true);
          translate([0,0,21]) cylinder(h=2, d=22, center=true);    
        }
        union()
        {
          translate([15.5,15.5,0]) cylinder(h=43, d=3, center=true);    
          translate([15.5,-15.5,0]) cylinder(h=43, d=3, center=true);    
          translate([-15.5,15.5,0]) cylinder(h=43, d=3, center=true);    
          translate([-15.5,-15.5,0]) cylinder(h=43, d=3, center=true);    
        }
      }
      rotate([0,0,45]) translate([0,0,0]) cube([55,55,55], center=true);
    }
  }
  color(barva2)
  {
    intersection()
    {
      union()
      {
        translate([0,0,0]) cube([40,40,24],center=true);
      }
      rotate([0,0,45]) translate([0,0,0]) cube([50,50,50], center=true);
    }
  }
  color(barva3)
  {
    difference()
    {
      translate([0,0,34]) cylinder(h=24, d=5, center=true);    
      translate([0,3,37]) cube([5,5,20],center=true);
    }
  }
}

module zubatice(barva1)
{
   color(barva1)
   {
     difference()
     {
       union()
       {
         translate([0,0,6.5]) cylinder(h=1, d=13, center=true); 
         translate([0,0,3]) cylinder(h=7, d=9.8, center=true); 
         translate([0,0,-3.5]) cylinder(h=6, d=13, center=true); 
       }
       translate([0,0,0]) cylinder(h=15, d=5, center=true); 
       translate([0,0,-3.5]) rotate([90,0,0]) cylinder(h=14, d=2.5, center=true);
       translate([0,0,-3.5]) rotate([0,90,0]) cylinder(h=14, d=2.5, center=true);
     }
   }
}

module pojezd_z(barva1,barva2)
{
  color(barva1)
  {
    difference()
    {
      union()
      {
        translate([-4,49,-10]) cube([60,12,190],center=true); // horni deska
      }
      union()
      {
        translate([-15,49,-80]) rotate([90,0,0]) cylinder(h=13, d=21, center=true); 
        translate([-15,49,-40]) rotate([90,0,0]) cylinder(h=13, d=8, center=true); 
        translate([-15,49,0]) rotate([90,0,0]) cylinder(h=13, d=21, center=true); 
      }
    }
    difference()
    {
      union()
      {
        translate([-4,-49,-10]) cube([60,12,190],center=true); // dolni deska
      }
      union()
      {
        translate([-15,-49,-80]) rotate([90,0,0]) cylinder(h=13, d=21, center=true); 
        translate([-15,-49,-40]) rotate([90,0,0]) cylinder(h=13, d=8, center=true); 
        translate([-15,-55,-40]) rotate([90,0,0]) cylinder(h=10, d=12, center=true, $fn=6); 
        translate([-15,-49,0]) rotate([90,0,0]) cylinder(h=13, d=21, center=true); 
      }
    }
    difference()
    {
      union()
      {
        translate([20,0,50]) cube([12,86,70],center=true); // zadni deska
      }
      union()
      {
        translate([20,0,50]) rotate([0,90,0]) cylinder(h=13, d=22, center=true); 
        translate([20,-15.5,65.5]) rotate([0,90,0]) cylinder(h=13, d=4, center=true); 
        translate([20,-15.5,34.5]) rotate([0,90,0]) cylinder(h=13, d=4, center=true); 
        translate([20,15.5,65.5]) rotate([0,90,0]) cylinder(h=13, d=4, center=true); 
        translate([20,15.5,34.5]) rotate([0,90,0]) cylinder(h=13, d=4, center=true); 
      }
    }
    difference()
    {
      union()
      {
        translate([5,0,-99]) cube([42,86,12],center=true); // bocnice pro y prava
      }
      union()
      {
         translate([0,30,-99]) cylinder(h=13, d=8, center=true); 
         translate([0,-30,-99]) cylinder(h=13, d=8, center=true); 
         translate([-5,0,-99]) cube([30,30,13], center=true); 
      }
    }
    difference()
    {
      union()
      {
        translate([0,0,79]) cube([30,86,12],center=true);  // bocnice pro y leva
      }
      union()
      {
         translate([0,30,79]) cylinder(h=13, d=8, center=true); 
         translate([0,-30,79]) cylinder(h=13, d=8, center=true); 
      }
    }
  }
  color(barva2)
  {
    difference()
    {
      translate([-15,-55,-40]) rotate([90,0,0]) cylinder(h=8, d=12, center=true, $fn=6); 
      translate([-15,-55,-40]) rotate([90,0,0]) cylinder(h=9, d=8, center=true); 
    }
  }
}

module osa_z(barva1, barva2, barva3, barva4)
{
  color(barva1) // vodici tyce
  {
    translate([-15,-50,170]) rotate([-90,0,0]) cylinder(h=600.1, d=12, center=true);
    translate([-15,-50,250]) rotate([-90,0,0]) cylinder(h=600.1, d=12, center=true);   
  }
  color(barva2) // drevene casti
  {
    translate([-61,-100,210]) cube([12,500,100], center=true); // prava bocnice  
    translate([ 51,-50,210]) cube([12,600,100], center=true);  // leva bocnice
    translate([ -5,194,154]) cube([124,112,12], center=true);  // predni horni desaka
    difference()
    {
      translate([ -11,244,210]) cube([112,12,100], center=true);  // horni deska  
      union()
      {
        translate([-15,244,170]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,244,250]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,244,210]) rotate([-90,0,0]) cylinder(h=12.01, d=22, center=true);   
        translate([-30.5,244,225.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
        translate([-30.5,244,194.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
        translate([0.5,244,194.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
        translate([0.5,244,225.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
      }
    }
    difference()
    {
      translate([ -11,144,210]) cube([112,12,100], center=true);  // sposní deska  
      union()
      {
        translate([-15,144,170]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,144,250]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,144,210]) rotate([-90,0,0]) cylinder(h=12.01, d=9, center=true);   
        translate([-15,150,210]) rotate([-90,0,0]) cylinder(h=8, d=25, center=true);   
      }
    }
  }
  color(barva3) // zavitova tyc
  {
    translate([-15,20,210]) rotate([-90,0,0]) cylinder(h=400, d=8, center=true);
   
  }
  color(barva4) // ostatni dily
  {
    translate([-15,220,210]) rotate([-90,0,0]) cylinder(h=25, d=20, center=true);   
    translate([-15,159,210]) rotate([90,0,0]) cylinder(h=6, d=12, center=true, $fn=6); 
    translate([-15,151,210]) rotate([-90,0,0]) cylinder(h=8, d=25, center=true);   
  }
}

module zakladna(barva1,barva2)
{
  color(barva1)
  {
    difference()  // zadni deska
    {
      translate([0,-294,266]) cube([500,112,12], center=true);
      union()
      {
      }
    }
    difference()  // spodni deska
    {
      translate([0,-344,60]) cube([476,12,400], center=true);
      union()
      {
        translate([-15,-344,170]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,-344,250]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,-344,210]) rotate([-90,0,0]) cylinder(h=12.01, d=9, center=true);   
        translate([-61,-344,210]) cube([12,12.01,100.01], center=true); // prava bocnice  
        translate([ 51,-344,210]) cube([12,12.01,100.01], center=true);  // leva bocnice
     }
    }
    difference()  // horni deska
    {
      translate([0,-244,60]) cube([476,12,400], center=true);
      union()
      {
        translate([-15,-244,170]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,-244,250]) rotate([-90,0,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-15,-244,210]) rotate([-90,0,0]) cylinder(h=12.01, d=9, center=true);   
        translate([-61,-244,210]) cube([12,12.01,100.01], center=true); // prava bocnice  
        translate([ 51,-244,210]) cube([12,12.01,100.01], center=true);  // leva bocnice
        translate([220,-244,0]) // ulozeni motoru
        {
          translate([0,0,0]) rotate([-90,0,0]) cylinder(h=12.01, d=22, center=true);   
          translate([-15.5,0,-15.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
          translate([-15.5,0,15.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
          translate([15.5,0,-15.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
          translate([15.5,0,15.5]) rotate([-90,0,0]) cylinder(h=12.01, d=4, center=true);   
        }
      }
    }
    difference()  // leva bocnice
    {
      translate([244,-275,66]) cube([12,150,412], center=true);
      union()
      {
        translate([244,-215,75]) rotate([0,-90,0]) cylinder(h=12.01, d=12, center=true);   
        translate([244,-215,-75]) rotate([0,-90,0]) cylinder(h=12.01, d=12, center=true);   
      }
    }
    difference()  // prava bocnice
    {
      translate([-244,-275,66]) cube([12,150,412], center=true);
      union()
      {
        translate([-244,-215,75]) rotate([0,-90,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-244,-215,-75]) rotate([0,-90,0]) cylinder(h=12.01, d=12, center=true);   
        translate([-244,-225,0]) rotate([0,-90,0]) cylinder(h=12.01, d=6, center=true);   
      }
    }
  }
  color(barva2)
  {
    translate([0,-215,75]) rotate([0,-90,0]) cylinder(h=501, d=12, center=true);   
    translate([0,-215,-75]) rotate([0,-90,0]) cylinder(h=501, d=12, center=true);   
  }
}

module pojezd_x(barva)
{
   color(barva) 
   {
      
     difference() // horni deska
     {
       translate([0,-190,0]) cube([240,12,240], center=true); 
       union()
       {
         // otvory pro uchyceni vyhrivane desky
         translate([104.5,-190,104.5]) rotate([90,0,0]) cylinder(h=12.01, d=5, center=true);
         translate([104.5,-190,-104.5]) rotate([90,0,0]) cylinder(h=12.01, d=5, center=true);
         translate([-104.5,-190,104.5]) rotate([90,0,0]) cylinder(h=12.01, d=5, center=true);
         translate([-104.5,-190,-104.5]) rotate([90,0,0]) cylinder(h=12.01, d=5, center=true);
         // matky serizovacich sroubu vyhrivane desky
         translate([104.5,-200,104.5]) rotate([90,0,0]) cylinder(h=12.01, d=8, center=true, $fn=6);
         translate([104.5,-200,-104.5]) rotate([90,0,0]) cylinder(h=12.01, d=8, center=true, $fn=6);
         translate([-104.5,-200,104.5]) rotate([90,0,0]) cylinder(h=12.01, d=8, center=true, $fn=6);
         translate([-104.5,-200,-104.5]) rotate([90,0,0]) cylinder(h=12.01, d=8, center=true, $fn=6);
      }
     } 
     difference() // levy nosnik
     {
       translate([75,-213.5,0]) cube([12,35,220], center=true); 
       union()
       {
         translate([75,-240,0]) rotate([0,90,0]) cylinder(h=12.01, d=70, center=true);
         translate([75,-213.5,75]) rotate([0,90,0]) cylinder(h=12.01, d=20, center=true);
         translate([75,-213.5,-75]) rotate([0,90,0]) cylinder(h=12.01, d=20, center=true);
      }
     } 
     difference() // pravy nosnik
     {
       translate([-75,-213.5,0]) cube([12,35,220], center=true); 
       union()
       {
         translate([-75,-240,0]) rotate([0,90,0]) cylinder(h=12.01, d=70, center=true);
         translate([-75,-213.5,75]) rotate([0,90,0]) cylinder(h=12.01, d=20, center=true);
         translate([-75,-213.5,-75]) rotate([0,90,0]) cylinder(h=12.01, d=20, center=true);
      }
     } 
     difference() // vodici lista
     {
       translate([0,-213.5,0]) cube([50,35,12], center=true); 
       union()
       {
         translate([-15,-225,0]) rotate([0,0,90]) cylinder(h=12.01, d=4, center=true);
         translate([15,-225,0]) rotate([0,0,90]) cylinder(h=12.01, d=4, center=true);
      }
     } 
   }
}

rotate([90,0,0])
{
  


   // kompletni vozik osa Y
   translate([0,pozice_z,pozice_y])
   {
    translate([  15, -61,   0]) rotate([-90,0,0]) hotend("white");
    translate([   0,  30,  -20]) lozisko(8, 15, 24, "grey");
    translate([   0, -30,  -20]) lozisko(8, 15, 24, "grey");
    translate([   0,  30,   20]) lozisko(8, 15, 24, "grey");
    translate([   0, -30,   20]) lozisko(8, 15, 24, "grey");
    translate([   0,   0,    0]) pojezd_y("DarkKhaki");
  }
  
  // kompletni pojeyd osa Z
  translate([0,pozice_z,0])
  {
    translate([   0,   0, 100]) osa_y("DarkSlateGray","DarkKhaki","black");
    translate([   0,   0, -135])rotate([0,0,-90]) kladka("white","grey","green","grey");
    translate([   0,   0,  250]) pojezd_z("DarkKhaki","LightYellow");
    translate([45,0,300]) rotate([0,-90,0]) nema17("silver","black","LightYellow");
    translate([5,0,300]) rotate([0,-90,0]) zubatice("LightCyan");
    translate([-15,50,170]) rotate([-90,0,0]) lozisko(12, 21, 30, "grey");
    translate([-15,-50,170]) rotate([-90,0,0]) lozisko(12, 21, 30, "grey");
    translate([-15,50,250]) rotate([-90,0,0]) lozisko(12, 21, 30, "grey");
    translate([-15,-50,250]) rotate([-90,0,0]) lozisko(12, 21, 30, "grey");
  }
  
  // ulozeni sloupku osy Z
  translate([0,0,0])
  {
    translate([0,0,0]) osa_z("DarkSlateGray","DarkKhaki","silver","LightYellow"); 
    translate([-15,270,210]) rotate([90,0,0]) nema17("silver","black","LightYellow");
  }
  
   // základna s osou X
  translate([0,0,0])
  {
    translate([0,0,0]) zakladna("Khaki","DarkSlateGray");
    translate([220,-270,0]) rotate([-90,0,0]) nema17("silver","black","LightYellow");
    translate([220,-230,0]) rotate([-90,0,0]) zubatice("LightCyan");
    translate([-221,-225,0])rotate([0,90,0]) kladka("white","grey","green","grey");
  }
  
  
  // pojezd osy X
  translate([pozice_x,0,0])
  {
    translate([0,0,0]) pojezd_x("Khaki");
    translate([75,-215,75]) rotate([0,-90,0]) lozisko(12, 21, 30, "grey");
    translate([75,-215,-75]) rotate([0,-90,0]) lozisko(12, 21, 30, "grey");
    translate([-75,-215,75]) rotate([0,-90,0]) lozisko(12, 21, 30, "grey");
    translate([-75,-215,-75]) rotate([0,-90,0]) lozisko(12, 21, 30, "grey");
  }
 
  // bovdemovy extruder
  translate([50,275,180])
  {
    color("gold") translate([0,0,0]) cube([30,50,50], center=true); 
    translate([35,0,0]) rotate([0,-90,0]) nema17("silver","black","LightYellow");
    color("red") translate([-5,-10,0]) cylinder(h=300, d=4, center=true);
  }
 
  
  
  
  
  
  
  
  

}