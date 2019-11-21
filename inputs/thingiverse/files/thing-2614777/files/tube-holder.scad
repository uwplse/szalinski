tube_count=4; // [1:20]
tube_dia=3.3;
tube_length=30; // [10:60]
tube_gap=1;

grip=0.98;
strength=1.5;
base=3;
screwholes = true;

/* [Hidden] */
$fn=50;

tube_width=tube_dia+2*strength;

module schelle() {
difference() {
    cylinder(d=tube_width,h=tube_length);
    cylinder(d=tube_dia,h=tube_length);
    translate([tube_dia*(grip-0.5),-tube_width/2,0]) cube([tube_width,tube_width,tube_length]);
}
}

module schraube() {
color("green")
 {
 translate([0,0,25])    
 cylinder(d=3.6,h=20);
 hull() {    
 translate([0,0,20])    
 cylinder(d=3.6,h=5);
 translate([0,0,-60])    
 cylinder(d=7,h=80);
 }
 }
}

difference() {
    union() {
     hull() {
      cube([base,tube_count*tube_width+(tube_count-1)*tube_gap,tube_length]);
    if (screwholes) {     
    translate([0,-2.5,tube_length/2]) rotate([0,90,0]) cylinder(d=9,h=base);   
    translate([0,tube_width*(tube_count+.5)+(tube_count+1)*tube_gap-2.5,tube_length/2]) rotate([0,90,0]) cylinder(d=9,h=base);
    }   
     }
    for(i=[0:tube_count-1])
      translate([tube_width/2+base-strength,tube_width/2+i*(tube_width+tube_gap),0]) schelle();
    }
    if (screwholes) {
    translate([25,-2.5,tube_length/2]) rotate([0,-90,0]) schraube();
    translate([25,tube_width*(tube_count+.5)+(tube_count+1)*tube_gap-2.5,tube_length/2]) rotate([0,-90,0]) schraube();
    }
}
 