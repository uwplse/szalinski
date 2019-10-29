$fn = 50*1;

root = 7;
hole = 3;
deep = 15;

thick = sqrt(pow(hole/2,2)+pow(hole/2,2));


difference(){

translate([-root/2,root/2,0]){
    cylinder(r=root/2+1.2,h=thick);
}

translate([-root/2,root/2,-0.01]){
    cylinder(r=root/2,h=thick+02);
}

translate([-25,-50+root/10,-0.01]){
    cube([50,50,thick+0.02]);
}

}

difference(){

    translate([0,-deep+root/2,0]){
        cube([thick,deep,thick]);
    }

    for(i=[0:10]){
        translate([8/1.4 +thick/2,0-i*thick,thick/2]){
            rotate([0,0,45]){
                cube([8,8,thick+0.02],center=true);
            }
        }
        translate([-8/1.4+thick/2,-thick/2-i*thick,thick/2]){
            rotate([0,0,45]){
                cube([8,8,thick+0.02],center=true);
            }
        }
    }
    translate([thick/2,0,-0.01]){
        cube([8,8,thick+0.02]);
    }
}






