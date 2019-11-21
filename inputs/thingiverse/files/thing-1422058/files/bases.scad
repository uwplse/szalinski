/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK, wyloch:Wyloch]

/* [OpenLOCK] */
openlock = "true";// [true,triplex,false]

/* [Magnets] */
// Size of hole for magnet.  6 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 6;

/* [Priority] */
// Do you want openlock or magnets to win when the two conflict
priority = "openlock"; // [openlock,magnets]

/* [Style] */
// What should the base look like on the exterior
style = "plain"; // [stone,plain]

/* [Shape] */
// What type of tile is this for
shape = "square"; // [square,diagonal,curved]

/* [Dynamic Floors] */
// Add support for dynamic floors
dynamic_floors = "false";

/*
 * Openlock connection bay
 */
module openlock_chamber(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.2]);
    }
    translate([5,-5,1.4]) cube([8,5*2,4.2]);
    translate([7.55,-5.25,1.4]) cube([6,5.5*2,4.2]);
}

module openlock_supports(buffer=0) {
    translate([0-buffer*2,-0.5,1.4-buffer]) cube([10+buffer*2,1,4.2+buffer*2]);
}

module openlock_positive() {
    translate([0,-8,0]) cube([2,16,6]); 
}

module openlock_negative() {
    difference() {
        openlock_chamber(1);
        //openlock_supports(1);
    }
}

module magnet_positive(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0]) cylinder(6,magnet_hole/2+1,magnet_hole/2+1, $fn=100);
    }
}

module magnet_negative(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
    }
}



module center_connector_positive(edge, ordinal, magnet_hole=5.5, single=true, triplex=false, priority="openlock") {
    if (edge == 1) {
        if (priority == "openlock" && (single || triplex)) {
            openlock_positive(magnet_hole);
        } else {
            magnet_positive(magnet_hole);
        }
    } else {
        if (priority == "openlock" && triplex) {
            openlock_positive(magnet_hole);
        } else {
            magnet_positive(magnet_hole);
        }
    }
}

module center_connector_negative(edge, ordinal, magnet_hole=5.5, single=true, triplex=false, priority="openlock") {
    if (edge == 1) {
        if (priority == "openlock" && (single || triplex)) {
            openlock_negative(magnet_hole);
        } else {
            magnet_negative(magnet_hole);
        }
    } else {
        if (priority == "openlock" && triplex) {
            openlock_negative(magnet_hole);
        } else {
            magnet_negative(magnet_hole);
        }
    }
}

module joint_connector_positive(edge, ordinal, magnet_hole=5.5, single=true, triplex=false, priority="openlock") {
    if(single || triplex) {
        openlock_positive();
    }
}

module joint_connector_negative(edge, ordinal, magnet_hole=5.5, single=true, triplex=false, priority="openlock") {
    if(single || triplex) {
        openlock_negative();
    }
}

module openlock_base(x,y,square_basis,
        shape="square",style="plain",magnet_hole=6,openlock="true",priority="openlock",dynamic_floors="false") {
    single = openlock == "true" ? true : false;
    triplex = openlock == "triplex" ? true : false;
    df = dynamic_floors == "true" ? true : false;
    edge_width = magnet_hole >= 5.55 ? magnet_hole + 1 : 6.55;
    difference() {
        union() {
            if (style == "stone") {
                stone_base(x,y,square_basis,shape,edge_width);
            } else if (style == "plain") {
                plain_base(x,y,square_basis,shape,edge_width);
            }
            if (df) {
                cube([square_basis/2+4.75,square_basis/2+4.75,6]);
                translate([square_basis*x-square_basis/2-4.75,0,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
                translate([0,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
                translate([square_basis*x-square_basis/2-4.75,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
                translate([square_basis/2+3.75,square_basis/2+3.75,0]) cube([square_basis*x-(square_basis/2+3.75)*2,square_basis*y-(square_basis/2+3.75)*2,6]);
                if (x > 2) {
                    for ( i = [2 : x-1] ) {
                        translate([(i-.5)*square_basis-9.5/2,0,0]) cube([9.5,square_basis/2+4.75,6]);
                        translate([(i-.5)*square_basis-9.5/2,square_basis*y-square_basis/2-4.75,0]) cube([9.5,square_basis/2+4.75,6]);
                    }
                }
                if (y > 2) {
                    for ( i = [2 : y-1] ) {
                        translate([0,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
                        translate([square_basis*x-square_basis/2-4.75,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
                    }
                }
            }

            for ( i = [0 : y-1] ) {
                translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_positive(y,i,magnet_hole,single,triplex,priority);
                if (shape == "square") {
                    translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,i,magnet_hole,single,triplex,priority);
                }
            }
            if (y > 1) {
                for ( i = [1 : y-1] ) {
                    translate([0,square_basis*i,0]) joint_connector_positive(y,i,magnet_hole,single,triplex,priority);
                    if (shape == "square") {
                        translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_positive(y,i,magnet_hole,single,triplex,priority);
                    }
                }
            }
            for ( i = [0 : x-1] ) {
                translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_positive(x,i,magnet_hole,single,triplex,priority);
                if (shape == "square") {
                    translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_positive(x,i,magnet_hole,single,triplex,priority);
                }
            }
            if (x > 1) {
                for ( i = [1 : x-1] ) {
                    translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_positive(y,i,magnet_hole,single,triplex,priority);
                    if (shape == "square") {
                        translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_positive(y,i,magnet_hole,single,triplex,priority);
                    }
                }
            }
        }
        
        for ( i = [0 : y-1] ) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_negative(y,i,magnet_hole,single,triplex,priority);
            if (shape == "square") {
                translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,i,magnet_hole,single,triplex,priority);
            }
        }
        if (y > 1) {
            for ( i = [1 : y-1] ) {
                translate([0,square_basis*i,0]) joint_connector_negative(y,i,magnet_hole,single,triplex,priority);
                if (shape == "square") {
                    translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_negative(y,i,magnet_hole,single,triplex,priority);
                }
            }
        }
        for ( i = [0 : x-1] ) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_negative(x,i,magnet_hole,single,triplex,priority);
            if (shape == "square") {
                translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_negative(x,i,magnet_hole,single,triplex,priority);
            }
        }
        if (x > 1) {
            for ( i = [1 : x-1] ) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_negative(y,i,magnet_hole,single,triplex,priority);
                if (shape == "square") {
                    translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_negative(y,i,magnet_hole,single,triplex,priority);
                }
            }
        }
        if(df) {
            for ( i = [0 : x-1] ) {
                for ( j = [0 : y-1] ) {
                    translate([i*square_basis, j*square_basis,0]) translate([square_basis/2,square_basis/2,6-2.1]) cylinder(2.5,5.5/2,5.5/2, $fn=100);
                }
            }
        }
    }
}

module plain_base(x,y,square_basis,shape,edge_width) {
    difference() {
        intersection() {
            translate([0,0,0]) cube([square_basis*x, square_basis*y, 6]);
            if(shape == "curved") {
                translate([0,0,-1]) scale([x,y,1]) cylinder(8,square_basis,square_basis,$fn=200);
            } else if (shape == "diagonal") {
                translate([x*square_basis,0,0]) rotate([0,0,45]) {
                    cube([10.2/2,square_basis*x*2,6]);
                    mirror([1,0,0]) cube([square_basis*x*2,square_basis*x*2,6]);
                }
            }
        }
        
        intersection() {
            translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
            if(shape == "curved") {
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
    if(shape == "diagonal") {
        intersection() {
            translate([x*square_basis,0,0]) rotate([0,0,45]) {
                cube([10.2/2,square_basis*x*2,6]);
                mirror([1,0,0]) cube([10.2/2,square_basis*x*2,6]);
            }
            translate([0,0,0]) cube([square_basis*x, square_basis*y, 6]);
        }
    }
}

module stone_base(x,y,square_basis,shape,edge_width) {
    module generate_stones() {
        intersection() {
            union() {
                for (i = [0:xblocks]) {
                    for (j = [0:yblocks]) {
                        translate([i*10.2,j*10.2,0]) cube([9.2 + (i==xblocks ? 10.2 : 0),9.2 + (j==yblocks ? 10.2 : 0),5.5]);
                    }
                }
            }
            cube([length, width, 6]);
            if(shape == "curved") {
                translate([0,0,-1]) scale([x,y,1]) cylinder(8,square_basis,square_basis,$fn=200);
            } else if (shape == "diagonal") {
                translate([x*square_basis,0,0]) rotate([0,0,45]) {
                    cube([10.2/2,square_basis*x*2,6]);
                    mirror([1,0,0]) cube([square_basis*x*2,square_basis*x*2,6]);
                }
            }
        }
    }
    
    module generate_interior() {
        intersection() {
            translate([1,1,0]) cube([length-2, width-2, 6]);
            if(shape == "curved") {
                translate([0,0,-1]) scale([x,y,1]) cylinder(8,square_basis-0.5,square_basis-0.5,$fn=200);
            } else if (shape == "diagonal") {
                translate([x*square_basis,0,0]) rotate([0,0,45]) {
                    cube([10.2/2-1,square_basis*x*2,6]);
                    mirror([1,0,0]) cube([square_basis*x*2,square_basis*x*2,6]);
                }
            }
        }
    }
    
    length = square_basis*x;
    width = square_basis*y;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    difference() {
        union() {
            generate_stones();
            generate_interior();
        }
        intersection() {
            translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
            if(shape == "curved") {
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            } else if (shape == "diagonal") {
                translate([x*square_basis-sqrt(5.1*5.1+5.1*5.1),0,-1]) rotate([0,0,45]) {
                    mirror([1,0,0]) cube([square_basis*x*2,square_basis*x*2,8]);
                }
            }
        }
    }
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];

basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
square_basis_number = basis[keyLookup(basis, [square_basis])][1];

color("Grey") openlock_base(x,y,square_basis_number,shape=shape,style=style,magnet_hole=magnet_hole,openlock=openlock,priority=priority,dynamic_floors=dynamic_floors);
