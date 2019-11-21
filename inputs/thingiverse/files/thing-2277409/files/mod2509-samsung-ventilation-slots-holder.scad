/*
Version 1.00 - 17/04/26
holder for raspberry on Samsung-TV with short USB-Power-Cabel on ventilation slots

***
New features in 1.10:
    input the modifikation for pi 2/3 or pi zero;
    change pi_type for select
***


### mod2509 ####################
### http://www.masterofdorn.de #
################################
*/

//create=1 create holder; create=2 create holder quarrection
create=1;

// pi_type=1 pi2/3; pi_type=2 pi zero
pi_type = 1;

samsung_slots = 3;
holder_thick = 3;
holder_samsung_thick=holder_thick-(holder_thick/10);


//pi Box-Setting
pi_width = pi_type == 1 ? 65: 72;
pi_height = pi_type == 1 ? 29.3 : 11;
pi_length = pi_type == 1? 90:35;
holder_quarrection_length = pi_type == 1?17*samsung_slots:5*samsung_slots; //muss be a multiplication of samsung_slots and muss be a odd number
holder_pi_poor_rotation=-2;

$fn=100;

module holder_samsung(){
    cube(holder_samsung_thick);
    translate([0,0,holder_samsung_thick])
    cube([holder_samsung_thick*3,holder_samsung_thick,holder_samsung_thick]);
    translate([holder_samsung_thick*3,0,-holder_samsung_thick*3])
    cube([holder_samsung_thick,holder_samsung_thick,holder_samsung_thick*5]);
    translate([holder_samsung_thick*4,0,-holder_samsung_thick*3,])
    cube([holder_samsung_thick*5,holder_samsung_thick,holder_samsung_thick]);
    translate([holder_samsung_thick*4,holder_samsung_thick/2,0])
    mirror([0,0,1]) holder_strengthening();
    translate([holder_samsung_thick*9,holder_samsung_thick/2,-holder_samsung_thick*5])
    mirror([1,0,0]) holder_strengthening();
}

module holder_pi_poor(){
    cube([holder_thick,holder_thick,pi_width]);
    translate([0,0,pi_width]){
        difference(){
            cube([pi_height+holder_thick,holder_thick,holder_thick]);
            translate([(pi_height-holder_thick*2)/2,0,holder_thick/5])
            cube([holder_thick-(2*(holder_thick/5)),holder_thick,holder_thick-(2*(holder_thick/5))]);
        }
        translate([pi_height+holder_thick,0,-(pi_width/4)+holder_thick])
        cube([holder_thick,holder_thick,pi_width/4]);
    }
    translate([0,0,-holder_thick]){
        difference(){
            cube([pi_height+holder_thick,holder_thick,holder_thick]);
            translate([(pi_height+(holder_thick*5))/2,0,holder_thick/5])
            cube([holder_thick-(2*(holder_thick/5)),holder_thick,holder_thick-(2*(holder_thick/5))]);
        }
        translate([pi_height+holder_thick,0,0])
        cube([holder_thick,holder_thick,pi_width/4]);
    }
}

echo("holder_quarrection_length=",holder_quarrection_length);
echo("holder_samsung_thick=",holder_thick-(holder_thick/10));

module holder_strengthening(){
    x=0;
    y=holder_samsung_thick/2;
    z=holder_samsung_thick*2;
    polyhedron ( points = [[0, -y, z], [0, y, z], [0, y, 0], [0, -y, 0], [z, -y, z], [z, y, z]], 
    faces = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
}

module holder_quarrection(){
    tol=0.2; 
    echo("holder_quarrection_thick=",holder_thick-(2*(holder_thick/5))-tol);
    echo("holder_quarrection_length",holder_quarrection_length+(holder_thick*2));
    cube([holder_thick-(2*(holder_thick/5))-tol,holder_quarrection_length+(holder_thick*2),holder_thick-(2*(holder_thick/5))-tol],center=true);
}

rotate(a=90,v=[1,0,0])
if (create==1){
    holder_samsung();
    translate([holder_samsung_thick*9,0,-pi_width])
    rotate(a=holder_pi_poor_rotation, v=[0,1,0]) holder_pi_poor();
}

if (create==2){
    holder_quarrection();
}

if (create==0){
    cube([holder_samsung_thick*3,holder_samsung_thick,holder_samsung_thick]);
}