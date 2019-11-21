// 
// Customizable Flag Wall Mount
// version 1.0   2/11/2016
// by Steve Van Ausdall (DaoZenCiaoYen @ Thingiverse)
//

// preview[view:north, tilt:top]

/* [Base] */

// base width (mm)
base_width=55; // [25:75]

// base height (mm)
base_height=50; // [40:80]

// radius of rounded corners
base_corner_radius=5; // [1:8]

// base taper (percent)
taper_width_pct=85; // [75:100]
taper_height_pct=85; // [75:100]

// base thickness (mm)
base_thickness=3; // [2:0.5:7]

/* [Screws] */

// number of screws
number_of_screws=1 ; // [1:4]

// screw hole diameter (mm)
screw_diameter=2.5; // [1:0.5:5]

// screw hole taper diameter (mm)
screw_taper_diameter=5; // [1:0.5:7]

// screw hole taper thickness (mm)
screw_taper_thickness=1.5; // [1:0.5:7]

// margin for screw holes (mm) (inside rounded corners and tapers)
screw_margin=5; // [0:15]

/* [Tubes] */
tube_number=4; // [1:5]

// min/max horizontal angles (if multiple tubes)
min_tube_horiz_angle = 45 ; // [15:60]

// Flag rod diameter (mm) note: 1mm for easy insert is automaticaly added.
tube_diameter=5; // [4:15]

// Tube angle (degrees)
tube_angle=45; // [0:65]

// Tube length (mm)
tube_length=35; // [20:50]

// Tube thickness (mm)
tube_thickness=3; // [1:0.5:5]

// Style of the base of the tube
tube_stop_style=2; // [1:3]

/* [Supports] */

// Support thickness (mm)
support_thickness=2; // [2.5:0.5:5]

// Support height (mm)
support_height=15 ; // [0:40]

// Support connect tube position (mm)
support_connect=25 ; // [0:40]


/* [Hidden] */
tube_offset=-base_height*.18; // 
tube_r_in = (tube_diameter+1)/2 ;
tube_r_out = tube_r_in + tube_thickness ;
tube_tip_taper = 5 ;
screw_taper_d = screw_taper_diameter ;
support_conn = support_connect > tube_length ?
  tube_length : support_connect ;
screw_marg = screw_taper_diameter < screw_margin ? 
  screw_margin : screw_taper_diameter ;
inner_corner_x = (base_width/2-screw_marg)*taper_width_pct/100 ;
inner_corner_y = (base_height/2-screw_marg)*taper_height_pct/100 ;
inner_top = (base_height*taper_height_pct/200)-tube_offset ;
screw_top = inner_top-screw_marg*2 ;
top = number_of_screws == 1 ? screw_top : inner_top ;
support_h = support_height > top ? top : support_height ;
model_z = tube_length+base_thickness+tube_diameter+tube_thickness ;
support_conn_x = support_conn*cos(-tube_angle) ;
support_conn_y = support_conn*sin(-tube_angle) ;
tube_horiz_angle = min_tube_horiz_angle*2/(tube_number-1) ;
initial_tube_horiz_angle = tube_number == 1 ? 0 : -min_tube_horiz_angle ;
horiz_tube_travel_scale = 0.2 ;
vert_tube_travel_scale = 0.05 ;
tube_stop_angle_adjust = 0 ;
ff= 0.001;
$fn=32;

main();

module main() {
  union() {
    base();
    tube();
  }
}

module base() {
    translate([0, tube_offset, 0])
    difference() {
      roundedRect([base_width, base_height, base_thickness], base_corner_radius);
      screw_holes();
    }
}

module screw_holes() {

  if (number_of_screws == 1) {
    screw_hole(0, -inner_top-tube_offset+screw_marg);
  }
  
  if (number_of_screws == 2) {
    screw_hole(inner_corner_x, -inner_corner_y);
    screw_hole(-inner_corner_x, -inner_corner_y);
  }
  
  if (number_of_screws == 3) {
    screw_hole(0, inner_top+tube_offset-screw_marg);
    screw_hole(inner_corner_x, -inner_corner_y);
    screw_hole(-inner_corner_x, -inner_corner_y);
  }

  if (number_of_screws == 4) {
    screw_hole(inner_corner_x, inner_corner_y);
    screw_hole(-inner_corner_x, -inner_corner_y);
    screw_hole(inner_corner_x, -inner_corner_y);
    screw_hole(-inner_corner_x, inner_corner_y);
  }
}

module screw_hole(x, y) {
  translate([x, y, -ff/2]) 
    cylinder(d=screw_diameter, h=base_thickness+ff);
  translate([x, y, base_thickness-screw_taper_thickness+ff]) 
    cylinder(d1=screw_diameter, d2=screw_taper_d, 
      h=screw_taper_thickness);
}

// flag hold tubes
module tube() {
  difference() {
    union() {
      for (i = [ initial_tube_horiz_angle : 
        tube_horiz_angle : 
        min_tube_horiz_angle+1 ] ) { 
          _tube(i);
          support(i);
          tube_stop(i);
      }
    }
    translate([0, tube_offset, -tube_r_out+ff])
      cube([base_width*1.3, base_height, tube_r_out*2], center=true);  
  }
}


module _tube(ha) {
  translate([ha*horiz_tube_travel_scale,-abs(ha*vert_tube_travel_scale),0])
    rotate([tube_angle, ha, 0])
      translate([0,tube_r_out,base_thickness])
    difference() 
    {
      union() 
      {
        cylinder(r=tube_r_out, h=tube_length-tube_tip_taper, center=false);
        translate([0,0,tube_length-tube_tip_taper])
          cylinder(r1=tube_r_out, r2=(tube_r_in+tube_r_out)/2, h=tube_tip_taper, center=false);
      }
      cylinder(r=tube_r_in, h=tube_length+ff, center=false);
    }
}

module support(ha ) {
  translate([ha*horiz_tube_travel_scale,-abs(ha*vert_tube_travel_scale),0])
    rotate([0,ha,0])
      translate([support_thickness/2,0,base_thickness-1])
        rotate([0,-90,0])
          linear_extrude(height=support_thickness)
            polygon(points=[[0,0],[0,-support_h],
              [support_conn_x,support_conn_y],
              [0,0]]);
}

module tube_stop(ha) {
  translate([ha*horiz_tube_travel_scale,-abs(ha*vert_tube_travel_scale),0])
  rotate([tube_angle,ha,0])
  translate([0,tube_r_out,base_thickness+tube_r_in])
  union() {
    if (tube_stop_style==1 || tube_stop_style==3)
    {
      if (ha==0)
      {
        gem(ha);
      }
      else
      {
        gem(ha+(ha/abs(ha)*tube_stop_angle_adjust));
      }
    }
    if (tube_stop_style==2 || tube_stop_style==3)
    {
      if (ha==0)
      {
        gem(ha+45);
      }
      else
      {
        gem(ha+45+(ha/abs(ha)*tube_stop_angle_adjust));
      }
    }
  }
}

module gem(a) {
  slsf=1.3;
  szsf=1.2;
  mvup=6;
  rotate([0,0,a])
  union() {
    translate([0,0,-tube_r_out*slsf+mvup])
      linear_extrude(height=tube_r_out*slsf, scale=0.5)
      square(tube_r_out*2*szsf, center=true);
    translate([0,0,-tube_r_out*2*slsf+mvup+ff])
      linear_extrude(height=tube_r_out*slsf, scale=2)
      square(tube_r_out*szsf, center=true);
  }
}

// http://www.thingiverse.com/thing:9347
module roundedRect(size, radius)
{
  x = size[0]-radius;
  y = size[1]-radius;
  z = size[2];
  nt = 1 ;

  translate([0,0,nt])
    linear_extrude(height=z-nt, scale=[taper_width_pct/100,taper_height_pct/100])
      roundedRectShape(x,y,radius) ;
  linear_extrude(height=nt) roundedRectShape(x,y,radius) ;
}

module roundedRectShape(x,y,radius)
{
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
