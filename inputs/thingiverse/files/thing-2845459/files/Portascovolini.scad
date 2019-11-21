
difference() {
    cube([50,20,5]);
    translate([12, 12.5, 0]) cylinder(h=6, r1=3.1, r2=3.7, $fn=50);
    translate([38, 12.5, 0]) cylinder(h=6, r1=3.1, r2=3.7, $fn=50);
    bordino (2.5,17.5,0, $fn=50) ;
    bordino (-17.5,47.5,270, $fn=50);
}
    
cube([50,2, 20]);
translate ([50,06.5,9.5]) rotate([0,180,90]) paretina (5,50, 0.5);





//MODULI
    
module paretina (lato, lunghezza, offset) {
    difference () {
        cube([lato,lunghezza,lato]);
        rotate ([-90,0,0]) translate ([-offset,offset,0]) cylinder (h = lunghezza+2, r=lato, $fn=100);
    }
}   

module bordino (xoff, yoff, zrot) {
    rotate ([0,0, zrot]) translate ([xoff,yoff,0]) difference() {
        translate([-5,0,0]) cube([5,5,6]);
        cylinder(h=6, r=2.5);
    }
}