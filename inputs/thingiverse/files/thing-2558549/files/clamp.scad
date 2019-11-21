inner_diameter = 60;
length = 120;
height = 10;

gripper(inner_diameter, length, height);

module gripper(inner_diameter=60, length=120, height=10, rounding=4){
    inner_circle = inner_diameter; // diameter
    width = inner_circle+20-rounding;
    length = length-rounding;
    leg_length = length-width/2;
    h=height-rounding*2;


    difference(){
        minkowski(){
            union(){
                cube([width, leg_length, h]);
                translate([width/2, leg_length, 0]) cylinder(r=width/2, h=h);
            }
            sphere(rounding);
        }
        translate([width/2,leg_length, -1-rounding]){
            cylinder(r=inner_circle/2, h=height+2);
        }
        translate([0,0,-1-rounding])
        linear_extrude(height=height+2){
            polygon([ [5,-1-rounding], [width/2, leg_length], [width-5, -1-rounding]]);
        }
    }
}