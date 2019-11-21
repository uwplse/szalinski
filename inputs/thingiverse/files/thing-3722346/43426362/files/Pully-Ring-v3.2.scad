thickness = 2.5;
height = 8;
diameter = 17.5;
gap = 14;
barLength = 3;
$fn=64;

size = diameter/2;

module ring() {
    
    // Top and bottom supports
    difference() {
        circle(size + thickness);
        circle(size);
        polygon([[-gap/2, size+thickness], [gap/2, size+thickness], [gap/2, -size-thickness], [-gap/2, -size-thickness]]);
    }

    midline = (size + thickness/2);
    gap_y = sqrt(midline*midline - (gap/2)*(gap/2));

    // Left bar
    hull() {
      translate([-gap/2, -gap_y+thickness/4]) circle(thickness/2);
      translate([-gap/2, -gap_y - barLength]) circle(thickness/2);
    }

    // Right bar
    hull() {
      translate([gap/2, -gap_y+thickness/4]) circle(thickness/2);
      translate([gap/2, -gap_y - barLength]) circle(thickness/2);
    }

    // Size brace
    difference() {
        circle(midline + thickness);
        circle(midline + thickness/4); 
        polygon([ [-diameter, gap_y], [diameter, gap_y], [diameter, -gap_y-barLength-thickness],[-diameter, -gap_y-barLength-thickness] ]);
    }
    
    r = midline + thickness/2;
    y = gap_y;
    brace_x = sqrt(r*r - y*y);
    
    difference() {
      union() {
        translate([-brace_x, y]) circle(thickness);
        translate([ brace_x, y]) circle(thickness);
      }
       difference() {
          circle(midline+thickness*2);
          circle(midline+thickness);
      }
    }
}

linear_extrude(height=height) {
    ring();
}