// název, díra, obvod
batteries=[
["9V",[18,26,20],[18.5,26.5]],
["1S3.7",[6.5,12.5,20],[7.5,13]]
];

width=114;

space = 7;

function height(i) = batteries[i][1][1] + space + ( i>0 ? height(i-1) : 0 );

function maxsize(i) = max(batteries[i][1][2], (i>0 ? maxsize(i-1) : 0));

module row(battery) {
    translate([0,space-battery[2][1]+battery[1][1],-1.5]) linear_extrude(3) text(battery[0], size=space-3, valign="top");
    for(i=[0:(battery[2][0]):(width-battery[2][0])]){
        translate([i+battery[2][0]-battery[1][0],space,-battery[1][2]+.1]) cube(battery[1]);
    }
}

difference() {
    height = maxsize(len(batteries)-1);
    cube([width, height(len(batteries)-1), height]);
    for (i = [0:len(batteries)-1]) {
        battery = batteries[i];
        translate([0, height(i)-battery[2][1]-space, height])  row(battery);
    }
}