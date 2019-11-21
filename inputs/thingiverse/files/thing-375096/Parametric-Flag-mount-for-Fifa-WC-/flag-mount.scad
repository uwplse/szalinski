
/* [Base] */

// base width (mm)
base_width=20;

// base lenght (mm)
base_lenght=40;

// base height (mm)
base_height=5;

// holes diameter (mm)
screw_diameter=3;

// holes for screws margin (mm)
screw_margin=3;

/* [Tube] */

// Flag's rod diameter (mm)
// Note: 1mm for easy insert is automaticaly added.
diameter=10;

// Tube lenght
rod_l=40;

// Tube offset from center (mm)
tube_offset=10; // [10:100]

// Tube's thickness (mm)
thick=1.5;


// Tube orientation
rotate_x=30; // [30:60]
//rotate_y=0;
//rotate_z=0;


/* [Support] */

support_enable=1; // [0:Disable, 1:Enable]

support_diameter=2;

/* [Extra] */

//$fn=80;
mode="normal"; //[normal, heart]


/* [Hidden] */

// Tube orientation
//rotate_x=30;
rotate_y=0;
rotate_z=0;


rod_r_in=(diameter+1)/2;
rod_r_out=rod_r_in + thick;

/// construct


main();

//cube([base_width, base_lenght, base_height], center=true);

//cube([base_width, base_lenght, base_height], 3);


//  Modules

module main() {
  translate([0, base_lenght/6, 0])
  union() {
    socle();
    tube();
    if (support_enable) {
      support();
    }
  }
}



module support() {

  _support();  

}


module _support() {

  inter=(base_lenght/2)/cos(90-rotate_x);
  h=sqrt(inter*inter - (base_lenght/2)*(base_lenght/2));

  difference() {
    translate([0, -base_lenght/2, h/2])
      cylinder(r=support_diameter/2, h=h, center=true);
    
    _tube(rod_r_in, rod_l*4+2);
  }
}



module tube() {
  difference() {
    _tube(rod_r_out, rod_l*2);
    _tube(rod_r_in, rod_l*2+2);
    translate([0, 0, -rod_l])
      cube([rod_l*4, rod_l*4, rod_l*2], center=true);
  }
}


module _tube(r=rod_d_out, h=rod_l) {
  rotate([rotate_x, rotate_y, rotate_z])
  difference() {
    if (mode=="normal") {
      cylinder(r=r, h=h, center=true);
    } else if (mode=="heart") {
      _heart(r, h);
    }
  }
}



module socle() {
  x=rod_d_out;
  difference() {
    if (mode=="normal") {
      _socle();
    } else if (mode=="heart") {
      _heart_socle();
    }
    _tube(rod_r_in, rod_l);
  }
}


module _socle() {
    r=3;
    translate([0, -base_lenght/tube_offset, 0])
    difference() {
      roundedRect([base_width-r, base_lenght-r, base_height], r, center=true);
      _screw();
    }
}



module _heart_socle() {
    translate([0, -base_lenght/tube_offset, 0])
      _heart(base_width, base_height);
}



module _screw() {
  $fn=12;
  // holes Position var
  x_hole=base_width/2-screw_margin;
  y_hole=base_lenght/2-screw_margin;
  
  translate([x_hole, y_hole, 0]) cylinder(r=screw_diameter/2, h=base_height+2);
  translate([-x_hole, -y_hole, 0]) cylinder(r=screw_diameter/2, h=base_height+2);
  translate([x_hole, -y_hole, 0]) cylinder(r=screw_diameter/2, h=base_height+2);
  translate([-x_hole, y_hole, 0]) cylinder(r=screw_diameter/2, h=base_height+2);
}



module _heart(size, height) {
  rotate([0, 0, 135])
    union () {
      cube([size, size, height], center=true);
      translate([-size/2, 0, 0])
        cylinder(r=size/2, h=height, center=true);
      translate([0, size/2, 0])
        cylinder(r=size/2, h=height, center=true);
    }
}







///////// EXTERNAL

// http://www.thingiverse.com/thing:9347
module roundedRect(size, radius)
{
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
hull()
{
// place 4 circles in the corners, with the given radius
translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
circle(r=radius);

translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);

translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
circle(r=radius);
}
}

