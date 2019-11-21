//Choose width of the box
width=60; //[10:1:300]
//Choose length of the box
length=60; //[10:1:300]
//Choose heigth of the box
heigth=20; //[10:.5:300]
//Choose bottom thikness of the box
bottom=2; // [1:1:6]
//Choose the wall thickness of the box
wall=4; //[1:..5:6]
//Choose the height of the top
top_heigth=3;//[1:.5:150]
//Choose the tolerance between top and bottom part
tolerance=.6; //[0:.05:1]

    // Enter your text Line 1
    text_box1 = "Line 1";
    // Enter your text Line 1
    text_box2 = "Line 2";
    // Enter your text Line 1
    text_box3= "Line 3";
    // Enter text size
    text_size= 3;




difference(){  
//difference outer shell
difference(){  
//OUTER SHELL  
  cube([width,length,heigth]);
translate([wall,wall,bottom])
cube ([width-2*wall,length-2*wall,heigth]);
}
    
difference () {
//INNER SHELL
translate([0,0, heigth-top_heigth])
cube([width, length, top_heigth]);
translate([wall/2,wall/2, heigth-top_heigth])
cube([width-(wall), length-wall, top_heigth]);
}    
}
//TOP
difference () {

translate([width+10,0, 0])
cube([width, length, bottom+top_heigth]);
translate([width+10+(wall/2)-tolerance/2,(wall/2)-tolerance/2,bottom])
cube([width-wall+tolerance, length-wall + tolerance, top_heigth]);
//TEXT DIFFERENCE
    
font1 = "Archivo Black"; // here you can select other font type


translate ([width*1.5+10,length/2-(text_size/2),heigth]) {
rotate([0,180,0])
linear_extrude(height = 60) {
text(text_box2, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}}
translate ([width*1.5+10,length/2+(text_size/2)*2,heigth]) {
rotate([0,180,0])
linear_extrude(height = 60) {
text(text_box1, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}}
translate ([width*1.5+10,length/2-(text_size*2),heigth]) {
rotate([0,180,0])
linear_extrude(height = 60) {
text(text_box3, font = font1, size = text_size, halign="center",  direction = "ltr", spacing = 1 );
    ;
}}



}
//}

//text difference end
//}
//}