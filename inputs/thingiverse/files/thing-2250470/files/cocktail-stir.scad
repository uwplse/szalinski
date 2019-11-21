Text="5PM";
CircleSize=200; // [50:400]
TextSize=20;  // [10:35]
Font="Century"; // [Arial,Arimo,Arvo,Cabin Condensed,Calibri,Cambria,Candara,Century,Comic Sans MS,Consolas,Courier New,Deibi,DejaVu Sans,Fontin Sans,Franklin Gothic Medium,Gabriola,Gadugi,Georgia,Impact,MS Gothic,Tahoma,Times New Roman,Wingdings]
TextHeight=5; // [0:20]
StickLengthMM=150; // [0:5:300]
TopSides=8;// [0:200]
TopTwist=30;// [0:150]
translate([0,-3.5,0]) {
cube([StickLengthMM,7,3]);}
translate([0,0,1.5]) {
linear_extrude(height =3, center = true, convexity = 100, twist =TopTwist, slices = 200, scale = 1.0) {
scale([10/100, 10/100, 10/100]) circle(CircleSize, $fn=TopSides);}}
scale([0.6,0.6,1]){
rotate(a=[0,0,90]) {
translate([0,0,1.5]) {
linear_extrude(TextHeight)
    text(Text, halign="center", valign="center", size=TextSize, font=Font);}}}