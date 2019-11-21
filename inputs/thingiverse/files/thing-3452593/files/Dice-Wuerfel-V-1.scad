$fn=20;
difference(){
    intersection(){
        translate([20,20,20]) sphere(r=28);
        cube(40);
    };

    union(){
    //Lochradius
    rk=3;
    // Eins one
        translate([20,20,00]) sphere(r=rk);

    // Zwei two
        translate([40,10,10]) sphere(r=rk);
        translate([40,30,30]) sphere(r=rk);
        
    // Drei three
        translate([10,40,10]) sphere(r=rk);
        translate([30,40,30]) sphere(r=rk);
        translate([20,40,20]) sphere(r=rk);

    // Vier four
        translate([10,0,10]) sphere(r=rk);
        translate([30,0,30]) sphere(r=rk);
        translate([10,0,30]) sphere(r=rk);
        translate([30,0,10]) sphere(r=rk);

    // Fünf five
        translate([0,10,10]) sphere(r=rk);
        translate([0,30,30]) sphere(r=rk);
        translate([0,10,30]) sphere(r=rk);
        translate([0,30,10]) sphere(r=rk);    
        translate([0,20,20]) sphere(r=rk);    
       
        
    // Sechs six
        translate([10,10,40]) sphere(r=rk);
        translate([20,10,40]) sphere(r=rk);
        translate([30,10,40]) sphere(r=rk);
        translate([10,30,40]) sphere(r=rk);
        translate([20,30,40]) sphere(r=rk);
        translate([30,30,40]) sphere(r=rk);

        
    };
};