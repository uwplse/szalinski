//draw('Top','Rect',P=(4,0,0),G=(2,10,12))

translate([4,0,0]) {
    cube([2,20,24],true);
}

//for(i<2,'Trans',u1=(0,0,12))
//for(j<2,'Trans',u2=(0,10,0))
//draw('Leg','Cub',P=(-6,-6,-7)
//+(j×u2)+(i×u1),G=(12,2,2))

translate([-6,-6,-7]) {
    cube([12,2,2]);
    translate([0,0,12]) {
        cube([12,2,2]);
    }
    translate([0,10,0]) {
        cube([12,2,2]);
    }
    translate([0,10,12]) {
        cube([12,2,2]);
    }
}

//for(i<2,'Trans',u=(0,0,12))
//draw('HoriBar','Cub',P=(-5,-8,-7)
//+(i×u),G=(2,16,2))

translate([-5,-8,-7]) {
    cube([2,16,2]);
    translate([0,0,12]) {
        cube([2,16,2]);
    }
}

//draw('HoriBar','Cub',P=(-6,-1,-7),G=(2,2,14))

translate([-6,-1,-7]) {
    cube([2,2,14]);
}
