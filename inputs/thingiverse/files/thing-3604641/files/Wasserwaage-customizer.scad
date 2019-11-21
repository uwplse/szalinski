module wasserwaage()
{
    //length of the bubble level in mm
    length=800;
    //widthof the bubble level in mm
    width=22;
    //Desired slope in %
    slope=1; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    fence=2;
    rotate([90,0,0])
{
intersection()
{
    rotate([atan(slope/100),0,0]) cube(length);
    translate([0,0,0]) difference()
    {
        cube([(width+6*fence),50,length*slope/100+10]);
        translate([3*fence,fence,length*slope/100]) cube([width,100,51]);
    }
}
translate([0,42,length*slope/200]) rotate([90,0,270])#linear_extrude(height=0.5) text(str(slope, " % @ ", length, " mm"),size=4);
}
}
wasserwaage();