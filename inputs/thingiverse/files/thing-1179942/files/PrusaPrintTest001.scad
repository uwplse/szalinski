
module PrusaPrintTest001()
{
    xpos= 75;
    ypos = 75;
    rsize = 10;
    
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

PrusaPrintTest001();