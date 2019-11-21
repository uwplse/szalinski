/*clothes size marker 
sign for typical clothes rail
size punched out
20181003 P. de Graaff
*/
//size number
Text="40";

Fontsize=6;

TextPosition=19;

//Anpassung der Schriftgröße - adaption of the fontsize

difference(){
    resize(newsize=[40,60,2])cylinder(d=60,h=2,$fn=200);    //make oval outer cylinder
    resize(newsize=[20,35,2.2])cylinder(d=35,h=2.2,$fn=100);//make oval inner cylinder
    #translate([-2.5,-35,0])cube([5,30,5]);                 //gap for rail
    translate([0,TextPosition,-1])
    #color("Green")linear_extrude(height = 3,convexity=10)
    text(Text, size = Fontsize, font ="Arial",halign="center", $fn = 100);
}
