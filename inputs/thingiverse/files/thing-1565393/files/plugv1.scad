//shaft diameter
shaft_diameter=8;

//shaft_ length
shaft_length=7;

//shaft wall thickness
shaft_wall_thickness=1;

//cap diameter
cap_diameter=10;

//cap hight
cap_hight=3;

//resolution
$fn=300; //[100,300,500]
union(){
  cylinder ( cap_hight, d = cap_diameter );
  translate([0,0,cap_hight-.1])difference(){
   cylinder( shaft_length+.1, d=shaft_diameter);
   cylinder ( shaft_length+.2,d=(shaft_diameter-(2*shaft_wall_thickness)));
  }
}
