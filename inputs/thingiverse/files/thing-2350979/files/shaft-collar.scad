
shaft_size=8;
thickness=2;
width=7;
screw_diameter=3.5;
tab_length=6;

shaft_collar();

module shaft_collar() {
  $fn=60;
  difference() {
    union() {
      cylinder(d=shaft_size+thickness*2,h=width);
      linear_extrude(width)      
        translate([-thickness,0,0])
          square([thickness*2,shaft_size/2+thickness+tab_length]);
    }
    translate([0,0,-1])
      cylinder(d=shaft_size,h=width+2);    
    
    cut_size=1;
    linear_extrude(width+1)
      translate([-cut_size/2,0,0])
        square([cut_size,shaft_size/2+thickness+tab_length]);      
    
    translate([-thickness*2,shaft_size/2+thickness+(tab_length/2),width/2])
      rotate([0,90,0])
        cylinder(d=screw_diameter,thickness*4);
  }  
}