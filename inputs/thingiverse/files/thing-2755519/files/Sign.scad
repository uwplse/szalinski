//Thickness of the plate
thickness = 5;  
//Tilt angle in degrees
angle = 130; 
//Fillet radius, should have larger value than thickness
R1 = 15;
R2 = R1 - thickness;
//Length of the base part
A = 40;
//Length of the tilt part
B = 20;
//Width of the sign
C = 200;
text = "EXPERIMENT IN PROGRESS";
//Font of the text
font = "Calibri";
language = "en";
//Style of the text, options: Blank, 'Bold', 'Bold Italic', 'Italic'
style = "Bold";
// Size of the text
size = 13;
//Vertical shift of the text
D = 0;


coordR1 = [ for (a1 = [ 0 :1: angle ]) let (b1 = R1*sin(a1), c1 = R1*cos(a1) ) [ b1, c1 ] ]; 
coordR2 = [ for (a2 = [ 0 :1: angle ]) let (b2 = R2*sin(angle-a2), c2 = R2*cos(angle-a2)) [ b2, c2 ] ]; 

points=concat(coordR1,[[R1*sin(angle)+A*sin(angle+90),R1*cos(angle)+A*cos(angle+90)],[R2*sin(angle)+A*sin(angle+90),R2*cos(angle)+A*cos(angle+90)]],coordR2,[[-B,R2],[-B,R1]]);

rotate([0, 0, 180])rotate([0, 90, 0])rotate([0, 0, angle-90]) union(){
 linear_extrude(height = C, center = true, convexity = 10, slices = 20, scale = 1.0){
    polygon(points); }

translate([-D-B,R2,0]) rotate([-90, 90, 0]) linear_extrude(height = thickness,  convexity = 10, slices = 20, scale = 1.0){
    text(text, font = str(font,":style=",style), size = size, halign = "center", language = language);  }
}
