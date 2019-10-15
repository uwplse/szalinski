//cylinder(10,100,100);
module big() {
    for(x =[0:11]){
        translate([0,0,0])
        rotate([0,0,x*30])    
        cube([100,5,10]);   
        
    };

    for(x =[0:11]){
        
        rotate([0,0,x*30])  
        translate([0,-5,0])  
        cube([100,5,10]);   
        
    };
};

module small() {
    for(x =[0:60]){
        translate([0,0,0])
        rotate([0,0,x*6])    
        cube([100,1,10]);   
        
    };

    for(x =[0:60]){
        
        rotate([0,0,x*6])  
        translate([0,-1,0])  
        cube([100,1,10]);   
        
    };
};

module small_diff() {
    difference() {    
        small();
        translate([0,0,-10])
        cylinder(30,90,90);    
    };
};

module big_diff() {
    difference() {    
        big();
        translate([0,0,-10])
        cylinder(30,80,80);    
    };
};

module seconder() {
    translate([-30,-1,11])
    cube([100,2,1]);
    translate([60,0,11])
    cylinder(2,10,10);
    cylinder(12.5,3,3);
};

module seconder_rotate(x) {
    rotate([0,0,x])
    seconder();
    
};

module minuter() {
    translate([-30,-5,10])
    cube([120,10,1]);
};

module minuter_rotate(x) {
    rotate([0,0,x])
    minuter();    
};

module hour() {
    translate([-30,-5,9])
    cube([100,10,1]);
};

module hour_rotate(x) {
    rotate([0,0,x])
    hour();    
};

small_diff();
big_diff();
cylinder(6,100.5,100.5);
seconder_rotate(129);
minuter_rotate(40);
hour_rotate(272);



