// Parametric tapered thread coupling by blole
// https://www.thingiverse.com/thing:3544909
// https://github.com/blole/parametric-tapered-thread
//   based on
// ISO screw thread modules by RevK @TheRealRevK
// https://www.thingiverse.com/thing:2158656

/* [Common] */
type = "double collet";//[single collet,double collet]
//ready for printing or debug section view
view = "all parts";//[all parts, section view, only collet, only nut1, only nut2]
//mm
center_length = 4;
center_decoration = "none";//[none,hex,sphere]
//mm - only used for hex and sphere
center_decoration_outer_diameter = 13;
//mm - only used for hex
center_decoration_height = 8;
//mm - height of the protruding flat part of threads
thread_edge_flat_height=0.2;
//mm - expand nut internal thread radius, not necessary for tapered threads
nut_tolerance=0.2;

/* [single or top collet] */
//mm
collet1_inner_diameter = 5.2;
//mm
collet1_outer_diameter = 14;
//mm
collet1_length = 12;
//mm
collet1_pitch = 1.5;
//mm - shrink thread radius by this amount for every mm
collet1_taper = 0.178;
//count
collet1_cutouts = 3;
//mm
collet1_cutout_widths = 1.5;
//mm
collet1_cutout_depth = 12;
//degrees
collet1_top_angle = 45;
//degrees
collet1_bottom_angle = 45;
//mm - distance between flats for the hex nut
collet1_nut_outer_diameter = 17;//[3,3.2,4,5,6,6,7,8,10,11,13,17,19,22,24,27,30,32,36,41,46,50,55]
//mm
collet1_nut_height = 10;


/* [bottom collet] */
//mm
collet2_inner_diameter = 5.2;
//mm
collet2_outer_diameter = 14;
//mm
collet2_length = 12;
//mm
collet2_pitch = 1.5;
//mm - shrink thread radius by this amount for every mm
collet2_taper = 0.178;
//count
collet2_cutouts = 3;
//mm
collet2_cutout_widths = 1.5;
//mm
collet2_cutout_depth = 12;
//degrees
collet2_top_angle = 45;
//degrees
collet2_bottom_angle = 45;
//mm - distance between flats for the hex nut
collet2_nut_outer_diameter = 17;//[3,3.2,4,5,6,6,7,8,10,11,13,17,19,22,24,27,30,32,36,41,46,50,55]
//mm
collet2_nut_height = 10;


//hide from customizer
$fn     = 0+ 48;
epsilon = 0+ 0.01 ;

profile1     = thread_profile(collet1_pitch, collet1_taper, collet1_bottom_angle, collet1_top_angle, inner_flat=0, outer_flat=thread_edge_flat_height);
nut1_profile = thread_profile(collet1_pitch, collet1_taper, collet1_bottom_angle, collet1_top_angle, inner_flat=thread_edge_flat_height, outer_flat=0);
profile2     = thread_profile(collet2_pitch, collet2_taper, collet2_top_angle, collet2_bottom_angle, inner_flat=0, outer_flat=thread_edge_flat_height);
nut2_profile = thread_profile(collet2_pitch, collet2_taper, collet2_top_angle, collet2_bottom_angle, inner_flat=thread_edge_flat_height, outer_flat=0);

nut1_offset = ceil((collet1_length-collet1_nut_height)/2/collet1_pitch)*collet1_pitch;
nut2_offset = ceil((collet2_length-collet2_nut_height)/2/collet2_pitch)*collet2_pitch;
nut1_safe_distance = (collet1_nut_outer_diameter+max(collet1_outer_diameter,collet2_outer_diameter,center_decoration_outer_diameter))/2+1;
nut2_safe_distance = (collet2_nut_outer_diameter+max(collet1_outer_diameter,collet2_outer_diameter,center_decoration_outer_diameter))/2+1;
nut1_extra_radius = thread_edge_flat_height/(tan(collet1_top_angle)+tan(collet1_bottom_angle));
nut2_extra_radius = thread_edge_flat_height/(tan(collet2_top_angle)+tan(collet2_bottom_angle));
nut1_section_view_offset = nut_tolerance*tan((collet1_bottom_angle-collet1_top_angle)/2)-nut1_extra_radius*tan(collet1_top_angle);
nut2_section_view_offset = nut_tolerance*tan((collet2_bottom_angle-collet2_top_angle)/2)+nut2_extra_radius*tan(collet2_bottom_angle);

intersection() {
  union() {
    view = (type=="single collet"&&view=="only nut2") ? "all parts" : view;
    
    if (type=="double collet") {
      if (view=="section view" || view=="all parts" || view=="only collet")
        double_collet();
      
      if (view=="all parts") {
        translate([nut1_safe_distance,0,collet1_nut_height]) rotate([180,0,0])
          nut1();
        translate([-nut2_safe_distance,0,collet2_nut_height]) rotate([180,0,0])
          nut2();
      }
      if (view=="section view") {
        translate([0,0,collet2_length+center_length+nut1_offset+nut1_section_view_offset])
          nut1();
        translate([0,0,collet2_length-collet2_nut_height-nut2_offset+nut2_section_view_offset])
          nut2();
      }
    }
    
    if (type=="single collet") {
      if (view=="section view" || view=="all parts" || view=="only collet")
        single_collet();
      if (view=="all parts")
        translate([nut1_safe_distance,0,collet1_nut_height]) rotate([180,0,0])
          nut1();
      if (view=="section view")
        translate([0,0,center_length+nut1_offset+nut1_section_view_offset])
          nut1();
    }
    
    if (view=="only nut1")
      translate([0,0,collet1_nut_height]) rotate([180,0,0])
        nut1();
    if (view=="only nut2")
      translate([0,0,collet2_nut_height]) rotate([180,0,0])
        nut2();
  }
  
  if (view=="section view") {
    section_r = max(collet1_nut_outer_diameter, collet1_outer_diameter,
                    collet2_nut_outer_diameter, collet2_outer_diameter,
                    center_decoration_outer_diameter);
    translate([-section_r,0,-1])
      cube([2*section_r,section_r,collet1_length+center_length+collet2_length+2]);
  }
}

module nut1() {
  nut1_r = radius(profile1, collet1_outer_diameter, nut1_offset) + nut1_extra_radius + nut_tolerance;
  nut(nut1_profile, 2*nut1_r, collet1_nut_outer_diameter, collet1_nut_height);
}

module nut2() {
  translate([0,0,collet2_nut_height]) rotate([180,0,0]) {
    nut2_r = radius(profile2, collet2_outer_diameter, nut2_offset) + nut2_extra_radius + nut_tolerance;
    nut(nut2_profile, 2*nut2_r, collet2_nut_outer_diameter, collet2_nut_height);
  }
}

module single_collet() {
  difference() {
    union() {
      center();
      translate([0,0,center_length])
        thread(profile1, m=collet1_outer_diameter, l=collet1_length);
    }
    translate([0,0,center_length+collet1_length]) mirror([0,0,1])
      collet_cutouts(collet1_cutouts, collet1_cutout_widths, collet1_cutout_depth);
    translate([0,0,-epsilon])
      cylinder(d=collet1_inner_diameter,h=center_length+collet1_length+epsilon*2);
  }
}

module double_collet() {
  difference() {
    union() {
      translate([0,0,collet2_length])
        center();
      translate([0,0,collet2_length+center_length])
        thread(profile1, m=collet1_outer_diameter, l=collet1_length);
      translate([0,0,collet2_length]) rotate([180,0,0])
        thread(profile2, m=collet2_outer_diameter, l=collet2_length);
      
    }
    translate([0,0,center_length+collet1_length+collet2_length]) mirror([0,0,1])
      collet_cutouts(collet1_cutouts, collet1_cutout_widths, collet1_cutout_depth);
    mirror([0,1,0])
      collet_cutouts(collet2_cutouts, collet2_cutout_widths, collet2_cutout_depth);
    
    inner_diff = abs(collet1_inner_diameter-collet2_inner_diameter);
    translate([0,0,-epsilon])
      cylinder(d=collet2_inner_diameter,h=collet2_length-inner_diff/2+center_length/2+epsilon);
    translate([0,0,collet2_length-inner_diff/2+center_length/2-epsilon])
      cylinder(d1=collet2_inner_diameter,d2=collet1_inner_diameter,h=inner_diff+epsilon*2);
    translate([0,0,collet2_length+inner_diff/2+center_length/2])
      cylinder(d=collet1_inner_diameter,h=collet1_length-inner_diff/2+center_length/2+epsilon*2);
  }
}

module center() {
  //cylinder(r1=r1, r2=r2, h=center_length);
  r2 = smallest_radius(profile1, collet1_outer_diameter, 0);
  r1 = type=="single collet" ? r2 : smallest_radius(profile2, collet2_outer_diameter, 0);
  
  if (center_decoration=="none") {
    cylinder(r1=r1, r2=r2, h=center_length);
  }
  if (center_decoration=="hex") {
    cylinder(r1=r1, r2=r2, h=center_length);
    offset = type=="double collet" ? (center_length-center_decoration_height)/2 : 0;
    translate([0,0,offset])
      hex_head(d=center_decoration_outer_diameter,w=center_decoration_height);
  }
  if (center_decoration=="sphere") {
    single_max = sqrt(pow(center_decoration_outer_diameter/2,2)-pow(collet1_inner_diameter/2+1,2));
    sphere_center_height = type=="single collet" ? min(center_length/2,single_max) : center_length/2;
    if (type=="single collet")
      translate([0,0,sphere_center_height])
        cylinder(r1=r1, r2=r2, h=center_length-sphere_center_height);
    else
      cylinder(r1=r1, r2=r2, h=center_length);
    
    intersection() {
      translate([0,0,sphere_center_height])
        sphere(d=center_decoration_outer_diameter);
      cylinder(d=center_decoration_outer_diameter+epsilon, h=center_length);
    }
  }
}

module collet_cutouts(cutouts,cutout_w,cutout_depth) {
  translate([0,0,-epsilon]) {
    if (cutouts>0) {
      for (r=[0:360/cutouts:360]) {
        rotate([0,0,r]) {
          translate([-cutout_w/2,0,0]) {
            cube([cutout_w,1e3,cutout_depth+epsilon]);
            translate([0,0,cutout_depth+epsilon])
              rotate([0,45,0])
                ;//cube([cutout_w/sqrt(2),1e3,cutout_w/sqrt(2)]);
          }
        }
      }
    }
  }
}

/* Returns 5 points (x,y) detailing the repeating pattern of the thread
   
           __ p4
        /        }
       /         } top_slope_height
      /          }   (top_angle)
     / __ p3     }
    |          }
    |          } inner_flat
    |  __ p2   }
     \          } bottom_slope_height
      \  __ p1  }   (bottom_angle)
       |         }
       |         } outer_flat
       | __ p0   }
*/
function thread_profile(p,taper,bottom_angle,top_angle,inner_flat,outer_flat) = 
  let(taper_per_turn = taper*p)
  let(top_plus_bottom_slope_height = p - inner_flat - outer_flat - taper_per_turn*tan(top_angle))
  let(inner_radius_inset = top_plus_bottom_slope_height / (tan(bottom_angle)+tan(top_angle)))
  let(bottom_slope_height = inner_radius_inset*tan(bottom_angle))
  [
    [-inner_radius_inset,         0],
    [-inner_radius_inset,         inner_flat],
    [0,                           inner_flat + bottom_slope_height],
    [0,                           inner_flat + bottom_slope_height + outer_flat],
    [-inner_radius_inset-p*taper, p],
  ];

function p(profile) =      (profile[len(profile)-1] - profile[0])[1];
function taper(profile) = -(profile[len(profile)-1] - profile[0])[0]/p(profile);
function top_angle(profile) =    let(xy = profile[4] - profile[3]) atan2(xy[1], -xy[0]);
function bottom_angle(profile) = let(xy = profile[2] - profile[1]) atan2(xy[1],  xy[0]);
function radius(profile, m, height) = m/2 - height*taper(profile);
function biggest_radius(profile, m, height) = m/2 - (height+profile[3][1])*taper(profile);
function biggest_radius_underside(profile, m, height) =
    biggest_radius(profile, m, height+profile[3][1]-profile[2][1]);
function smallest_radius(profile, m, height) =
    biggest_radius(profile, m, height+profile[3][1]-profile[1][1])+profile[0][0];

module thread(
    profile,
    m=20,    // M size, mm, (outer diameter)
    p=0,  // Pitch, mm (0 for standard coarse pitch)
    l=50,   // length
    cap=1,  // capped ends. If uncapped, length is half a turn more top and bottom
)
{
  p = p(profile);
  
  fn=round($fn?$fn:36); // number of points per turn
  fa=360/fn; // angle of each point
  n=ceil(fn*l/p) + fn*(cap?3:1); // total number of points
  function r_at(i) =  biggest_radius(profile, m, i*p/fn - (cap?p:0)); //radius at index
  p1=[for(i=[0:1:n-1]) concat([cos(i*fa),sin(i*fa)]*(r_at(i)+profile[0][0]), i*p/fn+profile[0][1])];
  p2=[for(i=[0:1:n-1]) concat([cos(i*fa),sin(i*fa)]*(r_at(i)+profile[1][0]), i*p/fn+profile[1][1])];
  p3=[for(i=[0:1:n-1]) concat([cos(i*fa),sin(i*fa)]*(r_at(i)+profile[2][0]), i*p/fn+profile[2][1])];
  p4=[for(i=[0:1:n-1]) concat([cos(i*fa),sin(i*fa)]*(r_at(i)+profile[3][0]), i*p/fn+profile[3][1])];
  p5=[[0,0,p/2],[0,0,n*p/fn-p/2]];
  
  t1=[for(i=[0:1:fn-1]) [n*4,i,i+1]];
  t2=[[4*n,   n,   0],
      [4*n, 2*n,   n],
      [4*n, 3*n, 2*n],
      [4*n, fn,  3*n]];
  
  t3=[for(i=[0:1:n-2-fn])  [i,     i+n,     i+1]];
  t4=[for(i=[0:1:n-2-fn])  [i+n,   i+n+1,   i+1]];
  t5=[for(i=[0:1:n-2-fn])  [i+n,   i+2*n,   i+n+1]];
  t6=[for(i=[0:1:n-2-fn])  [i+2*n, i+2*n+1, i+n+1]];
  t7=[for(i=[0:1:n-2-fn])  [i+2*n, i+3*n,   i+2*n+1]];
  t8=[for(i=[0:1:n-2-fn])  [i+3*n, i+3*n+1, i+2*n+1]];
  t9=[for(i=[0:1:n-2-fn])  [i+3*n, i+fn,    i+3*n+1]];
  t10=[for(i=[0:1:n-2-fn]) [i+fn,  i+fn+1,  i+3*n+1]];
  
  t11=[for(i=[0:1:fn-1])[4*n+1, n-i-1, n-i-2]];
  t12=[[4*n+1,   n-fn-1, 2*n-fn-1],
       [4*n+1, 2*n-fn-1, 3*n-fn-1],
       [4*n+1, 3*n-fn-1, 4*n-fn-1],
       [4*n+1, 4*n-fn-1,   n-1]];
 
  intersection()
  {
    translate([0,0,-p/2-(cap?p:0)])
      polyhedron(points=concat(p1,p2,p3,p4,p5),
          faces=concat(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12),
          convexity=l/p+5);
    
    if (cap) hull() {
      ri0 = smallest_radius(profile,m,0);
      riL = smallest_radius(profile,m,l);
      ro0 = biggest_radius(profile,m,0);
      roL = biggest_radius(profile,m,l);
      if (bottom_angle(profile) <= 0)
        cylinder(r=ro0+1,h=epsilon);
      else
        cylinder(r1=ri0,r2=ro0+1,h=(ro0-ri0+1)*tan(bottom_angle(profile)));
      translate([0,0,l]) mirror([0,0,1])
        if (top_angle(profile) <= 0)
          cylinder(r=roL+1,h=epsilon);
        else
          cylinder(r1=riL,r2=roL+1,h=(roL-riL+1)*tan(top_angle(profile)));
    }
  }
}

module nut(profile, m, d, w=0)
{
  w=(w?w:m/2); // How thick to make the nut
  p = p(profile);
  taper=taper(profile);
  tr = biggest_radius(profile,m,w)+1;
  br = biggest_radius(profile,m,0)+1;
  difference()
  {
    hex_head(d=d,w=w);
    translate([0,0,-p])
    thread(profile, m=m+2*p*taper, l=w+2*p);
    //translate([0,0,-1])cylinder(r1=r+1,r2=r-5*h/8,h=1+5*h/8*tan(30));
    //translate([0,0,w-5*h/8*tan(30)])cylinder(r2=r+1,r1=r-5*h/8,h=1+5*h/8*tan(30));
    translate([0,0,w+tan(bottom_angle(profile))]) mirror([0,0,1])
      cylinder(r1=tr,r2=0,h=tr*tan(bottom_angle(profile)));
    translate([0,0,-tan(top_angle(profile))])
      cylinder(r1=br,r2=0,h=br*tan(top_angle(profile)));
  }
}

module hex_head(d=30,w=0)
{ // Make a hex head centred 0,0 with height h and wrench size/diameter d
  intersection()
  {
    w=(w?w:d/3);
    r=d/2;
    m=sqrt(r*r+r*r*tan(30)*tan(30))-r;
    rotate([0,0,90])
      cylinder(r=r+m,h=w,$fn=6);
    union()
    {
      cylinder(r1=r,r2=r+m,h=m);
      translate([0,0,m])cylinder(r=r+m,h=w-m*2);
      translate([0,0,w-m])cylinder(r1=r+m,r2=r,h=m);
    }
  }
}
