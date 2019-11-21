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
  length=120;
  //Handle Thickness
  thickness=5;
  
  //Handle Name
  handleName = "Your name here";
  
  //Handle Fot Size
  handleNameFontSize = 9;
  
    //Handle Name Height
  handleNameHeight = 1;
  
  //Handle Name Font
  handleNameFont = "Liberation Sans"; // [Liberation Sans, Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold]

union(){
  difference(){
    cylinder(d=diameter,h=height, center=true,$fn=180); 
    cylinder(d=diameter-ring_thickness,h=height*5, center=true,$fn=180);    
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
  translate([(diameter/2)+(length/2)-(ring_thickness/2),0,-(thickness/2)]){
    linear_extrude(height = (thickness+handleNameHeight)) {
      text(handleName, size=handleNameFontSize, valign = "center", halign = "center", font=handleNameFont);  
    }
  }
  translate([(diameter/2)+(length/2)-(ring_thickness/2),0,-(thickness/2)]){
    hull() {
        linear_extrude(height = (thickness/2)) {
          offset(r = 1) {
            text(handleName, size=handleNameFontSize, valign = "center", halign = "center", font=handleNameFont);  
          }
        }
    }   
  }
  translate([(diameter/2)+(length)-(thickness/2),0,0]){
    cylinder(d=thickness,h=thickness, center=true,$fn=180); 
  }
}





