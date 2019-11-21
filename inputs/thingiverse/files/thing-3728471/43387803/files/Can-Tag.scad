cantag();
//BEGIN VARIABLES
TAG_TEXT="22 LR";
TEXT_HEIGHT=1;
TEXT_FONT_SIZE=10;
TEXT_FONT="Liberation Sans";
TAG_OUTSIDE_THICKNESS=3;
TAG_OUTSIDE_WIDTH=63.5;
TAG_OUTSIDE_HEIGHT=13;
INWARD_ARM_THICKNESS=1;
INWARD_ARM_DEPTH=3.5;
BACKSIDE_TAB_THINCKNESS=1.5;
BACKSIDE_TAB_DEPTH=2;
BACKSIDE_TAB_GRIP_DEPTH=1;

module cantag(){
rotate([90,0,180]){
//Text
    union(){
        

    translate([TAG_OUTSIDE_WIDTH/2,TAG_OUTSIDE_HEIGHT/2,-TEXT_HEIGHT]){
    mirror([1,0,0])    
    color("blue")
        linear_extrude(height=TEXT_HEIGHT, center=false)
    text(str(TAG_TEXT),size = TEXT_FONT_SIZE, font = TEXT_FONT, valign="center", halign="center");
    }
    
//Base Tag
color("red")
linear_extrude(height=TAG_OUTSIDE_THICKNESS, center=false)
square([TAG_OUTSIDE_WIDTH,TAG_OUTSIDE_HEIGHT]);

//ARM 1
color("lime", 1.0 )
linear_extrude(height=INWARD_ARM_DEPTH+TAG_OUTSIDE_THICKNESS, center=false)
translate([TAG_OUTSIDE_WIDTH,0,0])
square([INWARD_ARM_THICKNESS,TAG_OUTSIDE_HEIGHT]);

//ARM2
color("lime", 1.0 )
linear_extrude(height=INWARD_ARM_DEPTH+TAG_OUTSIDE_THICKNESS, center=false)
translate([-INWARD_ARM_THICKNESS,0,0])
color("lime", 1.0 )
square([INWARD_ARM_THICKNESS,TAG_OUTSIDE_HEIGHT]);

//Backside Tab 1
color("yellow")
translate([-INWARD_ARM_THICKNESS,0,INWARD_ARM_DEPTH+TAG_OUTSIDE_THICKNESS+BACKSIDE_TAB_THINCKNESS])
rotate([-90,0,0])
linear_extrude(height=TAG_OUTSIDE_HEIGHT,center=false)
polygon(points=[[0,0],[0,BACKSIDE_TAB_THINCKNESS],[INWARD_ARM_THICKNESS+BACKSIDE_TAB_GRIP_DEPTH,BACKSIDE_TAB_THINCKNESS],[BACKSIDE_TAB_DEPTH+INWARD_ARM_THICKNESS,BACKSIDE_TAB_THINCKNESS * 0.5]]);

//Backside Tab 2
color("yellow")
translate([TAG_OUTSIDE_WIDTH+INWARD_ARM_THICKNESS,TAG_OUTSIDE_HEIGHT,INWARD_ARM_DEPTH+TAG_OUTSIDE_THICKNESS+BACKSIDE_TAB_THINCKNESS])
rotate([-90,0,180])
mirror([0,0,0])
linear_extrude(height=TAG_OUTSIDE_HEIGHT,center=false)
polygon(points=[[0,0],[0,BACKSIDE_TAB_THINCKNESS],[INWARD_ARM_THICKNESS+BACKSIDE_TAB_GRIP_DEPTH,BACKSIDE_TAB_THINCKNESS],[BACKSIDE_TAB_DEPTH+INWARD_ARM_THICKNESS,BACKSIDE_TAB_THINCKNESS * 0.5]]);
}}
}
