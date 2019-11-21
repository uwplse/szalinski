$fn=40;
clipWidth = 30;
clipLength =30;
clipDepth = 5;
//bottomTrackLength=27;
bottomTrackLength=sqrt(clipWidth*clipWidth+clipLength*clipLength)*.58;

bottomTrackWidth=4;
topTrackWidth=7;

columnWidth=14.8;
//my bed is 8mm thick
//.75 is measured error from first printing
columnHeight=8+.1+.75;
columnDepth=7;

wedgeWidth=columnWidth;
//my glass is 2.25mm thick
wedgeHeight=2.25-.7;
wedgeOverhang=3;
wedgeDepth=columnDepth+wedgeOverhang;

union()
{
    difference()
    {
        difference()
        {
            cube([clipWidth,clipLength,clipDepth],true);
            rotate([0,0,45])
            union()
            {
                translate([0,bottomTrackLength/2,0])
                cylinder(h=5,d=bottomTrackWidth,center=true);
                translate([0,-bottomTrackLength/2,0])
                cylinder(h=5,d=bottomTrackWidth,center=true);
                cube([bottomTrackWidth,bottomTrackLength,5],true);
            }
        }
        rotate([0,0,45])
        translate([0,0,5/2])
        union()
        {
            translate([0,bottomTrackLength/2,0])
            cylinder(h=5,d=topTrackWidth,center=true);
            translate([0,-bottomTrackLength/2,0])
            cylinder(h=5,d=topTrackWidth,center=true);
            cube([topTrackWidth,bottomTrackLength,5],true);
        }
    }

    translate([-clipWidth/2+columnDepth/2,-clipLength/2+columnWidth/2,clipDepth/2+columnHeight/2])
    cube([columnDepth,columnWidth,columnHeight],true);

    translate([clipWidth/2-columnWidth/2,clipLength/2-columnDepth/2,clipDepth/2+columnHeight/2])
    rotate([0,0,90])
    cube([columnDepth,columnWidth,columnHeight],true);
    
    translate([-clipWidth/2+wedgeDepth/2,-clipLength/2+columnWidth/2,clipDepth/2+columnHeight])
    cube([wedgeDepth,wedgeWidth,wedgeHeight],true);
    
    translate([clipWidth/2-columnWidth/2,clipLength/2-wedgeDepth/2,clipDepth/2+columnHeight])
    rotate([0,0,90])
    cube([wedgeDepth,wedgeWidth,wedgeHeight],true);
}


