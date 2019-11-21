length = 40;
width = 20;

moldHeight = length + 3;
moldWidth = width + 4;
moldLength = 7 + 4;

coreHeight = length - 3;
coreWidth = width - 5;
coreLength = 1 + 1;

union() {

translate([(moldWidth/2)-(coreWidth)/2,moldLength-5.5,3]) {
cube([coreWidth,coreLength,coreHeight]);
}

difference() {
cube([moldWidth,moldLength,moldHeight]);

translate([2,2,3]) {
cube([width,7,length]);
}
}
}