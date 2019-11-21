$fn=8;
n=8;

difference()
{
    union()
    {
        translate([0,0,0]) //main tray
        rotate([0,0,0])
        linear_extrude(height=60,scale=98/92,$fn=n)
        difference()
        {
            union()
            {
                square(size=[72,70],center=true);
                square(size=[92,50],center=true);
                translate([-36,-25])
                circle(d=20,center=true,$fn=n);
                translate([36,-25])
                circle(d=20,center=true,$fn=n);
                translate([36,25])
                circle(d=20,center=true,$fn=n);
                translate([-36,25])
                circle(d=20,center=true,$fn=n);
            };
            translate([-36,-25])
            circle(d=16,center=true,$fn=n);
            translate([36,-25])
            circle(d=16,center=true,$fn=n);
            translate([36,25])
            circle(d=16,center=true,$fn=n);
            translate([-36,25])
            circle(d=16,center=true,$fn=n);
            
            translate([-84/3-2.25,-13])
            square(size=[84/3-.5,24],center=true);
            translate([-84/3-2.25,13])
            square(size=[84/3-.5,24],center=true);
            translate([-84/3+1.75,-17])
            square(size=[84/3-8.5,32],center=true);
            translate([-84/3+1.75,17])
            square(size=[84/3-8.5,32],center=true);
            
            translate([84/3+2.25,-13])
            square(size=[84/3-.5,24],center=true);
            translate([84/3+2.25,13])
            square(size=[84/3-.5,24],center=true);
            translate([84/3-1.75,-17])
            square(size=[84/3-8.5,32],center=true);
            translate([84/3-1.75,17])
            square(size=[84/3-8.5,32],center=true);
            
            translate([0,-17])
            square(size=[84/3+1,32],center=true);
            translate([0,17])
            square(size=[84/3+1,32],center=true);
            
        };
        
        difference() //bottom part
        {
            union()
            {
                translate([0,0,-5])
                cube([72,50,10],center=true);
                translate([0,-25,0])
                rotate([0,90,0])
                cylinder(h=72,d=20,center=true,$fn=n);
                translate([0,25,0])
                rotate([0,90,0])
                cylinder(h=72,d=20,center=true,$fn=n);
                translate([-36,0,0])
                rotate([90,0,0])
                cylinder(h=50,d=20,center=true,$fn=n);
                translate([36,0,0])
                rotate([90,0,0])
                cylinder(h=50,d=20,center=true,$fn=n);
                translate([-36,-25,0])
                sphere(d=20,center=true,$fn=n);
                translate([36,-25,0])
                sphere(d=20,center=true,$fn=n);
                translate([-36,25,0])
                sphere(d=20,center=true,$fn=n);
                translate([36,25,0])
                sphere(d=20,center=true,$fn=n);
            };
            
            translate([-84/3+1.9,-13,2])
            cube([84/3-8.5,24,20],center=true);
            translate([-84/3+1.9,13,2])
            cube([84/3-8.5,24,20],center=true);
            translate([84/3-1.9,13,2])
            cube([84/3-8.5,24,20],center=true);
            translate([84/3-1.9,-13,2])
            cube([84/3-8.5,24,20],center=true);
            translate([0,-13,2])
            cube([84/3+1,24,20],center=true);
            translate([0,13,2])
            cube([84/3+1,24,20],center=true);
            
            translate([-84/3+1.9,-25,0])
            rotate([0,90,0])
            cylinder(h=84/3-8.5,d=16,center=true,$fn=n);
            translate([-84/3+1.9,25,0])
            rotate([0,90,0])
            cylinder(h=84/3-8.5,d=16,center=true,$fn=n);
            translate([84/3-1.9,-25,0])
            rotate([0,90,0])
            cylinder(h=84/3-8.5,d=16,center=true,$fn=n);
            translate([84/3-1.9,25,0])
            rotate([0,90,0])
            cylinder(h=84/3-8.5,d=16,center=true,$fn=n);
            translate([0,-25,0])
            rotate([0,90,0])
            cylinder(h=84/3+1,d=16,center=true,$fn=n);
            translate([0,25,0])
            rotate([0,90,0])
            cylinder(h=84/3+1,d=16,center=true,$fn=n);
            
            
            translate([-36,-13,0])
            rotate([90,0,0])
            cylinder(h=24,d=16,center=true,$fn=n);
            translate([-36,13,0])
            rotate([90,0,0])
            cylinder(h=24,d=16,center=true,$fn=n);
            translate([36,-13,0])
            rotate([90,0,0])
            cylinder(h=24,d=16,center=true,$fn=n);
            translate([36,13,0])
            rotate([90,0,0])
            cylinder(h=24,d=16,center=true,$fn=n);
            
            translate([-36,-25,0])
            sphere(d=16,center=true,$fn=n);
            translate([36,-25,0])
            sphere(d=16,center=true,$fn=n);
            translate([-36,25,0])
            sphere(d=16,center=true,$fn=n);
            translate([36,25,0])
            sphere(d=16,center=true,$fn=n);
            
            translate([0,0,5.01])
            cube([92.01,70.01,10],center=true);
        };
    };

    translate([-45,-34,0])
    rotate([90+atan(3/81),0,0])
    {
        for (y =[0:11:60])
            for(x=[9-3*y/80:72/7+y/92:90])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/76/30),d=5,center=true);
        for (y =[5:11:55])
            for(x=[9+72/7/2-3*y/80:72/7+y/92:80])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/76/30),d=5,center=true);
        for (y =[0:11:60])
        {
            translate([9-3*y/80,y,-2])
            rotate([0,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
            translate([81+3*y/80,y,-2])
            rotate([0,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
        };

    };

    translate([-45,0,0])
    rotate([90,0,0])
    {
        for (y =[0:11:60])
            for(x=[-3*y/60:10+y/90:90+3*y/60+0.01])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/76/30),d=5,center=true);
        for (y =[-5.5:11:55])
            for(x=[5-3*y/60:10+y/90:90+3*y/60])
            translate([x,y,0])
            cylinder(h=2.1*(1+3*y/76/30),d=5,center=true);
    };

    translate([-45,34,0])
    rotate([90-atan(3/81),0,0])
    {
        for (y =[0:11:60])
            for(x=[9-3*y/80:72/7+y/92:90])
                translate([x,y,0])
                cylinder(h=2.01*(1+3*y/76/30),d=5,center=true);
        for (y =[5:11:55])
            for(x=[9+72/7/2-3*y/80:72/7+y/92:80])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/76/30),d=5,center=true);
        for (y =[0:11:60])
        {
            translate([9-3*y/80,y,2])
            rotate([180,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
            translate([81+3*y/80,y,2])
            rotate([180,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
        };
    };

    translate([-45.005,-34,0])
    rotate([90-atan(3/62),0,90])
    {
        for (y =[0:11:60])
            for(x=[9-3*y/105:50/4+y/70:70])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/40/30),d=5,center=true);
        for (y =[5:11:55])
            for(x=[9+50/4/2-3*y/105:50/4+y/70:60])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/60/30),d=5,center=true);
        for (y =[0:11:60])
        {
            translate([9-3*y/105,y,2])
            rotate([180,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
            translate([59+3*y/105,y,2])
            rotate([180,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
        };
    };  

    translate([-15.495,-34,0])
    rotate([90-atan(2/123),0,90])
    {
        for (y =[0:11:60])
            for(x=[-3*y/105:68/6+y/105:70])
            translate([x,y,0])
            cylinder(h=2.02*(1+3*y/40/30),d=5,center=true);
        for (y =[-5.5:11:55])
            for(x=[68/6/2-3*y/105:68/6+y/105:70])
            translate([x,y,0])
            cylinder(h=2.02*(1+3*y/60/30),d=5,center=true);
    };
        
    translate([15.505,-34,0])
    rotate([90+atan(2/123),0,90])
    {
        for (y =[0:11:60])
            for(x=[-3*y/105:68/6+y/105:70])
            translate([x,y,0])
            cylinder(h=2.02*(1+3*y/40/30),d=5,center=true);
        for (y =[-5.5:11:55])
            for(x=[68/6/2-3*y/105:68/6+y/105:70])
            translate([x,y,0])
            cylinder(h=2.2*(1+3*y/60/30),d=5,center=true);
    };   

    translate([45.005,-34,0])
    rotate([90+atan(3/62),0,90])
    {
        for (y =[0:11:60])
            for(x=[9-3*y/105:50/4+y/70:70])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/40/30),d=5,center=true);
        for (y =[5:11:55])
            for(x=[9+50/4/2-3*y/105:50/4+y/70:60])
            translate([x,y,0])
            cylinder(h=2.01*(1+3*y/60/30),d=5,center=true);
        for (y =[0:11:60])
        {
            translate([9-3*y/105,y,-2])
            rotate([0,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
            translate([59+3*y/105,y,-2])
            rotate([0,0,0])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
        };
    };  

    translate([36,-25,-9])
    rotate([0,0,90])
    {
        for (y =[0:72/7:80])
            for(x=[0:50/4:55])
            translate([x,y,0])
            cylinder(h=2.01,d=5,center=true);
        for (y =[72/14:72/7:75])
            for(x=[50/8:50/4:55])
            translate([x,y,0])
            cylinder(h=2.01,d=5,center=true);
    };  
            
    translate([-36,-25,5.5])
    rotate([atan(3/81),-atan(3/62),0])
    for (z =[0:11:50])
        rotate([90,0,-45])
        translate([0,z,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);

    translate([-36,25,5.5])
    rotate([-atan(3/81),-atan(3/62),0])
    for (z =[0:11:50])
        rotate([90,0,-135])
        translate([0,z,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);

    translate([36,25,5.5])
    rotate([-atan(3/81),atan(3/62),0])
    for (z =[0:11:50])
        rotate([90,0,135])
        translate([0,z,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);

    translate([36,-25,5.5])
    rotate([atan(3/81),atan(3/62),0])
    for (z =[0:11:50])
        rotate([90,0,45])
        translate([0,z,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);

    translate([-36,-25,0])
    rotate([0,90,0])
    {
        for (z =[72/7/2:72/7:70])
        rotate([90,0,45])
        translate([0,z,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);
        
        for (z =[0:72/7:80])
            for(a=[90,0])
                rotate([90,0,a])
                translate([0,z,7])
                linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
                circle(d = 4.5);
            
        rotate([-45,-135,180])
        translate([0,0,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);
    };

    translate([-36,25,0])
    rotate([0,90,0])
    {
        for (z =[72/7/2:72/7:70])
            rotate([90,0,135])
            translate([0,z,7])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);
        
        for (z =[0:72/7:80])
            for(a=[180,90])
                rotate([90,0,a])
                translate([0,z,7])
                linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
                circle(d = 4.5);
    };


    translate([-36,25,0])
    rotate([90,0,0])
    {
        for (z =[50/8:50/4:55])
            rotate([90,0,-45])
            translate([0,z,7])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);

            for (z =[0:50/4:55])
                for(a=[0,-90])
                    rotate([90,0,a])
                    translate([0,z,7])
                    linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
                    circle(d = 4.5);
        rotate([36,-135,0])
        translate([0,0,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);
    };

    translate([36,25,0])
    rotate([90,0,0])
    {
        for (z =[50/8:50/4:55])
            rotate([90,0,45])
            translate([0,z,7])
            linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
            circle(d = 4.5);

        for (z =[0:50/4:55])
            for(a=[0,90])
                rotate([90,0,a])
                translate([0,z,7])
                linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
                circle(d = 4.5);
        
        rotate([225,45,180])
        translate([0,0,7])
        linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
        circle(d = 4.5);
    };
    translate([36,-25,0])
    rotate([45,135,0])
    translate([0,0,7])
    linear_extrude(height = 4, center = false, convexity = 10, scale=11/9)
    circle(d = 4.5);
    
};


        
