
//  - Thickness of the desktop, plus a little extra so it's not too tight (depending on your printer).
desk_thickness = 35.0;// 10 - 20

//  - Width of the slots the cables go through. This should be at least a mm greater than your thickest cable, but less than your thinnest plug!
cable_gap = 5.5; // 3  - 38

//  - Distance between cable slots.
finger_width = 6.8; // 5  - 10

//  - Number of cables.
cable_count = 7;   // [1:20]

//  - Thickness of the back plane. 2 to 4 mm should be fine for most.
back_thickness = 4; // 2  - 10

//  - Model Version.
model_version = 2;   // [1, 2]

//  - Circle quality - Increase to 5 for the final rendering.
quality = 5;     // [1:5]
FN = 3*pow(2, quality+1);

if(model_version == 1)
  cableHolder1(desk_thickness, cable_gap, cable_count, finger_width, back_thickness);
else
  cableHolder2(desk_thickness, cable_gap, cable_count, finger_width, back_thickness);

module cableHolder1(h, cw, cs, f, b)
{
  difference()
  {
    union()
    {
      n=0.04;
      for(i = [1:cs])
        translate([i*(cw+f)-n, 0, 0])
          B1(h, cw+2*n, b);
      
      for(i = [1:cs+1])
        translate([i*(cw+f)-f, 0, 0])
          {
            j=(2*(i-1))/cs-1;
            A1(h, cw, f, 36-15*cos(180*j*j), b);
          }
    }

    ew = 2*ceil(cs/7)-0.5;
    translate([(cs+1.5)*(cw+f)/2, h/2+10, cw+b])
      scale([1, 1, (cw+4+b)/(h/2)])
        rotate([90, 0, 90])
          if((cs-ew)*(f+cw) > 2.5*h)
          {
            difference()
            {
              cylinder((cs-ew)*(f+cw)+cw, h/2, h/2, true, $fn=FN);
              cube([h, h, (cw+f)*(1+isOdd(cs))], true);
            }
          }
          else
          {
            cylinder((cs-ew)*(f+cw)+cw, h/2, h/2, true, $fn=FN);
          }
  }
}

module B1(h, c, b)
{
  difference()
  {
    cube([c, h+20, c/2+b]);
    translate([c/2, h+21, b+c/2])
      rotate([90])
        cylinder(h+22, c/2, c/2, $fn=FN);
  }
}

module A1(h, c, f, l, b)
{
  cube([f, h+20, c+b]);
  translate([0,0, c+b])
    cube([f, 10, l-10]);
  translate([0,h+10, c+b])
    cube([f, 10, l-20]);
  translate([0, 10, c+b+l-10])
    difference()
    {
      rotate([0,90,0])
        cylinder(f, 10, 10, $fn=FN);
      translate([-1, 0, -11])
        cube([f+2, 11, 22]);
    }
  translate([0, h+10, c+b+l-20])
    difference()
    {
      rotate([0,90,0])
        cylinder(f, 10, 10, $fn=FN);
      translate([-1, -11, -11])
        cube([f+2, 11, 22]);
    }
}











module cableHolder2(h, cw, cs, f, b)
{
  difference()
  {
    union()
    {
      n=0.04;
      for(i = [1:cs])
        translate([i*(cw+f)-n, 0, 0])
          B2(h, cw+2*n, b);
      
      translate([(cw+f)-3*f, 0, 0])
      {
        A2end(h, cw, f, 36-15, b);
      }
      
      for(i = [2:cs])
        translate([i*(cw+f)-f, 0, 0])
        {
          j=(2*(i-1))/cs-1;
          A2(h, cw, f, 36-15*cos(180*j*j), b);
        }
        
      translate([(cs+1)*(cw+f)+2*f, 0, 0])
      {
        mirror()
          A2end(h, cw, f, 36-15, b);
      }
    }

    translate([cw*1.5+f, h/2+10, cw+b])
      scale([1, 1, (cw+4+b)/(h/2)])
        rotate([90, 0, 90])
          if((cs-1.5)*(f+cw) > 3*h)
          {
            difference()
            {
              cylinder((cs-1)*(f+cw), h/2, h/2, $fn=FN);
              translate([0,0,(cs-1)*(f+cw)/2])
                cube([h, h, (cw+f)*(1+isOdd(cs))], true);
            }
          }
          else
          {
            cylinder((cs-1)*(f+cw), h/2, h/2, $fn=FN);
          }
    translate([f+cw*1.5, -1, b])
      cube([(cs-1)*(cw+f), 15, cw+2]);
  }
}

module B2(h, c, b)
{
  difference()
  {
    cube([c, h+20, c/2+b]);
    translate([c/2, h+21, b+c/2])
      rotate([90])
        cylinder(h+22, c/2, c/2, $fn=FN);
  }
}

module A2(h, c, f, l, b)
{
  cube([f, h+20, c+b]);
  translate([0,h+10, c+b])
    cube([f, 10, l-20]);
  translate([0, h+10, c+b+l-20])
    difference()
    {
      rotate([0,90,0])
        cylinder(f, 10, 10, $fn=FN);
      translate([-1, -11, -11])
        cube([f+2, 11, 22]);
    }
}

module A2end(h, c, f, l, b)
{
  difference()
  {
    union()
    {
      cube([f*3, h+20, l+c+b+10]);
      translate([0, 10, l+c+b+10])
        rotate([0, 90, 0])
          cylinder(f*3, 10, 10, $fn=FN);
      translate([0, h+10, l+c+b+10])
        rotate([0, 90, 0])
          cylinder(f*3, 10, 10, $fn=FN);
    }
    a = atan2(2*f, h+20);
    rotate([0, 0, -a])
      translate([-f*3, -1, -1])
        cube([f*3, 2*h, (l+c+b+10)*2]);
    translate([-1, 10, b+c])
      cube([f*3+2, h, l+c+b+20]);
  }
}

function isOdd(t) = (t-(floor(t/2)*2));