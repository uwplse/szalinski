/*[Sprinkler]*/
hub_diameter            = 25;	//[10:1:50]
connector_diameter      = 6;  	//[4:1:13]
barb_diameter           = 8.5;  //[5:0.5:15]
connector_length        = 12;   //[10:1:25]
barb_length             = 6;	//[5:1:10]
nozzle_inner_diameter   = 1;	//[1:0.1:3]
nozzle_length           = 3;	//[0:0.5:10]
num_nozzles             = 3;	//[1:1:5]
nozzle_spread           = 75;	//[45:5:90]
wall_thickness          = 0.7;	//[0.5:0.1:2]
is_end_stop             = false;//[true,false]

$fa = 10;
$fn = 360 / $fa;

rotate([90, 0, 0]) difference()
{
  body();
  cutout();
  *translate([-50, -100, -50]) cube(100);
}

module body()
{
  union()
  {
    translate([0, (connector_diameter - barb_diameter) /2, (connector_diameter - barb_diameter) / 2]) 
    {
      intersection()
      {
        cylinder(h = barb_diameter, d = hub_diameter);
        translate([-hub_diameter / 2, 0, 0]) cube([hub_diameter, hub_diameter /2, barb_diameter]);
      }

      base();
    }
        
    connector();
      
		if(!is_end_stop)
		{
	        mirror([-1, 0, 0]) connector();
		}
    
    addNozzles();
  }
    
  module base()
  {
    difference()     
    {
      translate([-hub_diameter / 2, -2, -hub_diameter /2]) 
        cube([hub_diameter,2,hub_diameter + barb_diameter]);
      translate([2-hub_diameter / 2, -2.5, 2 -hub_diameter /2])   
        cube([hub_diameter-4,3,-2 +hub_diameter/2 ]);
      
      translate([2-hub_diameter / 2, -2.5, +barb_diameter])   
        cube([hub_diameter-4,3,-2 +hub_diameter/2 ]);
           
      w = barb_diameter-4;
      *if (w > 0)
        translate([2-hub_diameter / 2, -2.5, 2])
          cube([hub_diameter-4,2.5, w]);  
    }
  }
  
  module connector()
  {
    rotate([0, 90, 0]) translate([-connector_diameter / 2, connector_diameter / 2, 0]) union()
    {
        cylinder(h = connector_length + hub_diameter / 2, d = connector_diameter);
        translate([0, 0, connector_length + hub_diameter / 2 - barb_length]) cylinder(h = barb_length, d1 = barb_diameter, d2 = connector_diameter);
    }
  }
    
  module nozzle()
  {
    rotate([-90, 0, 0]) translate([0, -connector_diameter / 2, 0]) union()
    {
      cylinder(h = hub_diameter / 2, d = nozzle_inner_diameter + wall_thickness * 4);
      translate([0, 0, hub_diameter / 2]) 
        cylinder(h = nozzle_length, d1 = nozzle_inner_diameter + wall_thickness * 4, d2 = nozzle_inner_diameter + wall_thickness * 2);
    }
  }
  
  module addNozzles()
  {
    a_step = nozzle_spread / (num_nozzles - 1);
    offset = -a_step * (num_nozzles - 1) / 2;

    difference()
    {
      union()
      {
        for(idx = [0 : num_nozzles - 1])
        {
          rotate([0, 0, idx * a_step + offset]) nozzle();
        }
      }
      translate([-hub_diameter / 2, -hub_diameter, 0]) cube(hub_diameter);
    }
  }
}

module cutout()
{
    inner_hub_diameter = hub_diameter - wall_thickness * 4;
    inner_connector_diameter = connector_diameter - wall_thickness * 2;
    
    translate([0, wall_thickness, wall_thickness]) union()
    {
      /*
      #translate([0, (connector_diameter - barb_diameter) /2, 0]) intersection()
      {
          cylinder(h = inner_connector_diameter, d = inner_hub_diameter);
          translate([-inner_hub_diameter / 2, 0, 0]) cube([inner_hub_diameter, inner_hub_diameter, inner_hub_diameter]);
      }
      */
      
      connector();
      
      if(!is_end_stop)
      {
            mirror([-1, 0, 0]) connector();
      }
      
      addNozzles();
    }
    
    module connector()
    {
      add = inner_hub_diameter / 4;
      rotate([0, 90, 0]) translate([-inner_connector_diameter / 2, inner_connector_diameter / 2, -add]) 
        cylinder(h = add + connector_length + hub_diameter / 2 + 1, d = inner_connector_diameter);
    }
    
    module addNozzles()
    {
      a_step = nozzle_spread / (num_nozzles - 1);
      offset = -a_step * (num_nozzles - 1) / 2;

      translate([0, -wall_thickness, 0]) 
      difference()
      {
        union()
        {
              for(idx = [0 : num_nozzles - 1])
              {
                  rotate([0, 0, idx * a_step + offset]) nozzle();
              }
        }
        translate([-hub_diameter / 2, -hub_diameter + wall_thickness, 0]) cube(hub_diameter);
      }
    }
    
    module nozzle()
    {
      rotate([-90, 0, 0]) translate([0, -inner_connector_diameter / 2, wall_thickness +0.75]) 
        cylinder(h = hub_diameter / 2 + nozzle_length + 1, d = nozzle_inner_diameter);
    }
}