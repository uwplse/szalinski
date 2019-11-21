/* [Parameters] */

//
module_type = "X-module"; // [I-module, L-module, T-module, X-module, BL-module, BT-module, BR-module, FL-module, FT-module, FR-module]

//
module_width = 50;

//
board_thickness = 10;

//
wall_thickness = 3;

/* [Shape] */
//Open SCAD parameter $fn = 4*detalization. Do not put too big value customizer will stuck.
shape_detalization=4; // default = 15, i.e. $fn = 60

//
corner_radius = 15;

//corner shape type
shape_type = "no shape"; // [no shape, linear, circle, arc-in]

//
shape_parameter = 0;

HH = module_width;
RR = corner_radius;
DD = board_thickness;
r=wall_thickness/2;

PP = shape_parameter;
$fn = 4*shape_detalization;

module side_block(h,d,r) {
 LHH = h-d/2-3*r;
 LDD = d/2+r;
 eps=0.01;

 difference(){
  hull(){
   translate([-LDD,+LDD,-LDD])sphere(r=r,center=true);
   translate([-LDD,-LDD,-LDD])sphere(r=r,center=true);
   translate([LHH,+LDD,-LDD])sphere(r=r,center=true);
   translate([LHH,-LDD,-LDD])sphere(r=r,center=true);
   translate([-LDD,+LDD,LHH])sphere(r=r,center=true);
   translate([-LDD,-LDD,LHH])sphere(r=r,center=true);
   translate([LHH,+LDD,LHH])sphere(r=r,center=true);
   translate([LHH,-LDD,LHH])sphere(r=r,center=true);
  }
  translate([d/2+2*r+eps,-d/2+eps,-d/2])cube([h,d-2*eps,h]);
 }
}

module side_corner(h,d,q,r) {
 LHH = h-d/2-3*r;
 LDD = d/2+r;
 w=d+2*r;

 translate([0,0,-(d/2+r)]){
  translate([q+w/2,q+w/2,0])
  intersection(){
   rotate_extrude(convexity = 2){
    translate([q, 0]) circle(r = r); 
    translate([q, HH-2*r]) circle(r = r); 
   }
   translate([-q/2-r/2,-q/2-r/2,HH/2-r])
    cube([q+r,q+r,HH],center=true);
  }

  translate([0,0,-r])
  linear_extrude(HH)
  difference(){
   translate([w/2,w/2])square([q,q]);
   translate([+(q+w/2),+(q+w/2)])circle(q);
  }

  linear_extrude(HH-2*r)
  difference(){
   translate([w/2,w/2])square([q,q]);
   translate([+(q+w/2),+(q+w/2)])circle(q-r);
  }
 }
}

module side_plate_line(h,d,q,r){
 LHH = h-d/2-3*r;
 LDD = d/2+r;

 hull()
 {
  translate([LDD,LDD,-LDD])sphere(r=r,center=true);
  translate([LDD,LHH-q,-LDD])sphere(r=r,center=true);
  translate([LHH-q,LDD,-LDD])sphere(r=r,center=true);
 }
}

module side_plate_arcout(h,d,q,r){
 LHH = h-d/2-3*r;
 LDD = d/2+r;

 hull()
 {
  translate([LDD,LDD,-LDD])sphere(r=r,center=true);
  translate([LDD,LHH,-LDD])sphere(r=r,center=true);
  translate([LHH,LDD,-LDD])sphere(r=r,center=true);
  translate([0,0,-(d/2+r)])
  translate([LHH-q,LHH-q,0])
  intersection(){
   rotate_extrude(){
    translate([q, 0])
    intersection(){
     circle(r = r);
     translate([0,-r])square([2*r,2*r]);
    }
   }
   translate([+q/2+r/2,+q/2+r/2,h/2-r])
    cube([q+r,q+r,h],center=true);
  }
 }
}

module side_plate_arcin(h,d,q,r) {
 LHH = h-d/2-3*r;
 LDD = d/2+r;
 w=d+2*r;

 translate([0,0,-(d/2+r)]){
  translate([q+w/2,q+w/2,0])
  intersection(){
   rotate_extrude(convexity = 2){
    translate([q, 0]) circle(r = r); 
   }
   translate([-q/2-r/2,-q/2-r/2,HH/2-r])
    cube([q+r,q+r,HH],center=true);
  }

  translate([0,0,-r])
  linear_extrude(2*r)
  difference(){
   translate([w/2,w/2])square([q,q]);
   translate([+(q+w/2),+(q+w/2)])circle(q);
  }
 }
}

module side_plate(h,d,q,r){
 side_corner(h,d,q,r);
 if (shape_type == "linear") side_plate_line(h,d,PP,r);
 if (shape_type == "circle") side_plate_arcout(h,d,PP,r);
 if (shape_type == "arc-in") side_plate_arcin(h,d,h-d-4*r-PP,r);
}

module bottom_sub(h,d,q,r){
 w=d+2*r;
 translate([+(h-w/2),-w/2,0])
 scale([0.8,h/(h-w),1])  //1.5
 translate([0,h-w,0])
 cylinder(r=h-w,h=2*h,center=true,$fn=2*$fn);
}

module bottom_frame(h,d,q,r){
 LHH = h-d/2-3*r;
 LDD = d/2+r;
 w=d+2*r;
 ww = 2*h-w-2*(h-w)*0.8;

 rotate([0,0,180])
 minkowski()
 {
  difference(){
   translate([0,d/2+r,0])
    translate([-ww/2,0,-ww/2])
    cube([h-2*r,LHH-d/2-r,h-2*r]);
 
   union(){
    rotate([0,  0,0]) bottom_sub(h,d,q,r);
    rotate([0, 90,0]) bottom_sub(h,d,q,r);
    rotate([0,-90,0]) bottom_sub(h,d,q,r);
    rotate([0,180,0]) bottom_sub(h,d,q,r);
   }
  }
  sphere(r=r);
 }
}

module module_BL(h=HH,d=DD,q=RR,r=r){
 w=d+2*r;
 ww = 2*h-w-2*(h-w)*0.8;
 
 module_L(h,d,q,r);
 translate([(ww-w)/2,0,(ww-w)/2])
 rotate([0,90,0])bottom_frame(h,d,q,r);
}

module module_BR(h=HH,d=DD,q=RR,r=r){
 mirror([1,0,0])module_BL(h,d,q,r);
}

module module_BT(h=HH,d=DD,q=RR,r=r){
 w=d+2*r;
 ww = 2*h-w-2*(h-w)*0.8;
 
 rotate([0,0,180])module_T(h,d,q,r);
 translate([0,0,(ww-w)/2]){
 rotate([0,0,0])bottom_frame(h,d,q,r);
 rotate([0,90,0])bottom_frame(h,d,q,r);
 }
}

module module_FR(h=HH,d=DD,q=RR,r=r){
 w=d+2*r;
 ww = 2*h-w-2*(h-w)*0.8;
 
 module_L(h,d,q,r);
 //translate([(ww-w)/2,0,(ww-w)/2])
 translate([(ww-w)/2,0,h-w-2*r-(ww-w)/2])
 rotate([0,180,0])bottom_frame(h,d,q,r);
}

module module_FL(h=HH,d=DD,q=RR,r=r){
 mirror([1,0,0])module_FR(h,d,q,r);
}

module module_FT(h=HH,d=DD,q=RR,r=r){
 w=d+2*r;
 ww = 2*h-w-2*(h-w)*0.8;
 
 rotate([0,0,180])module_T(h,d,q,r);
 translate([0,0,h-w-2*r-(ww-w)/2]){
 rotate([0,180,0])bottom_frame(h,d,q,r);
 rotate([0,-90,0])bottom_frame(h,d,q,r);
 }
}

module module_I(h=HH,d=DD,q=RR,r=r){
 rotate([0,0,-90])side_block(h, d, r);
 rotate([0,0,+90])side_block(h, d, r);
}

module module_L(h=HH,d=DD,q=RR,r=r){
 side_block(h, d, r);
 rotate([0,0,90])side_block(h, d, r);

 side_plate(h,d,q,r);
}

module module_T(h=HH,d=DD,q=RR,r=r){
 rotate([0,0,0])side_block(h, d, r);
 rotate([0,0,-90])side_block(h, d, r);
 rotate([0,0,180])side_block(h, d, r);

 rotate([0,0,-90])side_plate(h,d,q,r);
 rotate([0,0,180])side_plate(h,d,q,r);
}

module module_X(h=HH,d=DD,q=RR,r=r){
 rotate([0,0,  0])side_block(h, d, r);
 rotate([0,0, 90])side_block(h, d, r);
 rotate([0,0,180])side_block(h, d, r);
 rotate([0,0,270])side_block(h, d, r);

 rotate([0,0,  0])side_plate(h,d,q,r);
 rotate([0,0, 90])side_plate(h,d,q,r);
 rotate([0,0,180])side_plate(h,d,q,r);
 rotate([0,0,270])side_plate(h,d,q,r);
}

if (module_type == "I-module") module_I();
if (module_type == "L-module") module_L();
if (module_type == "T-module") module_T();
if (module_type == "X-module") module_X();
if (module_type == "BL-module") module_BL();
if (module_type == "BT-module") module_BT();
if (module_type == "BR-module") module_BR();
if (module_type == "FL-module") module_FL();
if (module_type == "FT-module") module_FT();
if (module_type == "FR-module") module_FR();

