
//exterior_height
exterior_height=15;

//interior_hole_diameter
interior_hole_diameter=8; 

//wall thickness
wall_thickness=1.5;

//interior height offset
interior_height_offset=5;
//resolution
$fn=50; //[100,300,500]

difference(){
  cylinder (exterior_height, d=interior_hole_diameter+wall_thickness );
  translate([0,0,interior_height_offset])cylinder (exterior_height+1, d=interior_hole_diameter );
}