text = ["Frohe", "Weihnachten"];
font = "Liberation Sans";
depth=1;//max 3
position=[20,0];
side=[1,2];
fontSize=[12,10];
count=3;
fontDepth=depth;
minTextPosition=min(position);
highTextStart=83;

module textModule()
color("red")
for(i = [0 : count-1])
rotate([0,0,360/8*(1/2-side[i])])
translate([24.2-depth, -5, highTextStart-position[i]])
rotate([0,90,0])
linear_extrude(height = fontDepth)
text(text = text[i], font = font, size = fontSize[i]);

module cuttedModel()
color("blue")
difference(){
    import("puzzle-75-15-5-ii-lid.stl", convexity = 7);
    textModule();
}

junkTowerWallSize=0.5;
junkTowerSize=10;
junkTowerInnerSize=junkTowerSize-junkTowerWallSize*2;
junkTowerHeight=highTextStart-minTextPosition;
junkTowerBrimRadius=10;
extruderDistance=34.2;
module junkTower(){
    color("red")
    translate([0,-extruderDistance,0]){
        translate([-junkTowerSize/2,-junkTowerSize/2,0])
        difference(){
            cube([junkTowerSize,junkTowerSize,junkTowerHeight]);
            translate([junkTowerWallSize,junkTowerWallSize,0])
            cube([junkTowerInnerSize,junkTowerInnerSize,junkTowerHeight]);
        }
        cylinder(r1=junkTowerBrimRadius,r2=junkTowerBrimRadius,h=0.5);
    }
}

rotate([0,0,90]){
    //cuttedModel();

    textModule();
    //junkTower();
}