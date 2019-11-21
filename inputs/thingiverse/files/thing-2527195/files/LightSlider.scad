// Matthew Sparks
// 2017-09-09
//
// units in 1mm
// Slider for fitting Lutron-type dimmer slide switches

knobHeight = 10; // total height of knob
bevelMargin = 0.30; // Determines bezel position relative to height, use 0-0.5

slotWidth = 2; // width of rear slot
slotDepth = 7; // depth of rear slot.  Controls distance from switch panel
slotHeight = 6; // height of rear slot
bumpIndent = 0.25; // size of slot indents to latch onto switch stem
bumpPosition = 3.83; // position of slot indents to latch onto switch stem

$fn = 40;

difference(){
    scale([0.78,0.39,1]){
        minkowski(){
            scale([1,1,1]){
                cylinder(knobHeight-(((bevelMargin)*knobHeight)),10,8,false);
            };
            cylinder(bevelMargin*knobHeight,3,false);
        }
    }

    difference(){
        translate([-(slotWidth/2),-(slotHeight/2),-(slotDepth*0.1)]){
            cube([slotWidth,slotHeight,slotDepth*1.1],false);
        }
        translate([0,(slotHeight/2),(slotDepth-bumpPosition)]){
            rotate([0,90,0]){
                cylinder(slotWidth*1.1,bumpIndent,bumpIndent,true);
            }
        }
        translate([0,-(slotHeight/2),(slotDepth-bumpPosition)]){
            rotate([0,90,0]){
                cylinder(slotWidth*1.1,bumpIndent,bumpIndent,true);
            }
        }
    }
}


