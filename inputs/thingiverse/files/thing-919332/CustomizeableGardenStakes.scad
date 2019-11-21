//Customizeable Garden Signs

//Approximite Size For Each Letter
Size = 10;

//Text
Text = "LETTUCE";

//Letters In The Text
Letters = 7;

//Thickness
Thickness = 3;

//Center (Distance That The Base Will Go To The Left)
Centerx = -5;

//Center (Distance That The Base Will Go Up)
Centery = 3;

//Stake Width
Width = 5;

//Stake Length
Length = 100;


//Base(Green)
translate([0,Length,0]){
    difference(){
        translate([(Letters*Size)/4+Centerx,(Letters*Size)/4+Centery,0]){
            hull(){
                cylinder(Thickness,(Letters*Size)/4,(Letters*Size)/4);
                translate([(Letters*Size)/2,0,0]){
                    cylinder(Thickness,(Letters*Size)/4,(Letters*Size)/4);
                }
            }
        }
        //Letters(White)
        color("Gold"){
            translate([0,(Letters*Size)/4,0]){
                translate([0,0,Thickness]){
                    text(Text, Size, "Liberation Serif");
                }
            }
        }
    }
}

//Stake(Grey)
color("SlateGray"){
    translate([Centerx,Centery,0]){
        translate([(Letters*Size)/2-Width/2,0,0]){
            cube([Width,Length,Thickness]);
        }
    }
}