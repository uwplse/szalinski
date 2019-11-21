//Zippy Impact 3S 1500 mAh 25C
//cells = 3;
//cable_dia = 4;

//GNB 4S 1300 mAh 110C
//cells = 4;
//cable_dia = 4.5;

//Turnigy BOLT 2S HV 500 mAh 65C: 1.75
//cells = 3;
//cable_dia = 4;

/* [Global] */
/* [Battery Specs] */
cells = 3; // [2:8]
cable_dia = 4; // [1:0.1:7]

/* [Optional tunings] */
height = 6.5; // [4:0.5:10]
thickness = 1.3; // [0.7:0.1:2]

/* [Hidden] */
width = 8.2 + 2.5 * (cells - 2);
length = 4.8;
$fn = 48;
steg = 1;

module BalancerMount(){
    difference(){
        hull(){
            for(x = [-thickness, width+thickness])
            for (y = [-thickness, length]) translate([x, y, 0]) circle(0.2);
            translate([width/2-cable_dia/2-steg, length+cable_dia/2+thickness-0.4, 0]){
                for (x = [0, cable_dia+steg*2]) translate([x, 0, 0]) circle(d=cable_dia+thickness*1.5);
            } 
        };
        translate([width/2-cable_dia/2-steg/2, length+cable_dia/2+thickness-0.4, 0]){
            for (x = [0, cable_dia+1]) translate([x, 0, 0]){
                circle(d=cable_dia+0.2);
                translate([-cable_dia/8, 0, 0]) square([cable_dia/4, cable_dia+thickness]);
            };
        }; 
        plug();
    };
};

module plug(){
    square([width,length-0.8]);
    for(x = [1.05, width-2.45]) translate([x, length-0.8, 0]) square([1.4, 0.8]);
};

linear_extrude(height) BalancerMount();