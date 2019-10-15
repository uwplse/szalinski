// phoneHolderForLamp.scad 

phoneWidth = 72;
phoneThickness = 8;
boltLength = 20;
holderWidth = 40;
holderThickness = 3;
lampDiameter = 150;

negOffset = -1;
lampOffset = sqrt(pow(lampDiameter/2,2)-pow(holderWidth/2,2));
rad = sqrt(pow(phoneWidth/2,2)+pow(phoneWidth/2*1.9,2));

difference() {
    union(){
        // Flat base
        difference() {
            cube ([phoneWidth+boltLength+2, holderWidth, holderThickness]);
            translate([boltLength+phoneWidth/4, holderWidth/2, negOffset])
                cylinder(h = holderThickness+2, r=phoneWidth/8);
            translate([boltLength+3*phoneWidth/4, holderWidth/2, negOffset])
                cylinder(h = holderThickness+2, r=phoneWidth/8);
            translate([boltLength+phoneWidth/2, holderWidth+phoneWidth/2*1.9, negOffset])
                cylinder(h = holderThickness+2, r=rad);
            translate([boltLength+phoneWidth/2, -phoneWidth/2*1.9, negOffset])
                cylinder(h = holderThickness+2, r=rad);
        }
        
        difference() {
            translate([0, 0, holderThickness])
                cube([boltLength, holderWidth, phoneThickness+2]);
            translate([negOffset, holderWidth/2, holderThickness+phoneThickness/2])
                    rotate([0,90,0])
                        cylinder(h = boltLength+2, r=1.5);
            translate([boltLength-2.5, holderWidth/2, holderThickness+phoneThickness/2])
                    rotate([0,90,0])
                        cylinder(h = 3, r=3);
        }
    }
    translate([-lampOffset, holderWidth/2, negOffset])
            cylinder(h = holderThickness+phoneThickness+4, r=lampDiameter/2);
}
translate([phoneWidth+boltLength, 0, holderThickness])
    cube ([2, holderWidth, phoneThickness+2]);

translate([boltLength, 0, holderThickness+phoneThickness])
    cube([2,holderWidth,2]);

translate([boltLength+phoneWidth-2, 0, holderThickness+phoneThickness])
    cube([2,holderWidth,2]);
        
        

