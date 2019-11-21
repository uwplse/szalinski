global_fn = 2000;


module lead_nut()
{
    translate([33,0, 0])
    translate([0,9, 5])
    {
        color([1,0,0])cylinder(15+0.2,r=9.8149545762236+0.1,$fn=6);
        
        translate([0,0, -5])
        color([1,0,0])cylinder(30,d=12,$fn=global_fn);
        
        //translate([0,-15, -8])
        //color([0,1,0])cube([0.01,40,40]);
    }
}

module top_m5()
{
    translate([22.6,-10, 18])
    color([1,0,0]) cylinder(10,d=5.2,$fn=global_fn);
    translate([20,-13, 18])
    color([1,0,0]) cube([5.2,3,10]);
}

module side_m5()
{
    //m5 scerw hole
    translate([10,8, 10])
        rotate([90,0,0])
            color([1,0,0]) cylinder(10,d=5.2,$fn=global_fn);
    translate([10,5, 10])
        rotate([90,0,0])
            color([1,0,0]) cylinder(1,d=10,$fn=global_fn);
}

module back_m5()
{
    translate([20+12.6-5,23+5, 25/2])
        rotate([90,0,90])
            color([1,0,0]) cylinder(1,d=10,$fn=global_fn);
    translate([20+10.6-5,23+5, 25/2])
        rotate([90,0,90])
            color([1,0,0]) cylinder(10,d=5.2,$fn=global_fn);
}


// side 5m part
difference(){
    cube([20,5,25]);
    side_m5();
}

// top 5m part
difference(){
    translate([12.6,-13, 20])
        cube([20,18,5]);
    top_m5();
    lead_nut();
}

// back 5m part
difference(){
    translate([20+12.6-5,23, 0])
        cube([5,15,25]);
    back_m5();
}


// holder core
difference(){
    translate([20,0, 0])
        cube([12.6,23,25]);
    lead_nut();
}
