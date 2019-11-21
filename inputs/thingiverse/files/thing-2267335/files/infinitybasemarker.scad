//The diameter of the miniature's base (widest point)
marker = 120; // [10:200]

difference(){
    union(){
        cylinder(d = marker+20, h=2);
        intersection(){
            cylinder(d=marker+20,h=5);
            translate([-(marker+20)/2,0,0])
            cube([marker+20,marker+20,5]);
        }
    }
    translate([0,0,2])
    cylinder(d = marker+0.5, h = 5, $fn=36);
    translate([0,0,2])
    for(r = [0:45:180]){
        rotate(r)
        rotate([0,-90,0])
        cylinder(d=1,h=marker,$fn=4);
    }
    for(x = [-marker/2,marker/2]){
        translate([x,0,2])
        cylinder(d=1,h=marker,$fn=4);
    }
}