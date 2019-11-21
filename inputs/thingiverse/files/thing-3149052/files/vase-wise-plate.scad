 module mug(width, height, bottom_thickness=2, wall_thickness=5)
  {
    translate([0,0,height/2])
      difference()
      {
        intersection()
        {
          cube([width,width,height], center=true);
          scale([1,1,height/width])
            sphere(width/2 * sqrt(2));
        }
        translate([0,0,-height/2+bottom_thickness])
          cylinder(r=width/2-wall_thickness,h=height+0.1);
      }
  }

   //Reference dimension can be taken from below..
  union()
  {
    mug(width=40, height=60); // top Flask
    mug(width=80, height=20); // bottom flask
  }
