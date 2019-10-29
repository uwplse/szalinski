moduleMajorDimension = 25.4;
holeSizeFraction = .5;
ecks = 2;
wye = 1;
zed = 3;
$fn = 50;


module singleBlock(){
difference(){
cube ([moduleMajorDimension,moduleMajorDimension,moduleMajorDimension], center=true);
    translate() rotate([0,0,0]) cylinder(d=moduleMajorDimension*holeSizeFraction, h=moduleMajorDimension+.01,center=true);
    translate() rotate([90,0,0]) cylinder(d=moduleMajorDimension*holeSizeFraction, h=moduleMajorDimension+.01,center=true);
    translate() rotate([90,0,90]) cylinder(d=moduleMajorDimension*holeSizeFraction, h=moduleMajorDimension+.01,center=true);
    translate() rotate([0,0,0]) sphere(d=moduleMajorDimension*holeSizeFraction*1.414,center=true);
}

}

for(x=[1:ecks]){
    for(y=[1:wye]){
        for(z=[1:zed]){
            translate([moduleMajorDimension*(x-1),moduleMajorDimension*(y-1),moduleMajorDimension*(z-1)]) singleBlock();
        }
    }
}