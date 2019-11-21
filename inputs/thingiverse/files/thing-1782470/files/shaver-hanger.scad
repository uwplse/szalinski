$fn=10*1;

// Shape
shape = "rectangular"; // [rectangular,circle]

//inner height of the thing the holder is hung on
hangerheight=20;// [3:100]
//inner width of the thing the holder is hung on
hangerwidth=25;// [3:100]
//inner radius of the shape
hangerradius=15;// [1:100]
hangerxsize =   (shape == "rectangular") ? hangerheight : hangerradius*2 ;
hangerysize =   (shape == "rectangular") ? hangerwidth : hangerradius*2 ;

//all over thickness
thickness=2;// [2:10]
//distance from fixture and holder
holderdistance=20;// [2:50]
//width of the holder part
holderthickness=32;// [10:60]
//distance from the wall
holderheight=18;// [10:50]

if (shape=="rectangular") 
difference() {
    roundedBox([hangerheight+thickness,hangerwidth+thickness,thickness+2], 1, false);
    roundedBox([hangerheight,hangerwidth,thickness+4], 1, false);
    translate([0,0,thickness/2+1]) cube([hangerheight+1+thickness,hangerwidth+1+thickness,2],center=true);
    translate([0,0,-thickness/2-1]) cube([hangerheight+1+thickness,hangerwidth+1+thickness,2],center=true);
}
else if (shape=="circle") {
    difference() {
        cylinder(r=hangerradius+thickness,h=thickness,center=true, $fn = 50);
        cylinder(r=hangerradius,h=thickness+1,center=true, $fn = 50);
    }
}
translate([hangerxsize/2+holderdistance/2+thickness/2,0,holderheight/2-thickness/2]) difference() {
    union() {
        difference() {
            translate([holderdistance/2-thickness,0,0]) roundedBox([7,holderthickness,holderheight],1,false);
            translate([-7/2-1,0,-holderheight/2+(thickness)/2]) cube([7,hangerysize/3+1,thickness+2],center=true);
        }
        translate([0,0,-holderheight/2+thickness/2]) cube([holderdistance,hangerysize/3,thickness],center=true);
    }
    translate([holderdistance/2-3*thickness,hangerysize/6+holderthickness/4,-thickness-1]) roundedBox([8+thickness,holderthickness/2,holderheight+1], 1, false);
    translate([holderdistance/2-3*thickness,-hangerysize/6-holderthickness/4,-thickness-1]) roundedBox([8+thickness,holderthickness/2,holderheight+1], 1, false);
    translate([holderdistance/2-3*thickness,0,0]) roundedBox([8+thickness,holderthickness,holderheight-2*thickness], 1, false);
    translate([holderdistance/2-thickness,0,6]) roundedBox([9,holderthickness-4*thickness,holderheight+2], 1, false);
}

module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis]) 
          translate([x,y,0]) 
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}