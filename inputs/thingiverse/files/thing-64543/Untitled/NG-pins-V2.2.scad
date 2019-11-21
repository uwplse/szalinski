//Pin Diameter
pinDia=8.2;
//Pin Height
pinHt=20;
//Thread Diameter
threadDia=3.2;
//Thread Length (length of screw)
threadLength=13;
//Nut Diameter (across corners)
nutDia=6.7;
//Nut Height (thickness)
nutHeight=2.9;
//Array of X pins
arrayX=3;
//Array of Y pins
arrayY=3;

module draw_pin (nutDia,nutHeight)
{
  //radius of pin
  pinRad=pinDia/2;
  //total height of pin
      difference(){
        //draw the peg
        union() {
          translate([0,0,pinHt-pinRad]) sphere(r=pinRad,$fn=20);
          cylinder(r=pinRad,h=(pinHt-pinRad), $fn=20);
         } 
         //drill a hole for the bolt
         translate([0,0,-5])cylinder(h=threadLength+5,r=threadDia/2,$fn=20);
         //cut a hole for a nut
         translate([0,0,-1/nutHeight])cylinder(h=nutHeight, r=nutDia/2,$fn=6);
      }
      difference(){
        translate([0,0,0])cylinder(h=nutHeight, r=nutDia/3, $fn=6);
        translate([0,0,-2])cylinder(h=nutHeight+4, r=(nutDia/3)-0.2, $fn=6);
      }
}


module drawArray()
{
  for (i=[0:arrayX-1]){
    for(j=[0:arrayY-1]){
      translate([i*(pinDia+3),j*(pinDia+3),0])draw_pin(nutDia,nutHeight);
    }
  }
}


drawArray(6.8,3.2);

