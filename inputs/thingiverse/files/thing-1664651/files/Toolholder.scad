d = [2.5,3,3.5,2.3,4]; 
thickness = 6;
thicknessBoard = 8;
overUp = 10;
overDown = 8;
attachment = "H";// H or V

dn = len(d);
dMax = max(d);

width = (dMax + 2) * 6; 
breit = dMax + 6;


difference(){
    cube([breit, width ,thickness]);
    
    for (i = [0 : dn - 1])
    {
        translate([breit/2, (width/(dn+1))* (i + 1) ,0])
            cylinder(d = d[i], h = thickness, $fn=30);
    }
}

if (attachment == "H") 
{
translate([-(overUp + thickness),0,0])
    cube([overUp + thickness, width ,thickness]);

translate([- (overDown + thickness),0,-(thickness+thicknessBoard)])
    cube([overDown + thickness, width ,thickness]);

translate([-(thickness),0,-(thicknessBoard)])
    cube([thickness, width ,thicknessBoard]);
}
if (attachment == "V") 
{
translate([-thickness,0,-overDown])
    cube([ thickness, width ,overDown + thickness]);

translate([-(2*thickness + thicknessBoard),0,-overUp])
    cube([ thickness, width ,overUp + thickness]);
translate([-(thickness + thicknessBoard),0,0])    
    cube([thicknessBoard, width ,thickness]);

}

