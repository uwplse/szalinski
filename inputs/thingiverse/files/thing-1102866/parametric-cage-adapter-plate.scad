/*
 This creates a size a to size b ring adapter for interoperation of cage parts of different sizes or from different manufacturers
 Counterbores are assumed to be for M3 or 4-40 screws and Rod A counterbores will be easier to print (Rod B counterbores may need supports)
  */

Plate_Thickness = 10;

Outer_Diameter = 50;

//(0 = no thru hole)
Inner_Diameter = 20;

Rod_A_Diameter = 6;

Rod_A_Spacing = 26.9;

Rod_A_Hole_Type = "Counterbore";	//	[Thru, Counterbore]

Rod_B_Diameter = 6;

Rod_B_Spacing = 30;

Rod_B_Hole_Type = "Counterbore";	//	[Thru, Counterbore]

Relative_Angle= 45;//	[0:90]
difference(){
    make_plate ();
    make_rod_a_hole();
    make_rod_b_hole();
}

module make_plate (){
    if (Inner_Diameter == 0) cylinder(h = Plate_Thickness, r = Outer_Diameter/2, Center = false);
    else difference(){
        cylinder(h = Plate_Thickness, r = Outer_Diameter/2, Center = false);
        cylinder(h = Plate_Thickness, r = Inner_Diameter/2, Center = false);
    }
}
module make_rod_a_hole (){
    if (Rod_A_Hole_Type == "Thru")
    { 
        for (x = [-.5,.5], 
        y =[-.5,.5]) translate ([x*Rod_A_Spacing,y*Rod_A_Spacing,Plate_Thickness/2]) make_hex(Rod_A_Diameter,Plate_Thickness);
    }
    else
    { 
        for (x = [-.5,.5], 
        y =[-.5,.5]) translate ([x*Rod_A_Spacing,y*Rod_A_Spacing,Plate_Thickness/4]) make_counter(Rod_A_Diameter,Plate_Thickness);
    }
    
}
module make_rod_b_hole (){
    if (Rod_B_Hole_Type == "Thru")
    { 
        for (x = [-.5,.5], 
        y =[-.5,.5]) rotate([0,0,Relative_Angle]) translate ([x*Rod_B_Spacing,y*Rod_B_Spacing,Plate_Thickness/2]) make_hex(Rod_B_Diameter,Plate_Thickness);
    }
    else
    { 
        for (x = [-.5,.5], 
        y =[-.5,.5]) rotate([0,0,Relative_Angle])translate ([x*Rod_B_Spacing,y*Rod_B_Spacing,3*Plate_Thickness/4])mirror([0,0,1]) make_counter(Rod_B_Diameter,Plate_Thickness);
    }
    
}
module make_hex(Diam,Len){
    s =Diam/2 * ( 2 * tan(30));
        for (r = [-60,0,60]) rotate([0,0,r]) cube([s, Diam, Len], true);
            }
module make_counter(Diam,Len){
            union(){
            translate ([0,0,Len/2]) make_hex(Diam,Len/2);
            make_hex(3,Len/2);
        }
    }