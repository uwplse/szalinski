// Customizable Xmas Wreath
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 

wreathRadius = 200;   // [150:500]
numTwigs = 24;        // [10:2:50]
thickness = 3.0;      // [1:0.1:6.0]
// displays entire wreath (warning: very slow!)
show_assembled = "no"; // [yes,no]

rotationStep = 360/numTwigs;
rollAngle = atan2(1, sqrt(cos(rotationStep)));
twigLength = 2*wreathRadius*sin(rotationStep)/sin((180-rotationStep)/2);
twigThickness = 3*thickness;

tol=0.1*1;

if (show_assembled == "yes")
  wreathPart();
else
  twigPart();

// One piece, of which numTwigs are needed to form a wreath
module twigPart() {
    rotate([0, -rollAngle])
    translate([wreathRadius, 0])
    difference() {
        twig3D(twigLength, rollAngle, 0);

        // diagonal slot at base of the twig
        rotate(rotationStep)
          translate([-wreathRadius, 0])
            rotate([0, -rollAngle])
              cube([twigLength, twigLength/2, thickness+2*tol], center=true); 
        
        // slot at tip of twig
        rotate(-rotationStep)
          translate([-wreathRadius, 0])
            rotate([0, -rollAngle])
              cube([twigLength, twigLength/2, thickness+2*tol], center=true); 
    }
}

// Complete wreath
module wreathPart() {
    for (i=[0:numTwigs-1]) {
      twig3D(twigLength, 
              (2*floor(i/2) == i)? -rollAngle : rollAngle, 
              i*rotationStep);
    }
}

// twig without slot with given length, roll (around its  own axis) and 
// rotation around z-axis (rotZ)
module twig3D(length, roll, rotZ) {
   width = max(0.167*length, 3*thickness);
    
   rotate(rotZ)
     translate([-wreathRadius, 0])
       rotate([0, roll])
         translate([0, -length/2, -thickness/2])
           linear_extrude(height=thickness)
             level3Twig2D(length, width);
}

// 2D version of twig (all 9 branches)
module level3Twig2D(length, width) {
  l1 = 0.8*length;
  max_fillet = (l1-2.1*width)/0.73;
    
  level2Twig2D(length, width);
  rotate(72)
    level2Twig2D(l1, width);
  rotate(-72)
    level2Twig2D(l1, width);

  if (max_fillet > 0)
    upper_fillets(width, max_fillet);
}

// 2D twig with just three branches
module level2Twig2D(length, width) {
  h2 = 0.5*length;
  l2 = 0.5*length;
  max_upper_fillet = (length-l2-1.7*width)/0.73;
  max_lower_fillet = (length-l2-1.4*width)/0.73;
    
  basicTwig2D(length, width);
    
  translate([0, h2]) {
    rotate(72)
      basicTwig2D(l2, width);
    rotate(-72)
      basicTwig2D(l2, width);

    if (max_upper_fillet > 0)
      upper_fillets(width, max_upper_fillet);
    if (max_lower_fillet > 0)
      lower_fillets(width, max_lower_fillet);
  }
}

// 2D twig, a single branch
module basicTwig2D(length, width) {
    r = width/2;
    circle(d=width, $fn=24);
    translate([-r, 0])
      square([width, length-width]);
    translate([0, length-width])
      circle(d=width, $fn=24);
}


// "upper" fillets (the acute, 72 degree angles) 
module upper_fillets(width, max_fillet) {
  r_fillet = min(5, 0.1*width, max_fillet);
  dx = 0.5*width;
  dy1 = dx*tan(18);
  dy2 = dx/cos(18);
  
  translate([dx, dy1+dy2])
    fillet2D(72, r_fillet);
  mirror([1, 0])
    translate([dx, dy1+dy2])
      fillet2D(72, r_fillet);
}

// "lower" fillets (the obtuse, 108 degree angles)
module lower_fillets(width, max_fillet) {
  r_fillet = min(5, 0.1*width, max_fillet);
  dx = 0.5*width;
  dy1 = dx*tan(18);
  dy2 = dx/cos(18);
  
  translate([dx, dy1-dy2])
    mirror([0, 1])
      fillet2D(108, r_fillet);
  mirror([1, 0])
    translate([dx, dy1-dy2])
      mirror([0, 1])
        fillet2D(108, r_fillet);
}

// fills in a fillet of an angle
module fillet2D(angle, radius) {
    dy = radius/tan(angle/2);
    x1 = dy*cos(90-angle);
    y1 = dy*sin(90-angle);
    
    difference() {
        polygon([[0, 0], [0,dy], [radius,dy], [x1,y1]]);
        
        translate([radius, dy])
          circle(r=radius, $fn=25);
    }
} 
