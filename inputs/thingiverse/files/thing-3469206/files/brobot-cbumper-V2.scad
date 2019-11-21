// BROBOT EVO 2 customizable bumper
// JJROBOTS
// For thinguiverse customizer tool

// preview[view:south west, tilt:top diagonal]

bumper_text = "JJROBOTS";

text_size = 9; //[3:12]

text_font = "font1"; //[font1,font2,font3] 

// bumper
/* [Hidden] */
bumper = [[ -13.67812, -52.5 ], [ -13.6351, -65.00759 ], [ -13.24911, -74.43299 ], [ -12.48869, -82.53739 ], [ -11.37279, -89.26354 ], [ -9.86998, -94.66884 ], [ -8.05664, -98.67951 ], [ -6.82256, -100.49508 ], [ -5.61003, -101.82489 ], [ -4.37148, -102.85987 ], [ -2.92737, -103.64174 ], [ -1.08473, -104.24709 ], [ 1.10223, -104.69063 ], [ 3.54325, -105.0 ], [ 14.09606, -105.0 ], [ 14.09606, -108.0 ], [ 3.7702, -108.0 ], [ 1.12927, -107.61976 ], [ -1.15545, -107.09505 ], [ -3.1964, -106.37092 ], [ -4.93641, -105.44706 ], [ -6.36754, -104.37459 ], [ -8.0772, -102.65623 ], [ -9.88064, -100.37831 ], [ -10.97808, -98.60124 ], [ -11.95121, -96.52943 ], [ -12.8403, -93.95893 ], [ -13.74933, -90.41778 ], [ -14.60793, -86.27231 ], [ -15.21472, -82.37058 ], [ -15.83358, -75.42103 ], [ -16.25758, -65.86363 ], [ -16.44864, -54.83641 ], [ -16.43325, -52.49996 ], [ -13.67812, -52.5 ]];


difference(){
// Bumper
union(){
linear_extrude(height=28)
{
translate([-14-6,52.5,0])polygon(points=bumper);
translate([-14-6,-52.5,0])mirror([0,1,0])polygon(points=bumper);
}
translate([-6.25,52.5,0])cube([6.25,3,28]);
translate([-6.25,-52.5-3,0])cube([6.25,3,28]);
}

// Text
translate([-14-14-6-0.25,0,14])rotate([90,0,-90])linear_extrude(height=4)
{
    // We use three different google fonts
    if (text_font=="font1") text(font="Luckiest Guy",text=bumper_text,size=text_size,halign="center",valign="center");
    if (text_font=="font2") text(font="Open Sans:style=Bold",text=bumper_text,size=text_size,halign="center",valign="center");
    if (text_font=="font3") text(font="Raleway:style=Black",text=bumper_text,size=text_size,halign="center",valign="center");
        
}

// Holes
translate([-13.5,0,26.9])rotate([90,0,0])cylinder(r=3.25,h=200,$fn=16,center=true);

translate([-6.5,0,18.5])rotate([90,0,0])cylinder(r=1.65,h=200,$fn=16,center=true);
translate([-6.5,-52.5-3,18.5])rotate([90,0,0])cylinder(r=3.65,h=2.5,$fn=16,center=true);
translate([-6.5,52.5+3,18.5])rotate([90,0,0])cylinder(r=3.65,h=2.5,$fn=16,center=true);

// Borders cuts
translate([-3,52.5-0.5,0])rotate([0,30,0])cube([6,4,6]);
translate([-3,52.5-0.5,28])rotate([0,60,0])cube([6,4,6]);
translate([-3,-52.5-3.5,0])rotate([0,30,0])cube([6,4,6]);
translate([-3,-52.5-3.5,28])rotate([0,60,0])cube([6,4,6]);

}
