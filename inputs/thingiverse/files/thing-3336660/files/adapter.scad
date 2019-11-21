/* [General] */
//Fan Size (Only 40mm and 60mm Supported)
fan_size=40;//[40,60] 
//Wall Thickness (.5mm print nozzle)
wall_thickness=1;//[.5,1,1.5] 
//Resolution (facets per circular/sperical primitive)
resolution=36;//[36:540] 

/* [Flange] */
//Flange Height in mm (z axis)
flange_height=2; 
//Screw hole diameter in mm
screw_hole_diameter=3.5;// [3:5] 

/* [Conical Section] */
//Conical section height in mm (from top of flange (z axis))
conical_section_height=25; 

/* [Tube Slip Connector] */
//Exhaust Tube Slip Connector Height in mm (from top of conical section (z axis))
tube_connection_height=12; 
//Slip connector exterior diameter in mm
tube_connection_ext_diameter=25.4; 

/* [Hidden] */
$fn=resolution;

if (fan_size==40){
    
flange_info =   [
                38.3,//inner hole
                16//screwhole spacing
                ];

adapter(flange_info,
        fan_size,
        flange_height,
        screw_hole_diameter,
        conical_section_height,
        tube_connection_height,
        tube_connection_ext_diameter);    
}
else{
    flange_info =   [
                57.8,//inner hole
                25//screwhole spacing
                ];

adapter(flange_info,
        fan_size,
        flange_height,
        screw_hole_diameter,
        conical_section_height,
        tube_connection_height,
        tube_connection_ext_diameter);    
}

    
module adapter  (  
                flange_info,
                fan_size,
                flange_height,
                screw_hole_diameter,
                conical_section_height,
                tube_connection_height,
                tube_connection_ext_diameter){
  difference(){
    translate ([-fan_size/2,-fan_size/2,0])
      cube([fan_size,fan_size,flange_height]);
    translate([0,0,-.1])cylinder(h=flange_height+.2,d=flange_info[0]);
    translate([flange_info[1],flange_info[1],-.1])
      cylinder(h=flange_height+.2,d=screw_hole_diameter);
    translate([-flange_info[1],flange_info[1],-.1])
      cylinder(h=flange_height+.2,d=screw_hole_diameter);
    translate([flange_info[1],-flange_info[1],-.1])
      cylinder(h=flange_height+.2,d=screw_hole_diameter);
    translate([-flange_info[1],-flange_info[1],-.1])
      cylinder(h=flange_height+.2,d=screw_hole_diameter);
  }
 
  difference(){
    translate([0,0,flange_height])
      cylinder( h=conical_section_height+.01,
                d1=flange_info[0]+1,
                d2=tube_connection_ext_diameter);
    translate([0,0,flange_height-.2])
      cylinder( h=conical_section_height+.3,
                d1=flange_info[0],
                d2=tube_connection_ext_diameter-wall_thickness);
 }
 
 difference(){
   translate([0,0,flange_height+conical_section_height-.1])
     cylinder(h=tube_connection_height+.1,d=tube_connection_ext_diameter);
   translate([0,0,flange_height+conical_section_height-.2])
     cylinder(  h=tube_connection_height+.3,
                d=tube_connection_ext_diameter-wall_thickness);     
 }  
}
