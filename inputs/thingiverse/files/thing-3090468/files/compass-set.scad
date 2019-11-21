//Number of rectangles for approximation of angled section
//Too high of a value takes a long time to render
//200 is a good value, but it still takes a while to render
quality=200;
//Diameter of disk
d=53;
R=d/2;
//Location of the slanted sides, relative to radius
cut1 = 0.32*R;
cut2 = 0.89*R;
cutmid = 0.5*(cut1+cut2);
//Depth of groove
groove=4;
angle = atan(groove/(0.5*(cut2-cut1)));
//Thickness of disk
t=d*0.075;
//To fit an M3 screw with the head
screwHoleTop = 6;
screwHoleBot = 3.2;
nutThickness=2.2;
nutDiameter=5.6;

//Pointer parameters
shaftDiameter = 7.6;//About the diameter of a standard wooden pencil
shaft = 120;
cap=5;
start=12;
screwLength=20;//Remember to leave room for the tip top point out!
screwDiameter=3.5;//Designed for a #6 screw shaft


//Define function for height offset for angled portion of plate
function zoff(x)= 
( 
    x>cut1&&x<cutmid? 
       (x-cut1)*tan(angle)
    : x>cutmid&&x<cut2?       
       (cut2-x)*tan(angle)
    : 0 
);

module part1() {
    difference() {
        cylinder(d=d,h=t,$fn=80);
        translate([cut1,-R,0])
        cube([d,d,t]);
    }
}

module part2() {
    difference() {
        cylinder(d=d,h=t,$fn=80);
        translate([-d+cut2,-R,0])
        cube([d,d,t]);
    }
}

module angleSection() {
    breaks=quality;
    delta=(cut2-cut1)/breaks;
    low = floor(cut1/delta);
    high = ceil(cut2/delta);
    for(i=[low:high]) {
        x = i*delta;
        h=2*sqrt(pow(R,2)-pow(i*delta,2));
        translate([x,-h/2,zoff(x)]) cube([delta,h,t]);
    }
}

module plate(hex=false) {
    difference() {
        union() {
            part1();
            angleSection();
            part2();
        }
        if(hex==false){
            cylinder(d1=screwHoleBot,d2=screwHoleTop,h=t,center=false,$fn=80);
            }
        else{
            union() {
                cylinder(d=screwHoleBot,h=t,center=false,$fn=80);
                translate([0,0,t-nutThickness])
                cylinder(d=nutDiameter,h=nutThickness,$fn=6);
            }
        }
    }
}

module pointer() {
    difference(){
        union() {
            rotate([30,0,0])
            rotate([0,90,0])
            cylinder(h=start,d1=shaftDiameter*0.65,d2=shaftDiameter,$fn=6);
            translate([start,0,0])
            rotate([30,0,0])
            rotate([0,90,0])
            cylinder(h=shaft,d=shaftDiameter,$fn=6);
            translate([shaft+start,0,0])
            rotate([30,0,0])
            rotate([0,90,0])
            cylinder(h=cap,d1=shaftDiameter,d2=shaftDiameter*0.6,$fn=6);
            translate([start+cap+shaft,0,0])
            sphere(d=shaftDiameter*sin(60),$fn=80);
        }
        rotate([0,90,0])
        cylinder(h=screwLength,d=screwDiameter,$fn=80);
    }
}

//Full Set
plate();
translate([d+10,0,0])
plate(hex=true);
translate([-R-(shaft+cap+start-(d+d+10))/2,-R-10,shaftDiameter*sin(60)/2])
pointer();