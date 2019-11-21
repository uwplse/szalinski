// thickness of the material around the pencil in mm
material_thickness = 1;
// extended length in mm
Handle_length = 50;
// defines how deep the pencil is going into the extender in mm
shaft_deepness = 30;
// Diameter of the pencil in mm
Pencil_diameter = 5;
union(){
  difference() {
    cylinder(r1=(Pencil_diameter + material_thickness), r2=(Pencil_diameter + material_thickness), h=(Handle_length + shaft_deepness), center=false);

    cylinder(r1=Pencil_diameter, r2=Pencil_diameter, h=shaft_deepness, center=false);
  }
  translate([0, 0, (Handle_length + shaft_deepness)]){
    sphere(r=(Pencil_diameter + material_thickness));
  }
}