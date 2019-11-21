bottom_od = 60; 
stem_ht = 100;

variant1(); 

module variant1() {
  translate([22,5,-10]){
    cylinder(h=10, d1=80, d2=60); 
  }
  linear_extrude(height = stem_ht, 
     convexity = 10, 
     twist = 320,
     scale = 0.4) {
    translate([22, 5, 0])
    circle(d = bottom_od);
  }


  translate([-45,-10,stem_ht/2]) {
    linear_extrude(height = stem_ht/2, 
     convexity = 10, 
     twist = 90,
     scale = 0.6, 
     slices = 20) {
    translate([30, 0, 0])
    circle(d = bottom_od/2);
  }
  }

  translate([5,6,stem_ht]) {
    cylinder(h=15, d1=24,d2=60);
  }

  translate([-45,-28,stem_ht]) {
    cylinder(h=15, d1=20,d2=60);
  }
}


module variant2() {
    linear_extrude(height = stem_ht, 
     convexity = 10, 
     twist = 320,
     scale = 0.4) {
    translate([22, 5, 0])
    circle(d = bottom_od);
  }


  translate([-45,-10,stem_ht/2]) {
    linear_extrude(height = stem_ht/2, 
     convexity = 10, 
     twist = 90,
     scale = 0.6, 
     slices = 20) {
    translate([30, 0, 0])
    circle(d = bottom_od/2);
  }
  }

  translate([22,5,-10]){
    cylinder(h=10, d1=80, d2=60); 
  }
  
  translate([5,6,stem_ht+10]) {
    scale([1,1,0.6]) sphere(25);
  }
  translate([-45,-28,stem_ht+10]) {
    scale([1,1,0.6]) sphere(25);
  }
}