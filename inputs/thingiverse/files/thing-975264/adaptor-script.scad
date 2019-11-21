//Adapter für Spulen-Abroller
//Parametrisch!


$fn=100*1;
//Spool hole diameter
numerical_slider = 27;//[20:60]

//Pizza is very tasty
module pizza(r=3.0,a=30) {
  $fn=64;
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
};


difference(){
    linear_extrude(height=26){
        difference(){
            circle(r=40);
            for(i=[30:120:270]){
                rotate(i)translate([70,0])circle(r=40);
            };
            for(i=[70:120:450]){
                difference(){
                    rotate(i)pizza(30.1,40.2);
                    rotate(i)pizza(19.9,40.2);
                };
            };
        };
    };
    translate([0,0,16])difference(){
        cylinder(r=40,10);
        cylinder(d=numerical_slider,10);
    };
    cylinder(r=8,26);
    cylinder(r1=20,r2=13,5);
};


