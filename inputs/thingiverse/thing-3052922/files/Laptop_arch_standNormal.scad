//!OpenSCAD

Arch_inner_radius = 50;
Arch_thickness = 5;
Laptop_thickness = 20;


difference() {
  {
    $fn=90;    //set sides to 90
    difference() {
      scale([1, 1.1, 1]){
        difference() {
          cylinder(r1=(Arch_inner_radius + Arch_thickness * 2), r2=(Arch_inner_radius + Arch_thickness * 2), h=1000, center=true);

          cylinder(r1=Arch_inner_radius, r2=Arch_inner_radius, h=10000, center=true);
        }
      }

      translate([0, 0, 500]){
        cube([1000, 1000, 1000], center=true);
      }
      translate([0, ((Arch_inner_radius + Arch_thickness * 2) * 1.2), ((Arch_inner_radius + Arch_thickness * 2) * 1.2)]){
        rotate([0, 90, 0]){
          cylinder(r1=((Arch_inner_radius + Arch_thickness * 2) * 3), r2=((Arch_inner_radius + Arch_thickness * 2) * 3), h=1000, center=true);
        }
      }
      translate([0, -500, 0]){
        cube([1000, 1000, 1000], center=true);
      }
      translate([0, ((Arch_inner_radius + Arch_thickness * 2) * 1.2), ((((Arch_inner_radius + Arch_thickness * 2) * -1.2 - (Arch_inner_radius + Arch_thickness * 2) * 3) - (Arch_inner_radius + Arch_thickness * 2) * 1) - Laptop_thickness)]){
        rotate([0, 90, 0]){
          cylinder(r1=((Arch_inner_radius + Arch_thickness * 2) * 3), r2=((Arch_inner_radius + Arch_thickness * 2) * 3), h=1000, center=true);
        }
      }
      translate([0, 0, -900]){
        cube([1000, 1000, 1000], center=true);
      }
    }
  }

  translate([0, 510, ((((((Arch_inner_radius + Arch_thickness * 2) * -1.2 - (Arch_inner_radius + Arch_thickness * 2) * 3) - (Arch_inner_radius + Arch_thickness * 2) * 1) - Laptop_thickness) + (Arch_inner_radius + Arch_thickness * 2) * 1.2) / 2)]){
    cube([1000, 1000, Laptop_thickness], center=true);
  }
}