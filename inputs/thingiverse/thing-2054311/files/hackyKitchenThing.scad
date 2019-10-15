//Sink Middle Bar Extender
//BEGIN CUSTOMIZER VARIABLES
/*[Bar]*/
width_of_bar = 1.3;
thickness = .2;
depth_of_slot = 2;
/*[Extender]*/
length_of_extender = 3;
width_of_extender= 1;
//END CUSTOMIZER VARIABLES
/*[Hidden]*/
unitConversion =25.4;

theThing();

module theThing(){
  difference(){
    union(){
      cube([width_of_bar+thickness*2, width_of_extender,depth_of_slot+thickness]*unitConversion);
      translate([width_of_bar/2+thickness,0,depth_of_slot]*unitConversion){
        cube([length_of_extender,width_of_extender,thickness]*unitConversion);
      }
    }
    translate([thickness-.001,0,0]*unitConversion){
      cube([width_of_bar, width_of_extender+.1, depth_of_slot]*unitConversion);
    }
  }
}