// Which one would you like to see?
part = "case"; // [case:the case without cap,cap:the cap for the case]

// The width of the (e. g. Arduino) board which should fit into the case (all parameters are in mm)
board_width = 18.5;


// The length of the (e. g. Arduino) board which should fit into the case
board_length = 33.5;

// The thickness of the (e. g. Arduino) board which should fit into the case, must be >= 0. (its used for the thickness of the slots, it is not the size of the inner space
board_thickness = 2.0;

// the board can slide into the case. Therefore there are slots on both sides of the case. If you want the complete inner of the case with same width as above given board with: set this parameter to 0
board_slot_depth = .75;

// if the board should not be centered in the case, you can add an offset here. Positive values give a lower position of the slots
board_out_of_center_Z = 1.5;



// the inner height of the case
case_inner_height = 8;

// on the front there is a centered opening. Typically this is used for connecting the usb conncetor of the board. Set to 0 if you don't need a openening there
USB_openening_height = 8;
USB_openening_width = 11;



// the cap is made a little bit smaller and thinner than the cap slot in the case, must be >= 0 (in mm)
gap = 0.2;

// in the cap there is a slot, e. g. for passing a wire through the cap. Set it to 0 if you do not need a slot
cap_Gap_width =1.7;

// the height is measured above the board in the case. The slot ends at the lower end of the cap
cap_gap_height = 3; 


module dummy() {
    //end of configurable section of customizer
}

houseTS = 2;
houseTT = 2;
capT = 3;
capSkewed = 2;
capWT = 1.5;


houseL = board_length + houseTT + capT;
houseW = board_width + 2 * houseTS;
houseH = case_inner_height + 2 * houseTS;

module mycube(pos,center=[false,false,false])
{   
    translate([center[0]?-pos[0]/2:0,center[1]?-pos[1]/2:0,center[2]?-pos[2]/2:0])cube(pos);
}


module cap(gap = 0) {
    difference() {
        union() {
            translate([0,0,(houseTS-.5)/2+(gap==0?1:0)]) intersection() {
                mycube([capT,houseW-2*capWT-2*gap,case_inner_height+.5+houseTS+2*(gap==0?1:0)],[false,true,true]) ;
                rotate([45,0,0]) rotate([0,90,0]) cylinder(capT-gap,sqrt(2)*(houseW/2-capWT+capT-capSkewed-gap),sqrt(2)*(houseW/2-capWT-capSkewed-gap),$fn=4); 
            }
        }
        if(gap!=0) translate([0,0,-case_inner_height-board_out_of_center_Z/2+cap_gap_height])mycube([capT+2,cap_Gap_width,case_inner_height],[false,true,false]);
    }
}


PartIsCap = (part == "cap");

rotate([0,-90,0]) if(!PartIsCap)
difference() {
    mycube([houseL,houseW,houseH],[false,true,true]);
    translate([-1,0,0]) mycube([2+houseTS,USB_openening_width,USB_openening_height],[false,true,true]);
    translate([houseTS,0,-board_out_of_center_Z]) mycube([houseL,board_width,board_thickness],[false,true,true]);
    translate([houseTS,0,0])mycube([houseL,board_width-2*board_slot_depth,case_inner_height],[false,true,true]);
    translate([houseTT+board_length+0.001,0,0]) cap(0);
}
else
    translate([-15,0,0]) cap(.2);