// Good settings for an adult size spinner
bearing_ht = 10;
bearing_od = 22; 
bearing_id = 16;
container_od = 70; 

// Good settings for a micro spinner
// bearing_ht = 8;
// bearing_od = 14; 
// bearing_id = 10;
// container_od = 40; 

// Tolerance. You might need to tweak this for your printer. 
// This is the buffer around the spinner. 
tol = 0.6; 
eps = 0.01;

// decrease this for higher quality. 
$fa=1;

module spindle(expand) {
  translate([0,0,0]) 
    cylinder(d1=bearing_od+expand*2, 
             d2=bearing_id+expand*2, 
              h=bearing_ht/2+2*eps);
  translate([0,0,bearing_ht/2]) {
    cylinder(d2=bearing_od+expand*2, 
             d1=bearing_id+expand*2, 
              h=bearing_ht/2+2*eps); 
  }
}
module holder() {
  difference() {
    union () {
      cylinder(h=bearing_ht, d=container_od);
      rotate_extrude()
        translate([container_od/2,bearing_ht/2,0])
          circle(r = bearing_ht/2);
    }
    spindle(tol);
  }
}

// super-thin circle with cutouts that we can apply 
// minkowski to. 
module scallop(od,offset_factor,d_factor){
  difference() {
    cylinder(h=eps,d=od); 
    for(i=[0,1,2]){
      rotate(120*i,[0,0,1]){
        translate([od*offset_factor,0,-eps]){
          cylinder(d=od*d_factor,h=3*eps); 
       }
     }
    }
  }
}

module spinner() {
   difference() {
     minkowski($fn=24) { 
       // must be a multiple of 4 or you get issues
       scallop(container_od, 0.45, 0.57); 
       sphere(r=bearing_ht/2);
     }
     translate([0,0,-bearing_ht/2-eps]) spindle(tol);
   }
   translate([0,0,-bearing_ht/2]) spindle(0);
}

spinner();


