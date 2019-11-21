
// preview[view:north, tilt:top diagonal]

//tray thickness (in mm)
thickness = 2.5;

//tray width (in cm)
width = 15;

//tray depth (in cm)
depth = 4;

//magnets diameter (in mm)
magnet_diameter = 18.6;

//magnets thickness (in mm)
magnet_thickness = 2;

sth = thickness;

sw = width*10;   // support width
sd = depth*10;   // support depth

seh = 12*1;   // support edge height
sei = 1/3;  // support edge incline

msh = 36/40*sd;   // magnet support height
msd = 5*1;    // magnet support depth


mr = magnet_diameter/2;   // magnets radius
md = 2*1;     // magnets depth (ie thickness)

cr = 1*1;     // chamfer radius
$fn = 30*1;

// other calculated values (magnets position)
vpos = (msh-seh)*1/3;
mpos = (msh-mr*2)*4/5;


// object
difference() {
    translate(v = [msd, 0, 0])
    linear_extrude(height = sw) {
      magnet_support();
      pen_support();
    }
    translate(v = [0, 0, mr+5]) magnet();
    translate(v = [0, 0, sw/2]) magnet();
    translate(v = [0, 0, sw-mr-5]) magnet();
}

module magnet() {
    translate(v = [-md, mr+mpos, 0])
    rotate([0, 90, 0])
    cylinder(r=mr, h=md*2);
}

module magnet_support() {
    translate(v = [cr-msd, cr, 0])
    offset(chamfer = true, r = cr)
    square(size = [msd-2*cr, msh-2*cr]);
}

module pen_support() {
    translate(v = [0, vpos+sth/2, 0])
    offset(chamfer = true, r = sth/2-0.1)
    polygon(points = [
          [0, 0],
          [sd, 0],
          [sd+seh*sei, seh],
          [0.1+sd+seh*sei, seh],
          [sd, 0.1],
          [0, 0.1]
        ]
      );
    translate(v = [0, cr+0.1, 0])
    difference() {
      square(size = [vpos-cr, vpos-cr]);
      translate(v = [vpos-cr, 0, 0]) circle(r=vpos-cr);
    }
    translate(v = [0, vpos+sth, 0])
    difference() {
      square(size = [sth, sth]);
      translate(v = [sth, sth, 0]) circle(r=sth);
    }
    translate(v = [sd-sth+0.05, vpos+sth, 0])
    difference() {
      square(size = [sth*1.2, sth]);
      translate(v = [0, sth, 0]) circle(r=sth);
    }
}
