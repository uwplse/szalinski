
/* [Remote controller dimensions] */

// Remote controller width
cWidth = 44;

// Remote controller height
cHeight = 18;

// Depth of the pocket (Remote controller length)
cLength = 65;

/* [Rod paremeters] */

// Diameter of the rod
rodDiameter = 37;

/* [Common parameters] */

// Corner radius
cRadius = 5;

// Wall thickness
wThickness=3.8;


module roundedRect(size, radius)
{
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull()
  {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(r=radius);

    translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(r=radius);

    translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(r=radius);

    translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(r=radius);
  }
}


module controllerBox(width, height, length, thickness, radius) {
     
    difference() {
      roundedRect([width+2*thickness, 
                    height+2*thickness,
                    length+thickness], 
        radius=radius+thickness);
    
      translate([0,0,thickness]) {
        roundedRect([width,height,length+thickness],radius=radius);    
      }
    }   
}


module rodGrip(diameter, height, thickness, screwDiameter) {

    difference() {
      cylinder(d=diameter+2*thickness, h=height);
    
      translate([0,0,-1]) {
        cylinder(d=diameter, h=height+2);
      }
    }
}



controllerBox(cWidth,cHeight,cLength,wThickness,cRadius);
translate([0,rodDiameter/2+cHeight/2+wThickness,0]) {    
  rodGrip(rodDiameter, cLength+wThickness, wThickness, 3);
}