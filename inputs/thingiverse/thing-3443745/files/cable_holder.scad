width = 25;
maxdiameter = 50;
thickness = 2;
wirethickness = 5/sin(45);

length=sqrt(2*(maxdiameter/2*maxdiameter/2));

rotate([45]) {
  difference() {
    cube([width + 2*thickness, maxdiameter/2, maxdiameter/2]);
    translate([thickness,thickness,thickness]) cube([width, maxdiameter/2, maxdiameter/2]);
    translate([thickness,-1,thickness]) cube([width, thickness+2, wirethickness]);
  }
}

translate([0,-length/2,0]) difference() {
  cube([width+2*thickness,length,2*thickness]);
  translate([thickness,-1,thickness]) cube([width,length-thickness-1,thickness+1]);
}

cube([thickness,length/2,length/2]);
translate([width+thickness,0,0]) cube([thickness,length/2,length/2]);
