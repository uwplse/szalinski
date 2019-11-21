//$fn=50;
line1 = "DID YOU FEED";
line2 = "THE CATS?";
line3 = "SUN";
line4 = "MON"; 
line5 = "TUE";
line6 = "WED";
line7 = "THU";
line8 = "FRI"; 
line9 = "SAT";
//Font style and size. Go to Help->Font List, to see all available fonts. 
Font_Lines1to2 = "Liberation Sans:style=Bold"; 
Font_Size_lines1to2 = 5;
Font_Lines3to9 = "Liberation Sans:style=Bold"; 
Font_Size_lines3to9 = 5;
Day_Font_Position = -24;



module titles(line_num, alignment, font_type, fontsize, X_pos, Y_pos){
    translate ([X_pos, Y_pos, 1.5]) {
    
            linear_extrude(height = 1.5) {
    text(line_num, font = font_type, size = fontsize, halign = alignment, valign = "center");
                    }
                }
            }
    
module all_text(){
titles(line1, "center", Font_Lines1to2, Font_Size_lines1to2, 0, 40);
titles(line2, "center", Font_Lines1to2, Font_Size_lines1to2, 0, 32);
titles(line3, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, 16.25+7/2);  
titles(line4, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, 6.25+7/2); 
titles(line5, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -3.75+7/2); 
titles(line6, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -13.75+7/2); 
titles(line7, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -23.75+7/2); 
titles(line8, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -33.75+7/2);
titles(line9, "left", Font_Lines3to9, Font_Size_lines3to9, Day_Font_Position, -43.75+7/2);
    }                       
            
module base(){
translate([0,0,1.5/4]){

minkowski(){
    cube([55-2*7.53,95-2*7.53,1.5/2],center=true);
    cylinder(r=7.53, h=1.5/2);
}
}
}

module slot(x,y){  //Cutout slot, (x,y) = position
translate([x,y,0]){
union(){
cube([18.5,7,1.5]);
translate([0,3.5,0]){
    cylinder(r=3.5,h=1.5);
}
translate([18.5,3.5,0]){
    cylinder(r=3.5,h=1.5);
}
}
}
}


//Create the baseplate with 7 cutout slots 

module baseplate(){
difference(){
    base();
    slot(-1.75,16.25); //Sunday
    slot(-1.75,6.25); //Monday
    slot(-1.75,-3.75); //Tuesday
    slot(-1.75,-13.75); //Wednesday
    slot(-1.75,-23.75); //Thursday
    slot(-1.75,-33.75); //Friday
    slot(-1.75,-43.75); //Saturday
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
     
 translate([-55/2,0,0]){
 tab(0);
 }
 
translate([55/2,0,0]){
    tab(180);
}
translate([0,-95/2,0]){
    tab(90);
}

translate([0,95/2,0]){
    tab(270);
}
}

union(){
    baseplate();
    all_text();
    tabs();
}
