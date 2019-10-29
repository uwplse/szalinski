// Threaded ball diameter in mm
ballDiameter = 10; // [8, 10, 12]

// Thickness of the push rod
rodDiameter = 14; // [5:20]

// Total intended push rod length (center to center between ball joints) 
pushRodLength = 288; // [50:400]

// Width of the grub screw
grubScrewDiameter = 4; // [3,4,5]

// Maximum length of the grub screw
grubScrewLength = 20; // [5:50]

// Nut trap distance from rod end
nutTrapOffset = 12; // [4:30]

// Width of the nut trap
nutTrapWidth = 9; 

// Height of the nut trap
nutTrapHeight = 3; 

/* [Hidden] */
lipWidth = 1;
taperLength = 3;
rodSideCount = 6;
nutSideCount = 6;


difference() {
    hull() {
        cylinder(r=lipWidth + ballDiameter/4, h=pushRodLength-ballDiameter, $fn=rodSideCount);  
        translate([0,0,taperLength])
            cylinder(r=rodDiameter/2, h=pushRodLength-ballDiameter-2*taperLength, $fn=rodSideCount);    
    };
    for (i = [[0,0],[pushRodLength-ballDiameter,180]]) {
        translate([0,0,i[0]]) rotate([i[1],0,0]) {
            cylinder(r=grubScrewDiameter/2, h=grubScrewLength, $fn=50);
            translate([0,0,nutTrapOffset])  
                hull() {
                    cylinder(r=nutTrapWidth/2, h=nutTrapHeight, $fn=nutSideCount);
                    translate([0,rodDiameter/2,0]) 
                        cylinder(r=nutTrapWidth/2, h=nutTrapHeight, $fn=nutSideCount);
                };
        }
    };
}