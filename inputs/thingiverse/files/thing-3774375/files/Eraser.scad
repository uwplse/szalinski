
Width  = 40;
Length = 100;
Height = 30;

// Use spaces to center the text
label_text   = " RafaelEstevam";
// Controls the offset to center
label_ffsetX = 15;
// Font name
label_font   = "Liberation Sans";
// Font size in mm
label_size   = 10;
// Font heigh, use negative value to low relief text
label_heigh   = 1.5;

eraser();
//belt();

module eraser(){
  if (label_heigh > 0 && len(label_text) > 0) label();
  difference(){    
    cube([Width, Length, Height]);
    belt();  
    if (label_heigh < 0 && len(label_text) > 0) label();
  }
}
module label(){
  h = Height + (label_heigh < 0 ? label_heigh : -0.01);
  
  translate([label_size+label_ffsetX,0,h]) rotate(a=[0,0,90])
  linear_extrude(height = abs(label_heigh)) {
     text(label_text, font = label_font, size = label_size);
   }
}
module belt(){
  cd = Height/3;
  offset = 1;
  
  translate([0,0,cd*1.5]){
    rotate(a=[0,90]){
      translate([0,-offset])
        cylinder(d=cd,Width);
      translate([0,Length+offset])
        cylinder(d=cd,Width);
    }  
    rotate(a=[-90,0]){
      translate([-offset,0])
        cylinder(d=cd,Length);
      translate([Width+offset,0])
        cylinder(d=cd,Length);
    }
  }
}