/*door wedge with text
20181004 P. de Graaff
*/

//height in mm
height=30;
//length in mm
length=130;
//depth in mm
depth=50;

fontsize=18;

Text="don't close";

b=sqrt(height*height+length*length);
echo(b);

//Winkel berechnen
gamma=90-acos(height/b);
echo(gamma);

difference(){
    minkowski(){
        difference(){
            cube([length,depth,height]);
            translate([0,0,height])rotate([0,gamma,0])cube([length+10,depth+10,50]);
        }
        sphere(0.5);
    }
    #translate([0,depth/2,height-2])rotate([0,gamma,0])translate([b/2,0,0])
    color("Green")linear_extrude(height = 2.5,convexity=10)
    text(Text, size = fontsize, font ="Arial",valign="center",halign="center", $fn = 100);
}
