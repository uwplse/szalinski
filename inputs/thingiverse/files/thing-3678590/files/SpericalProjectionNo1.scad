//$fn=100;

//height of lamp
hlamp=60;

intersection(){

difference(){
//outer sphere
translate ([0,0,50])sphere(r = 52.5);
//minus
union() {
    //inner sphere
    translate ([0,0,50])sphere(r = 50);
    //projection
    for (x =[-125:50:125]){
        for (y =[-125:50:125]){
            hull(){
            translate ([0,0,hlamp])sphere(r = 1);
            translate ([x,y,0])cube(size = [33,33,.1], center = true);
            };
            };
        };
    };
};

hull(){
    translate ([0,0,50])sphere(r = 1);
    translate ([0,0,4])cube(size = [650,650,8], center = true);
};

};


cube([40,15,2],center=true);
cube([15,40,2],center=true);
