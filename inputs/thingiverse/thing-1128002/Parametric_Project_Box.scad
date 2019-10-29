// Which one would you like to print?
part = "all"; // [top:Top or Bottom,side:Side,front:Front or Back,all:All Pieces]

// How thick are the walls of the box? Snaps don't work well if the walls are too thin.
wall_thickness=5.5;

box_length=150;
box_height=40;
box_width=82;

t=wall_thickness;

// How much smaller are the dovetails than the slots?
tolerance=1.3;


tt=t+t;


length=box_length+tt;
height=box_height+tt;
width=box_width+tt;

longTabLength=t*4;


module clip(height, t) {
  $fn=50;
  union() {
    cylinder(r=t/3, h=height);
    translate([-t/4, -t/3, 0])
    cube([t/3.3, longTabLength/4 + t/3, height]);
  }
}

module innerSlotLeft(height, t, cut) {
  difference() {
    hull() {
      cube([0.1, height, longTabLength]);
      translate([t-0.1, t, 0])
        cube([0.1, height-t-t, longTabLength]);
    }
    translate([t/4*3+0.01, 0, longTabLength-t+0.01])
      rotate([-90, 180, 0])
      union() {
      clip(height, t);
    }
  }
}

module innerSlotRight(height, t) {
  difference() {
    hull() {
      cube([0.1, height, longTabLength]);
      translate([-t, t, 0])
        cube([0.1, height-tt, longTabLength]);
    }
    translate([-t/4*3-0.01, height, longTabLength-t+0.01])
      rotate([-90, 180, 180])
      union() {
      clip(height, t);
    }
  }
}

module front(length, width, height, t) {
  difference() {
    union() {
      cube([width, height, t]);
      
      translate([-tolerance/2, 3/2*t+tolerance/2, t])
        difference() {
        innerSlotLeft(height-t*3-tolerance, t);
        translate([-t+tolerance/2, 0, 0])
        cube([t, height, height-t-3-tolerance]);
        }
    
      translate([width-0.1+tolerance/2, t*3/2+tolerance/2, t])
        difference() {
        innerSlotRight(height-t*3-tolerance, t);
        translate([-tolerance/2, 0, 0])
        cube([t, height, height-t-3-tolerance]);
        }
    }
    
    translate([(width-width*0.75-tolerance)/2, t-0.01, 0])
      rotate([0, 0, -90])
      innerSlotLeft(width*0.75+tolerance, t);

    translate([(width-width*0.75-tolerance)/2, height-t, 0])
      rotate([0, 0, -90])
      innerSlotRight(width*0.75+tolerance, t);
  }
  
}

module side(length, width, height, t) {
  length=length-t-t;
  difference() {
    cube([length, height, t]);

    translate([-0.01, t*3/2, t])
    rotate([0, 90, 0])
      innerSlotLeft(height-t*3, t*1.04);

    rotate([0, 0, 90])
      translate([t, -length/2-(length+tt)*0.25/2 - tolerance/2, 0])
      innerSlotRight((length+tt)*0.25+tolerance, t);

    rotate([0, 0, 90])
      translate([height-t*0.98, -length/2-(length+tt)*0.25/2 - tolerance/2, 0])
      innerSlotLeft((length+tt)*0.25+tolerance, t);


    translate([length+0.01,(t*3/2), t*1.0])
    rotate([180, 0, 0])
    rotate([0, 90, 180])
      innerSlotRight(height-t*3, t*1.04);
    }
  
}

module top(length, width, height, t) {
  length=length-t-t;
  width=width-t-t;

    union() {
      cube([width, length, t]);
      
      translate([((width)-(width+tt)*0.75)/2, -t, 0])
        rotate([0, -90, -90])
        innerSlotLeft((width+tt)*0.75, t);
      
      translate([((width)-(width+tt)*0.75)/2, t+length, 0]) //magic numbers are yucky
        rotate([0, 90, -90])
        innerSlotRight((width+tt)*0.75, t);

      rotate([0, 90, 0])
        translate([0, length/2-(length+tt)*0.25/2, -t])
        innerSlotRight((length+tt)*0.25, t);

      rotate([0, 90, 180])
        translate([0, -length/2-(length+tt)*0.25/2, -width-t])
        innerSlotRight((length+tt)*0.25, t);
  }
  
}

if (part == "all") {
  front(length, width, height, t);

  translate([width+t, 0, 0])
    front(length, width, height, t);

  translate([0, -height-t*2, 0])
    side(length, width, height, t);

  translate([0, -height*2-t*2*2, 0])
    side(length, width, height, t);

  translate([t, height+t*2, 0])
    top(length, width, height, t);

  translate([width+t*2, height+t*2, 0])
    top(length, width, height, t);
} else if (part == "top") {
  top(length, width, height, t);
} else if (part == "side") {
  side(length, width, height, t);
} else if (part == "front") {
  front(length, width, height, t);
}
