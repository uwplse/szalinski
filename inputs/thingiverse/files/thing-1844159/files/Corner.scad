//Size in mm
size      = 25;

//Thickness in mm, thicker guard will work better but would print slower and requires more material
thickness = 5;

//Resolution of the corners in mm. Reduce this value to have smoother corner, increase to have rougher corners.
resolution   = 1;

/* [hidden] */

pi = 3.1416;

module p1(r, h) {
    len=r*pi/2;
    s = ceil(len / resolution);
    steps = s < 6 ? 6 : s;
    ang = 90/steps;
    
    pts = [for(i=[0:ang:90.01]) [cos(i)*r, sin(i)*r]];
    linear_extrude(height=h)
    polygon(concat([[0,0]], pts));
}

module p2(r, h) {
    len=r*pi/2;
    s = ceil(len / resolution);
    steps = s < 6 ? 6 : s;
    ang = 90/steps;
    
    pts = [for(i=[0:ang:90.01]) [cos(i)*r, sin(i)*r]];
    linear_extrude(height=h)
    polygon(concat([[0,r*2], [r*2,r*2], [r*2,0]], pts));
}

r = size;
h = thickness;


difference() {
  union() {
    rotate([0, 0, 0]) 
    translate([-h, -h, 0])
        p1(r+h, h);
      
    translate([0,-h,0])
    cube([r,h,h]);
    translate([-h,0,0])
    cube([h,r,h]);

    rotate([90, 0, 0]) 
        p1(r, h);
    rotate([0, -90, 0]) 
        p1(r, h);

    rotate([0,0,180])
        p1(h, r);
  }
  
  rotate([0,0,180])
        p2(h, r);
  
  rotate([0,0,90])
  translate([r-h-0.4,0,0])
        p2(h, r);
  
  rotate([0,0,-90])
  translate([0,r-h-0.4,0])
        p2(h, r);
  
}