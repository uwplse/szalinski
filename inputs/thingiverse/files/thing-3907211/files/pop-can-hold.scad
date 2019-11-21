//Resolution of model
$fn = 100;
//Specify length of can
height = 100;
//Specify outter radius of can
BottomRadius = 35;
TopRadius = BottomRadius;
//Orientation of can
deg_a = 180;
height2 = height + 20;
smallr = BottomRadius - 10;
height3 = height2 + 5;
height4 = (height3 - height2)/2;
smallerr = smallr - 1;

cut = height + 100;
difference(){
    difference(){
    difference(){
    rotate (a = deg_a, v = [1, 0, 1])
    union(){

       hull(){

//Outtermost body
cylinder(h = height, r1 = BottomRadius, r2 = BottomRadius, center = true);
//Small Lower Lip
cylinder(h = height2, r1 = smallr, r2 = smallr, center = true);
        }
        
difference(){
//Metal Fold
cylinder (h = height3, r1 = smallr, r2 = smallr, center = true);
        
//Subtraction of inner rim
translate([0, 0, height3/2 -2 ]) cylinder (h = height4, r1 = smallerr, r2 = smallerr, center = false);
    

    //end of hull
        }  
//End of Union   
    }
    
    
    //Concave Bottom Subtraction
translate([-height3/2 -10, 0, 0])
    sphere(smallr);
}
//Flattening of Bottom
translate([0,0,-cut/2])
cube([cut, cut, cut], center = true);
}
//hex bolt hole
boltB = 25;
bolth = 80;
boltl = 30;
boltd = 11;
    union(){
    translate([0, 0, boltl-0.1])
    cylinder(h = bolth, r = boltB/2); 
    cylinder(h=boltl, r = boltd/2);}
}
