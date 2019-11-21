// Carlos Martín (Guarnio) 
// 12 Octubre 2019
// Creacion logo + Nomrbre IV KDD Granada 3D

nombre="Guarnio";
separacion_arroba=55;
separacion_nombre=72;
font_size=15;
longitud_raya=135;

color("#0088cc"){
    translate([0, 0, 5]) {
        linear_extrude(height=10,center=true){
            import(file="./dibujo.svg",layer="Capa1"); 
        }
    }
    
    translate([separacion_arroba, 4, 5]) {
        linear_extrude(height=10,center=true){
        text("@", font = "Liberation Sans:style=Bold Italic",size=font_size);
        }
    }
    
    translate([separacion_nombre, 2, 5]) {
        linear_extrude(height=10,center=true){
        text(nombre, font = "Liberation Sans:style=Bold Italic",size=font_size);
        }
    }

    translate([15, 1,0]){
        cube([longitud_raya,2,5]);
    }
}

