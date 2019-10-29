pole_dia = 24.5;
pole_r = pole_dia/2;
pole_thick = 3;
pole_h = 5;
clip_depth = 10;
clip_thick = 2;

$fn = 50;

clip_depth2 = clip_depth + pole_r;

difference (){

  union(){
    translate([pole_r, 0, 0]){
      cube([clip_thick, clip_depth2, pole_h]);
      
      translate([0+1, clip_depth2, 0]){
        rotate(a=180, v=[0,0,1]){
          cube([(pole_r*2), clip_thick, pole_h]);
          
          translate([(pole_r*2), 0, 0]){
            cube([clip_thick, clip_depth2/2, pole_h]);
          }
        }
      }      
    }
    
    cylinder(r=pole_r+pole_thick, h=pole_h);
  }

  translate([0, 0, 0-(pole_h*0.1) ]){
    cylinder(r=pole_r, h=pole_h*1.2);
    
    translate([0, 0-pole_r-(pole_thick*2), 0])
      cylinder(r=pole_r+pole_thick, h=pole_h*1.2);
  }
}
