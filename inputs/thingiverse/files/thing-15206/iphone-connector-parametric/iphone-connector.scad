module iphone_connector()
{
  
//  $fn = 100;
  connector_depth = 2.57;
  connector_width = 21.36;
  connector_height = 6;

  plastic_width = 26.15;
  plastic_height = 9.07;
  plastic_depth = 5.65;
  
  cable_strain_diameter = 4.5;
  cable_strain_height = 6;
  
  plastic_block_width = plastic_width-plastic_depth;
  r_plastic_edge = plastic_depth/2;
  
  union()
  {
    translate([-connector_width/2, -connector_depth/2, plastic_height]) cube([connector_width, connector_depth, connector_height]); // connector protrusion
    translate([-plastic_block_width/2,0,0]) cylinder(r = r_plastic_edge, h = plastic_height); // left rounded edge
    translate([plastic_block_width/2,0,0]) cylinder(r = r_plastic_edge, h = plastic_height); // right rounded edge
    translate([-plastic_block_width/2,-plastic_depth/2,0]) cube([plastic_block_width, plastic_depth, plastic_height]); // center of plastic peice
    translate([0,0,-cable_strain_height]) cylinder(r = cable_strain_diameter/2, h = cable_strain_height); // cable strain protrusion
  }
  
}

$fn = 100;
iphone_connector();
