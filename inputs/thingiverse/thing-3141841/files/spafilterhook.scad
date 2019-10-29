// Tool to remove filter bucket from jacuzzi
// Made by Torkel Borjeson 2018-10-07
// E-mail torkelb+thingiverse@gmail.com

diameter = 140.0;
width = 4.0;
height = 3.0;
$fn=50;

module hollowCylinder(diam, wid) {
    difference() {
        cylinder(height, d=diam, true);
        translate([0,0, -height])
            cylinder(height*3, d=(diam-2*wid), true);
    }
}

module arc(diam, wid) {
    difference() {
        hollowCylinder(diam, width);        
        translate([0, diam/2, 0])
            cube([diam,diam, height*4], true); 
    }
}

hookDiameter = 15;

module hook(pos) {
    translate([-pos, 0, 0])
    rotate([0, 0, 180])        
    arc(hookDiameter, width);
}
union() {
    arc(diameter, width);
    translate([0, -diameter/2-width, 0]) 
        hollowCylinder(hookDiameter, width);
    hook(diameter/2+width-0.5);
    hook(-(diameter/2+width-0.5));
}