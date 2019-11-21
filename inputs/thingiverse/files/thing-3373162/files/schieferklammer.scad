hoehe=40;
breite=50;
auflage=10;

overlap=3;
luecke=4;

staerke=2;

federbreite=10;
federstaerke=1;

hohl=hoehe-2*staerke-luecke-federstaerke;

federanzahl=round(hohl/federbreite);
exaktfederbreite=hohl/federanzahl+federstaerke;

module add() {
    cube([breite,hoehe,auflage+overlap]);
    
}

module sub() {
    translate([0,staerke,auflage]) cube([breite,hoehe-2*staerke,overlap]);
    translate([staerke,staerke,staerke]) cube([breite-2*staerke,hoehe-2*staerke-luecke,auflage]);
    translate([10,0,staerke]) cube([6,staerke,6]);
    translate([breite-10-6,0,staerke]) cube([6,staerke,6]);

}

difference() {
    add();
    sub();
}

translate([0,hoehe+5,0]) {
    for(i=[0:federanzahl-1]) translate([breite/2,(exaktfederbreite-federstaerke)*i+staerke+exaktfederbreite/2,0]) difference() { 
    resize([0,exaktfederbreite,0]) cylinder(d=breite-3*staerke,h=auflage+overlap+5);
    resize([0,exaktfederbreite-2*federstaerke,0]) cylinder(d=breite-3*staerke-2*federstaerke,h=auflage+overlap+5);
}
        
    translate([10,staerke,0]) cube([breite-20,federstaerke,auflage+overlap-staerke]);
    translate([10+.2,0,0]) cube([6-.4,staerke,6-.4]);
    translate([breite-10-6+.2,0,0]) cube([6-.4,staerke,6-.4]);

}