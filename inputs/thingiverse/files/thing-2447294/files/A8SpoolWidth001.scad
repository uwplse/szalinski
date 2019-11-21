cw=128.3;
ch=29.5;
cd=4.5;

difference()
{
	cube([cw,ch,cd],center=true);
	captivescrew();
	mirror([1,0,0])
    captivescrew();
    
	cube([cw-100,15,cd+1],center=true);
	translate([(cw-100)/2,0,0])
		cylinder(d=15,h=cd+1,center=true);
	translate([-(cw-100)/2,0,0])
		cylinder(d=15,h=cd+1,center=true);    
}

module captivescrew()
{
	translate([cw/2-4.65,-10/2,-cd/2-0.5])
		cube([4.65+1,10,cd+1]);
	translate([cw/2-19,-3.4/2,-cd/2-0.5])
		cube([19,3.4,cd+1]);
	translate([cw/2-(3+4.65+4),-5.7/2,-cd/2-0.5])
		cube([3,5.7,cd+1]);	
}