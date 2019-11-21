//$fn=50;
line1 = "DID YOU TAKE";
line2 = "YOUR PILLS?";
line3a = "AM";
line3b = "PM";
line4 = "SUN";
line5 = "MON"; 
line6 = "TUE";
line7 = "WED";
line8 = "THU";
line9 = "FRI"; 
line10 = "SAT";
//Font style and size. Go to Help->Font List, to see all available fonts. 
Letter_Height = 1;
Font_Lines1to2 = "Liberation Sans:style=Bold"; 
Font_Size_lines1to2 = 5;
Font_Size_line3 = 4;
Font_Line3 = "Liberation Sans:style=Bold"; 
Font_Lines3to9 = "Liberation Sans:style=Bold"; 
Font_Size_lines3to9 = 5;
Day_Font_Position = -30;
AM_Position = -5;
PM_Position = 20.5;



module titles(line_num, alignment, font_type, fontsize, X_pos, Y_pos){
    translate ([X_pos, Y_pos, 1.5]) {
    
            linear_extrude(height = Letter_Height) {
    text(line_num, font = font_type, size = fontsize, halign = alignment, valign = "center");
                    }
                }
            }
    
module all_text(){
/////////////Task Title////////////////////////
titles(line1, "center", Font_Lines1to2, Font_Size_lines1to2, 0, 44);
titles(line2, "center", Font_Lines1to2, Font_Size_lines1to2, 0, 36);
//////////////AM PM////////////////////////////
titles(line3a, "center", Font_Line3, Font_Size_line3,AM_Position, 27);
titles(line3b, "center", Font_Line3, Font_Size_line3,PM_Position, 27);    
/////////////Days of the Week//////////////////
titles(line4, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, 16.25+7/2);  
titles(line5, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, 6.25+7/2); 
titles(line6, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -3.75+7/2); 
titles(line7, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -13.75+7/2); 
titles(line8, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -23.75+7/2); 
titles(line9, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -33.75+7/2);
titles(line10, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -43.75+7/2);
    }                       
            
module base(){
translate([0,0,1.5/4]){

minkowski(){
    cube([70-2*7.53,100-2*7.53,1.5/2],center=true); //60mm X 100mm
    cylinder(r=7.53, h=1.5/2);
}
}
}

module slot(x,y){  //Cutout slot, (x,y) = position
translate([x,y,0]){
union(){
cube([8.5,7,1.5]);
translate([0,3.5,0]){
    cylinder(r=3.5,h=1.5);
}
translate([8.5,3.5,0]){
    cylinder(r=3.5,h=1.5);
}
}
}
}


//Create the baseplate with 7 cutout slots 

module baseplate(){
difference(){
    base();
    slot(-9.25,16.25); //Sunday-AM
    slot(-9.25,6.25); //Monday-AM
    slot(-9.25,-3.75); //Tuesday-AM
    slot(-9.25,-13.75); //Wednesday-AM
    slot(-9.25,-23.75); //Thursday-AM
    slot(-9.25,-33.75); //Friday-AM
    slot(-9.25,-43.75); //Saturday-AM
    
    slot(16.25,16.25); //Sunday-PM
    slot(16.25,6.25); //Monday-PM
    slot(16.25,-3.75); //Tuesday-PM
    slot(16.25,-13.75); //Wednesday-PM
    slot(16.25,-23.75); //Thursday-PM
    slot(16.25,-33.75); //Friday-PM
    slot(16.25,-43.75); //Saturday-PM
}


}

module tab(angle){
rotate(a=angle, v=[0,0,1]){
rotate(a=-90, v=[0,1,0]){
rotate(a=90, v=[1,0,0]){
 linear_extrude(height = 9.5, center = true, convexity = 10, twist = 0, slices = 100, scale = 1.0) {
 polygon(points=[[0,0],[1.5/2,1.5],[1.5,0]]);
 }
 }
 }
 }
 }
 //Create the triangular connecting tabs
 module tabs(){
     
 translate([-70/2,0,0]){
 tab(0);
 }
 
translate([70/2,0,0]){
    tab(180);
}
translate([0,-100/2,0]){
    tab(90);
}

translate([0,100/2,0]){
    tab(270);
}
}

union(){
    baseplate();
    all_text();
    tabs();
}
