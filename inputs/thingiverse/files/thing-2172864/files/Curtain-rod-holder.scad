
$fn = 16;

// in mn

base_diameter = 40;
cylinder_diameter = base_diameter/4;
cylinger_height = 20;
pole_diamter = 20;
screw_Size = 3;
screw_head_size = 5;

module screw_holes()
{
  union(){
    translate([base_diameter*0.25,0,0]) cylinder(h=base_diameter,r=screw_Size/2,center=true);
    translate([base_diameter*-0.25,0,0]) cylinder(h=base_diameter,r=screw_Size/2,center=true);            
    translate([base_diameter*0.25,0,(base_diameter/2)+(base_diameter*.125)]) cylinder(h=base_diameter,r=screw_head_size/2,center=true);
    translate([base_diameter*-0.25,0,(base_diameter/2)+(base_diameter*.125)]) cylinder(h=base_diameter,r=screw_head_size/2,center=true);            
  }
}

module pole()
{

  difference() {
    translate([0,0,-base_diameter/4]) sphere(d=base_diameter, center=true);
    translate([0,0,-base_diameter/2]) cube([base_diameter+1,base_diameter+1,base_diameter], center=true);    
  }

  difference(){
    union() {      
      cylinder(h=cylinger_height+(pole_diamter/2),r1=cylinder_diameter/2,r2=cylinder_diameter/2,center=false);
      translate([0,0,cylinger_height+(pole_diamter/2)]) rotate([0,90,0]) cylinder(h=base_diameter*0.3,r=(pole_diamter/2)+3,center=true);
    }
    translate([0,0,cylinger_height+(pole_diamter/2)]) rotate([0,90,0]) cylinder(h=base_diameter,r=(pole_diamter/2),center=true);  
  }
}

difference()
{
  pole();
  screw_holes();
}




