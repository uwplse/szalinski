//What started as a plate with 4 holes even spaced on corners and two holes centered on the length axis. 
//
//Turned into this
//The goal was to teach myself something new and OpenSCAD became my candidate. 
//this has morhped into my "Always Right" housing and transmission.
//spacing and size of corner holes are selectable using $hole and $corner_distance
//The two center holes are even spaced from the top and bottom using $center_distance and selectable hole size using $center_hole
//Thickness, length and width are all customizable using $length, $width, and $heigth
// Defaults will build a 100mm bar set for gears and pins on thingiverse

/* [Bar] */
//Smoothness?
$fn=200;
//How wide should the bar be? (mm)
$width=30;
//how long should the bar be? (mm)
$length=100;
//How thick should the bar be? (mm)
$height=3*1;
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
$oval1=6;
$oval2=6;
//Oval Width?
$oval_width=1.1;
//Wing Hole size
$wing=27;
center=$width/2;

/* [Text] */
//What is the length of of text box?
$box_length=28;
//What is the height of the text box?
$box_height=13.5;
//how far from the edge should the box start?
$box_start=.75;
//What is the top Word (you can use whitespace to position)
$top_word="I'm Always";
////What justification do you want (left, center,right)?
//What is the bottom line? (you can use whitespace to position)
$bottom_word="Right";
//What is the text height?
$text_h=.4;

//Font Size
$font_size=4;
//Font 
//Font (NO QUOTES)
$font="Gadugi:style=Bold";



difference() {
    translate ([center,$center_distance,-1]) cylinder(r=$width/2+11, h=3.5);
translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
            
        translate([$width-5,$center_distance,-1])cylinder(d=$wing, h=7, $fn=100);
        translate([5,$center_distance,-1])cylinder(d=$wing, h=7, $fn=100);
    #translate([$width/2,$center_distance,-1])cylinder(r=$center_hole/2,h=$heigth+2);
    
   #translate([center,$center_distance+18,-1.5])scale([$oval_width,2.0,3.0]) cylinder (r=$oval2, h=1.5);
    
    #translate([center,$center_distance-18,-1.5])scale([$oval_width,2.0,3.0]) cylinder(r=$oval1, h=1.5);
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
    #translate([center,$center_distance+18,-1.5])scale([$oval_width,2.0,3.0]) cylinder (r=$oval2, h=1.5);
    
    #translate([center,$center_distance-18,-1.5])scale([$oval_width,2.0,3.0]) cylinder(r=$oval1, h=1.5);
 
 //Text Box cutout   
    translate ([center-($box_height/2),$length-($box_length+$box_start),$height-.8]) cube([$box_height,$box_length,.4]);
    
   


}

// Text
translate([center, $length-$box_start-.25, 2.2]) {
    //(text line 1)
    rotate(90,180,0)
    linear_extrude(height = $text_h) text(text = $top_word, size = $font_size, font = $font, halign = "right", valign = "bottom", language = text_language);

    //(text line 2)
    rotate(90,180,0)
    translate([0, -6 ]) linear_extrude(height = $text_h) text(text = $bottom_word, size = $font_size, font=$font, halign = "right", valign = "bottom", language = text_language);
}
