/*clothes size marker
sign for typical clothes rail
2color version
20181002 P. de Graaff
*/
//size number
Text="48";
//true -> print marker  false -> print number for two color print
body="true";

if (body == "true"){
    difference(){
        resize(newsize=[40,60,2])cylinder(d=60,h=2,$fn=200);        //make oval outer cylinder
        resize(newsize=[20,35,2.2])cylinder(d=35,h=2.2,$fn=100);    //make oval inner cylinder
        translate([-2.5,-30,0])cube([5,30,5]);                     //gap for rail
        translate([0,19,1])
        #linear_extrude(height = 2,convexity=10)
        text(Text, size = 9, font ="Arial",halign="center", $fn = 100);
    }
}
if (body != "true"){
    translate([0,19,1])
    color("Green")linear_extrude(height = 1,convexity=10)
    text(Text, size = 9, font ="Arial",halign="center", $fn = 100);
}