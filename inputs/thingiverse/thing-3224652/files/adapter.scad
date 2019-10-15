// outer size of adapter, units in mm
depth = 39;
width = 41;
height = 40;
// the wall we attach it to
inner = 18;
// distance from rear of the adapter to rear of the wall
strength = 8;
// notch, prevents supportless building
notch = 5;
nd = 2;
// clamp
tw = 3;
teeth = depth+2*tw;
// angle of the clamp ~ holding strength
clamp = 2.5;
// rims, prevent slipping of the kura holders
rim = 1.5;

// technical parameters
crop = 0.1; c = crop;

toff = (depth-teeth)/2;
front = width-inner-strength;
// main clamp with rims

difference() {
  union() {
    // this notch prevents building without support 
    //translate([0,-nd,-rim])
    //  cube([notch,nd+c,depth+2*rim]);
    
    cube([width, height, depth]);
    //rims    
    translate([-rim,0,-rim]) 
      cube([width+2*rim, height+rim, rim]);
    translate([-rim,0,depth]) 
      cube([width+2*rim, height+rim, rim]);
  }      
  translate([strength, strength, -crop-rim])
    cube([inner, height-strength+rim+c, depth+rim*2+c*2]);
  // clip rims
  translate([-rim-c,strength,-rim-c])
    cube([rim+c, height, depth+2*rim+2*c]);
  translate([-c,height,-c-rim])
    cube([strength+2*c,rim+c,depth+2*rim+2*c]);
  // hollow space for clamping teeth
  translate([inner,strength,toff])
    cube([front+toff, height, teeth]);

}

// clamping teeth
translate([0,strength,toff]) {
  th = height-strength+tw;
    translate([inner+strength,-tw,tw/2]) 
    translate([0,strength,0])
    rotate([0,0,clamp])
    translate([0,-strength,0])
    difference(){
      cube([tw, th, teeth-tw]);
      translate([0,th-tw,-c])
      rotate([0,0,45])   
      cube([tw*2, tw, teeth-tw+c*2]);   
    }
}

