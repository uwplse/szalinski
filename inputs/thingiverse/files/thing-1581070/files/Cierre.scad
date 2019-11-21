$fn=300;


difference(){
cylinder(2.5,8.8/2,8.8/2);
translate([-0.75,-5,0])
    cube([1.5,10,2.4]);
}
translate([0,0,2.5])
    cylinder(34,6.9/2,6.9/2);

translate ([-1,0,6.5])
    cube([2,5.5,3]);

translate ([-1,0,31.5])
    cube([2,5.5,5]);

translate ([0,0,28]){
    intersection(){
        cylinder (1.5,7.4/2,7/2);
        translate ([0,-10,0])
            cube (10);
    }
}