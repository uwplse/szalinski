
/* [Size] */
size = 180; //[1:500]

circle_diameter = 20; //[1:50]

module fivePoint1stLayerPrintTest()
{
    rsize = circle_diameter/2;
    xpos= size/2 - rsize;
    ypos = size/2 - rsize;
    
    union() {
translate([-xpos,-ypos,0]){
      cylinder(r=rsize, h=0.3, center = true);
}
translate([xpos,-ypos,0]){
      cylinder(r=rsize, h=0.3, center = true);
}
translate([-xpos,ypos,0]){
      cylinder(r=rsize, h=0.3, center = true);
}
translate([xpos,ypos,0]){
      cylinder(r=rsize, h=0.3, center = true);
}
cylinder(r=rsize, h=0.3, center = true);

rotate([0,0,45])
      cube([(xpos+ypos)*1.4, 3, 0.3], center = true);
rotate([0,0,-45])
      cube([(xpos+ypos)*1.4, 3, 0.3], center = true);

    }
    
}

fivePoint1stLayerPrintTest();