//
//  7Segment display by D. Pruimboom jul-2016
//
Margin=1;       // Wall thickness (not exactly)
HH=8;           // segment height without margin
L=25;           // square part of the segment
LEDS=3;         // nr of leds per segement
LED_Diam=5;     // LED diameter ( i originally used 5mm leds).
WallHeight=30;  // Height of the wall

$fn=40;         // make sure the led-holes are nice and round


module Segment(SegSize=50,SegH=15)
{
    SegH_h=SegH/2;
    SegSize_h=SegSize/2;

    polygon(points=[[-SegSize_h-SegH_h,0],
                    [-SegSize_h,SegH_h],
                    [SegSize_h,SegH_h],
                    [SegSize_h+SegH_h,0],
                    [SegSize_h,-SegH_h],
                    [-SegSize_h,-SegH_h]
                   ]);
}

module SegmentOuter(SegSize=50,SegH=15)
{
    SegH_h=SegH/2;
    SegSize_h=SegSize/2;
    
    left = -SegSize_h-SegH_h-Margin;
    left2 = -SegSize_h-Margin;
    right = SegSize_h+SegH_h+Margin;
    right2 = SegSize_h+Margin;
    top=SegH_h+Margin;
    bottom = -SegH_h-Margin;

    polygon(points=[[left,0],
                    [left2,top],
                    [right2,top],
                    [right,0],
                    [right2,bottom],
                    [left2,bottom]
                   ]);
}


module Seg()
{
    
    difference()
    {
       linear_extrude(height=WallHeight)SegmentOuter(SegSize=L,SegH=HH);
       translate([0,0,2])linear_extrude(Height=WallHeight+10)Segment(SegSize=L,SegH=HH);
        
       for(i=[1:LEDS])
       {
           offs = -(L+HH)/2 + i*((L+HH)/(LEDS+1));
           translate([offs,0,0])cylinder(d=LED_Diam,h=20,center=true);
       } 
       
    }
}

module SevenSegs()
{
   TotalLength=(HH+2*Margin+L);
   TotalHeight=HH+2*Margin;
    
   translate([0,TotalHeight/2,0])
   {
        Seg();
        translate([TotalLength/2,TotalLength/2,0]) rotate([0,0,90])Seg();
        translate([-TotalLength/2,TotalLength/2,0]) rotate([0,0,90])Seg();
        translate([0,TotalLength,0])Seg(); 
        translate([0,2*TotalLength,0])Seg(); 
        translate([TotalLength/2,TotalLength+TotalLength/2,0]) rotate([0,0,90])Seg();
        translate([-TotalLength/2,TotalLength+TotalLength/2,0]) rotate([0,0,90])Seg();
   }
}





   


SevenSegs();
