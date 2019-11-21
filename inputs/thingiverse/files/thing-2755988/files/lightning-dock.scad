// The diameter of the whole thing (in mm). Current value is suitable for iPhone 5 for this is what I have.
diameter = 75;
// The diameter of the cable channel (in mm).
cable_diameter = 3.5;
// The width (in mm) of the channel through which it is still possible to push the cable.
cable_minimum_width = 2.8;
// The width of the lightning connector (in mm). The preset dimensions is for the random lighting cable I happen to have (not the genuine apple).
lightning_width = 9.4;
// The thickness of the lightning connector (in mm).
lightning_thickness = 6.5;
// The length (in mm) of the lightning connector up to the cable.
lightning_length = 30;
// The length of the M3 screw used to fix the lightning connector
screw_length = 25;

/* [Hidden] */
layer_height=.2; extrusion_width=.5;
epsilon=.01;

module lightning_dock(
 d=75,                                  // the whole thing diameter
 cable_d=3.5, cable_und = 2.8,          // cable diameter, cable undiameter
 usbsize=[9 +.4,6 +.3,30],              // usb connector dimensions
 cable_r=5,                             // the radius of cable turn
 tilt=10,                               // phone tilt
 nut_d=5.5/cos(30), nut_h=3,            // nut dimensions (m3 here)
 screw_l=25, screw_d=3.2,               // screw dimensions
 screwhead_d=6, screwhead_h=3,          // screw head dimensions
 cut_angle = 30, cut_away = 8,          // front cutoff angle and distance from connector (center)
 s = 2.5,                               // shell under the cabling
 flex_s = 2*extrusion_width, flex_e = 2*extrusion_width,
 ch=1.5,                                // chamfer
 debug = false
) {
 fnd = PI*2; fnr = 2*fnd;
 
 h = usbsize.z+cable_r+cable_d+s;
 
 difference() {
  cylinder(d=d,h=h,$fn=d*fnd);
  //
  translate([-d/2-1,-cut_away,h]) rotate([cut_angle,0,0])
  mirror([0,1,0]) cube(size=[d+2,d/2+1,h]);
  extrl = usbsize.y/2+1/cos(tilt);
  translate([0,0,h]) rotate([-tilt,0,0]) mirror([0,0,1]) {
   hull() for(mx=[0,1]) mirror([mx,0,0]) translate([usbsize.x/2-usbsize.y/2,0,-extrl])
    cylinder(d=usbsize.y,h=h/cos(tilt)+2*extrl,$fn=usbsize.y*fnd);
   fx = usbsize.x;
   translate([-fx/2,usbsize.y/2+flex_s,usbsize.z/2-usbsize.x/2]) mirror([0,1,0]) {
    translate([0,-flex_e,0])
    difference() {
     cube(size=[fx,flex_e+flex_s+usbsize.y/2,usbsize.x]);
     translate([0,flex_e,flex_e])
     cube(size=[fx-2*flex_e,flex_e+flex_s+usbsize.y/2+1,usbsize.x-2*flex_e]);
     translate([-1,flex_e,flex_e+usbsize.x-flex_e-flex_e])
     mirror([0,0,1]) cube(size=[fx+2,flex_s+usbsize.y/2+1,layer_height*2]);
    }//difference
   }
  }
  
  holdpos = [0,
   -usbsize.z*sin(tilt)/2,
   h-usbsize.z*cos(tilt)/2];
  screwoff = usbsize.y/cos(tilt)/2+screw_d*sin(tilt)/2+flex_s;
  translate(holdpos)
  rotate([-90,0,0]) {
   translate([0,0,screwoff])
   cylinder(d=screw_d,h=d,$fn=screw_d*fnd);
   translate([0,0,screw_l-usbsize.y/cos(tilt)+holdpos.y])
   cylinder(d=screwhead_d,h=d,$fn=screwhead_d*fnd);
   hull() for(whoosh=[0,h+nut_d])
   translate([0,whoosh,(screw_l-usbsize.y/cos(tilt)/2)/2+holdpos.y]) rotate([0,0,30]) cylinder(d=nut_d,h=nut_h,$fn=6);
  }

  fz = s+usbsize.y/2+cable_r+usbsize.y/2+cable_r*sin(tilt);
  chpos = [0,
           cable_r*cos(tilt)-(h-fz)*sin(tilt)+usbsize.y/2/cos(tilt),
           usbsize.y/2+s];
   translate(chpos) {
    for(oz=[0:usbsize.y/2:chpos.z+cable_r]) translate([0,-oz*sin(tilt),-oz]) {
     mirror([0,1,0]) rotate([0,90,0])
     translate([-cable_r-usbsize.y/2,0,0]) rotate_extrude(angle=90+tilt,$fn=(cable_r+usbsize.y+cable_d/2)*fnr)
     hull() for(my=[0,1]) mirror([0,my]) translate([0,usbsize.x/2-usbsize.y/2])
     translate([cable_r+usbsize.y/2,0]) rotate([0,0,45]) circle(d=usbsize.y,$fn=4);     
    }
    rotate([-90,0,0]) {
     translate([0,0,-epsilon]) cylinder(d1=usbsize.y,d2=cable_d,h=(usbsize.y-cable_d)/2,$fn=usbsize.y*fnd);
     cylinder(d=cable_d,h=d,$fn=cable_d*fnd);
    }
   }

  cl=d/2+1+h*sin(tilt);
  translate([0,-h*sin(tilt),-1]) {
   translate([-cable_und/2,0,0])
   cube(size=[cable_und,cl,s+usbsize.y/2+1]);
   hull() {
    translate([-cable_und/2-ch,0,0])
    cube(size=[cable_und+2*ch,cl,1]);
    translate([-cable_und/2,0,0])
    cube(size=[cable_und,cl,ch+1]);
   }

  }
    
  //debug:
  if(debug) translate([-d/2-1,-d/2-1,-1]) cube(size=[d/2+1,d+2,h+2]);
 }//difference
 
}//lightning_dock module

lightning_dock(
 d = diameter,
 cable_d = cable_diameter, cable_und = cable_minimum_width,
 usbsize = [lightning_width,lightning_thickness,lightning_length]
);