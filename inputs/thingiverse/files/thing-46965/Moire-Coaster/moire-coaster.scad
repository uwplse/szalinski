// preview[view:south, tilt:top]

// Diameter of coaster
outer_diam = 80;

// Thickness of coaster
thickness = 3;

// Width of coaster lip
lip_width = 1;

// Moire pattern inset thickness
inset_thickness = 1;

// Number of moire curves
moire_count = 10;

// Diameter of moire curves
moire_diam = 70;

// Thickness of moire curves
moire_thickness = 3;

// Where the curve reverses direction
moire_join_angle = 40;

// Moire curve offset from center
center_diam = 10;

// Offset when drawing the reverse pattern
moire_mirror_angle = 66;

/////////////////////////////////////////////////////////////

difference()
{
  linear_extrude(height=thickness)
    circle(outer_diam/2);
  translate([0, 0, thickness - inset_thickness])
    linear_extrude(height=inset_thickness+0.1)
    {
      moire_scythe();
      rotate(moire_mirror_angle) mirror() moire_scythe();
    }
}

linear_extrude(height=thickness)
difference()
{
  circle(outer_diam/2);
  circle(outer_diam/2 - lip_width);
}

/////////////////////////////////////////////////////////////

module moire_scythe()
{
  spacing_angle = 360 / moire_count;
  join_angle = 180 + moire_join_angle;
  center_off = center_diam/2;
  inner_radius = moire_diam/4;
  outer_radius = moire_diam/3;

  circle(center_diam/2);

  for (c = [0 : moire_count-1])
  {
    rotate([0, 0, spacing_angle * c])
    union()
    {
      intersection()
      {
        translate([inner_radius-center_off, 0, 0])
          circle_trace(inner_radius);
        rotate([0, 0, join_angle])
          translate([outer_radius-center_off, 0, 0])
            circle(outer_radius);
        translate([0, -moire_diam, 0])
          square(moire_diam*2, center=true);
      }

      difference()
      {
        rotate([0, 0, join_angle])
          translate([outer_radius-center_off, 0, 0])
            difference()
            {
              circle_trace(outer_radius);
              translate([0,-moire_diam,0])
                square(moire_diam*2, center=true);
            }
        translate([inner_radius-center_off, 0, 0])
          circle(inner_radius);
      }
    }
  }
}

module circle_trace(rad)
{
  difference()
  {
    circle(rad);
    circle(rad - moire_thickness);
  }
}

