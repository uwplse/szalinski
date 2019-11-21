/* [Parameters] */
//Number of shells
shells = 5; //[2:1:20]
//Shell thickness in mm
thick = 2;
//Gap between shells in mm
gap = 0.5;



module shell(r,thick){
    difference(){
        sphere(r);
        sphere(r-thick);
    }
}


module onion(shells,thick,gap){
    for(i=[1:shells]){
        shell(i*(thick+gap),thick);
    }
}

$fn=80;




difference(){
    onion(shells,thick,gap);
    translate([0,0,thick/2])
    cylinder(r1=0,r2=180,h=60);
    mirror([0,0,1])
    translate([0,0,thick/2])
        cylinder(r1=0,r2=180,h=60);
}