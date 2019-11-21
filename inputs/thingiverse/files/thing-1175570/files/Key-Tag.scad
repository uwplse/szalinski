Length = 55;
Width = 20;
Hole_Diameter = 10;
Thickness = 2;
// You may need to adjust this to fit the tag
Text_Size = 1.4;  // [0.1:0.1:2]
// The default font works well, but change it if you need.
Font = "Liberation San";
// Text on the tag.
Line1 = "Cort's";
// Leave this blank if you only need a single line. The text will auto-resize.
Line2 = "Tesla S";

/* [Hidden] */
$fs=0.1; // Circle Resolution
//Hole_Radius = (Width-6)/2;
Hole_Radius = Hole_Diameter/2;
Filet = 2;
Text_Indent = 1.5;
//Font_and_Style = "Liberation San:style=Bold";
Font_and_Style = str(Font,":style=Bold");

difference(){
    union(){
        translate([Filet,Filet,0]) cylinder(r=Filet,h=Thickness);
        translate([Filet,Width-Filet,0]) cylinder(r=Filet,h=Thickness);
        translate([0,Filet,0]) cube([Filet,Width-Filet*2,Thickness]);
        translate([Filet,0,0]) cube([Length-Width/2-Filet,Width,Thickness]);
        translate([Length-Width/2,Width/2,0]) cylinder(r=Width/2,h=Thickness);
    }
    translate([Length-Hole_Radius-3,Width/2,-1]) cylinder(r=Hole_Radius,h=Thickness+10);
    if (Line2 == "") {
        translate([Text_Indent,Width/2,Thickness-1]) linear_extrude(2) scale([Text_Size,Text_Size,1]) text(Line1, font=Font_and_Style,valign="center");
    } else {
        translate([Text_Indent,Width/2+0.5,Thickness-1]) linear_extrude(2) scale([Text_Size/2,Text_Size/2,1]) text(Line1, font=Font_and_Style,valign="bottom");
        translate([Text_Indent,Width/2-0.5,Thickness-1]) linear_extrude(2) scale([Text_Size/2,Text_Size/2,1]) text(Line2, font=Font_and_Style,valign="top");
    }
}