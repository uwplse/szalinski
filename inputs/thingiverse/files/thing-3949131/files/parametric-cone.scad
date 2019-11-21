$fa=0.1;
$fs=0.1;

// Base diameter (mm)
diameter_base = 5.0;

// Top diameter (mm)
diameter_top = 2.5;

// Height (mm)
height = 80;

cone(r1=diameter_base/2.0, r2=diameter_top/2.0, h=height);

module cone(r1, r2, h) {
    cylinder(r1=r1, r2=r2, h=h);
}
