// Matthew Sparks
// 2019-09-08
//
// SATA/SAS drive tray bracket for SC-743
// replaces Supermicro MCP-220-00092-0B
// units in 1mm

railLength      =   150; // Length of rails
railWidth       =   26.1; // Width of rails
railThickness   =   7.7; // Thickness of rails

railGrooveWidth     =   8.9; // Width of main groove
railGrooveOffset    =   3.1; // Distance of main groove from bottom
railGrooveDepth     =   5.0; // Depth of main groove
railGrooveLength    =   railLength; // Length of main groove

railOtherGrooveWidth    =   9.0; // Width of secondary groove
railOtherGrooveOffset   =   2.4; // Distance of secondary groove from top
railOtherGrooveDepth    =   2.4; // Depth of secondary groove

railToRailInside    =   102.5; // Rail to rail spacing, inside distance

frontDepth      =   25.0; // Depth of front section

frontSlotLength =   30.0; // Length of front airflow slots
frontSlotWidth  =   6.0; // Width of front airflow slots

frontHandleLength   =   80.0; // Length of front handle
frontHandleWidth    =   5.0; // Width of front handle
frontHandleDepth    =   6.0; // Depth of front handle

frontSlotTopOffset      =   2.0; // Distance from top of airflow slots
frontSlotBottomOffset   =   2.0; // Distance from bottom of airflow slots
frontSlotSpacing        =   2.0; // Distance between edges of airflow slots

lightPipeSlotWidth      =   5.0; // Width of divot for light pipe
lightPipeSlotLength     =   20.0; // Length of divot for light pipe 
lightPipeSlotDepth      =   5.0; // Depth of divot for light pipe
lightPipeSlotOffset     =   7.5; // Offset of divot for light pipe

screwHeadDiameter   =   5.0; // Screw head diameter
screwDiameter       =   3.51; // 6-32 screw size
screwFirstToRear    =   27.8; // Distance of rear screws from rear
screwSecondToRear   =   128.8; // Distance of front screws from rear
screwCenterToBottom =   7.0; // Distance of screws from bottom of rails

$fn = 40;

union(){
    // left rail
    difference() {
        // main block
        translate([0,-((railToRailInside+railThickness)/2),0]) {
            rotate([90,0,0]) {
                cube([railLength,railWidth,railThickness],true);
            }
        }
        // main groove
        translate([((railLength-railGrooveLength)/2+0.01),-((((railToRailInside-railGrooveDepth)/2)+railThickness)+0.01),-((railWidth-railGrooveWidth)/2)+railGrooveOffset]) {
            rotate([90,0,0]) {
                cube([railGrooveLength,railGrooveWidth,railGrooveDepth],true);
            }
        }
        // other groove
        translate([((railLength-railGrooveLength)/2+0.01),-((((railToRailInside-railOtherGrooveDepth)/2)+railThickness)+0.01),((railWidth-railOtherGrooveWidth)/2)-railOtherGrooveOffset]) {
            rotate([90,0,0]) {
                cube([railGrooveLength,railOtherGrooveWidth,railOtherGrooveDepth],true);
            }
        }
        // rear screwhole
        translate([(railLength/2)-screwFirstToRear,-((railToRailInside+(railThickness-railGrooveDepth))/2-0.4),-(railWidth/2)+screwCenterToBottom]) {
            union(){
                translate([0,-((railThickness-railGrooveDepth+1)-((screwHeadDiameter-screwDiameter)/2))/2,0]){
                    rotate([270,0,0]) {
                        cylinder((screwHeadDiameter-screwDiameter)/2,screwHeadDiameter/2,screwDiameter/2,true);
                    }
                }
                rotate([90,0,0]) {
                    cylinder(railThickness-railGrooveDepth+1,screwDiameter/2,screwDiameter/2,true);
                }
            }
        }
        // front screwhole
        translate([(railLength/2)-screwSecondToRear,-((railToRailInside+(railThickness-railGrooveDepth))/2-0.4),-(railWidth/2)+screwCenterToBottom]) {
            union(){
                translate([0,-((railThickness-railGrooveDepth+1)-((screwHeadDiameter-screwDiameter)/2))/2,0]){
                    rotate([270,0,0]) {
                        cylinder((screwHeadDiameter-screwDiameter)/2,screwHeadDiameter/2,screwDiameter/2,true);
                    }
                }
                rotate([90,0,0]) {
                    cylinder(railThickness-railGrooveDepth+1,screwDiameter/2,screwDiameter/2,true);
                }
            }
        }
    }
    // right rail
    difference() {
        // main block
        translate([0,(railToRailInside+railThickness)/2,0]) {
            rotate([90,0,0]) {
                cube([railLength,railWidth,railThickness],true);
            }
        }
        // main groove
        translate([((railLength-railGrooveLength)/2+0.01),((((railToRailInside-railGrooveDepth)/2)+railThickness)+0.01),-((railWidth-railGrooveWidth)/2)+railGrooveOffset]) {
            rotate([90,0,0]) {
                cube([railGrooveLength,railGrooveWidth,railGrooveDepth],true);
            }
        }
        // other groove
        translate([((railLength-railGrooveLength)/2+0.01),((((railToRailInside-railOtherGrooveDepth)/2)+railThickness)+0.01),((railWidth-railOtherGrooveWidth)/2)-railOtherGrooveOffset]) {
            rotate([90,0,0]) {
                cube([railGrooveLength,railOtherGrooveWidth,railOtherGrooveDepth],true);
            }
        }
        // rear screwhole
        translate([(railLength/2)-screwFirstToRear,((railToRailInside+(railThickness-railGrooveDepth))/2-0.4),-(railWidth/2)+screwCenterToBottom]) {
            rotate([180,0,0]) {
                union(){
                    translate([0,-((railThickness-railGrooveDepth+1)-((screwHeadDiameter-screwDiameter)/2))/2,0]){
                        rotate([270,0,0]) {
                            cylinder((screwHeadDiameter-screwDiameter)/2,screwHeadDiameter/2,screwDiameter/2,true);
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(railThickness-railGrooveDepth+1,screwDiameter/2,screwDiameter/2,true);
                    }
                }
            }
        }
        // front screwhole
        translate([(railLength/2)-screwSecondToRear,((railToRailInside+(railThickness-railGrooveDepth))/2-0.4),-(railWidth/2)+screwCenterToBottom]) {
            rotate([180,0,0]) {
                union(){
                    translate([0,-((railThickness-railGrooveDepth+1)-((screwHeadDiameter-screwDiameter)/2))/2,0]){
                        rotate([270,0,0]) {
                            cylinder((screwHeadDiameter-screwDiameter)/2,screwHeadDiameter/2,screwDiameter/2,true);
                        }
                    }
                    rotate([90,0,0]) {
                        cylinder(railThickness-railGrooveDepth+1,screwDiameter/2,screwDiameter/2,true);
                    }
                }
            }
        }
    }
    
    // front
    difference(){
        // main piece and handle
        union(){
            translate([-((railLength+frontDepth)/2),0,0]) {
                rotate([0,0,0]) {
                    cube([frontDepth,railToRailInside+railThickness*2,railWidth],true);
                }
            }
            translate([-((railLength+frontHandleDepth)/2+frontDepth),0,0]) {
                rotate([0,0,0]) {
                    cube([frontHandleDepth,frontHandleLength,frontHandleWidth],true);
                }
            }
        }
        // slot for light pipes on front cover
        translate([-((railLength-lightPipeSlotDepth)/2+frontDepth+0.01),-(railToRailInside+lightPipeSlotWidth)/2-railThickness+lightPipeSlotOffset,0]) {
            rotate([0,0,0]) {
                cube([lightPipeSlotDepth,lightPipeSlotWidth,lightPipeSlotLength],true);
            }
        }
        // top slots
        translate([-((railLength+frontDepth)/2),0,(((railWidth-frontSlotWidth)/2)-frontSlotTopOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
        translate([-((railLength+frontDepth)/2),frontSlotLength+frontSlotSpacing,(((railWidth-frontSlotWidth)/2)-frontSlotTopOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
        translate([-((railLength+frontDepth)/2),-(frontSlotLength+frontSlotSpacing),(((railWidth-frontSlotWidth)/2)-frontSlotTopOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
        // bottom slots
        translate([-((railLength+frontDepth)/2),0,-(((railWidth-frontSlotWidth)/2)-frontSlotBottomOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
        translate([-((railLength+frontDepth)/2),frontSlotLength+frontSlotSpacing,-(((railWidth-frontSlotWidth)/2)-frontSlotBottomOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
        translate([-((railLength+frontDepth)/2),-(frontSlotLength+frontSlotSpacing),-(((railWidth-frontSlotWidth)/2)-frontSlotBottomOffset)]) {
            rotate([0,0,0]) {
                cube([frontDepth+1,frontSlotLength,frontSlotWidth],true);
            }
        }
    }
}