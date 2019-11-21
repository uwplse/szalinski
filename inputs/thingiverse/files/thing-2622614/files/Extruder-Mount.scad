//Extruder Mount for TronxyX5S (or anything else using 2020 Extrusion)
//Probably best printed in Petg or similar
use <BOSL/nema_steppers.scad>;
$fs = 0.05;
final_angle = 45;
over_extrusion = 30;
clearance = 40; //spacing of centerpoint of motor from extrusion, a nema17 is 42mm
length = 60; //length of mount
case_thickness = 5;//thickness of 2020 mount
bracket_thickness = 2.5; //thickness of motormount
reinforcement = 5; //print a 3mm ridge this wide around the motor mount
printer_slop =0.1;
difference(){
    union(){
    translate([-case_thickness,0,0]){rotate([0,90,0])cube([20,length,case_thickness]);
    cube([20+case_thickness,length,case_thickness]);}
    //position the extruder mount
    hull(){
      translate([-clearance,(bracket_thickness+3)/2,over_extrusion])rotate([0,final_angle,0])cube([42+reinforcement,bracket_thickness+3,42+reinforcement],center=true);
      translate([-case_thickness,0,0]){rotate([0,90,0])cube([20,bracket_thickness,case_thickness]);
      //cube([20+case_thickness,bracket_thickness,case_thickness]);
      }
      //cube([10,length/2,30]);
      translate([-clearance,0,0])rotate([0,90,0])#cube([20,length/3,clearance]);
    }
  }
  translate([0,-10,-20])cube([20,length*2,20]);
  translate([-clearance,bracket_thickness/2,over_extrusion])rotate([0,final_angle,0]){
    union(){
      translate([0,length/2,0])cube([43,length,43],center=true);
      rotate([90,0,0])#nema17_mount_holes(depth=bracket_thickness*2, l=0, slop=printer_slop);
    }
  }
  translate([10,length/4,-case_thickness/2])#cylinder(r=2.5+printer_slop,h=case_thickness*2);
  translate([10,3*length/4,-case_thickness/2])#cylinder(r=2.5+printer_slop,h=case_thickness*2);
  rotate([0,90,0]){translate([10,3*length/4,-case_thickness-0.1])#cylinder(r=2.5+printer_slop,h=case_thickness*2);
  }
}
