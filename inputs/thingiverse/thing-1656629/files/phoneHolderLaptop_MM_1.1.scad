/////////////////////////////////////////////////////////////////
//
//      OpenScad PhoneHolderLaptop v1.1
//      By MehdiMaker 07/2016
//      http://mehdimaker.com
//
//////////////////////////////////////////////////////////////////

//////////////// - Display your object        - //////////////////

showPhoneHolder = true;        // true or false
showSupportLaptop = false;      // true or false
showScrew = false;             // true or false
position = "left";             // "right" or "left"
buttonsHoleLeft = true;        // display hole for buttons

/////////////// - Phone Holder parameters    - ///////////////////
// Dimension iphone 5 : 125x59x9
// Share me your phone dimension please
height = 125;                  // value no limit
width = 59;                    // value no limit
thickness = 9;                 // value >= 9
arrondi= 15;                   // not paramettrable

// Includes modules
include <module_thread.scad>

module myPhone(height,width,thickness,arrondi){
    hull(){
        cylinder(d=arrondi ,h=thickness, $fn=50);
        translate([0,width-arrondi,0]) cylinder(d=arrondi ,h=thickness, $fn=50);
        translate([height-arrondi,width-arrondi,0]) cylinder(d=arrondi ,h=thickness, $fn=50);
        translate([height-arrondi,0,0])cylinder(d=arrondi ,h=thickness, $fn=50);
    }
}

module PhoneHolder(height,width,thickness,arrondi){
    difference(){
        union(){
            myPhone(height+4,width+4,thickness+4,arrondi);
            translate([5,-27,1+((thickness-13)/2)])
            union(){
                difference(){
                    union(){
                        translate([15,10,1])rotate([0,0,45])cube([11,20,13]);
                        translate([15,10,1])cube([9,25,13]);
                    }
                    translate([2,14,3.5])cube([25,6,8]);
                    translate([2,6,3.5])cube([15,10,8]);
                }
                difference(){
                    union(){
                        translate([50,10,1])rotate([0,0,45])cube([11,20,13]);
                        translate([50,10,1])cube([9,25,13]);
                    }
                    translate([37,14,3.5])cube([25,6,8]);
                    translate([39,6,3.5])cube([13,10,8]);
                }
                difference(){
                    union(){
                        translate([85,10,1])rotate([0,0,45])cube([11,20,13]);
                        translate([85,10,1])cube([9,25,13]);
                    }
                    translate([72,14,3.5])cube([25,6,8]);
                    translate([74,6,3.5])cube([13,10,8]);
                }
            }
        }
        // Plus/moin - lock
        if (position == "left" && buttonsHoleLeft == true)translate([height-56,45,2])cube([40,20,thickness]);
        //difference myPhone
        translate([2,2,2])myPhone(height+6,width,thickness,arrondi);
        //difference face avant
        translate([5,5,6])myPhone(height+6,width-6,thickness,arrondi);
        //difference trou charge
        translate([-arrondi,4,2])cube([arrondi,width-4-arrondi,thickness]);
    }
}

module SupportLaptop(){
    difference(){
        translate([0,-4,0])cube([93,24,13]);
        //trou 1
        translate([-7,17,-1])rotate([0,0,-45])cube([10,20,20]);
        translate([28,18,-1])rotate([0,0,-45])cube([10,20,20]);
        translate([23,11,-1])cube([12,20,20]);
        translate([15,11,-1])cube([10,4.5,20]);
        translate([15,11,0])cube([10,10,3]);
        translate([15,11,10])cube([10,10,3]);
        translate([15,11,0])rotate([0,0,45])cube([14,20,3]);
        translate([15,11,10])rotate([0,0,45])cube([14,20,3]);
        //trou 2
        translate([63,18,-1])rotate([0,0,-45])cube([10,20,20]);
        translate([58,11,-1])cube([12,20,20]);
        translate([50,11,-1])cube([10,4.5,20]);
        translate([50,11,0])cube([10,10,3]);
        translate([50,11,10])cube([10,10,3]);
        translate([50,11,0])rotate([0,0,45])cube([14,20,3]);
        translate([50,11,10])rotate([0,0,45])cube([14,20,3]);
        //trou 3
        translate([98,18,-1])rotate([0,0,-45])cube([10,20,20]);
        translate([93,11,-1])cube([12,20,20]);
        translate([85,11,-1])cube([10,4.5,20]);
        translate([85,11,0])cube([10,10,3]);
        translate([85,11,10])cube([10,10,3]);
        translate([85,11,0])rotate([0,0,45])cube([14,20,3]);
        translate([85,11,10])rotate([0,0,45])cube([14,20,3]);

       translate([0,-39.4,18.1])rotate([-27.5,0,0])translate([-2,-2,2])cube([100,40,15-4]);

    }
        translate([0,-39.4,18.1])rotate([-27.5,0,0])
        difference(){   
           cube([93,40,15]);
            
            translate([-2,-2,2])cube([110,40,15-4]);
            translate([0,20,-22.4])rotate([27.5,0,0])cube([110,40,15-4]);
            translate([0,-22,-12])rotate([0,0,0])cube([110,40,35-4]);
            
            translate([11,27,-8])scale([1.2,1.2,1.2])screw();
            translate([46,27,-8])scale([1.2,1.2,1.2])screw();
            translate([81,27,-8])scale([1.2,1.2,1.2])screw();
        }       
}

module screw(){
    for(i=[0:14]){
        hull(){
          rotate([0,0,15*i])translate([7,0,0])cylinder(h=5,r=1,$fn=50);
          rotate([0,0,-15*i])translate([7,0,0])cylinder(h=5,r=1,$fn=50);
        }
    }
    english_thread(0.45, 5, 0.55);    
}

// Displaying
if (position == "right"){
    if (showPhoneHolder == true) mirror([0,1,0])PhoneHolder(height,width,thickness,arrondi);
    if (showSupportLaptop == true) translate([0,40,0])mirror([0,1,0])SupportLaptop();
}else if (position == "left"){
    if (showPhoneHolder == true) PhoneHolder(height,width,thickness,arrondi);
    if (showSupportLaptop == true) translate([0,-40,0]) SupportLaptop(); 
}
if (showScrew == true) translate([0,-40,20])screw();



