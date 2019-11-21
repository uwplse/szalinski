//The ranges of most values below aren't hard limits; values outside of them will likely mess up the instrument.

//bongos() makes bongos
//castanets() makes a pair of castanets
//clave(length) makes a stick with a recommended length value of 20-30
//jam_block(size,ridges) makes a jam block for a drum kit
//*size: range 0-4 and affects the hole in the block and therefore pitch.
//*ridges: 0 or 1. If 1, there are ridges on the striking edge
//drumstick() makes a drumstick
//mallet() makes a xylophone mallet that can be used with these instruments
//tube_block(pitch,ridges,heads,pitch2,ridges2) makes a tube wood block
//*pitch: range 0-9; higher number yields a higher pitch
//*ridges: range 0-2:
//**0 - no ridges
//**1 - ridges along the tube's length
//**2 - 3 ridges at the tube's center
//*heads: range 0-1; makes a double-sided wood block - each side is equally customizable
//*pitch2, ridges2 operate the same as pitch and ridges on the first head
//tulips(count) makes an instrument I might have made up
//*count: range 1-25 (effective range 2-16); determines number of tulip objects

jam_block(0,0);
//jam_block(0,1);

module bongos() {   //membrane 0.8mm thick
    difference() {
        union() {
            //drums
            translate([0,0,3]) cylinder(120,71,76,$fn=195);
            translate([185,0,0.1]) cylinder(122.9,81,89,$fn=200);
            
            //joint
            translate([65,-10,32]) cube([50,20,55]);
            
            //rims
            translate([0,0,103]) cylinder(15,77,77,$fn=195);
            translate([185,0,103]) cylinder(15,90,90,$fn=200);
            hull() {
                cylinder(12,72,72,$fn=200);
                translate([43,43,0]) cylinder(5,16,16,$fn=100);
                translate([-43,43,0]) cylinder(5,16,16,$fn=100);
                translate([43,-43,0]) cylinder(5,16,16,$fn=100);
                translate([-43,-43,0]) cylinder(5,16,16,$fn=100);
            }
            hull() {
                translate([185,0,0]) cylinder(12,82,82,$fn=200);
                translate([228,56,0]) cylinder(5,16,16,$fn=100);
                translate([142,56,0]) cylinder(5,16,16,$fn=100);
                translate([228,-56,0]) cylinder(5,16,16,$fn=100);
                translate([142,-56,0]) cylinder(5,16,16,$fn=100);
            }
        }
        translate([0,0,-0.1]) cylinder(119.3,64,69,$fn=195);
        translate([185,0,-0.1]) cylinder(122.3,73,82,$fn=200);
    }
}

module castanet() {
    difference() {
        union() {
            hull() {
                translate([-10,30,0]) cylinder(6,5,5,$fn=70);
                translate([10,30,0]) cylinder(6,5,5,$fn=70);
                translate([0,0,-5]) sphere(10,$fn=100);
            };
            translate([0,0,-17]) sphere(30,$fn=200); 
        };          
        translate([0,0,-35]) sphere(40);
        translate([0,0,-50]) cylinder(50,60,60);
        translate([4,29,-.5]) cylinder(7,1.5,1.5,$fn=50);
        translate([-4,29,-.5]) cylinder(7,1.5,1.5,$fn=50);
        translate([0,70.5,-.5]) cylinder(10,36.5,36.5,$fn=200);
        translate([0,41,-.5]) cylinder(10,8,8,$fn=100);
    }
}

module clave(length) {
    cylinder(length*10,15,15,$fn=100);
}

module castanets() {
    castanet();
    translate([41,30,0]) rotate([0,0,180]) castanet();

}

module drumstick() {
    translate ([0,0,3.875]) cylinder(343.025,6.85,6.85,$fn=100);
    
    difference() {
        translate([0,0,8]) sphere(8,$fn=100);
        translate([0,0,12.375]) cube(17,true);
    }
    translate([0,0,355]) cylinder(55,6.7,2,$fn=100);
    translate([0,0,346.9]) cylinder(8.1,6.85,6.7,$fn=100);
    hull() {
        translate([0,0,410]) sphere(3.1,$fn=50);
        translate([0,0,411.25]) sphere(3.15,$fn=50);
        translate([0,0,412.55]) sphere(3.05,$fn=50);
    }
}

module jam_block(size,ridges) {//0 default, 1 ridges
    //size value of 4 is the highest reasonable size. Anything above 5 is impossible
    difference() {
        union() {
            hull() {
                translate([0,0,3]) cube([55,140,10]);
                translate([-15,20,3]) cube([15,100,10]);
                translate([5,20,-5]) cube([70,100,25]);
            };
            hull() {
                translate([72,22,21]) rotate([-90,0,0]) cylinder(96,3,3,$fn=100);
                translate([58,20,20]) cube([17,100,0.1]);
            }
        };
        translate([10,21,3-size/2]) hole(size);
        
        translate([20,0,13]) cube([20,19.5,10]);
        translate([20,0,-7]) cube([20,19.5,10]);
        translate([20,120.5,13]) cube([20,19.5,10]);
        translate([20,120.5,-7]) cube([20,19.5,10]);
        translate([-15,60.5,13]) cube(19.5,20,10);
        translate([-15,60.5,-7]) cube([19.5,20,10]);
        
        translate([30,10,0]) cylinder(20,3,3,$fn=50);
        translate([30,130,0]) cylinder(20,3,3,$fn=50);
        translate([-5,70.5,0]) cylinder(20,3,3,$fn=50);
        translate([22,17,2]) dents();
        translate([22,123,2]) dents();
        translate([0,78.5,2]) rotate([0,0,-90]) dents();
        
        if (ridges) {
            for (i=[0:22]) {
                translate([65,26+i*4,24.2]) rotate([0,90,0]) cylinder(10,1.5,1.5,$fn=50);
            }
        }
    };
}

module mallet() {
    cylinder(335,3,3,$fn=50);
    translate([0,0,349.25]) sphere(r=15.875,$fn=100);
}

module tube_block(pitch,ridges,heads,pitch2,ridges2) {
    if (heads==1) {
        tube(pitch,ridges);
        translate([0,0,-55]) cylinder(34,12,12,$fn=100);
        translate([55,0,-38]) rotate([0,-90,0]) cylinder(55,12,12,$fn=100);
        translate([140,0,-38]) rotate([0,-90,0]) handle();
        translate([0,0,-76]) rotate([0,180,0]) tube(pitch2,ridges2);
    }
    if (!heads) {
        tube(pitch,ridges);
        translate([0,0,-100]) handle();       
    }
}

module tulips(count) {
    for (i = [0:count-1]) {
        translate ([0,50*i-(i*i),0]) {
            translate([0,0,-i*19/25-0.5]) tulip(25-i);
        }
    }
    hull() {
        translate([0,0,-24]) cylinder(5,25,25,$fn=100);
        translate([0,(52*count)-(count*count)-51,-24]) cylinder(5,25-(count/2),25-(count/2),$fn=100);
    }
}

module handle() {
    translate([0,0,0]) cylinder(85,12,12,$fn=100);
    translate([0,0,-5]) cylinder(12,13,12.5,$fn=100);
    difference() {
        translate([0,0,0.2]) sphere(14,$fn=100);
        translate([0,0,-5]) cylinder(12,15,15);
    };
}

module tube(pitch,ridges) {
    difference() {
        union() {
            difference() {
                cylinder(100,21,21,$fn=100);
                translate([0,0,-1]) cylinder(102,18,18,$fn=100); 
                minkowski() {
                    translate([-25.5,-0.5,pitch*10+1]) cube([51,1,101]);
                    sphere(0.5);
                }
            };
            difference() {
                sphere(r=21,$fn=100);
                translate([-21,-21,0]) cube(42);
                translate([0,0,26.1]) sphere(32,$fn=100);
            };
            translate([0,0,-21]) cylinder(5,12,13,$fn=100);
        };
        if (ridges==1) {
            for (i = [0:13]) {
                translate([0,0,7*i+4]) band();
            }
        };
        if (ridges==2) {
            for (i = [0:2]) {
                translate([0,0,7*i+35]) band();
            }
        };
    }
}

module band() {
    difference() {
        cylinder(2.5,21.1,21.1,$fn=100);
        cylinder(2.5,20,20,$fn=100);
    };
}

module tulip(radius) {
    union() {
        difference() {
            sphere(radius,$fn=100);
            sphere(radius*4/5,$fn=100);
            translate([0,0,-radius*2/5]) {
                cylinder(radius,radius*3/5,radius*3/5);
            };
            translate([0,0,radius*3/5-1]) {
                cylinder(radius*2/5+1,radius,radius);
            };
            translate([0,0,-radius]) {
                cylinder(radius*8/25,radius,radius);
            };
        };
        translate([0,0,-radius*19/25]) {
            cylinder(radius*2/25,radius*18/25,radius*18/25,$fn=100);
        };
    }
}

module hole(size) {
    minkowski() {
        cube([75,98,9+2*size]);
            sphere($fn=40,r=0.5);
    }
}

module dents() {
    difference() {
        union() {
            cylinder(12,1.5,1.5,$fn=50);
            translate([16,0,0]) cylinder(12,1.5,1.5,$fn=50);
        };
        translate([-2,-2,2]) cube([20,4,8]);
    }
}
