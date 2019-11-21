coreArmLength = 50; //[10:50]
coreArmDepth = 5; //[1:10]
coreArmHeight = 5; //[1:10]
armsPerUnit = 4; //[1:15]
unitCount = 12; //[1:25]

module base(rotate=0) {

    rotate([0,0,rotate]){
    cube(size=[coreArmLength,coreArmDepth,coreArmHeight], center=true);
    }
}

module createSpike(step = 10) {
    for (a = [0 : step]) 
    base((180 / step) * a);
}

union() {
for (b = [0 : unitCount]) 
    rotate([(180/unitCount)*b,0,0]){
        translate([0,(coreArmLength/2),0])
        createSpike(armsPerUnit);
    }
};
