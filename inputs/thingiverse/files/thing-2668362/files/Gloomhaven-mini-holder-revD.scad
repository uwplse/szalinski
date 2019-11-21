// Written by xoque (mwifall@gmail.com)
/**************************************
Gloomhaven miniature holder with condition tile holders

I created this so we could see what conditions our characters had while viewing the game board.  I would always forgot to look at my character mat to look for conditions.  I found that the diameter of the miniature bases have small differences, and I had to adjust them slightly to get them to work well, otherwise it was too loose.

**************************************/

// This is the diameter of the inner cylinder
// 27 worked well for SpellWeaver
// 26.6 worked well for me for the Brute
MiniDiameter=27;

// Hexagon Diameter
HexDiameter=38.1;
// Length of half the hexagon from end to end
HexHalfLength=sqrt((pow(HexDiameter,2))-(pow(HexDiameter/2,2)));
// Hexagon Height
HexHeight=7;
HexBaseHeight=3;

// Condition Cutout
CutoutHeight=3;
ConditionLength=15;

difference() {
    
    union() {
        //The Base Hexagon
        cylinder(h=HexHeight,r=HexDiameter/2,$fn=6);
        //The condition holders
        rotate([0,0,-60]) {
            translate([-HexDiameter/4+(HexDiameter/4-ConditionLength/2),sqrt(pow(HexDiameter/2,2)-pow(HexDiameter/4,2))-3,HexHeight-CutoutHeight]) {
                color("red")
                    cube([ConditionLength,2,CutoutHeight]);
        }
    }
}
    translate([-0.8,-1.2,HexBaseHeight])
        cylinder(h=HexHeight-HexBaseHeight,d=MiniDiameter,$fn=100);
    translate([-HexDiameter/4+(HexDiameter/4-ConditionLength/2)-1,sqrt(pow(HexDiameter/2,2)-pow(HexDiameter/4,2))-3,HexHeight-CutoutHeight]) {
        rotate([0,0,0]) {
            color("red")
                cube([ConditionLength,2,CutoutHeight]);
        }
    }
    rotate([0,0,-60]) {
        translate([-HexDiameter/4+(HexDiameter/4-ConditionLength/2)+1,sqrt(pow(HexDiameter/2,2)-pow(HexDiameter/4,2))-3,HexHeight-CutoutHeight]) {
            color("red")
                cube([ConditionLength,2,CutoutHeight]);
            }
    }
}



