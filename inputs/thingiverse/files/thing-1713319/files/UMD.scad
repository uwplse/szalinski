/**
*
* UMD Memory Stick Duo keeper.
*
* Copyright (C) 2016 thelongrunsmoke.
*
* Licensed under the Apache License, Version 2.0 (the "License")
*
* See ECMA-365 for dimensions details.
*
*/

//this depend from printer, nozzle and using material. If you do not now yours, -0.15 is good place for start. 
tolerance = -0.15; //[-0.3:0.05:0.3]

/* [Hidden] */
$fn = 128;

R1 = 32;
R2 = 70;
R3 = 5;
R8 = 1.8;

L1 = 65;
L3 = 64;
L6 = 20.5;
L7 = 26.3;
L9 = 4.2;
L10 = 3.6;
L11 = 41;
L12 = 3.6;
L13 = 4.6;
L16 = 35.8;
L17 = 9.8;
L18 = 17.4;
L19 = 2.2;

D2 = 3.6;
D5 = 18;

cor = 4.18;

// Two card variant.
*difference(){
    baseShape();
    translate([-19,0,0])
      simpleCardSlot();
    translate([16.5,0,0])
      simpleCardSlot();
}

// More printable one card variant.
difference(){
    baseShape();
    translate([-20.3,0,0])
      cardSlot();
}

// UMD disc shape, based on ECMA-365 standart.
module baseShape(){
    difference(){
        linear_extrude(L9)
          outline();
        refHoles();
        spindelHole();
        headHole();
        latchHole();
    }
}

module outline(){
    offset(R3+tolerance){
        circle(r=R1-R3, center=true);
        difference(){
            translate([R1+R2-L1,0,0])
              circle(r=R2-R3, center=true);
            translate([R2-L7,0,0])
              square((R2-cor)*2, center=true);
        }
        translate([-(L7-4.2)/2,0,0])
          square([L7-cor, L3-(R3*2)], center=true);
    }
}

module refHoles(){
    translate([0,0,L9-0.2])
      linear_extrude(0.3)
        offset(0.2-tolerance)
          refHolesOutline();
    translate([0,0,L9-L10])
      linear_extrude(L10)
        offset(-tolerance)
          refHolesOutline();
}

module refHolesOutline(){
    translate([-L7,L6,0])
      circle(d=D2, center=true);
    translate([-L7,-(L11-L6),0])
      hull(){
          translate([0,(L13-R8*2)/2,0])
            circle(r=R8, center=true);
          translate([0,-(L13-R8*2)/2,0])
            circle(r=R8, center=true);
      }
}

module spindelHole(){
    translate([0,0,L9-0.2])
      linear_extrude(0.3)
        offset(-tolerance)
          circle(d=D5+0.2*2, center=true);
    translate([0,0,L9-L19])
      linear_extrude(L19)
        offset(-tolerance)
          circle(d=D5, center=true);
}

module headHole(){
    translate([0,L6-L17+30/2,L9-L19])
      linear_extrude(L19)
        offset(-tolerance)
          square([L16-L18, 30], center=true);
    translate([0,L6-L17+30/2,L9-0.2])
      linear_extrude(0.3)
        offset(-tolerance)
          square([L16-L18+0.6, 30], center=true);
}

module latchHole(){
    translate([0,0,L9-0.2])
      linear_extrude(0.3)
        offset(0.2)
          latchHoleOutline();
    translate([0,0,-0.1])
      linear_extrude(L9)
          latchHoleOutline();
}

module latchHoleOutline(){
    translate([0,-17,0])
      offset(-tolerance)
        hull(){
            translate([2.5,0,0])
              circle(r=2.5, center=true);
            translate([-2.5,0,0])
              circle(r=2.5, center=true);
        }
}

// Card slots.
module cardSlot(){
    translate([0,0,L9-2.2])
      union(){
          difference(){
              linear_extrude(2.2+0.1)
                offset(-tolerance)
                  square([20, 31], center=true);
              translate([110,0,2.2-0.4])
                linear_extrude(0.6)
                  offset(-tolerance)
                    circle(r=100, center=true);
              translate([-110,0,2.2-0.4])
                linear_extrude(0.6)
                  offset(-tolerance)
                    circle(r=100, center=true);
          }
          translate([0,0,-5/2])
            linear_extrude(5)
              offset(-tolerance)
                hull(){
                    translate([0,5,0])
                      circle(r=6, center=true);
                    translate([0,-5,0])
                      circle(r=6, center=true);
                }
      }  
}

module simpleCardSlot(){
    translate([0,0,-0.1])
      linear_extrude(1.8+0.1)
        offset(-tolerance)
          square([20, 31], center=true);
    linear_extrude(5)
      offset(-tolerance)
        hull(){
            translate([0,5,0])
              circle(r=6, center=true);
            translate([0,-5,0])
              circle(r=6, center=true);
        }
     translate([0,0,L9-0.2])
    linear_extrude(0.3)
      offset(0.2+-tolerance)
        hull(){
            translate([0,5,0])
              circle(r=6, center=true);
            translate([0,-5,0])
              circle(r=6, center=true);
        }
}