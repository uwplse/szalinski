CxLargura=30;
CxComprimento=60;
CxAltura=15;

caixa();
//tampa();

translate([-15,0,0]){
        trava();    
    
}




module caixa(){
    difference(){
        cube([CxLargura,CxComprimento,CxAltura]);
        translate([2, 2, 2]) {
            cube([CxLargura-4,CxComprimento-4,CxAltura]);
        }
    }
    translate([CxLargura-2,CxComprimento/2-5,2]){
        rotate([0,0,90]){
            difference(){
                cube([10,3,CxAltura-2]);
                translate([1.5,-1,-1]){
                    cube([7,2.5,CxAltura]);
                }
                translate([4,1.4,-1]){
                    cube([2,2.5,CxAltura]);
                }
            }

        }
    }
}

module trava(){
    cube([6.5,1,2]);
    translate([2.75,0,0]){
        cube([1,CxLargura/2,2]);
    }
    translate([3.25,CxLargura/2,0]){
        rotate([90,0,90]){
            $fn=64;
            intersection() {
                circle(r=2);
                square(2);
                //rotate(90) square(2);
            }
        }

    }

}
