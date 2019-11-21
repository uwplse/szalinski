$fn=100;

raise=90;
center_hole=43;
upper_wall=20;

piede(51,raise,center_hole,2,upper_wall);

module piede(larghezza,altezza,diametro,spessore,rialzo){
    difference(){
        union(){
            difference(){
                translate([0,0,altezza/2]) cube([larghezza,larghezza,altezza], center=true);
                translate([0,0,altezza/2-1]) cylinder(r=diametro/2,h=altezza+3, center=true);
            }
            translate([(larghezza+spessore)/2,spessore/2,(altezza+rialzo)/2]) cube([spessore,larghezza+spessore,altezza+rialzo], center=true);
            translate([spessore/2,(larghezza+spessore)/2,(altezza+rialzo)/2]) cube([larghezza+spessore,spessore,altezza+rialzo], center=true);
            for(i=[0:1]) rotate([0,0,i*90]) translate([larghezza/2+spessore,-i*spessore,0]) placca(larghezza,spessore, diametro);
        }
    for(i=[0:1]) rotate([0,0,i*90]) translate([larghezza/2+spessore+1.25,0,altezza+rialzo/2]) rotate([0,90,0]) svaso(spessore);
    cylinder(r=diametro/2,h=3*spessore, center=true);
    }
}

module svaso(spessore){
    union(){
        translate([0,0,-spessore-1]) cylinder(r=4.2/2,h=spessore-3.8+1);
        translate([0,0,-3.8]) cylinder(r1=4.2/2,r2=8.2/2,h=3.8);
    }
}

module placca(larghezza,spessore, diametro){
    difference(){
        hull(){
            translate([-spessore/2,spessore/2,spessore/2]) cube([spessore,larghezza+spessore,spessore], center=true);
            translate([1,spessore/2,spessore/2]) cylinder(r=32/2,h=spessore, center=true);
        }
        translate([10,spessore/2,spessore+1.25]) svaso(spessore);
    }
}