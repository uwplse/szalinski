pitch_diameter=10;
center_hole_diameter=2;
circular_belt_diameter=2;

height=3;

difference(){
    cylinder(h=height,d=pitch_diameter,$fn=30,center=true);
    cylinder(h=height+1,d=center_hole_diameter,$fn=30,center=true);
    rotate_extrude(convexity = 10, $fn = 100)translate([pitch_diameter/2, 0, 0])circle(d = circular_belt_diameter, $fn = 100);
    
    
}

