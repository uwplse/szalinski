adapter_diameter = 30;
adapter_depth = 20;
adapter_wall_thickness = 3;

shaft_height = 10;

connector_gender = "female"; // [female, male]
connector_strengthening = 0;

// Types: Boston,Small Boston,Pinch,Halkey Roberts
// Calculations
radius = adapter_diameter/2;
b = radius + adapter_wall_thickness;

if(connector_gender=="female"){
    union(){
      female_connector(1);
      shaft(15,4.5,connector_strengthening);
      adapter(adapter_depth);
    }
}else{
    rotate([180,0,0])
    union(){
        male_connector(2.2);
        shaft(10,2.1,0);
        adapter(adapter_depth);
    }
}

// Male Connector
module male_connector(wall) 
{
    translate([0,0,3.5])
    difference(){
        $fn=300;
        cylinder(17,10,10,true);
        cylinder(17.1,10-wall,10-wall,true);
    }
    translate([0,10,6.5])
        difference(){
            $fn=100;
            rotate([90,0,0])
            cylinder(3,2,2,true);
            translate([0,2,0.4])
            rotate([45,0,0])
            cube([5,2,6],center = true);
        }
    translate([0,-10,6.5])
        difference(){
            $fn=100;
            rotate([90,0,0])
            cylinder(3,2,2,true);
            translate([0,-2,0.4])
            rotate([-45,0,0])
            cube([5,2,6],center = true);
        }
}

// Female Connector
module female_connector(height) 
{
    difference(){
        $fn=300;
        translate([0,0,3.5])
        cylinder(17,15,15,true);
          union(){
            union(){
              $fn=300;
              translate([0,0,3.5])
              cylinder(17.1,10.3,10.3,true);
              translate([0,0,7.6])
              cube([4.2,30,9.1],center = true);
              translate([0,0,5.3])
              rotate([0,0,15])cube([4,30,4.5],center = true);
              translate([0,0,5.3])
              rotate([0,0,30])cube([4,30,4.5],center = true);
            }
            difference(){
               translate([-2.5,12.5,8])
               cube([3,6,2],center = true);
               $fn=100;
               translate([-3.9,12,9.5])
               rotate([90,0,0])
               cylinder(8,2,2,true);
            }
            difference(){
               translate([2.5,-12.5,8])
               cube([3,6,2],center = true);
               $fn=100;
               translate([3.9,-12,9.5])
               rotate([90,0,0])
               cylinder(8,2,2,true);
            }
        }
    }
    if(connector_strengthening>0 && connector_gender == "female")
    translate([0,0,3.5])
    difference(){
        $fn=300;
        cylinder(17,15+connector_strengthening,15+connector_strengthening,true);
        $fn=300;
        cylinder(17.1,15,15,true);
    }
}

// Shaft
module shaft(connector_radius, connector_wall, strengthening)
{
    translate([0,0,-5-shaft_height/2])
    difference(){
        $fn=300;
        cylinder(shaft_height,b,connector_radius+strengthening,true);
        $fn=300;
        cylinder(shaft_height+0.1,radius,connector_radius-connector_wall-0.1,true);
    }
}

// Adapter
module adapter(depth) 
{
    translate([0,0,-5 - shaft_height - depth/2])
        difference(){
            $fn=300;
            cylinder(depth,b,b,true);
            $fn=300;
            cylinder(depth+0.1,radius,radius,true);
        }
}