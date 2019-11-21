difference() {cylinder(d = 46.5, h = 10, $fn = 10);cylinder(d = 44, h=12, $fn = 10);}
First_Char = "1";
Second_Char = "2";
Third_Char = "3";
Fourth_Char = "4";
Fifth_Char = "5";
Sixth_Char = "6";
Seventh_Char = "7";
Eighth_Char = "8";
Ninth_Char = "9";
Tenth_Char = "10";
translate([2,22.5,2.5]){
    rotate([90,0,180]){text(First_Char, 5);}
}
//text(t, size, font, halign, valign, spacing, direction, language, script)