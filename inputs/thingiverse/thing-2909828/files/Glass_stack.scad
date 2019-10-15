Larger_diameter=60;
Minor_diameter=50;
$fn = 500;
principale();

module principale(){
    sotto();
    base();
    sopra();
}
module sotto(){
    difference(){
    cylinder(h=3,d=Larger_diameter+5);
     translate([0,0,-1]){cylinder(h=5,d=Larger_diameter+2);}
    }
    }


module base(){
    difference(){
    translate([0,0,3]){cylinder(h=2,d=Larger_diameter+5);}
     translate([0,0,2]){cylinder(h=5,d=Minor_diameter-10);}
  }
} 
module sopra(){
difference(){
    translate([0,0,5]){cylinder(h=3,d=Minor_diameter+5);}
     translate([0,0,4]){cylinder(h=5,d=Minor_diameter+2);}
  }
} 
 