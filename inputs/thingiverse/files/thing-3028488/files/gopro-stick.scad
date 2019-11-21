include <gopro_mounts.scad>

module single(){
  difference(){
    union(){
        translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
    }
    // remove the axis
    translate([0,0,-gopro_tol])
      cylinder(r=gopro_holed_two/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
  }
}

module gopro_stick(length=100, height=10, width=10){
  union(){
    single();
    translate([
      -gopro_connector_z/2,
      10,
      gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]
    ) 
    cube([
    gopro_connector_z,
    length-20,
    gopro_connector_th2]
    );
    mirror(v= [0, 1, 0] ) translate([0,-100,0]) single();
      
    }
}

gopro_stick();


