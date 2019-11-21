
rou = 7;
rin = 4;
height = 40-8;
depth = 15.5;

bras_thick = 5.5;
bras_length = 17;
bras_height = 12;
buttonr = 6;
alpha = atan(5/13);
//omega = atan(30/13);
omega = atan(27/13);

knob();


module knob(){
    difference(){
        union(){
            frame();
            butee(8);
            //cylinder(r=-(-rin-7-2.7),h=bras_height);
            //rotate([0,0,-omega])scale([3,1,1])butee();
        }
        translate([0,0,height-depth])cylinder(r=rin, h=depth+1);
        translate([-rin,-rin-rin,height-depth])cube([2*rin,2*rin,depth+1]);
    }
    intersection(){
        translate([-rin,-rin-7,height-depth])cube([2*rin,2*rin,depth]);
            cylinder(r=rou, h=height);
    }
}

module frame(){
    union(){
        cylinder(r=rou, h=height);
        // jointure poignée et centre
        hull(){
          translate([-rin,-rin-7,0])cube([2*rin,2*rin,bras_height]);
          translate([-bras_thick/2,-7-rin-2,0])cube([bras_thick,2,bras_height]);
        }
        // extremite poignée
        hull(){
          translate([0,-rou-bras_length-rou,0])cylinder(r=buttonr,h=bras_height);
          translate([-bras_thick/2,-bras_length-rou,0])cube([bras_thick,2,bras_height]);
        }
        translate([-bras_thick/2,-bras_length-rou,0])cube([bras_thick,bras_length,bras_height]);
    }

}

module butee(add=0){
    hauteur = bras_height + add;
    length = 14.5;
    rotate([0,0,-omega])translate([-5/2,-length,0])cube([5,length,hauteur]);
//    difference(){
//        translate([-rin,-rin-7-2.7,0])cube([2*rin,2*rin+2.7,hauteur]);
//        translate([-rin,-rin-7-2.7,0])rotate([0,0,45])cube([2,2,2.5*hauteur],center=true);
//        translate([rin,-rin-7-2.7,0])rotate([0,0,45])cube([2,2,2.5*hauteur],center=true);
//    }
//    hull(){
//      translate([-rin,-rin-7,0])cube([2*rin,2*rin,bras_height]);
//      translate([-bras_thick/2,-7-rin-2,0])cube([bras_thick,2,bras_height]);
//    }
}