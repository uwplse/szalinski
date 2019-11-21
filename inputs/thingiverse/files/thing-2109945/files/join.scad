


thickness=1.5;
height=12;
innerwidth=7;
innerdepth=3;

difference()
{
cube([innerwidth+thickness*2,innerdepth+thickness*2,height]);
    
translate([thickness,thickness,0]) cube([innerwidth,innerdepth,height]);
}