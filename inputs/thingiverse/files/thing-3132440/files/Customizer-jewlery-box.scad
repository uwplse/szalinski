//Cutomizable Jewlery Box with Lid

//Width
X=50;
//Length-Must by 1.5 Times Larger Than Width if adding Initials
Y=75;
//Height
Z=18;
//Wall Thickness
T=4;
//Lid Thickness
L=2;
//Initials (Max 3 Characters)
A="CJT";
module LetterBlock(letter, size=X/2) {

           linear_extrude(height=size, convexity=4)
               text(letter, 
                    size,
                    font="Bitstream Vera Sans",
                    halign="center",
                    valign="center");
                               }

//equations
module Box(){
difference(){
    cube([Y,X,Z],center=true);
    translate([0,0,T])
cube([Y-2*T,X-2*T,Z-T],center=true);}}
difference(){
Box();
translate([0,0,-(Z/2)+(T/2)])
LetterBlock(A);}


  union(){
translate([Y+5,0,-(Z/2)+(L/2)])
cube([Y,X,L],center=true);
translate([Y+5,0,-(Z/2)+(L/2)+L])
cube([Y-2*T-.5,X-2*T-.5,L],center=true);}