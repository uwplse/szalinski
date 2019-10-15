ancho=13;
alto=19;
largo=37;
e=1;
oreja=10;
orificio=10;
difference(){

cube([ancho+e,largo+e,alto], center=true);
translate([0,0,e])cube([ancho,largo,alto+e],center=true);
};
difference(){
union(){
translate([0,largo/2+oreja/2,-alto/2+e/2])cube([ancho+e,oreja,e],center=true);
translate([0,largo/2+oreja,-alto/2+e/2])cylinder(h=e,d=ancho+e,center=true);}
    
translate([0,largo/2+oreja,-alto/2+e/2])cylinder(h=2*e,d=orificio,center=true);};
difference(){
union(){
translate([0,-largo/2-oreja/2,-alto/2+e/2])cube([ancho+e,oreja,e],center=true);
translate([0,-largo/2-oreja,-alto/2+e/2])cylinder(h=e,d=ancho+e,center=true);}
translate([0,-largo/2-oreja,-alto/2+e/2])cylinder(h=2*e,d=orificio,center=true);}