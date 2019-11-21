/*
|========================================
|                          
|Design:    AngleDivider         
|Made by:   BeeDesign                       
|Date:      05/04/2018
|
|========================================
*/



//Parameters
$fa = 5; $fs = 0.5;
width = 20;
toollengt = 150;
height = 8;
//height of the wings
height_wing = 2.5;
//Screwsize in millimeter
screw = 4; //[3,4,5,6]
//Create a hole for a nut in the centerpart
Centerpart_Nut = false; //[true, false]
//Choose for a loose washer or add a spacer on the wing
Wing_Spacer = false;  //[true, false]



wrench = round(screw * 1.65);
lengt = toollengt-(width/2);
//Renders

translate([0,0,0])bar();
translate([screw,lengt*0.8,0])bar_spacer();
translate([1.5*width,0,0])wing();
translate([3*width,0,0])centerpart();
translate([4.5*width,0,0])wing();
translate([6* width,0,0])bar();
if (Wing_Spacer == false) translate([6.5* width,lengt*0.8,0])wing_washer();
   
//Modules

module centerpart(){
    difference(){
        union(){
            cube([width,lengt,height]);
            translate([width/2,lengt,0])cylinder(height,width/2,width/2);
        }
        //groef
        translate([width/2,10,-0.1])cylinder(height,screw/2,screw/2);
        translate([width/2,lengt*.75,-0.1])cylinder(height,screw/2,screw/2);
        translate([(width -screw)/2,10,-0.1])cube([screw,lengt*.75-10,height]);
        
        //top groef
        translate([width/2,10,height-screw*0.7 ])cylinder(height,wrench/2,wrench/2);
        translate([width/2,lengt*.75,height-screw*0.7])cylinder(height,wrench/2,wrench/2);
        translate([(width -wrench)/2,10,height-screw*0.7])cube([wrench,lengt*.75-10,height]);
        
        //schroefgat
        translate([width/2,lengt,-1])cylinder(height,screw/2.1,screw/2.1);
        if (Centerpart_Nut== true){
            $fn=6;
            translate([width/2,lengt,screw*0.7])cylinder(height,screw,screw);
        }
    }
}

module wing(A){
    difference(){
        union(){
            cube([width,lengt,height_wing]);
           if (Wing_Spacer == true)
                translate([width/2,lengt,0])cylinder(1.5*height_wing,width/2,width/2);
           else
                translate([width/2,lengt,0])cylinder(1*height_wing,width/2,width/2);
           
            translate([width*.75,lengt*.7,0])cylinder(2*height_wing,screw/2,screw/2);
        }
        translate([width/2,lengt,-0.1])cylinder(height,screw/1.95,screw/1.95);
        translate([-.1,-.1,-.1])cube([width/2 + screw,lengt*.1 + screw*2,height]);
        
        translate([width/2 + screw -.1,lengt*.1 + screw*2-.1,height-1])
            rotate([0,180,15])
                cube([width/2 + screw,lengt,height]);
    }
}


module bar(){
    difference(){
        union(){
            cube([width*.5,lengt*.6,height_wing]);
            translate([width/2+.5,screw,0])cylinder(height_wing,screw,screw);
            translate([width*.25,lengt*.6,0])cylinder(height_wing,width*.25,width*.25);
            
        }
        translate([width*.25,lengt*.6,-0.1])cylinder(height,screw/2,screw/2);
        translate([width/2+.5,screw,-0.1])cylinder(height,screw/2,screw/2);
        translate([-1,-1,-0.1])cube([3,3,height]);
        translate([width/2+.5,screw,height_wing/2])cylinder(height_wing,screw*1.1,screw*1.1);
    }
    translate([2,2,0])cylinder(height_wing,2,2);
}

module bar_spacer(){
    difference(){
        union(){
            translate([0,0,0])cylinder(height_wing,screw,screw);
            translate([0,width,0])cylinder(height_wing,screw,screw);
            translate([-screw,0,0])cube([2*screw,width,height_wing]);

            translate([0,0,0])cylinder(height-screw*0.7 +height_wing -.5,screw/2.1,screw/2.1);
            translate([0,width,0])cylinder(height-screw*0.7 +height_wing -.5,screw/2.1,screw/2.1);
            translate([-screw/2.1,0,0])cube([2*screw/2.1,width,height-screw*0.7 +height_wing -.5]);
        }
        translate([0,width/2,-0.01])cylinder(height,screw/1.9,screw/1.9);
    }
}
// height - (height-screw*0.7)      width/2 + screw
module wing_washer(){
    difference(){
        cylinder(height_wing,width/2,width/2);
        translate([0,0,-0.1])cylinder(height+1,screw/1.9,screw/1.9);
    }
}