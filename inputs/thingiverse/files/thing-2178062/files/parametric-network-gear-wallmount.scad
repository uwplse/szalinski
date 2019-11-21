//itemwidth
itemwidth = 50;
//itemheight
itemheight = 50;
//itemdepth
itemdepth = 15;

difference() {
    union() {
    translate([0,0,1.5])
        cube([(itemwidth+6),15,3], center=true);
    translate([0,0,1.5]) 
        cube([15,(itemheight+3),3], center=true); 
}
translate([0,(itemheight/3.5),1.5]) 
cylinder(h=3.1,r1=2.5,r2=4.5,center=true);
translate([0,-(itemheight/3.5),1.5]) 
cylinder(h=3.1,r1=2.5,r2=4.5,center=true);
}

translate([((itemwidth/2)+3),-7.5,0])
    cube([3,15,(itemdepth+3)]);
    
translate([-((itemwidth/2)+6),-7.5,0])
    cube([3,15,(itemdepth+3)]);
    
translate([-7.5,-((itemheight/2)+4.5),0])
    cube([15,3,(itemdepth+3)]);
    
translate([-7.5,-((itemheight/2)+4.5),(itemdepth+3)])
    cube([15,6,3]);
    
translate([-(itemwidth/2),-7.5,(itemdepth+3)])
rotate(90)
    cube([15,6,3]);
    
translate([(itemwidth/2)+6,-7.5,(itemdepth+3)])
rotate(90)
    cube([15,6,3]);
    
    