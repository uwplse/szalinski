vitiPerLato = 5;      // screws per side
lunghezzaVite = 20;   // screw initial length
lunghezzaFinale = 8;  // screw final length
diametroVite = 5;     // screw diameter
diametroDado = 8.8;   // nut diameter
altezzaDado= 5;       // nut height
spessoreSupporto = 3; // thickness

difference() {
  union() {
    // Centro
    translate([0,-(spessoreSupporto +1.5),0]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto,spessoreSupporto+diametroDado+4]);
    translate([0,1.5,0]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto,spessoreSupporto+diametroDado+4]);
    translate([0,-(spessoreSupporto +1.5),diametroDado+4]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto+1,spessoreSupporto]);
    translate([0,0.5,diametroDado+4]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto+1,spessoreSupporto]);
    
    // Laterali e base
    translate([0,-lunghezzaFinale,0]) cube([vitiPerLato*(diametroDado+2+diametroVite),(lunghezzaFinale)*2,spessoreSupporto]);
    translate([0,-lunghezzaFinale,0]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto,spessoreSupporto+diametroDado+4]);
    translate([0,lunghezzaFinale-spessoreSupporto,0]) cube([vitiPerLato*(diametroDado+2+diametroVite),spessoreSupporto,spessoreSupporto+diametroDado+4]);
  }
  for(i=[0:(vitiPerLato-1)]) {
    translate([spessoreSupporto+diametroVite/2+(i*(diametroDado+1+diametroVite)),lunghezzaFinale-lunghezzaVite+0.1,spessoreSupporto+diametroDado/2+2]) rotate([0,90,90]) #cylinder(r=diametroVite/2,h=lunghezzaVite,$fn=60);
    translate([spessoreSupporto+diametroVite/0.5+(i*(diametroDado+1+diametroVite)),-lunghezzaFinale-0.1,spessoreSupporto+diametroDado/2+2]) rotate([0,90,90]) #cylinder(r=diametroVite/2,h=lunghezzaVite,$fn=60);
    if((lunghezzaFinale-spessoreSupporto*2-1.5)>altezzaDado) {
      translate([spessoreSupporto+diametroVite/2+(i*(diametroDado+1+diametroVite)),2,spessoreSupporto+diametroDado/2+2]) rotate([0,90,90]) #cylinder(r=diametroDado/2,h=altezzaDado,$fn=6);
      translate([spessoreSupporto+diametroVite/0.5+(i*(diametroDado+1+diametroVite)),-(2+altezzaDado),spessoreSupporto+diametroDado/2+2]) rotate([0,90,90]) #cylinder(r=diametroDado/2,h=altezzaDado,$fn=6);
    }
  }
}
