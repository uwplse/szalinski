// larghezza totale 56
// diametro 24
// spessore 11
l = 56;
dia = 24;
sp = 11;

difference(){

union(){    
    cube([l-dia,dia,sp],true);
    translate([-(l-dia)/2,0,0])cylinder(sp,dia/2,dia/2,true);
    translate([(l-dia)/2,0,0])cylinder(sp,dia/2,dia/2,true);
       }

// fessura centrale
union(){
    // rettangolo superiore
    translate([l/2-(l-13)/2,0,-sp/2+3])cube([(l-13)/2,dia/2,sp-3-3]);
    mirror([1,0,0])translate([l/2-(l-13)/2,0,-sp/2+3])cube([(l-13)/2,dia/2,sp-3-3]);
    // cilindri alloggio
    translate([(l-dia)/2,0,0])cylinder(sp-3-3,(dia-5.5)/2,(dia-5.5)/2,true);
    mirror([1,0,0])translate([(l-dia)/2,0,0])cylinder(sp-3-3,(dia-5.5)/2,(dia-5.5)/2,true);     
       }

//fori per viti legno
union(){
    // foro vite
    translate([(l-dia)/2,0,-sp/2])cylinder(4,3,3,false);
    mirror([1,0,0])translate([(l-dia)/2,0,-sp/2])cylinder(4,3,3,false);   
    // svaso
    translate([(l-dia)/2,0,-sp/2])cylinder(4,0,6,false);  
    mirror([1,0,0])translate([(l-dia)/2,0,-sp/2])cylinder(4,0,6,false);    
    }

// fori faccia superiore    
union(){
    // quadrato d'angolo
    translate([(l-dia)/2,0,0])cube(dia/2);
    mirror([1,0,0])translate([(l-dia)/2,0,0])cube(dia/2);
    // cilindro
    translate([(l-dia)/2,0,0])cylinder(sp/2,11/2,11/2);
    mirror([1,0,0])translate([(l-dia)/2,0,0])cylinder(sp/2,11/2,11/2);
    // cubo inclinato per raccordo
    translate([(l-dia)/2,0,sp/2])rotate([0,0,-45])translate([0,11/2,0])cube(11,true);
    mirror([1,0,0])translate([(l-dia)/2,0,sp/2])rotate([0,0,-45])translate([0,11/2,0])cube(11,true);   
    }
 }