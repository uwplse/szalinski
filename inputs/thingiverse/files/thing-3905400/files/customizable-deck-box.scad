//print in place customizable deck box

//How many cards?
c=110;



module box(){
    cube([c+6,74,71],true);
    translate([0,86,0]) cube([c+12,80,77],true);
}

module cut(){
    cube([c,68,65],true);
    translate([0,86,0]) cube([c+7,75,72],true);
}

difference() {
    box();
    translate([0,0,7]) cut();
}