// název, tloušťka, průměr
batteries=[
["LR44",11.6,5.4],
["LR1130",11.6,3.1],
["CR1620",16,2],
["CR2025",20,2.5],
["CR2032",20,3.2],
["CR2450",24.5,5],
];

width=65;

space = 7;

wall = 1;

function thickness(b) = .4 + b[2] ;
function diameter(b) = .4 + b[1] ;

function height(i) = batteries[i][1] + space + wall + ( i>0 ? height(i-1) : 0 );

function maxsize(i) = max(batteries[i][1], (i>0 ? maxsize(i-1) : 0));

module row(battery) {
    diameter = diameter(battery);
    thick = thickness(battery);
    translate([wall,space-wall,-1.5]) linear_extrude(3) text(battery[0], size=space-3, valign="top");
    for(i=[0:thick+wall:width-thick-2*wall]){
        translate([i+wall,diameter/2+space,diameter/20]) rotate([0,90,0]) cylinder(d=diameter, h=thick);
    }
}

difference() {
    height = maxsize(len(batteries)-1) / 2;
    cube([width, height(len(batteries)-1), height]);
    for (i = [0:len(batteries)-1]) {
        battery = batteries[i];
        translate([0,height(i) - diameter(battery) - space - wall, height]) row(battery);
    }
}