bottomtwist = 30;
middletwist = 90;
toptwist = 30;

totalslices = 20;

bottomheight = 15;
middleheight = 80;
topheight = 15;
totalheight = bottomheight + middleheight + topheight;

taper = .75;
outerradius = 26;
outerdist = 3.37849279448;
scaleval = outerradius/outerdist;

vapeheight = 110;
vaperadius = 12.75;
buttonheight = 60;
buttonradius = 15;

cutoutradius = 12;
cutoutoffset = 6;

function computeslices(maxslices,maxheight,height) = (maxslices/maxheight) * height;

module octagon(r = 0)
{
    offset(r) {
    polygon([[1+sqrt(2),1],[1,1+sqrt(2)],[-1,1+sqrt(2)],[-(1+sqrt(2)),1],[-(1+sqrt(2)),-1],[-1,-(1+sqrt(2))],[1,-(1+sqrt(2))],[1+sqrt(2),-1]]);
    }
}

module buttonchannel()
{
translate([0,0,totalheight-buttonheight+.5])
    rotate(90,00,0)
    difference()
    {
    cylinder(h=buttonheight,r=buttonradius);
    union()
    {
    translate([0,-buttonradius,-0.5])
    cube([buttonradius,buttonradius*2,buttonheight+1]);
    
    translate([-buttonradius-1,buttonradius/2,-0.5])
    cube([buttonradius+2,buttonradius/2,buttonheight+1]);

    translate([-buttonradius-1,-buttonradius,-0.5])
    cube([buttonradius+2,buttonradius/2,buttonheight+1]);
    }
}
}

difference()
{
union()
{
//bottom twist
linear_extrude(height = bottomheight,center = false, convexity = 10,twist = bottomtwist,slices = computeslices(totalslices,totalheight,bottomheight) , scale = taper)
scale([scaleval,scaleval,0])
octagon(.25); 

//middle
translate([0,0,bottomheight])
rotate([0,0,-bottomtwist])
linear_extrude(height = middleheight,center = false, convexity = 10,twist = middletwist,slices = computeslices(totalslices,totalheight,middleheight) , scale = 1)
scale([scaleval*taper,scaleval*taper,0])
octagon(.25);

difference(){
//top twist
translate([0,0,totalheight])
rotate([0,180,-bottomtwist-middletwist-toptwist])
linear_extrude(height = topheight,center = false, convexity = 10,twist = toptwist,slices = computeslices(totalslices,totalheight,topheight) , scale = taper)
scale([scaleval,scaleval,0])
octagon(.25);

translate([0,0,totalheight+0.1])
rotate([0,180,-bottomtwist-middletwist-toptwist])
linear_extrude(height = topheight+0.1,center = false, convexity = 10,twist = toptwist,slices = computeslices(totalslices,totalheight,topheight) , scale = taper)    
scale([scaleval+2,scaleval+2,0])
polygon([[1+sqrt(2),1],[1,1+sqrt(2)],[0,0]]);
}
}

union() {
translate([0,0,totalheight+1-vapeheight])
cylinder(h=vapeheight,r=vaperadius);

translate([0,cutoutradius+cutoutoffset,bottomheight+(middleheight/2)])
scale([1,1,2])
sphere(r = cutoutradius, $fn = 50);

translate([0,-cutoutradius-cutoutoffset,bottomheight+(middleheight/2)])
scale([1,1,2])
sphere(r = cutoutradius, $fn = 50);

buttonchannel();
}
}



