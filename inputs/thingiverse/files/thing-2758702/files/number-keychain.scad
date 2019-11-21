text1="1";
textfont="arialblack";
fontsize1=20;

union(){
    difference(){
    cylinder(h=3,r=30,$fn=100);  
    translate([0,0,2])
    cylinder(h=4,r=26,$fn=100);
         
}
difference(){
translate([0,37,0])
cylinder(h=3,r=10,$fn=100);
translate([0,37,-10+2])
cylinder(h=10+2,r=6.5,$fn=100);
}
linear_extrude(height=3)
text(text1,halign="center",valign="center",size=fontsize1,font=textfont);
}

