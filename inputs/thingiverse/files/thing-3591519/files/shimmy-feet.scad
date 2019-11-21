// Ender Shimmy Feet
// Copyright A.Wilson
// 2019-04-27

$fn = 120;

// What is the height of this shim (not including ridge)? [mm]
height = 5; // [1:1:25]

// What is the inner diameter at the top / size of the thing that will sit on top? [mm]
diameter_top = 17;

// What is the diameter of the base? [mm]
diameter_base = 26;

// What is the size of the rim (both height and width)? [mm]
rim = 1.5;

// What is the text size? [mm]
text_size = 6;

// auto-dimension the text height
text_height = height < 4 ? 1 : 1.5;

// format the text marking
marking = str("+",height);

difference() {
    cylinder(h = height+rim, r1 = diameter_base/2, r2 = diameter_top/2+rim);
    
    translate([0,0,height]) cylinder( h = 2*rim, r=diameter_top/2 );
    
    translate([0,0,height-text_height]) linear_extrude(height = 2*text_height) text(text=marking, size=text_size, font="Helvetica", halign="center", valign="center");
}