/*Simple standee*/

/*[Basic parameters]*/
base_diameter = 20;

base_height = 2;
//minimal distance between "slot" walls for insert
gap = 0.3;
//Slot height
slot_height=8;

slot_width = 1;

slot_length = 16;

/*[A bit of advanced ones]*/
//Slot corner diameter
slot_diameter = 5;
//pivot - upper inner edge of slot walls, gap raimains unchanged
angle = 3;

union(){
    cylinder(h=base_height, d=base_diameter, $fn=50);
    placeWall();
    mirror([1,0,0])placeWall();
}

module placeWall(){
    c1 = slot_height*(1-cos(angle))/cos(angle);
    c2 = slot_width*tan(angle);
    C=c1+c2;
  translate([gap/2.0,-slot_length/2.0,base_height-C])
    slotWall(slot_height+C,slot_width,slot_length,slot_diameter,angle);    
}


module slotWall(){
    translate([0,0,slot_height])
    rotate(a=[0,-angle,0])
    translate([0,0,-slot_height])
    rotate(a=[90,0,90])
    hull(){
        cylinder(slot_width,d=0.0001);
        translate([slot_length,0,0])cylinder(slot_width,d=0.0001);
        translate([slot_diameter/2,slot_height-slot_diameter/2,0])cylinder(slot_width,d=slot_diameter, $fn=30);
        translate([slot_length-slot_diameter/2,slot_height-slot_diameter/2,0])cylinder(slot_width,d=slot_diameter,$fn=30); 
    }
}


