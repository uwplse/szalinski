/*
Dice for Code Mainia
https://www.hopp-foundation.de/foerderangebot-schule/informatik/informatikspiele/code-mainia/
by Olaf Zelesnik
*/
$fn=50;
difference(){
//dice    
    intersection(){
        translate([20,20,20]) sphere(r=28);
        cube(40);
    };
//united numbers: -3; -2; -1; 1; 2; 3
    union(){
        rotate(a=180, v=[0,1,0]) translate ([-37,9,-1])linear_extrude(height=2) text("-1", size=25);
        rotate(a=-90, v=[0,0,1]) translate ([-30,9,39])linear_extrude(height=2) text("1", size=25);
        rotate(a=90, v=[0,1,0]) translate ([-29,9,39])linear_extrude(height=2) text("2", size=25);
        rotate(a=-90, v=[0,1,0]) translate ([4,9,-1])linear_extrude(height=2) text("-2", size=25);
        rotate(a=-90, v=[1,0,0]) translate ([10,-31,39])linear_extrude(height=2) text("3", size=25);
        rotate(a=90, v=[1,0,0]) translate ([4,8,-1])linear_extrude(height=2) text("-3", size=25);
       
    };
};

