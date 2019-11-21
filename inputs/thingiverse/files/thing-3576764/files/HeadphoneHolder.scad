$fn=300;
headphoneholder();

module cornerengrade(x,y,z)
{
    cube([x , y ,z]);
   
}

module  headphoneholder()
{
    mainthick = 2  ;
    thickness = 25  ;
    bordertop = 15 ; 
    borderleft = 14  ;
    toplength = 60 ;
    leftlength = 80 ;
    armlength = 50;
    armthick = 14;
    text="MYTEXT";
    
     translate([4, 0, -(mainthick *6)])
    {
         rotate(a=[90,0,0]) { 
    linear_extrude(height = 0.5) {
    text(text);
        }}
    }
    cube([toplength , thickness + (mainthick*2) , mainthick]); 
    translate([0, 0, -(bordertop)])
    {
       cube([toplength, mainthick, bordertop]);
        translate([0, thickness + mainthick, -10])
            cube([toplength, mainthick, bordertop +10]);
    }
    
    translate([0, 0, -(bordertop + leftlength)])
    {
       cube([mainthick , thickness + (mainthick*2) , leftlength + bordertop]);
       translate([mainthick, 0, 0]) 
       { 
           cube([borderleft , mainthick , leftlength + bordertop]);
           translate([0, thickness + mainthick, 0]) 
            cube([borderleft +10, mainthick , leftlength + bordertop]);
       }
    }
    
     translate([- armlength, 0, -(leftlength/2 -(armthick / 2))])
     {
           translate([25, armthick, 5])
         rotate(a=[0,90,0]) { 
          cylinder(h=armlength, r=armthick, center=true);}
       
          translate([0, 0, 4 ])
            cube([9 ,thickness + (mainthick+1), 20]);
     }
}
// cube([armlength,thickness + (mainthick*2), armthick]);