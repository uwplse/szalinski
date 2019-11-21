//Height Settings (for each color assign the extrusion height in mm, this is the height of the model that you will need to swap the plastic over)
hc1 = 1;
hc2 = 1.5;
hc3 = 2;
hc4 = 2.5;
hc5 = 3;

// Color Settings (assign color codes to each extrusion height, visual only, you will still need to adjust this on your printer)
    c1 = "green";
    c2 = "red";
    c3 = "blue";
    c4 = "white";
    c5 = "yellow";

//Tree Measurements  
//Tree Height (not the extruded height) 
    th = 50; 
//Tree Width 
    tw = 60;
//Tree Points (not adjustable yet, so please leave it at 3, but in future plans)
    tp = 3;

//Star Measurements
//Star Outer radius
    outr = 5;
//Star Inner radius
    ir = 2;

//Bauble settings
//Bauble radius
    br = 2;
//Bauble heights
    bc1 = 1.5;
    bc2 = 2;
    bc3 = 2;
    bc4 = 3;
    bc5 = 2.5;
    bc6 = 1.5;
    bc7 = 2.5;
    bc8 = 1.5;
    bc9 = 2;
    bc10 = 3;

//Light settings
//light radius  
    lr = 1; 
//light heights
    lc1 = 1.5;
    lc2 = 2;
    lc3 = 2.5;
    lc4 = 3;
    lc5 = 1.5;
    lc6 = 2;
    lc7 = 2.5;
    lc8 = 3;
    lc9 = 1.5;
    lc10 = 2;
    lc11 = 2.5;
    lc12 = 3;
    lc13 = 1.5;
    lc14 = 2;
    lc15 = 2.5;
    lc16 = 3;
    lc17 = 1.5;
    lc18 = 2;
    lc19 = 2.5;
    lc20 = 3;
    lc21 = 1.5;
    lc22 = 2;
    lc23 = 2.5;
    lc24 = 3;

        // Tree calculations
        pw = tw/(2*(tp+1));
        ph = th/(tp);
        ht = tw/2;
   
  // Draw Tree (height 1)
color (c1) linear_extrude (height=hc1)
polygon (points = [[0,0], [tw,0], [tw-(2*pw),ph], [tw-pw,ph], [tw-(3*pw),2*ph], [tw-(2*pw),2*ph], [tw-(4*pw),3*ph], [2*pw,2*ph], [3*pw,2*ph], [pw,ph], [2*pw,ph]]);

//Draw Star (height 5)
difference() {
color (c5) linear_extrude (height=hc5)
polygon (points = [[ht,th+outr], [ht+ir*sin(36),th+ir*cos(36)], [ht+outr*cos(18),th+outr*sin(18)], [ht+ir*cos(18),th-ir*sin(18)], [ht+outr*cos(54),th-outr*sin(54)], [ht,th-ir], [ht-outr*cos(54),th-outr*sin(54)], [ht-ir*cos(18),th-ir*sin(18)], [ht-outr*cos(18),th+outr*sin(18)], [ht-ir*sin(36),th+ir*cos(36)]]);
rotate ([0,90,0]) translate ([-hc2,th,0.5*tw]) cylinder (h = 3*outr, r=1, center = true, $fn=100);
}

//Draw Baubles
//Bauble 1
if (bc1 == hc2) {color (c2) linear_extrude (height = bc1) translate ([2.95*pw,2.25*ph,0]) circle (br, $fn=50);} else if (bc1 == hc3) {color (c3) linear_extrude (height = bc1) translate ([2.95*pw,2.25*ph,0]) circle (br, $fn=50);} else if (bc1 == hc4) {color (c4) linear_extrude (height = bc1) translate ([2.95*pw,2.25*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height = bc1) translate ([2.95*pw,2.25*ph,0]) circle (br, $fn=50);}
//Bauble 2
if (bc2 == hc2) {color (c2) linear_extrude (height=bc2) translate ([4.65*pw,2.45*ph,0]) circle (br, $fn=50);} else if (bc2 == hc3) {color (c3) linear_extrude (height=bc2) translate ([4.65*pw,2.45*ph,0]) circle (br, $fn=50);} else if (bc2 == hc4) {color (c4) linear_extrude (height=bc2) translate ([4.65*pw,2.45*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc2) translate ([4.65*pw,2.45*ph,0]) circle (br, $fn=50);}
//Bauble 3
if (bc3 == hc2) {color (c2) linear_extrude (height=bc3) translate ([2.25*pw,1.45*ph,0]) circle (br, $fn=50);} else if (bc3 == hc3) {color (c3) linear_extrude (height=bc3) translate ([2.25*pw,1.45*ph,0]) circle (br, $fn=50);} else if (bc3 == hc4) {color (c4) linear_extrude (height=bc3) translate ([2.25*pw,1.45*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc3) translate ([2.25*pw,1.45*ph,0]) circle (br, $fn=50);}
//Bauble 4
if (bc4 == hc2) {color (c2) linear_extrude (height=bc4) translate ([3.15*pw,1.20*ph,0]) circle (br, $fn=50);} else if (bc4 == hc3) {color (c3) linear_extrude (height=bc4) translate ([3.15*pw,1.20*ph,0]) circle (br, $fn=50);} else if (bc4 == hc4) {color (c4) linear_extrude (height=bc4) translate ([3.15*pw,1.20*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc4) translate ([3.15*pw,1.20*ph,0]) circle (br, $fn=50);}
//Bauble 5
if (bc5 == hc2) {color (c2) linear_extrude (height=bc5) translate ([4.25*pw,1.85*ph,0]) circle (br, $fn=50);} else if (bc5 == hc3) {color (c3) linear_extrude (height=bc5) translate ([4.25*pw,1.85*ph,0]) circle (br, $fn=50);} else if (bc5 == hc4) {color (c4) linear_extrude (height=bc5) translate ([4.25*pw,1.85*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc5) translate ([4.25*pw,1.85*ph,0]) circle (br, $fn=50);}
//Bauble 6
if (bc6 == hc2) {color (c2) linear_extrude (height=bc6) translate ([5.45*pw,1.35*ph,0]) circle (br, $fn=50);} else if (bc6 == hc3) {color (c3) linear_extrude (height=bc6) translate ([5.45*pw,1.35*ph,0]) circle (br, $fn=50);} else if (bc6 == hc4) {color (c4) linear_extrude (height=bc6) translate ([5.45*pw,1.35*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc6) translate ([5.45*pw,1.35*ph,0]) circle (br, $fn=50);}
//Bauble 7
if (bc7 == hc2) {color (c2) linear_extrude (height=bc7) translate ([1.55*pw,0.45*ph,0]) circle (br, $fn=50);} else if (bc7 == hc3) {color (c3) linear_extrude (height=bc7) translate ([1.55*pw,0.45*ph,0]) circle (br, $fn=50);} else if (bc7 == hc4) {color (c4) linear_extrude (height=bc7) translate ([1.55*pw,0.45*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc7) translate ([1.55*pw,0.45*ph,0]) circle (br, $fn=50);}
//bauble 8
if (bc8 == hc2) {color (c2) linear_extrude (height=bc8) translate ([2.85*pw,0.20*ph,0]) circle (br, $fn=50);} else if (bc8 == hc3) {color (c3) linear_extrude (height=bc8) translate ([2.85*pw,0.20*ph,0]) circle (br, $fn=50);} else if (bc8 == hc4) {color (c4) linear_extrude (height=bc8) translate ([2.85*pw,0.20*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc8) translate ([2.85*pw,0.20*ph,0]) circle (br, $fn=50);}
//Bauble 9
if (bc9 == hc2) {color (c2) linear_extrude (height=bc9) translate ([4.85*pw,0.85*ph,0]) circle (br, $fn=50);} else if (bc9 == hc3) {color (c3) linear_extrude (height=bc9) translate ([4.85*pw,0.85*ph,0]) circle (br, $fn=50);} else if (bc9 == hc4) {color (c4) linear_extrude (height=bc9) translate ([4.85*pw,0.85*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc9) translate ([4.85*pw,0.85*ph,0]) circle (br, $fn=50);}  
//Bauble 10
if (bc10 == hc2) {color (c2) linear_extrude (height=bc10) translate ([6.25*pw,0.55*ph,0]) circle (br, $fn=50);} else if (bc10 == hc3) {color (c3) linear_extrude (height=bc10) translate ([6.25*pw,0.55*ph,0]) circle (br, $fn=50);} else if (bc10 == hc4) {color (c4) linear_extrude (height=bc10) translate ([6.25*pw,0.55*ph,0]) circle (br, $fn=50);} else {color (c5) linear_extrude (height=bc10) translate ([6.25*pw,0.55*ph,0]) circle (br, $fn=50);}
//Draw Lights
//light 1
if (lc1 == hc2) {color (c2) linear_extrude (height= lc1) translate ([3.3*pw,2.55*ph]) circle (lr, $fn=20);} else if (lc1 == hc3) {color (c3) linear_extrude (height= lc1) translate ([3.3*pw,2.55*ph]) circle (lr, $fn=20);} else if (lc1 == hc4) {color (c4) linear_extrude (height= lc1) translate ([3.3*pw,2.55*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height= lc1) translate ([3.3*pw,2.55*ph]) circle (lr, $fn=20);}
//light 2
if (lc2 == hc2) {color (c2) linear_extrude (height=lc2) translate ([3.55*pw,2.42*ph]) circle (lr, $fn=20);} else if (lc2 == hc3) {color (c3) linear_extrude (height=lc2) translate ([3.55*pw,2.42*ph]) circle (lr, $fn=20);} else if (lc2 == hc4) {color (c4) linear_extrude (height=lc2) translate ([3.55*pw,2.42*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc2) translate ([3.55*pw,2.42*ph]) circle (lr, $fn=20);} 
//light 3
if (lc3 == hc2) {color (c2) linear_extrude (height=lc3) translate ([3.85*pw,2.32*ph]) circle (lr, $fn=20);} else if (lc3 == hc3) {color (c3) linear_extrude (height=lc3) translate ([3.85*pw,2.32*ph]) circle (lr, $fn=20);} else if (lc3 == hc4) {color (c4) linear_extrude (height=lc3) translate ([3.85*pw,2.32*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc3) translate ([3.85*pw,2.32*ph]) circle (lr, $fn=20);} 
//light 4
if (lc4 == hc2) {color (c2) linear_extrude (height=lc4) translate ([4.1*pw,2.23*ph]) circle (lr, $fn=20);} else if (lc4 == hc3) {color (c3) linear_extrude (height=lc4) translate ([4.1*pw,2.23*ph]) circle (lr, $fn=20);} else if (lc4 == hc4) {color (c4) linear_extrude (height=lc4) translate ([4.1*pw,2.23*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc4) translate ([4.1*pw,2.23*ph]) circle (lr, $fn=20);} 
//light 5
if (lc5 == hc2) {color (c2) linear_extrude (height=lc5) translate ([4.42*pw,2.13*ph]) circle (lr, $fn=20);} else if (lc5 == hc3) {color (c3) linear_extrude (height=lc5) translate ([4.42*pw,2.13*ph]) circle (lr, $fn=20);} else if (lc5 == hc4) {color (c4) linear_extrude (height=lc5) translate ([4.42*pw,2.13*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc5) translate ([4.42*pw,2.13*ph]) circle (lr, $fn=20);}  
//light 6
if (lc6 == hc2) {color (c2) linear_extrude (height=lc6) translate ([4.8*pw,2.05*ph]) circle (lr, $fn=20);} else if (lc6 == hc3) {color (c3) linear_extrude (height=lc6) translate ([4.8*pw,2.05*ph]) circle (lr, $fn=20);} else if (lc6 == hc4) {color (c4) linear_extrude (height=lc6) translate ([4.8*pw,2.05*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc6) translate ([4.8*pw,2.05*ph]) circle (lr, $fn=20);} 
//light 7
if (lc7 == hc2) {color (c2) linear_extrude (height=lc7) translate ([3.1*pw,1.95*ph]) circle (lr, $fn=20);} else if (lc7 == hc3) {color (c3) linear_extrude (height=lc7) translate ([3.1*pw,1.95*ph]) circle (lr, $fn=20);} else if (lc7 == hc4) {color (c4) linear_extrude (height=lc7) translate ([3.1*pw,1.95*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc7) translate ([3.1*pw,1.95*ph]) circle (lr, $fn=20);}
//light 8
if (lc8 == hc2) {color (c2) linear_extrude (height=lc8) translate ([3.42*pw,1.75*ph]) circle (lr, $fn=20);} else if (lc8 == hc3) {color (c3) linear_extrude (height=lc8) translate ([3.42*pw,1.75*ph]) circle (lr, $fn=20);} else if (lc8 == hc4) {color (c4) linear_extrude (height=lc8) translate ([3.42*pw,1.75*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc8) translate ([3.42*pw,1.75*ph]) circle (lr, $fn=20);}
//light 9
if (lc9 == hc2) {color (c2) linear_extrude (height=lc9) translate ([3.82*pw,1.57*ph]) circle (lr, $fn=20);} else if (lc9 == hc3) {color (c3) linear_extrude (height=lc9) translate ([3.82*pw,1.57*ph]) circle (lr, $fn=20);} else if (lc9 == hc4) {color (c4) linear_extrude (height=lc9) translate ([3.82*pw,1.57*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc9) translate ([3.82*pw,1.57*ph]) circle (lr, $fn=20);}
//light 10
if (lc10 == hc2) {color (c2) linear_extrude (height=lc10) translate ([4.2*pw,1.42*ph]) circle (lr, $fn=20);} else if (lc10 == hc3) {color (c3) linear_extrude (height=lc10) translate ([4.2*pw,1.42*ph]) circle (lr, $fn=20);} else if (lc10 == hc4) {color (c4) linear_extrude (height=lc10) translate ([4.2*pw,1.42*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc10) translate ([4.2*pw,1.42*ph]) circle (lr, $fn=20);}
//light 11
if (lc11 == hc2) {color (c2) linear_extrude (height=lc11) translate ([4.65*pw,1.3*ph]) circle (lr, $fn=20);} else if (lc11 == hc3) {color (c3) linear_extrude (height=lc11) translate ([4.65*pw,1.3*ph]) circle (lr, $fn=20);} else if (lc11 == hc4) {color (c4) linear_extrude (height=lc11) translate ([4.65*pw,1.3*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc11) translate ([4.65*pw,1.3*ph]) circle (lr, $fn=20);}
//light 12
if (lc12 == hc2) {color (c2) linear_extrude (height=lc12) translate ([5.1*pw,1.18*ph]) circle (lr, $fn=20);} else if (lc12 == hc3) {color (c3) linear_extrude (height=lc12) translate ([5.1*pw,1.18*ph]) circle (lr, $fn=20);} else if (lc12 == hc4) {color (c4) linear_extrude (height=lc12) translate ([5.1*pw,1.18*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc12) translate ([5.1*pw,1.18*ph]) circle (lr, $fn=20);} 
//light 13
if (lc13 == hc2) {color (c2) linear_extrude (height=lc13) translate ([5.5*pw,1.1*ph]) circle (lr, $fn=20);} else if (lc13 == hc3) {color (c3) linear_extrude (height=lc13) translate ([5.5*pw,1.1*ph]) circle (lr, $fn=20);} else if (lc13 == hc4) {color (c4) linear_extrude (height=lc13) translate ([5.5*pw,1.1*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc13) translate ([5.5*pw,1.1*ph]) circle (lr, $fn=20);}
//light 14
if (lc14 == hc2) {color (c2) linear_extrude (height=lc14) translate ([5.9*pw,1.04*ph]) circle (lr, $fn=20);} else if (lc14 == hc3) {color (c3) linear_extrude (height=lc14) translate ([5.9*pw,1.04*ph]) circle (lr, $fn=20);} else if (lc14 == hc4) {color (c4) linear_extrude (height=lc14) translate ([5.9*pw,1.04*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc14) translate ([5.9*pw,1.04*ph]) circle (lr, $fn=20);}
//light 15
if (lc15 == hc2) {color (c2) linear_extrude (height=lc15) translate ([2.1*pw,0.95*ph]) circle (lr, $fn=20);} else if (lc15 == hc3) {color (c3) linear_extrude (height=lc15) translate ([2.1*pw,0.95*ph]) circle (lr, $fn=20);} else if (lc15 == hc4) {color (c4) linear_extrude (height=lc15) translate ([2.1*pw,0.95*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc15) translate ([2.1*pw,0.95*ph]) circle (lr, $fn=20);}  
//light 16
if (lc16 == hc2) {color (c2) linear_extrude (height=lc16) translate ([2.58*pw,0.75*ph]) circle (lr, $fn=20);} else if (lc16 == hc3) {color (c3) linear_extrude (height=lc16) translate ([2.58*pw,0.75*ph]) circle (lr, $fn=20);} else if (lc16 == hc4) {color (c4) linear_extrude (height=lc16) translate ([2.58*pw,0.75*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc16) translate ([2.58*pw,0.75*ph]) circle (lr, $fn=20);}
//light 17
if (lc17 == hc2) {color (c2) linear_extrude (height=lc17) translate ([3.0*pw,0.58*ph]) circle (lr, $fn=20);} else if (lc17 == hc3) {color (c3) linear_extrude (height=lc17) translate ([3.0*pw,0.58*ph]) circle (lr, $fn=20);} else if (lc17 == hc4) {color (c4) linear_extrude (height=lc17) translate ([3.0*pw,0.58*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc17) translate ([3.0*pw,0.58*ph]) circle (lr, $fn=20);} 
//light 18
if (lc18 == hc2) {color (c2) linear_extrude (height=lc18) translate ([3.48*pw,0.45*ph]) circle (lr, $fn=20);} else if (lc18 == hc3) {color (c3) linear_extrude (height=lc18) translate ([3.48*pw,0.45*ph]) circle (lr, $fn=20);} else if (lc18 == hc4) {color (c4) linear_extrude (height=lc18) translate ([3.48*pw,0.45*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc18) translate ([3.48*pw,0.45*ph]) circle (lr, $fn=20);} 
//light 19
if (lc19 == hc2) {color (c2) linear_extrude (height=lc19) translate ([4.02*pw,0.35*ph]) circle (lr, $fn=20);} else if (lc19 == hc3) {color (c3) linear_extrude (height=lc19) translate ([4.02*pw,0.35*ph]) circle (lr, $fn=20);} else if (lc19 == hc4) {color (c4) linear_extrude (height=lc19) translate ([4.02*pw,0.35*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc19) translate ([4.02*pw,0.35*ph]) circle (lr, $fn=20);}  
//light 20
if (lc20 == hc2) {color (c2) linear_extrude (height=lc20) translate ([4.58*pw,0.28*ph]) circle (lr, $fn=20);} else if (lc20 == hc3) {color (c3) linear_extrude (height=lc20) translate ([4.58*pw,0.28*ph]) circle (lr, $fn=20);} else if (lc20 == hc4) {color (c4) linear_extrude (height=lc20) translate ([4.58*pw,0.28*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc20) translate ([4.58*pw,0.28*ph]) circle (lr, $fn=20);} 
//light 21
if (lc21 == hc2) {color (c2) linear_extrude (height=lc21) translate ([5.15*pw,0.20*ph]) circle (lr, $fn=20);} else if (lc21 == hc3) {color (c3) linear_extrude (height=lc21) translate ([5.15*pw,0.20*ph]) circle (lr, $fn=20);} else if (lc21 == hc4) {color (c4) linear_extrude (height=lc21) translate ([5.15*pw,0.20*ph]) circle (lr, $fn=20); } else {color (c5) linear_extrude (height=lc21) translate ([5.15*pw,0.20*ph]) circle (lr, $fn=20);} 
//light 22
if (lc22 == hc2) {color (c2) linear_extrude (height=lc22) translate ([5.68*pw,0.16*ph]) circle (lr, $fn=20);} else if (lc22 == hc3) {color (c3) linear_extrude (height=lc22) translate ([5.68*pw,0.16*ph]) circle (lr, $fn=20);} else if (lc22 == hc4) {color (c4) linear_extrude (height=lc22) translate ([5.68*pw,0.16*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc22) translate ([5.68*pw,0.16*ph]) circle (lr, $fn=20);}  
//light 23
if (lc23 == hc2) {color (c2) linear_extrude (height=lc23) translate ([6.25*pw,0.12*ph]) circle (lr, $fn=20);} else if (lc23 == hc3) {color (c3) linear_extrude (height=lc23) translate ([6.25*pw,0.12*ph]) circle (lr, $fn=20);} else if (lc23 == hc4) {color (c4) linear_extrude (height=lc23) translate ([6.25*pw,0.12*ph]) circle (lr, $fn=20);} else {color (c5) linear_extrude (height=lc23) translate ([6.25*pw,0.12*ph]) circle (lr, $fn=20);}  
//light 24
if (lc24 == hc2) {color (c2) linear_extrude (height=lc24) translate ([7*pw,0.1*ph]) circle (lr,, $fn=20);} else if (lc24 == hc3) {color (c3) linear_extrude (height=lc24) translate ([7*pw,0.1*ph]) circle (lr,, $fn=20);} else if (lc24 == hc4) {color (c4) linear_extrude (height=lc24) translate ([7*pw,0.1*ph]) circle (lr,, $fn=20);} else {color (c5) linear_extrude (height=lc24) translate ([7*pw,0.1*ph]) circle (lr,, $fn=20);}