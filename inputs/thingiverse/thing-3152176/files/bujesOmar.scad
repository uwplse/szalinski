//How many do you need?
number = 2; //[1:10]
base_diameter = 19.05;
//
base_height = 1;//[.8:.2:2]
//
bushing_height = 4.76;
//
bushing_external_diamter = 12.7;
//
bushing_internal_diameter = 7.94;

columnas = sqrt(number);
for (i= [1:number]){
  translate([(2+base_diameter)*floor((i-1)/columnas),  (2+base_diameter)*floor((i-1)%columnas), 0]) buje(bushing_height);
    echo (floor(i/columnas));
}

//translate([20,0,0])buje(25.4);
//translate([0,20,0]){
//  buje(7.94);
//  translate([20,0,0])buje(25.4);
//}
module buje(h){
  difference(){
    union(){
      cylinder(d=base_diameter, h=base_height, $fn=35);
      cylinder(d=bushing_external_diamter, h=h, $fn=35);
    }
    cylinder(d=bushing_internal_diameter, h=h, $fn=35);
  }
}