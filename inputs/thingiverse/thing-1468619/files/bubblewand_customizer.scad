  //Ring Diameter
  diameter=60;
  //Ring Height
  height=5;
  //Ring Thickness
  ring_thickness=5;
  
  //Notch Length
  notch_length=3;
  //Notch Thickness
  notch_thickness=1;
  //Notch Placement
  notch_placement=4;
  //Notch Height
  notch_height=0;
  //Notch Count
  notch_count=70;

  //Handle Length
  length=75;
  //Handle Thickness
  thickness=5;

union(){
  difference(){
    cylinder(d=diameter,h=height, center=true); 
    cylinder(d=diameter-ring_thickness,h=height*5, center=true);    
  }
  for(i = [0:notch_count]){
    rotate(360/notch_count*i){  
      translate([diameter/2-notch_placement,0,0]){
        cube([notch_length,notch_thickness,height+notch_height], center=true);
      }
    }
  }
  translate([(diameter/2)+(length/2)-(ring_thickness/2),0,0]){
    cube([length,thickness,thickness],center=true);
  }    
}





