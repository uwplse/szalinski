$fn = 50;

auxDiameter = 9.1;
auxSides = 8;
overallHeight = 8;
usbLength = 5.7;
usbWidth = 10.8;
spacing = 7.2;
overallThickness = 1.2;

// handles();
// translate([27,0,0]) mirror([1,0,0]) handles();



difference () {
  translate([-overallThickness,0,0]) punchIn();
  translate([0,0,-.5]) punchOuts();
}

module handles()
{
  handle();
    mirror([0,1,0]) handle();
}
module handle() 
{
  translate([(auxDiameter/2)+.25,(auxDiameter/2)]) 
    rotate([0,0,22.5]) 
      cube([8,overallThickness,overallHeight]);
}
module punchIn()
{
  hull () {
    aux(diameter=auxDiameter+(overallThickness*2), height=overallHeight);
    translate([spacing+usbWidth,0,0]) aux(auxDiameter+(overallThickness*2), height=overallHeight);
  }
}

module punchOuts ()
{
  union(){
    translate([auxDiameter+spacing+usbWidth-2,-overallThickness/2,0]) cube([4, overallThickness,overallHeight+1]);
    translate([-2,-overallThickness/2,0]) cube([4, overallThickness,overallHeight+1]);
    translate([auxDiameter + spacing,0,0]) usb(height=overallHeight+1);
    aux(diameter=auxDiameter, height=overallHeight+1);
  }
  
}

module aux (diameter, height)
{
  translate([diameter/2, 0, 0]) 
    cylinder(d=diameter, $fn=auxSides, h=height);
}

module usb (height) 
{
  translate([(usbLength/2),0,0]) 
  hull(){
    cylinder(d=usbLength, h=height);
    translate([usbWidth-usbLength,0,0]) cylinder(d=usbLength, h=height);
  }
}