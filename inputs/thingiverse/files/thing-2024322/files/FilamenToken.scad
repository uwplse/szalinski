//Changes the "roundness"
$fn=100;

//First line text
line1="Top";
//Font size of first line
size1=2;
//Offset of first line
off1=4;
//Second line text
line2="Bottom";
//Font size of second line
size2=2;
//Offset of second line
off2=-4;

//Ignore all of this, this is what generates the token
difference() {
    cylinder(r=10,h=1);

    translate([0,off1,1]){
        text(line1,size=size1,halign="center",valign="center");
    }
    translate([0,off2,1]) {
        text(line2,size=size2,halign="center",valign="center");
    }
}