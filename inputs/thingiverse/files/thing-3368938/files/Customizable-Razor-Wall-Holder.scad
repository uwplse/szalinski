//Wall holder for double edged razor and accessories
//Modules for each stage to allow customisation

// preview[view:north east, tilt:top diagonal]


/*[Parameters]*/
//Edge Rounding figure - to minimise server resources this is limited online, but if you want radii rather than fillets download the code and run on your machine
$fn=6; //[6:2:8];

//Part to be made
part=0; //[0:Wall Holder, 1:Old Blade box Full Height, 2: Old Blade Box Half Height, 3:Old Blade Box Lid]
//Depth of unit
D=50; //[50:5:80]
//Height of unit
H=60; //[40:5:80]
//Module One - Must be a razor holder for screw hole
Mod1=36; //[36:Razor,36:Razor]
//Module Two
Mod2=50; //[0:None,36:Razor,50:Brush,38:Blades Slot]
//Module Three
Mod3=38; //[0:None,36:Razor,50:Brush,38:Blades Slot]
//Module Four
Mod4=0; //[0:None,36:Razor,50:Brush,38:Blades Slot]
//Module Five
Mod5=0; //[0:None,36:Razor,50:Brush,38:Blades Slot]
//Module Six
Mod6=0; //[0:None,36:Razor,50:Brush,38:Blades Slot]
//Last Module - Must be a Razor for screw hole
Mod7=36;//[36:Razor,36:Razor]

/*[Hidden]*/
//Work out offsets
P1=0;
P2=Mod1;
P3=Mod1+Mod2;
P4=Mod1+Mod2+Mod3;
P5=Mod1+Mod2+Mod3+Mod4;
P6=Mod1+Mod2+Mod3+Mod4+Mod5;
P7=Mod1+Mod2+Mod3+Mod4+Mod5+Mod6;

if((part==0)) { //Making the main wall mount
    
    //Module 1 (Always a Razor)
    Razor(P1); //36mm wide
    
    //Module 2
    if((Mod2==36)) Razor(P2);
    if((Mod2==38)) New_Blades(P2);
    if((Mod2==50)) Brush(P2);
    
    //Module 3
    if((Mod3==36)) Razor(P3);
    if((Mod3==38)) New_Blades(P3);
    if((Mod3==50)) Brush(P3);
    
    //Module 4
    if((Mod4==36)) Razor(P4);
    if((Mod4==38)) New_Blades(P4);
    if((Mod4==50)) Brush(P4);
    
    //Module 5
    if((Mod5==36)) Razor(P5);
    if((Mod5==38)) New_Blades(P5);
    if((Mod5==50)) Brush(P5);
    
    //Module 6
    if((Mod6==36)) Razor(P6);
    if((Mod6==38)) New_Blades(P6);
    if((Mod6==50)) Brush(P6);

    //End module (always a Razor)
    Razor(P7); //36mm wide
}

if((part==1)) { //Making Full Height Old Razor Blade Box
Old_Blades_Box(1);
}

if((part==2)) { //Making Half Height Old Razor Blade Box
Old_Blades_Box(0.5);
}

if((part==3)) { //Making Old Razor Blade Box Lid
Old_Blades_Lid();
}
module Razor(Offset) { //Offset is how far along to have the item
    
    // Module that ads a razor holder to the assembly, 36mm wide
    difference(){
        minkowski(){
            union(){
                translate([Offset,0,0]) cube([36,D,H]);
                translate([(Offset+6),5,0]) cube([2,(D-10),(H+3)]);
                translate([(Offset+28),5,0]) cube([2,(D-10),(H+3)]);
            }
            sphere(2);
        }
        translate([(Offset+18),(D/2),-2]) cylinder(r=8,(H+5),$fn=50);
        translate([(Offset+10),(D/2),-2]) cube([16,((D/2)+4),(H+5)]);
        //Screwholes to avoid use of seperate module
        translate([(Offset+18),(D+2),(H/2)]) rotate([90,0,0]) cylinder(r=2.5,h=(D+5),$fn=50); //screwhole
        translate([(Offset+18),(D+2),(H/2)]) rotate([90,0,0]) cylinder(r=5,h=(D-15),$fn=50); //counterbore
     
     }
}    

module Brush(Offset) { //Offset is how far along to have the item
    
    // Module that adds a brush holder to the assembly, 50mm wide
    difference(){
        minkowski(){
            union(){
                translate([Offset,0,0]) cube([50,D,H]);
            }
            sphere(2);
        }
        translate([(Offset+25),((D/2)+5),-2]) cylinder(r=14,(H+5),$fn=50);
        translate([(Offset+13),(D/2),-2]) cube([24,((D/2)+4),(H+5)]);
        translate([(Offset+25),(D/2),-2]) cylinder(r=23,(H-3),$fn=50);
        translate([(Offset+5),(D/2),-2]) cube([40,((D/2)+4),(H-3)]);


    }
}  
         
module New_Blades(Offset) { //Offset is how far along to have the item
    
    // Module that adds a section to store packs of new blades 36mm wide
    difference(){
        minkowski(){
            union(){
                translate([Offset,0,0]) cube([38,D,H]);
            }
            sphere(2);
        }
        translate([(Offset+2),5,6]) cube([34,(D+4),(H+3)]);

    }
}  

module Old_Blades_Box(Scale) {
  //Used blade holder
  // Box to be able to dispose of old blades that sits below packs of new blades in the holder system
  //Razor blades are 24mm wide by 45mm long, opening is 34mm wide
  //This will spit out 3 parts, a full size box, a half height box and a common lid

Box_Height=(H-10)*Scale;

// Base
difference(){
    minkowski(){
        cube([26,47,Box_Height]);
        sphere(2);
    }
    // Cut off top
    translate([-2.1,-2.1,(Box_Height-3)]) cube([42,60.2,5]);
    //Hollow out
    translate([0,0,0]) cube([26,47,Box_Height+3]);
    //Front Opening
    translate([0,-2,Box_Height-6]) cube([26,10,6]);
}
}

module Old_Blades_Lid(){
//Lid

translate([-40,0,0]) difference(){
    minkowski(){
        cube([26,47,2]);
        sphere(2);
    }
    // Cut off top
    translate([-2,-2,1]) cube([30,51,5]);
    
    
}
//Locating face
    #translate([-39.8,0.2,0]) cube([25.6,46.6,2.5]);
}


