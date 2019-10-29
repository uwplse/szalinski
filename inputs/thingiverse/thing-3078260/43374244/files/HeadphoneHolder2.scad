//How thick is your Desk (in mm)?
thickness_of_desk = 40;
//How wide should the Headphoneholder be (in mm)?
width = 40;//[10:80]
//How thick is the Headband of your Headset?
thickness_of_headset = 30;


rha = width*2; //Radius Headset Auflage

//Tischklemme+Rundung
rotate([0,0,1]){
    translate([5,0,0]){
    cube([35,5,width]);
        translate([35,5,0]){
            intersection(){
                cylinder(width,5,5,$fn=50);
                translate([0,-5,0]){
                    cube([5,5,width]);
                }
            }
        }
    }
}

//Rundung Ecke Tischklemme/thickness_of_desknabstand
translate([5,5,0]){
    intersection(){
        cylinder(width,5,5,$fn=50);
        translate([-5,-5,0]){
            cube([5,5,width]);
        }
    }
}

//thickness_of_desknabstand
translate([0,5,0]){
    cube([5,thickness_of_desk,width]);
}

//Rundung Ecke thickness_of_desknabstand/langes Ding
translate([5,thickness_of_desk+5,0]){
    intersection(){
        cylinder(width,5,5,$fn=50);
        translate([-5,0,0]){
            cube([5,5,width]);
        }
    }
}

//Langes Ding
translate([5,5+thickness_of_desk,0]){
    cube([75,5,width]);
}

//Rundung langes Ding/Headsetabstand
translate([80,15+thickness_of_desk,0]){
    intersection(){
        cylinder(width,10,10,$fn=50);
        translate([0,-10,0]){
            cube([10,10,width]);
        }
    }
}

//Headset abstand
translate([80,15+thickness_of_desk,0]){
    cube([10,thickness_of_headset-5,width]);
}

//Rundung Headsetabstand/auflage
translate([80,thickness_of_headset+10+thickness_of_desk,0]){
    intersection(){
        cylinder(width,10,10,$fn=50);
        translate([0,0,0]){
            cube([10,10,width]);
        }
    }
}

//Headset Auflage 4,5DEG
translate([80,thickness_of_headset+20+thickness_of_desk,0]){
    intersection(){
        translate([0,rha-4.7,width/2]){
            rotate([0,-90,5]){
                cylinder(100,rha,rha,$fn=rha*2);
            }
        }
        rotate([0,0,185]){
            cube([80,5,width]);
        }
    }
}