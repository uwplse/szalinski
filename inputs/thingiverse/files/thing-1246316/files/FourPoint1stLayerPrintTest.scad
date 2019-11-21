
/* [Size] */
size = 170; //[1:500]

circle_diameter = 20; //[1:50]

module fourPoint1stLayerPrintTest()
{
    rsize = circle_diameter/2;
    xpos= size/2 - rsize;
    ypos = size/2 - rsize;
    
    union() {
        translate([0,ypos,0]){
              cylinder(r=rsize, h=0.3, center = true);
        }
        translate([cos(30)*xpos,-sin(30)*ypos,0]){
              cylinder(r=rsize, h=0.3, center = true);
        }
        translate([-cos(30)*xpos,-sin(30)*ypos,0]){
              cylinder(r=rsize, h=0.3, center = true);
        }
        cylinder(r=rsize, h=0.3, center = true);
        
        translate([0,ypos/2,0]){
              cube([3, size/2, 0.3], center = true);
        }
        translate([-cos(30)*xpos/2,-sin(30)*ypos/2,0]){
            rotate([0,0,30])
                cube([size/2, 3, 0.3], center = true);
        }
        translate([cos(30)*xpos/2, -sin(30)*ypos/2, 0]){
            rotate([0,0,-30])
                cube([size/2, 3, 0.3], center = true);
        }

    }
    
}

fourPoint1stLayerPrintTest();