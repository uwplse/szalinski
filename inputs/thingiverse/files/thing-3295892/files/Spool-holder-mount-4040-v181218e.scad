dx=225;

difference()
{
    union()
    {
        translate([-40,140,-1]) //feet
        cube([40,40,6]);
        translate([-40,-1,180])
        rotate([-90,0,0])
        cube([40,40,6]);

        translate([-5,5,5])
        rotate([0,90,0])
        difference() //arc
        {
            rotate_extrude(angle=90,convexity = 10, $fn=360) 
            translate([135, 0, 0])
            square([40,5]); 
            translate([0,-200,-0.5])
            cube([200,400,6]); 
            translate([-200,-200,-0.5])
            cube([400,200,6]);
        };

        translate([-10,140,0]) //enforcements
        cube([10,40,10]);
        translate([-10,0,180])
        rotate([-90,0,0])
        cube([10,40,10]);
        
        translate([-9.999,114.601,114.601]) //M8 axle mount
        rotate([0,90,0])
        cylinder(h=5.001,d1=11,d2=40,$fn=80);
        
    };

    #translate([-20,dx/2,-20]) //4040 profiles Y 
    resize([40,dx,40])
    import("item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);

    #rotate([90,0,0]) //4040 profile Z
    translate([-20,dx/2,20]) 
    resize([40,dx,40])
    import("item_0002633_Profile 8 40x40 light_L=20_1.stl", convexity=3);

    translate([-10,185,10]) //enforcements
    rotate([90,0,0])
    cylinder(h=50,r=5,$fn=80);
    translate([-10,10,135])
    rotate([0,0,0])
    cylinder(h=50,r=5,$fn=80);

    #translate([-20,150,-2]) //M5 holes on Z
    rotate([0,0,0])
    cylinder(h=8,d=6,$fn=80);
    #translate([-20,170,-2])
    rotate([0,0,0])
    cylinder(h=8,d=6,$fn=80);
    
    #translate([-20,6,150]) //M5 holes on Y
    rotate([90,0,0])
    cylinder(h=8,d=6,$fn=80);
    #translate([-20,6,170])
    rotate([90,0,0])
    cylinder(h=8,d=6,$fn=80);

    #union() // spool and M8 bolt
    {
        translate([-50,114.601,114.601]) //max spool size 225, excluding bolt height!
        rotate([0,90,0])
        cylinder(h=80,d=225, center=true, $fn=360);

        translate([-50,114.601,114.601]) //M8 axle
        rotate([0,90,0])
        cylinder(h=110,d=8, center=true, $fn=96);
        
        translate([-2,114.601,114.601]) //M8 head, do not change $fn !
        rotate([0,90,0])
        cylinder(h=6,d=15, center=true, $fn=6);
    };



};



