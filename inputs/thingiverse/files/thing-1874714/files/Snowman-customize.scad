render_quality = 100; // [50:draft,80:normal,100:fine]
$fn = render_quality;

headturning = 0; // [-45:45] 

layout = 1; // [1:assembled,2:printing,3:explotion]
if (layout == 1) {
    translate([0,0,35])
    union(){
    rotate([0,0,headturning])
        head();
    upperbody();
    }
    
    lowerbody();
    
    rotate([0,0,headturning])
    translate([0,-16,78])
    rotate([100,0,0])
    sticks();
    
    translate([-27,-10,50])
    rotate([0,-60,25])
    sticks();
    
    translate([27,-10,50])
    rotate([0,60,-25])
    sticks();
} else if (layout == 2) {
    translate([0,0,0])
    union(){
    rotate([0,0,headturning])
        head();
    upperbody();
    }
    
    translate([-55,55,35])
    rotate([180,0,0])
    lowerbody();
    
    translate([-50,0,0])
    rotate([0,0,0])
    sticks();
    
    translate([-60,0,0])
    rotate([0,0,0])
    sticks();
    
    translate([-70,0,0])
    rotate([0,0,0])
    sticks();
} else if (layout == 3) {
    translate([0,0,55])
    union(){
        rotate([0,0,headturning])
        head();
        upperbody();
    }
    
    lowerbody();
    
    rotate([0,0,headturning])
    translate([0,-26,98])
    rotate([100,0,0])
    sticks();
    
    translate([-37,-10,70])
    rotate([0,-60,25])
    sticks();
    
    translate([37,-10,70])
    rotate([0,60,-25])
    sticks();
}

module head(){
    union(){
        difference(){
            translate([0,0,45])
            sphere(d=40);
            
            translate([0,0,45])
            sphere(d=35);      
            
            translate([0,0,15])
            cylinder(r=13,h=20);      
        }
        
        translate([10,-15.8,50])
        rotate([60,80,0])
        balls();
        
        translate([-10,-15.8,50])
        rotate([60,-80,0])
        balls();
    }
}

module upperbody(){
    difference(){
        translate([0,0,0])
        sphere(d=70);
        
        translate([0,0,-35])
        cube(70,true);
        
        translate([0,0,2])
        sphere(d=60);
        
        translate([0,0,15])
        cylinder(r=13,h=20);
    }
    
    translate([0,-34,5])
    rotate([85,0,0])
    balls();
    
    translate([0,-28,20])
    rotate([60,0,0])
    balls();
}
    
module lowerbody(){
    difference(){
        translate([0,0,35])
        sphere(d=70);
        
        translate([0,0,70])
        cube(70,true);
    }
    
    translate([0,-32.3,23])
    rotate([110,0,0])
    balls();
}

module balls(){
    difference(){
        sphere(d=4);
        translate([0,0,-5])
        cube(10,true);
    }
}    

module sticks(){
    cylinder(20,3,0.5);
}
