/*
Text Keychain Generator
B_Layne
https://www.thingiverse.com/B_Layne/designs
*/

$fn=360; //resolution of curves

Text="Keychain";
length2=len(Text);

length = length2*8; //length of input text multiplied by 8

difference(){
    //Makes oval base and cuts a circle out at the far end
    hull(){
        cylinder(h=2, d=22);
        translate([length+8,0,0])
        cylinder(h=2, d=22);
    }
    translate([length+8,0,0]) //Positions the hole to cut
    cylinder(h=2, d=17);
    }
    color("black") //only for rendering
    //Moves all text down to center string when ygpqj are in input
    if(search("ygpqj", Text)){
        translate([-5, -1, 0])
            linear_extrude(3)
                resize([length, 0], auto = true)
                    text(Text, valign = "center");
    }
    else{
        translate([-5, 0, 0])
            linear_extrude(3)
                resize([length, 0], auto = true)
                    text(Text, valign = "center");
    }