//!OpenSCAD




Nombre_de_faces = 4;
Taille = 5;
Qualite = 10;
Nombre_de_tours = 2;
// chain hull
for (i = [0 : abs(Qualite) : 360 - Qualite]) {
  hull() {
  rotate([0, i, 0]){
    translate([Taille, 0, 0]){
      rotate([0, 0, ((i * Nombre_de_tours) / Nombre_de_faces)]){
        // torus
        rotate_extrude($fn=Nombre_de_faces) {
          translate([1, 0, 0]) {
            circle(r=1, $fn=4);
          }
        }
      }
    }
  }
  rotate([0, (i + Qualite), 0]){
    translate([Taille, 0, 0]){
      rotate([0, 0, (((i + Qualite) * Nombre_de_tours) / Nombre_de_faces)]){
        // torus
        rotate_extrude($fn=Nombre_de_faces) {
          translate([1, 0, 0]) {
            circle(r=1, $fn=4);
          }
        }
      }
    }
  }
  }
}