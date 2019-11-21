$fn=20; //smoothness of holes
MX = 525; //Machine X
MY = 500; //Machine Y
MZ = 500; //Machine Y
MZO = 55; //Machine Z offset
ARM = 70; //Length of support arm (horizontal part)
DX = 37.5; //Dimensional Lumber X
DY = 37.5; //Dimensional Lumber Y
Wall = 2; //Wall thickness
HR=5; //Size of screw hole
PT=25.4; //Thickness of Pink Foam
BT=5; //Thickness of Bottom/Top Plates
PMode=1; //Print Mode [1=Assembled,2=Bottom Bracket,3=Top Bracket,4=Bottom Panel Support,5=Top Panel Support]
module LowerBracket(){
    color("OrangeRed")difference(){
        union(){
            cube([DX+(Wall*2),DY+(Wall*2),MZO]); //Main Upright section
            translate([0,0,MZO-DY-(Wall*2)]){  //Arms
                cube([ARM,DX+(Wall*2),DY+(Wall*2)]);
                cube([DY+(Wall*2),ARM,DX+(Wall*2)]);
            }
            translate([DX+(Wall*2),0,0])rotate([0,-45,])cube([DX,DY+(Wall*2),DX/2]); //Slanted relief
            translate([0,DY+(Wall*2),0])rotate([45,0,0])cube([DX+(Wall*2),DY,DX/2]); //Slanted relief
        }
        union(){ //Holes for wood
            translate([Wall,Wall,Wall])cube([DX,DY,MZO]);
            translate([Wall,Wall,MZO-DY-(Wall)]){
                cube([ARM,DX,DY]);
                cube([DX,ARM,DY]);
            }
            translate([ARM-HR*2,DX-Wall*2,MZO-(DX/2)])rotate([-90,0,0])hull(){
                translate([-HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([HR/2,0,0])cylinder(d=HR,h=DY/2);
            }
            translate([DX-Wall*2,ARM-HR*2,MZO-(DX/2)])rotate([0,90,0])hull(){
                translate([0,-HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([0,HR/2,0])cylinder(d=HR,h=DY/2);
            }
            translate([DX/2+Wall,Wall*2,MZO-(DX/2)])rotate([90,0,0])hull(){
                translate([0,HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([0,-HR/2,0])cylinder(d=HR,h=DY/2);
            }
            translate([Wall*2,DX/2+Wall,MZO-(DX/2)])rotate([0,-90,0])hull(){
                translate([HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([-HR/2,0,0])cylinder(d=HR,h=DY/2);
            }
        }
    }
    
}
module UpperBracket(){
    color("OrangeRed")difference(){
        union(){
            cube([DX+(Wall*2),DY+(Wall*2),DY+Wall]); //Main upright section
            translate([0,0,Wall*2]){ //Arms
                cube([ARM,DX+(Wall*2),DY+(Wall*2)]);
                cube([DY+(Wall*2),ARM,DX+(Wall*2)]);
            }
        }
        union(){ //Holes for wood
            translate([Wall,Wall,Wall])cube([DX,DY,MZO]);
            translate([Wall,Wall,Wall*3]){
                cube([ARM,DX,DY]);
                cube([DX,ARM,DY]);
            }
            translate([ARM-HR*2,DX-Wall*2,(DX/2)+Wall*2.5])rotate([-90,0,0])hull(){
                translate([HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([-HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
            }
            translate([DX-Wall*2,ARM-HR*2,(DX/2)+Wall*2.5])rotate([0,90,0])hull(){
                translate([0,HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([0,-HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
            }
            translate([DX/2+Wall,Wall*2,(DX/2)+Wall*2.5])rotate([90,0,0])hull(){
                translate([0,HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([0,-HR/2,0])cylinder(d=HR,h=DY/2); //Screw hole
            }
            translate([Wall*2,DX/2+Wall,(DX/2)+Wall*2.5])rotate([0,-90,0])hull(){
                translate([HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
                translate([-HR/2,0,0])cylinder(d=HR,h=DY/2); //Screw hole
            }
        }
    }
    
}
module wood(BL){
    translate([.05,.05,])cube([DX-.1,DY-.1,BL]);
}
module BottomPlate(){
    difference(){
        cube([MX-Wall*2,MY-Wall*2,BT]);
        union(){
            translate([-Wall,-Wall,-Wall])cube([DX+Wall*2,DY+Wall*2,BT*2]);
            translate([MX-DX-Wall*3,-Wall,-Wall])cube([DX+Wall*2,DY+Wall*2,BT*2]);
            translate([-Wall,MY-DY-Wall*3,-Wall])cube([DX+Wall*2,DY+Wall*2,BT*2]);
            translate([MX-DX-Wall*3,MY-DY-Wall*3,-Wall])cube([DX+Wall*2,DY+Wall*2,BT*2]);
        }
    }
}
module Spacer(){
    color("OrangeRed")difference(){
        cube([DX+(Wall*2),DY+(Wall*2),DY*2]);
        translate([Wall,Wall,-1])cube([DX,DY,DY*3]);
    }
}
module PrinterBlank(){
    color("Grey"){
        cube([350,410,150]);
        translate([-25,200,0])cube([400,50,400]);
    }
}
module SidePanel(){
    color("Pink")
    cube([MY-Wall*2-DY*2,MZ-MZO-DY-Wall*4,25.4]);
}
module BackPanel(){
    color("Pink")
    cube([MX-Wall*2-DX*2,MZ-MZO-DX-Wall*4,25.4]);
}

module PanelSupport(){
    color("OrangeRed")
    difference(){
        union(){
            cube([15,30,Wall]);
            cube([Wall,30,15]);
        }
        union(){
            translate([7,6,-Wall/2])cylinder(d=HR,h=Wall*2);
            translate([7,24,-Wall/2])cylinder(d=HR,h=Wall*2);
        }
    }
}
module PanelSupportUpper(){
    color("OrangeRed")difference(){
        union(){
            cube([30,20,Wall]);
            hull(){
                translate([0,20,Wall/2])rotate([0,90,0])cylinder(d=Wall,h=30);
                translate([0,20,DY-PT-Wall])rotate([0,90,0])cylinder(d=Wall,h=30);
            }
            translate([0,20,DY-PT-Wall*1.5])cube([30,20,Wall]);
        }
        union(){
            translate([6,7,-Wall/2])cylinder(d=HR,h=Wall*2);
            translate([24,7,-Wall/2])cylinder(d=HR,h=Wall*2);
            
        }
    }
}
//!PanelSupportUpper();
//!PanelSupport();
//!LowerBracket();
//!UpperBracket();
//!Spacer();
if (PMode==1){
    union(){ //Side and back panels
        translate([0,DY+Wall,MZO+BT])rotate([90,0,90])SidePanel();
        translate([MX-PT,DY+Wall,MZO+BT])rotate([90,0,90])SidePanel();
        translate([DX+Wall,MY,MZO+BT])rotate([90,0,0])BackPanel();
    }
    union(){ //bottom Brackets
        LowerBracket();
        translate([MX,0,0])rotate([0,0,90])LowerBracket();
        translate([0,MY,0])rotate([0,0,-90])LowerBracket();
        translate([MX,MY,0])rotate([0,0,180])LowerBracket();
    }
    union(){ //Wood Framing
        translate([Wall,Wall,Wall])wood(MZ);
        translate([MX-DX-Wall,Wall,Wall])wood(MZ);
        translate([Wall,MY-DY-Wall,Wall])wood(MZ);
        translate([MX-DX-Wall,MY-DY-Wall,Wall])wood(MZ);
        translate([Wall+DX,Wall,MZO-Wall])rotate([0,90,0])wood(MX-(DX*2)-(Wall*2));
        translate([Wall,Wall+DY,MZO-Wall])rotate([-90,0,0])wood(MY-(DY*2)-(Wall*2));
        translate([Wall+DX,MY-DY-Wall,MZO-Wall])rotate([0,90,0])wood(MX-(DX*2)-(Wall*2));
        translate([MX-DX-Wall,Wall+DY,MZO-Wall])rotate([-90,0,0])wood(MY-(DY*2)-(Wall*2));
        translate([Wall+DX,Wall,MZ-Wall])rotate([0,90,0])wood(MX-(DX*2)-(Wall*2));
        translate([Wall,Wall+DY,MZ-Wall])rotate([-90,0,0])wood(MY-(DY*2)-(Wall*2));
        translate([Wall+DX,MY-DY-Wall,MZ-Wall])rotate([0,90,0])wood(MX-(DX*2)-(Wall*2));
        translate([MX-DX-Wall,Wall+DY,MZ-Wall])rotate([-90,0,0])wood(MY-(DY*2)-(Wall*2));
    }
    union(){ //Bottom and top plates
        translate([Wall,Wall,MZO])BottomPlate();
        translate([Wall,Wall,MZ])BottomPlate();
    }
    union(){ //Upper Brackets
        translate([0,0,MZ+Wall*2])rotate([0,180,-90])UpperBracket();
        translate([MX,0,MZ+Wall*2])rotate([0,180,0])UpperBracket();
        translate([0,MY,MZ+Wall*2])rotate([0,180,180])UpperBracket();
        
        translate([MX,MY,MZ+Wall*2])rotate([0,180,90])UpperBracket();
    }
    union(){ //Side panel supports
        translate([PT,MY*.25,MZO+BT])PanelSupport();
        translate([PT,MY*.75,MZO+BT])PanelSupport();
        translate([MX-PT,MY*.75,MZO+BT])rotate([0,0,180])PanelSupport();
        translate([MX-PT,MY*.25,MZO+BT])rotate([0,0,180])PanelSupport();
        translate([MX*.25,MY-PT,MZO+BT])rotate([0,0,-90])PanelSupport();
        translate([MX*.75,MY-PT,MZO+BT])rotate([0,0,-90])PanelSupport();
        translate([DX+Wall*2,MY*.25,MZ-DY+15+Wall])rotate([-90,0,90])PanelSupportUpper();
        translate([DX+Wall*2,MY*.75,MZ-DY+15+Wall])rotate([-90,0,90])PanelSupportUpper();
        translate([MX-DY-Wall*2,MY*.25,MZ-DY+15+Wall])rotate([-90,0,-90])PanelSupportUpper();
        translate([MX-DY-Wall*2,MY*.75,MZ-DY+15+Wall])rotate([-90,0,-90])PanelSupportUpper();
        translate([MX*.25,MY-DY-Wall*2,MZ-DY+15+Wall])rotate([-90,0,0])PanelSupportUpper();
        translate([MX*.75,MY-DY-Wall*2,MZ-DY+15+Wall])rotate([-90,0,0])PanelSupportUpper();
    }
    *union(){ //spacers
        translate([MX/2-DY,0,MZO])rotate([0,90,0])Spacer();
        translate([MX/2-DY,0,MZ])rotate([0,90,0])Spacer();
        translate([MX/2-DY,MY-DY-Wall,MZO])rotate([0,90,0])Spacer();
        translate([MX/2-DY,MY-DY-Wall,MZ])rotate([0,90,0])Spacer();
        translate([0,MY/2+DY,MZO])rotate([0,90,-90])Spacer();
        translate([0,MY/2+DY,MZ])rotate([0,90,-90])Spacer();
        translate([MX-DY-Wall,MY/2+DY,MZO])rotate([0,90,-90])Spacer();
        translate([MX-DY-Wall,MY/2+DY,MZ])rotate([0,90,-90])Spacer();
    }
    *PrinterBlank();
    translate([140,80,133])color("grey")import("C:/OpenSCAD/Enclosure/Prusa_i3_MK2-full_model.stl");
    color("Black")translate([MX/2,MY/2,20+MZ])import("C:/OpenSCAD/Enclosure/PP3DP_standard_spool.STL");
} else if (PMode==2){
    translate([0,0,MZO])rotate([0,180,0])LowerBracket();
} else if (PMode==3){
    translate([0,0,DY+Wall*4])rotate([0,180,0])UpperBracket();
} else if (PMode==4){
    PanelSupport();
} else if (PMode==5){
    rotate([0,-90,0])PanelSupportUpper();
}