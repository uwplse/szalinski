length    = 35;
radius    = 8;
hole      = 1.5;
textSize = 9; 
textHeight  = 1;
thickness = 2;
resulution= 60;
fontName = "Segoe Print:style=Regular";
names = ["John","Halil","Tessa","Bill","Chris","Ali","Pierre"];
perRow = 4;
deltaY = (radius*2)+5;
deltaX = length + 2* radius + 5;


for(i=[0 : 1 : len(names) - 1]){
    echo();
    dx = floor(i/perRow)*deltaX;
    dy = (i%perRow)*deltaY;
    echo(dx);
    echo(dy);
    union(){
    translate([dx+(length/2),dy-(textSize/2),0]) linear_extrude(thickness+textHeight) text(names[i], font = fontName, size = textSize,halign = "center");
        
    linear_extrude(thickness) difference(){
        hull() {
            translate([dx+length,dy,0]) circle(radius,$fn=resulution);
            translate([dx,dy,0]) circle(radius,$fn=resulution);
            };
        translate([dx-(radius/2),dy,0]) circle(hole,$fn=resulution);
    };
    };
    
};