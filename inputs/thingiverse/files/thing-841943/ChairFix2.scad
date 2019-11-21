//Clip Height
height=30;
//Cylinder diameter
diameter=28.5;
//Clip Thickness
thickness=5;
//Roundness
$fn=256;
//ClipB Padding
clipB_padding=1;

color("blue")clipA();

color("red")translate([thickness*1.5,thickness*1.5,0]) clipB();

module clipA(){
    difference(){
        union(){
            difference(){
                cylinder(d=diameter+(thickness*2),h=height);
                translate([0,0,-1]){cylinder(d=diameter,h=height+2);}
                translate([0,0,-1])cube([diameter+(thickness*2),diameter+(thickness*2),height+2]);
            }
            translate([(diameter+(thickness*2))/2,0,0])cylinder(d=thickness*2,h=height);
            translate([0,(diameter+(thickness*2))/2,0])cylinder(d=thickness*2,h=height);
        }
        //Securing Clip
        translate([diameter/2+thickness,-thickness,-1])cube([thickness,thickness,height+2]);
        translate([-thickness,diameter/2+thickness,-1])cube([thickness,thickness,height+2]);
    }
}

module clipB(){
    difference(){
        translate([(diameter+(thickness*4))/2,0,0])cylinder(d=thickness*2,h=height);
        translate([diameter/2+thickness,0,-1])cube([thickness,thickness,height+2]);
    }
    difference(){
        translate([0,(diameter+(thickness*4))/2,0])cylinder(d=thickness*2,h=height);
        translate([0,diameter/2+thickness,-1])cube([thickness,thickness,height+2]);
    }
    sideLen=diameter/2+thickness*2;
    barLen=sqrt((sideLen*sideLen)+(sideLen*sideLen));
    difference(){
        translate([sideLen/2,sideLen/2,0])rotate([0,0,45])translate([0,-barLen/2,0]){
            cube([thickness*1.5,barLen,height]);
            translate([thickness*1.5/2,0,0])cylinder(d=thickness*1.5,h=height);
            translate([thickness*1.5/2,barLen,0])cylinder(d=thickness*1.5,h=height);
        }
        translate([(diameter+(thickness*2))/2,0,-1])cylinder(d=thickness*2+clipB_padding,h=height+2);
        translate([0,(diameter+(thickness*2))/2,-1])cylinder(d=thickness*2+clipB_padding,h=height+2);
    }
}

//color("grey")translate([0,0,-5])cylinder(d=diameter,h=height+10);