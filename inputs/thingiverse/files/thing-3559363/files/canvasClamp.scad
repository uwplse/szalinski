Wall = 3.6;
Radius = 4;
Thinning = 0.15;
Rounding = 2;
PadGeom = [30, 35];
PadAngle = 13;
ClampAcross = 30;
ZigZagPattern = [3.5, -0.5];
PatternAngle = 20;
PatternDepth = 1.4;
MeanderCount = 2;
epsilon = 0.01;

module pad() {
    difference() {
        translate([0,0,-Wall])
            rotate([0,0,180])
                linear_extrude(Wall)
                    hull() {
                        translate([0,-Rounding/2])
                            square(PadGeom - [0, Rounding], center=true);
                        for(i=[0:1])
                            translate([(1-2*i) * (PadGeom.x/2-Rounding), PadGeom.y/2 - Rounding])
                                circle(Rounding);
                    }
        union() {
            linear_extrude(2*PatternDepth, center=true)
                zigzag();
            translate([0,-PadGeom.y/2, Wall])
                rotate([0,90,0])
                    cylinder($fn=4,center=true,r=2*Wall,h=PadGeom.x+Wall);        }
    }
        
    
}

module padV2() {
    PatternTotalSize = ZigZagPattern[0] + ZigZagPattern[1];
    Patterns = [ceil(PadGeom.x/PatternTotalSize), ceil(PadGeom.y/PatternTotalSize)];
    difference() {
        translate([0,0,-Wall]) {
            rotate([0,0,180])
                linear_extrude(Wall-PatternDepth+epsilon)
                    hull() {
                        translate([0,-Rounding/2])
                            square(PadGeom - [0, Rounding], center=true);
                        for(i=[0:1])
                            translate([(1-2*i) * (PadGeom.x/2-Rounding), PadGeom.y/2 - Rounding])
                                circle(Rounding);
                    }
            intersection() {
                for(i=[0:Patterns.x])
                    for(j=[0:Patterns.y])
                        translate([(Patterns.x/2-i)*PatternTotalSize, PadGeom.y/-2 + j*PatternTotalSize, Wall-PatternDepth])
                            rotate([0,0,PatternAngle])
                                cylinder(d1=ZigZagPattern[0], d2=0, h=PatternDepth, $fn=4);
                translate([0,0,Wall/2])
                    cube([PadGeom.x-Wall/2, PadGeom.y-Wall/2, Wall+epsilon], center=true);
                }
            }
        union() {
            translate([0,-PadGeom.y/2, Wall*1.2])
                rotate([0,90,0])
                    scale([1,2,1])
                        cylinder($fn=4,center=true,r=2*Wall,h=PadGeom.x+Wall);        
            }
    }
        
    
}

//padV2();
//cylinder(r1=1,r2=0,$fn=4);

module pipe(din,dout,h) {
    difference() {
        cylinder(d=dout, h=h, center=true);
        cylinder(d=din, h=h+epsilon, center=true);
    }
}

module quarterPipe(din,dout,h) {
    rotate([0,0,-90])
        difference() {
            pipe(din,dout,h);
            translate([0,0,-h/2-epsilon])
                cube([dout,dout,h+2*epsilon]);
        }
}

//quarterPipe(100,120,100);
module chamfer(d,h) {
    rotate([0,0,90])
        difference() {
            cylinder(d=d,h=h,$fn=4,center=true);
            translate([d/4,0])
                cube([d/2,d+epsilon,h+epsilon],center=true);
        }
}

module halfPipe_2d(din, dout, angle=180) {
    r = dout/2+epsilon;
    difference() {
        circle(dout/2);
        union() {
            circle(din/2);
            if (angle > 0) {
                if (angle > 90) {
                    polygon([
                        [0,0],
                        r * [tan((180-angle)/2), 1],
                        r * [1,1],
                        r * [1, -1],
                        r * [tan((180-angle)/2), -1]
                        ]);
                } else {
                    polygon([
                        [0,0],
                        r * [1, tan(angle/2)],
                        r * [1, -tan(angle/2)]
                        ]);                
                }
            }
        }
    }
}

module halfPipe(din, dout, h, angle=180) {
    linear_extrude(h, center=true)
        halfPipe_2d(din, dout, angle);
}
// validation
//a = 360*$t;
//halfPipe(10,12,10,a);
//translate([0,0,-1])
//rotate([0,0,-90])
//color("cyan")
//rotate_extrude(angle=(180-a)/2)
//    polygon([[5,0],[5,1],[6,1],[6,0]]);

module meander(wall, length, N) {
    meanDiam = length / N;
    din = meanDiam - wall/2;
    dout = meanDiam + wall/2;
    
    //(1-(i%2)*2)*meanDiam/2 
    for(i=[0:N-1])
        translate([meanDiam*(i+0.5), 0])
            rotate([0,0,(1-(i%2)*2)*90])
                halfPipe_2d(din, dout);
}

module half(mirrorMeander = false) {
    din=Radius*2;
    dout=din+Wall*1.8;
    translate([0,0,-ClampAcross/2+sin(PadAngle)*PadGeom.y/2])
        rotate([-PadAngle,0,0])
            padV2();
    translate([0,PadGeom.y/2+din/2,-ClampAcross/2-Wall/2])
        rotate([0,-90,0])
            halfPipe(din=din, dout=dout, h=PadGeom.x, angle= 180-PadAngle/2);
    cham = 1.8*Wall;
    translate([0,PadGeom.y/2+Wall/4,-ClampAcross/2-Wall/4])
        rotate([0,90,0])
            rotate([0,0,PadAngle/-2])
            linear_extrude(PadGeom.x, center=true)
                polygon([[0.1*cham,0],[cham*0.9,cham*0.1],[0,-2*cham]]);
    ConnectorGeom = [PadGeom.x, Wall*(1-Thinning), ClampAcross/2+Wall/2+epsilon*2];
    translate([0,PadGeom.y/2+din+(dout-din)/4,-ConnectorGeom.z])
        rotate([0,-90,0])
            linear_extrude(PadGeom.x, center=true) {
                mirror([0,mirrorMeander?1:0,0])
                    meander(Wall*(1-Thinning), ConnectorGeom.z, MeanderCount);
                circle(Wall*0.6);
            }
//        cube(ConnectorGeom, center=true);
}

module main() {
    for(i=[0:1])
    rotate([0,180*i,0])
        half(i==0);
}
$fn = 92;
rotate([0,90,0])
    main();

module zigzag() {
    TotalPatternSize = ZigZagPattern[0] + ZigZagPattern[1];
    NumberOfPatterns = ceil(max(PadGeom) /cos(PatternAngle) / TotalPatternSize) + 1;
    BaseElement = [ZigZagPattern[1], (max(PadGeom)+TotalPatternSize)/cos(PatternAngle)];
    for(j=[0:1])
        for(i=[0:NumberOfPatterns-1])
            translate([TotalPatternSize *(i-NumberOfPatterns/2+0.5),0])
                rotate([0,0,PatternAngle*(1-2*j)])
                    square(BaseElement, center=true);
}