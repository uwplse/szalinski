//unit is millimeter
mode = 1; //[1:holder,2:lid]
number = 2; //[1:10]
cartridgeWidth = 21.6; //[Hidden]
cartridgeLength = 31.2; //[Hidden]
cartridgeHeight = 3.5; //[Hidden]
gutter = 1; //[Hidden]

module lid() {
    translate([cartridgeHeight + gutter*4, 0, 0]) {
        rotate([0, -90, 0])
        difference() {
            difference(){
                cube([cartridgeWidth*number+gutter*(number+2), cartridgeLength*2 + gutter*5, cartridgeHeight + gutter*4]);
                translate([gutter, gutter, gutter])
                cube([cartridgeWidth*(number+1), cartridgeLength*2 + gutter*3, cartridgeHeight + gutter*2]);
            }
            
            translate([
                cartridgeWidth*number+gutter*(number+2),
                (cartridgeLength*2 + gutter*4)/2,
                -gutter
            ])
            cylinder(cartridgeHeight + gutter*6, cartridgeWidth/2 - gutter, cartridgeWidth/2 - gutter);
        }
    }
}
module holder() {
    difference() {
        difference() {
            difference() {    
                cube([cartridgeWidth + gutter * 2, cartridgeLength + gutter, cartridgeHeight + gutter*2]);
                translate([gutter, -gutter, gutter]) {
                    cube([cartridgeWidth, cartridgeLength, cartridgeHeight]);
                }
            }
            
            translate([gutter*2, -gutter, gutter]) {
                cube([cartridgeWidth - gutter * 2, cartridgeLength - gutter, cartridgeHeight + gutter*2]);
            }
        }
        
        translate([cartridgeWidth/2 + gutter , 0, -gutter/2]) {
            cylinder(gutter*2, cartridgeWidth/2 - gutter, cartridgeWidth/2 - gutter);
        }
    }
}


module block() {    
    holder();
    rotate([0, 0, 180])
    translate([-cartridgeWidth-gutter*2, -cartridgeLength*2-gutter*2, 0])
    holder();
}



module holderBlock() {
    for (i = [1:1:number]) {
        translate([cartridgeWidth*(i-1)+gutter*(i-1), 0, 0])
        block();
    }
}

if (mode == 1){
    holderBlock();
} else {    
    lid();
}