diameter=17.65;
height=3.35;

fn=100;

// Higher number means less rounding.
rounding_factor=3;

{
    int_corner_r=height/rounding_factor;
    int_d=diameter-int_corner_r*2;
    int_h=height-int_corner_r*2;
    minkowski() {
        sphere(r=int_corner_r, center=true, $fn=fn);
        cylinder(d=int_d, h=max(0.01,int_h), center=true, $fn=fn);
    }
    
    // how did it do against the goal size?
    //translate([0,0,-height/2])color("red")cylinder(d=diameter, h=height, center=true, $fn=fn);
    //color("red")translate([diameter/2,0,0])cylinder(d=diameter, h=height, center=true, $fn=fn);
}

