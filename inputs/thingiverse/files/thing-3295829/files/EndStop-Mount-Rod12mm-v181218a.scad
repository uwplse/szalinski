ds=12; //shaft diameter
dw=4; //wall thickness
b=13; //clamp bolt length

difference() //insert double slashes for experimenting
{
    color("blue") //clamps
    union()
    {
        cube([ds+18,dw*2+1,15], center=true);
        cylinder(h=15,d=ds+2*dw,center=true, $fn=(ds+8)*16);
        #translate([0,-3.5-ds/2-dw,0]) //switch space
        minkowski()
        {    
            cube([20,7,14], center=true);
            cylinder(h=1,r=dw, center=true,$fn=8*16);
        };
    };
    
    color("grey") //shaft
    cylinder(h=30,d=ds,center=true, $fn=10*16);
    
    color("orange") //separation
    cube([ds+19,1,16], center=true);

    color("red") //right bolt & nut 
    union()
    {
        translate([ds/2+5,0,0]) //shaft
        rotate([90,0,0])
        cylinder(h=b,d=3,center=true,$fn=48);
        translate([ds/2+5,b/2-0.5,0]) //head
        rotate([90,0,0])
        cylinder(h=5,d=6,center=true,$fn=96);
        translate([ds/2+5,-b/2+2,0]) //nut
        rotate([90,0,0])
        cylinder(h=2.5,d=6.35,center=true,$fn=6);
        translate([ds/2+7.5,-b/2+2,0]) //nut cavity
        cube([8,2.5,5.5], center=true);
    };  

    color("red") //left bolt & nut
    union()
    {
        translate([-ds/2-5,0,0]) //shaft
        rotate([90,0,0])
        cylinder(h=b,d=3,center=true,$fn=48);
        translate([-ds/2-5,b/2-01.5,0]) //head
        rotate([90,0,0])
        cylinder(h=5,d=6,center=true,$fn=96);
        translate([-ds/2-5,-b/2+2,0]) //nut
        rotate([90,0,0])
        cylinder(h=2.5,d=6.35,center=true,$fn=6);
        translate([-ds/2-7.5,-b/2+2,0]) //nut cavity
        cube([8,2.5,5.5], center=true);
    };
  
    color("black") // switch block
    union()
    {
        translate([0,-3.5-ds/2-dw,0]) //switch
        cube([20.5,7,15.01], center=true);
        
        translate([5,1-b/2-ds/2-dw,0]) //right bolt shaft
        rotate([90,0,0])
        cylinder(h=b,d=3,center=true,$fn=48);
        
        translate([-5,1-b/2-ds/2-dw,0]) //left bolt shaft
        rotate([90,0,0])
        cylinder(h=b,d=3,center=true,$fn=48);
    };

};


    
    












