// created by Christopher Behrmann [3d@cbxy.de] 16.03.2019


//Customizable X-Endstop for prusa i3 alike printers

//What is your rod diameter?
rod_diameter = 8; //[2:12]
//What is the z-distance of your rods?
rod_distance = 45; //[35:55]
//how much inwards do you need the endstop?
depth = 20 ; //[10:30]

//how thick do you need your walls?
thickness = 2; // [1:5]

//which height do you want?
height = 17;  // [15:20]







module tube(inner,wall,height, stick=2){
    union(){
    difference(){
            cylinder(d=inner+2*wall,h=height,$fn=40);
            translate([0,0,-1]) cylinder(d=inner, h=height+2, $fn=40);
            translate([-inner-wall,3,-1]) cube([2*inner+2*wall, inner+wall,height+2]);
    }
    rotate([180,180,0]) translate([-wall,inner/2+0.05,0]) cube([2*wall,stick,height]);//,center=true);
}
}

module connector(length, thickness, height){
    translate([0,0,height/2]) 
    intersection(){
    difference(){
        translate([0,0,0]) cube([length, thickness, height], center=true);
        translate([3,-1,0]) cube([18,4,3],center=true);
        translate([-12,-1]) cube([3,4,height-2], center=true);
        rotate([90,0,0]) translate([-7,5,-thickness+1]) cylinder(d=3.3,h=thickness+2,$fn=40);
        rotate([90,0,0]) translate([12,5,-thickness+1]) cylinder(d=3.3,h=thickness+2,$fn=40);
        rotate([90,0,0]) translate([12,5,-thickness-3]) cylinder(d=7.0,h=thickness+3, $fn=6);
        rotate([90,0,0]) translate([-7,5,-thickness-3]) cylinder(d=7.0,h=thickness+3,$fn=6);    
    }
    scale([1,0.3,1]) cylinder(d=length-2,h=30, center=true);
}
}

    
//start construct here


//!connector(52,5,17)



union(){
    tube(rod_diameter,thickness,height,depth);
    translate([rod_distance,0,0]) tube(rod_diameter,thickness,height,depth);   
    translate([rod_distance/2,-depth-4,0]) connector(rod_distance+2*thickness+2,5,height) ;
}