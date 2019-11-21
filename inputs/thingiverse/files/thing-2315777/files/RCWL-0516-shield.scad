view_inner_sides = true;
view_outer_sides = true;

view_PCB_holes = true;
view_wire_holes = true;
view_fixtures = true;

$fn = 100;

base_walls = 2;
base_depth=17.5+2*base_walls+2;
base_width=36+2*base_walls+2;

// Sensor holes
sensor_hole_width=33;
sensor_hole_depth=14.5;
sensor_pillar_diameter=6;
sensor_pillarhole_diameter=2;
sensor_pillar_heigth=8;

side_heigth=30;
front_angle=120;
back_angle=90;
left_angle=135;
right_angle=135;

//fixtures
fixture_length = 15;
fixture_width = 10;
fixture_hole_diameter = 4;

main();

module main() {
	
    
    if(view_inner_sides){
    radar_inner_sides();}
    
    if(view_outer_sides){
    radar_outer_sides();}
    
    
    
   }
   
//Radar Base
module radar_PCB_holes() {
    
translate([base_width/2, base_depth/2,base_walls-1])
    difference() {
group() {
        translate([sensor_hole_width/2, sensor_hole_depth/2, 0])
    cylinder(h=sensor_pillar_heigth, d=sensor_pillar_diameter);
        translate([-sensor_hole_width/2, sensor_hole_depth/2, 0])
    cylinder(h=sensor_pillar_heigth, d=sensor_pillar_diameter);
        translate([sensor_hole_width/2, -sensor_hole_depth/2,0])
    cylinder(h=sensor_pillar_heigth, d=sensor_pillar_diameter);
        translate([-sensor_hole_width/2, -sensor_hole_depth/2,0])
    cylinder(h=sensor_pillar_heigth, d=sensor_pillar_diameter);
         
    }
    group() {
        translate([sensor_hole_width/2, sensor_hole_depth/2, 0])
    cylinder(h=sensor_pillar_heigth+1, d=sensor_pillarhole_diameter);
        translate([-sensor_hole_width/2, sensor_hole_depth/2, 0])
    cylinder(h=sensor_pillar_heigth+1, d=sensor_pillarhole_diameter);
        translate([sensor_hole_width/2, -sensor_hole_depth/2,0])
    cylinder(h=sensor_pillar_heigth+1, d=sensor_pillarhole_diameter);
        translate([-sensor_hole_width/2, -sensor_hole_depth/2,0])
    cylinder(h=sensor_pillar_heigth+1, d=sensor_pillarhole_diameter);
         
    }
}
     
}  

module radar_inner_sides() {
    if(view_PCB_holes){
    radar_PCB_holes();}
 
    difference(){ 
    CustomPolyhedron(0,side_heigth);
    CustomPolyhedron(-base_walls,side_heigth+1);
    if(view_wire_holes){
        translate([base_width/2, base_depth/2-5, side_heigth-5])
        rotate([0,90,0])
        cylinder(h=100, d=3);
        }
}
}

module radar_outer_sides() {
 
    difference(){ 
    CustomPolyhedron(base_walls*2,side_heigth);
    CustomPolyhedron(base_walls,side_heigth+1);
    if(view_wire_holes){
        translate([base_width/2, base_depth/2-5, side_heigth-5])
        rotate([0,90,0])
        cylinder(h=100, d=3);
        }
    
        
    }
    if(view_fixtures){  
      translate( [base_width+base_walls+side_heigth/tan(180-left_angle),base_depth/2-fixture_width/2,side_heigth-base_walls] )
  difference(){        
        cube([fixture_length,fixture_width,base_walls]);
      translate( [fixture_length-base_walls-fixture_hole_diameter/2,fixture_width/2,-base_walls] )
        cylinder(h=100, d=fixture_hole_diameter);    
      
  }
  
   translate( [side_heigth/tan(right_angle)-base_walls-fixture_length,base_depth/2-fixture_width/2,side_heigth-base_walls] )
  difference(){        
        cube([fixture_length,fixture_width,base_walls]);
      translate( [base_walls+fixture_hole_diameter/2,fixture_width/2,-base_walls] )
        cylinder(h=100, d=fixture_hole_diameter);    
      
  }
}
}



module CustomPolyhedron(spacing,heigth)
{
PolyhedronPoints = [
  [ base_width+spacing,  -spacing,  -spacing ],   //0
  [  -spacing,  -spacing,  -spacing ],           //1
    [  -spacing,  base_depth+spacing,  -spacing ],           //2
  [  base_width+spacing,  base_depth+spacing,  -spacing  ],           //3
  
  [ base_width+spacing+heigth/tan(180-left_angle),  heigth/tan(back_angle)-spacing,  heigth],           //4
  [  heigth/tan(right_angle)-spacing,  heigth/tan(back_angle)-spacing,  heigth], //5

  [ heigth/tan(right_angle)-spacing,  base_depth+heigth/tan(180-front_angle)+spacing, heigth ],           //6
  
  [  base_width+spacing+heigth/tan(180-left_angle),  base_depth+spacing+heigth/tan(180-front_angle),   heigth ]]; //7   

    PolyhedronFaces = [
  [3,2,1,0],[0,1,5,4], [1,2,6,5], [2,3,7,6], [3,0,4,7], [4,5,6,7]];
    
    polyhedron( PolyhedronPoints, PolyhedronFaces );
    }
    
