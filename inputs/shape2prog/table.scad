//draw('Top','Rect',P=(6,0,0),G=(2,7,12))


//for(i = [0:1],'Trans',u=(0,0,12))
//draw('Leg','Cub',P=(-7,-1,-8)
//+(i×u),G=(12,2,2))

// Top
translate([6,0,0]) {
    cube([2,14,24], true);
}

// Legs
translate([-7,-1,-8]) {
    cube([12,2,2]);
    translate([0,0,12]) {
        cube([12,2,2]);
    }
}

// "Layer"
translate([-7,0,0]) {
    cube([1,10,18], true);
}
//draw('Layer','Rect',P=(-7,0,0),G=(1,5,9))