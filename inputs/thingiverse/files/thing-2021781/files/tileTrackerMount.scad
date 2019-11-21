use <roundedRect.scad>;

seatSupportDiameter = 7.04;//mm

thicknessOfSupport = 3;

TileWidth = 34;


supportDepth = 3.5;

cornerRadius = 5;

cutWidth = 4;//to put on seat support

tileHoleDiameter = 6;
holeOffset = 12;

beepHoleDiameter = 2.5;
beepHoleOffset = 8;

rotate([-90, 90, 90])
difference(){
    union(){
        
        roundedRect([TileWidth-cornerRadius, TileWidth-cornerRadius, supportDepth], cornerRadius, center = true, $fn=100);
        
        difference(){
            union(){
                translate([0, 0, -seatSupportDiameter/2])
                rotate([0, 90, 0])
                cylinder(d = thicknessOfSupport+seatSupportDiameter, h = TileWidth, $fn = 100, center = true);
                cube([TileWidth, thicknessOfSupport+seatSupportDiameter, (thicknessOfSupport+seatSupportDiameter)/2], center = true);
        
            }
            union(){
                translate([0, 0, -seatSupportDiameter/2])
                rotate([0, 90, 0])
                cylinder(d = seatSupportDiameter, h = TileWidth, $fn = 100, center = true);
                
                translate([0, 0, -seatSupportDiameter])
                rotate([0, 0, 0])
                cube([TileWidth, cutWidth, cutWidth], center = true);
                
            }
        }
    }
    
    union(){
        //keychain hole
        translate([holeOffset, -holeOffset, supportDepth/2])
        rotate([0, 0, 0])
        cylinder(d = tileHoleDiameter, h = supportDepth, $fn = 100, center = true);
            
        //beeper
        translate([-beepHoleOffset, -beepHoleOffset, supportDepth/2])
        rotate([0, 0, 0])
        cylinder(d = beepHoleDiameter, h = supportDepth, $fn = 100, center = true);

    }
}
    