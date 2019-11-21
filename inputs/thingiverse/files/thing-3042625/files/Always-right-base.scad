//A plate with 4 holes even spaced on corners and two holes centered on the length axis. 
//spacing and size of corner holes are selectable using $hole and $corner_distance
//The two center holes are even spaced from the top and bottom using $center_distance and selectable hole size using $center_hole
//Thickness, length and width are all customizable using $length, $width, and $heigth
//The goal was to make a plate that was adjustable to dial in the right dimensions and to serve multiple purposes

//Smoothness?
$fn=100;
//How wide should the bar be? (mm)
$width=30;
//how long should the bar be? (mm)
$length=100;
//How thick should the bar be? (mm)
$heigth=3;
//what is the diameter of the corner holes? (mm)
$hole=4;
//how far from the edges should the corner holes be centered? (mm)
$corner_distance=3;
//What is the diameter of the two center holes? (mm)
$center_hole=6;
//How far should the two center holes be centered from the length edges? (mm)
$center_distance=32;
difference(){
    minkowski(){
cube([$width,$length,$heigth]);
        sphere(1);
    }
    #translate([$corner_distance,$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate([$width-$corner_distance,$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate([$width-$corner_distance,$length-$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate([$corner_distance,$length-$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
    #translate([$width/2,$length-$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);


}