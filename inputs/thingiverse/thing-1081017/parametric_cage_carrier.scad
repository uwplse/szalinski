/*
 This creates a general purpose widget holder to stradle two rails on a cage system. 
 The calculations are done such that the given Z height is entirely above the rails with additional material below and beside the rails.
 */

// length or x direction (length along the rail)
length_x = 100;
// Width or y direction (width across rails)
Width_y = 40;
// Height or z direction (height above rail)
Height_z = 6;

Rail_Diameter = 6;

Rail_Spacing = 26.9;

Number_of_Holes = 3; //[0:10]
 
Hole_Diameter = 6; 
//nutSize = 8; //size of nuts


difference(){
    Put_Together();
    make_holes(Hole_Diameter);
}

module Put_Together(){
    union(){
        make_rodholder();
        mirror ([1,0,0])make_rodholder();
        mirror ([0,1,0])make_rodholder();
        mirror ([1,0,0])mirror ([0,1,0])make_rodholder();
        main_body();
    }
}


module make_rodholder(){
    translate([7*length_x/16,Rail_Spacing/2,Rail_Diameter*.51 + Height_z])//translate to get rail holder to 0z
    difference(){
    translate([0,0,Rail_Diameter*-.09])cube([length_x/8,Rail_Diameter*1.5,Rail_Diameter*.82],true);//0.82 rail diameter gives limited contact with incircle; -0.09 translate sets floor
    rotate ([0,90,0]) make_hex(-30, 30, 90, Rail_Diameter, length_x/8 );
    }


}
module make_holes(Hole_Diameter){
    if (Number_of_Holes > 0)
        {
            for (a=[1:Number_of_Holes])
            translate ([(a * length_x/ (Number_of_Holes +1)) - (length_x/2),0,0]) make_hex(-30, 30, 90, Hole_Diameter, 2*Height_z);                   
    }
}
module make_hex(Rx,Ry,Rz,Diam,Len){
    s =Diam/2 * ( 2 * tan(30));
        for (r = [Rx,Ry,Rz]) rotate([0,0,r]) cube([s, Diam, Len], true);
            }
module main_body(){
    translate ([0,0,(Height_z ) /2]) cube(size = [length_x, Width_y, (Height_z )], center = true);
}
module fancy_body(){
hull(){
    translate ([0,0,Height_z/4]) cube (size = [length_x,Width_y,Height_z/2], center = true);
    translate ([0,0,Height_z/2]) scale ([length_x,2,1])rotate ([0,90,0]) cylinder (h = 1, r=Height_z/2, center = true, $fn=50);
}
}
