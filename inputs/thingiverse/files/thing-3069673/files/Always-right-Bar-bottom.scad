//A plate with 4 holes even spaced on corners and two holes centered on the length axis. 
//spacing and size of corner holes are selectable using $hole and $corner_distance
//The two center holes are even spaced from the top and bottom using $center_distance and selectable hole size using $center_hole
//Thickness, length and width are all customizable using $length, $width, and $heigth
//The goal was to make a plate that was adjustable to dial in the right dimensions and to serve multiple purposes

/* [Bar] */
//Smoothness?
$fn=100;
//How wide should the bar be? (mm)
$width=30;
//how long should the bar be? (mm)
$length=100;
//How thick should the bar be? (mm)
$height=3;
$heigth=$height/2;
/* [Holes] */
//what is the diameter of the corner holes? (mm)
$hole=4;
//what is the outer diameter of the chamfer?
$counter_sink_d=7;
//How far above the part should the chamfer start (play with it)
$counter_sink_h=1.3;
//how far from the edges should the corner holes be centered? (mm)
$corner_distance=4.5;
//What is the diameter of the two center holes? (mm)
$center_hole=6;
//How far should the two center holes be centered from the length edges? (mm)
$center_distance=32;
/* [Ovals]) */
//what size ovals?
$oval1=0;
$oval2=0;
//Oval Width?
$oval_width=1.1;
//Wing Hole size
$wing=0;

/* [Text] */
//What is the hieght of of thext box?
$box_height=0;
//What is the width of the text box?
$box_width=13.5;
//What is the top Word 
$top_word="";
//What justification do you want (left, center,right)?
$top_just="center";
//What is the bottom Word (6 letters is about it)
$bottom_word="";
//What justification do you want (left, center,right)?
$bottom_just="left";
//Font Size
$font_size=4;
//Font 
//Font (NO QUOTES)
$font="Gadugi:style=Bold";



difference() {
    translate ([$width/2,$center_distance,-1]) cylinder(r=$width/2+11, h=3.5);
translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
            
        translate([25,$center_distance,-1])cylinder(d=$wing, h=7, $fn=100);
        translate([5,$center_distance,-1])cylinder(d=$wing, h=7, $fn=100);
    //#translate([15,50,-1])cylinder(d=20,h=5);
    #translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
    
   #translate([15,50,-1.5])scale([$oval_width,2.0,3.0]) cylinder (r=$oval2, h=1.5);
    
    #translate([15,13.5,-1.5])scale([$oval_width,2.0,3.0]) cylinder(r=$oval1, h=1.5);
    }
difference(){
    minkowski(){
cube([$width,$length,$heigth]);
        sphere(1);
    }
    #translate([$corner_distance,$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate ([$corner_distance,$corner_distance,$counter_sink_h])cylinder(r1=$hole/2,r2=$counter_sink_d/2,h=$counter_sink_h);
    #translate([$width-$corner_distance,$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate ([$width-$corner_distance,$corner_distance,$counter_sink_h])cylinder(r1=$hole/2,r2=$counter_sink_d/2,h=$counter_sink_h);
    #translate([$width-$corner_distance,$length-$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate ([$width-$corner_distance,$length-$corner_distance,$counter_sink_h])cylinder(r1=$hole/2,r2=$counter_sink_d/2,h=$counter_sink_h);
    #translate([$corner_distance,$length-$corner_distance,-1])cylinder(r=$hole/2,h=$heigth+2);
    #translate ([$corner_distance,$length-$corner_distance,$counter_sink_h])cylinder(r1=$hole/2,r2=$counter_sink_d/2,h=$counter_sink_h);
    
    #translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
    #translate([$width/2,$length-$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
    
    //#translate([15,50,-1])cylinder(d=20,h=5);
    #translate([15,50,-1.5])scale([$oval_width,2.0,3.0]) cylinder (r=$oval2, h=1.5);
    
    #translate([15,13.5,-1.5])scale([$oval_width,2.0,3.0]) cylinder(r=$oval1, h=1.5);
 
 //Text Box cutout   
    translate ([8.25,71.5,$height-.8]) cube([$box_width,$box_height,.4]);
    
   


}

// Text
translate([15.0, 85.5, 2.2]) {
    //(text line 1)
    rotate(90,180,0)
    linear_extrude(height = .4) text(text = $top_word, size = $font_size, font = $font, halign = $top_just, valign = "bottom", language = text_language);

    //(text line 2)
    rotate(90,180,0)
    translate([0, -6 ]) linear_extrude(height = .4) text(text = $bottom_word, size = $font_size, font=$font, halign = $bottom_just, valign = "bottom", language = text_language);
}


