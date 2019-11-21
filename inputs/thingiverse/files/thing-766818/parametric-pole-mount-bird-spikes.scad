spike_l = 60; // spike length
spike_h = 2;  // spike height
spike_w = 3;  // spike width

pole_dia = 13;  // diameter of the pole
pole_thick = 3; // thickness of the clip
pole_h = 10;    // height of the clip

$fn = 48;

pole_r = pole_dia/2;

difference (){

  union(){
    translate([0-(spike_w/2), 0, 0]){

      rotate(a=-45, v=[0,0,1])
        cube([spike_w, spike_l, spike_h], center=false);

      rotate(a=-22.5, v=[0,0,1])
        cube([spike_w, spike_l, spike_h], center=false);

      cube([spike_w, spike_l, spike_h], center=false);

      rotate(a=22.5, v=[0,0,1])
        cube([spike_w, spike_l, spike_h], center=false);

      rotate(a=45, v=[0,0,1])
        cube([spike_w, spike_l, spike_h], center=false);
    }

    cylinder(r=pole_r+pole_thick, h=pole_h);
  }

  translate([0, 0, 0-(pole_h*0.1) ]){
    cylinder(r=pole_r, h=pole_h*1.2);

    translate([0, 0-pole_r-(pole_thick*2), 0])
      cylinder(r=pole_r+pole_thick, h=pole_h*1.2);
  }
}
