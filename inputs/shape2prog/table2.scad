//draw('Top','Rect',P=(4,0,0),G=(2,7,12))

translate([4,0,0]) {
    cube([2,14,24],true);
}

//for(i<2,'Trans',u=(0,0,10))
//draw('Leg','Cub',P=(-6,-1,-6)
//+(i×u),G=(10,1,2))

translate([-6,-1,-6]) {
    cube([10,1,2]);
    translate([0,0,10]) {
        cube([10,1,2]);
    }
}

//for(i<2,'Trans',u=(0,0,13))
//draw('HoriBar','Cub',P=(-5,-6,-8)
//+(i×u),G=(1,12,2))

translate([-5,-6,-8]) {
    cube([1,12,2]);
    translate([0,0,13]) {
        cube([1,12,2]);
    }
}

//draw('HoriBar','Cub',P=(-5,0,-8),G=(2,2,15))
translate([-5,0,-8]) {
    cube([2,2,15]);
}
