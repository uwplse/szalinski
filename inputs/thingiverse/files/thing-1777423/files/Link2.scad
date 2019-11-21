
thickness = 1.2;
length = 30.3;
gap_size = 0.9;
desired_hook_thickness = 2.55;
desired_width = 9.3;

/* [Hidden] */
FA = 5;
FS = 0.35;

// Do thickness2 bounds
max_thickness2 = (length-9*gap_size)/5;
if(desired_hook_thickness > max_thickness2)
  echo(str("Warning: Hook thickness can be at most ", max_thickness2, ", so using this instead!"));
thickness2 = min(desired_hook_thickness, max_thickness2);

// Do width bounds
max_width = (length + thickness2-3*gap_size)/3;
min_width = 2*(thickness2 + gap_size);
if(desired_width > max_width)
  echo(str("Warning: Width can be at most ", max_width, ", so using this instead!"));
if(desired_width < min_width)
  echo(str("Warning: Width can be at least ", min_width, ", so using this instead!"));
width = min(max(min_width, desired_width), max_width);

// Compute some things
c2c = length - width;
icr = width/2 - thickness2;
i3rd = (length - 2*thickness2) / 3;
er = thickness2/2;
df = sqrt(pow(width/2+er, 2) - pow(width/2-er, 2));
ed = sqrt(pow(width/2 - thickness2/2, 2) - pow(thickness2/2, 2));

difference()
{
  hull()
  {
    translate([c2c/2, 0, 0])
      cylinder(thickness, width/2, width/2, true, $fa = FA, $fs = FS);
    
    translate([-c2c/2, 0, 0])
      cylinder(thickness, width/2, width/2, true, $fa = FA, $fs = FS);
  }
  cutOut();
  rotate(180)cutOut();
}

addBack();
rotate(180)addBack();


module cutOut()
{
  hull()
  {
    translate([c2c/2, 0, 0])
      cylinder(thickness+1, icr, icr, true, $fa = FA, $fs = FS);
    translate([i3rd/2 + icr, 0, 0])
      cylinder(thickness+1, icr, icr, true, $fa = FA, $fs = FS);
  }

  translate([width/2 + i3rd/2, 0, 0])
  {
    intersection()
    {
      cylinder(thickness+1, width/2, width/2, true, $fa = FA, $fs = FS);
      translate([-width/2-1, 0, -thickness/2-0.5])
        cube([width/2+1, width/2+1, thickness+1]);
    }
  }

  translate([width/2 + i3rd/2-df, width/2 - er, 0])
  {
    linear_extrude(height=thickness+1, center=true)
      polygon(points=[[0, er+1], [0, 0], [df, -width/2+er], [df+gap_size, er-thickness2], [df+gap_size,er+1]]);
  }
}

module addBack()
{
  translate([width/2 + i3rd/2-df, width/2 - er, 0])
    cylinder(thickness, er, er, true, $fa = FA, $fs = FS);

  translate([width/2 + i3rd/2+gap_size, 0, 0])
  linear_extrude(height=thickness, center=true)
  union()
  {
    difference()
    {
      intersection()
      {
        circle(width/2, true, $fa = FA, $fs = FS);
        translate([-width/2-1, 0])
          square(width/2+1, width/2+1);
      }
      circle(icr, true, $fa = FA, $fs = FS);
      polygon(points=[[0,0], [-ed*3, thickness2*1.5], [-sqrt(ed*ed*4 +  thickness2*thickness2),0]]);
    }
  }
  translate([width/2 + i3rd/2+gap_size-ed, thickness2/2, 0])
    cylinder(thickness, thickness2/2, thickness2/2, true, $fa = FA, $fs = FS);
}