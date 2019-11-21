// Label on the base
label = "+1.5";
// Thin walls thickness (or thinness) in mm
thin_walls = 1.2;
// Base width (in mm)
base_width = 15;

/* [Hidden] */
layer_height=.2; extrusion_width=.4;
epsilon=.01;

module thinoptics_holder(
 in = [88,2.5,45], r = 5,
 notch_wide = 20, notch_narrow = 16, notch_h = 7, notch_r = 2,
 thins = thin_walls,
 thicks = 3.5,
 base_r = base_width,
 label = label
) {
 module r2(r) {
  offset(r=+r,$fn=max(r,4)*PI*4) offset(delta=-r) children();
 }
 module rsq(size,r) {
  r2(r=r) square(size=size);
 }
 difference() {
  union() {
   wx=in.x+2*thicks;
   rotate([90,0,0])
   translate([-wx/2,0,-in.y/2-thins])
   intersection() {
    hull() {
     translate([thicks-thins,thicks-thins,0])
     linear_extrude(height=in.y+2*thins)
     rsq(size=[in.x+2*thins,in.z+2*thins],r=r);
     translate([0,0,thins])
     linear_extrude(height=in.y)
     rsq(size=[wx,in.z+thins+thicks],r=r);
    }//hull
    // big box with notch cutout
    bbz=in.z+thins+thicks+notch_r+1;
    bboz=-1-notch_r;
    translate([-notch_r,bboz,-1])
    linear_extrude(height=in.y+2*thins+2)
    r2(r=notch_r) r2(r=-notch_r)
    difference() {
     square(size=[wx+2*notch_r,bbz],r=notch_r);
     translate([wx/2+notch_r,bbz-notch_h])
     polygon([
      [-notch_narrow/2,0], [notch_narrow/2,0],
      [notch_wide,2*notch_h], [-notch_wide,2*notch_h]
     ]);
    }//difference
   }//intersection
   hull() {
    for(sx=[-1,1]) translate([sx*(in.x/2+thins+thicks),0,0])
     cylinder(r=base_r,h=thicks,$fn=base_r*PI*4);
    translate([-in.x/2-thins,-in.y/2-thins,0])
    cube(size=[in.x+2*thins,in.y+2*thins,thicks+base_r/2]);
   }//hull
  }
  translate([0,0,thicks])
  rotate([90,0,0])
  translate([-in.x/2,0,-in.y/2])
  linear_extrude(height=in.y)
  rsq(size=[in.x,in.z+2*r],r=r);

  translate([0,-base_r,thicks])
  rotate([30,0,0])
  translate([0,(base_r-in.y/2-thins)/2,-2*layer_height])
  linear_extrude(height=4*layer_height)
  text(text=label,size=base_r/2,halign="center",valign="center");
 }//difference
}

thinoptics_holder();