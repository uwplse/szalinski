
height = 5;
width = 4.5;
//output STL in inches:
scale(25.4, 25.4, 25.4)
difference(){
    difference() {
        union(){
            difference(){
                //Main plate:
                cube([height,width,0.25], center=true);
                //Subtract the corner:
                translate([2,2,0])
                    cube([1,1,2], center=true);
                
            }
            translate([1.5,1,-0.125])
                cylinder(0.5, r = 1.75, center = true, $fn=200);
        }
        //center hole
        translate([1.5,1, -0.95])
        cylinder(2, r = 0.75, center = true, $fn=200);
        
        //top notch to allow axle to slide in from top
        translate([4,1,-0.2])
        cube([5,1.5,0.5], center=true);
        
    }
    translate([-2,-1.75,1])
        cylinder(3, r=0.07, center = true, $fn=100);
     translate([-0,-1.75,1])
        cylinder(3, r=0.07, center = true, $fn=100);
      translate([2,-1.75,1])
        cylinder(3, r=0.07, center = true, $fn=100);
      translate([-2,-1.75,-0.1])
        cylinder(.1, r=0.15, center = true, $fn=100);
      translate([-0,-1.75,-0.1])
        cylinder(.1, r=0.15, center = true, $fn=100);
      translate([2,-1.75,-0.1])
        cylinder(.1, r=0.15, center = true, $fn=100);
}
