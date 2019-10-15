CxLargura=30;
CxComprimento=20;
CxAltura=7;
caixa();
//tampa();
/*
translate([0,20,10]){
    rotate([180,0,0]){
        tampa();    
    }
    
}
*/



     translate([0,CxComprimento+4,0]){
        tampa();    
    }



module caixa(){
    difference(){
        cube([CxLargura,CxComprimento,CxAltura]);
        translate([2, 2, 2]) {
            cube([CxLargura-4,CxComprimento-4,CxAltura]);
        }
        //borda
        translate([1, 1, CxAltura-1.5]) {
            cube([CxLargura-2,CxComprimento-2,CxAltura]);
        }
    }

    translate([CxLargura-7,CxComprimento-7,0]){
        difference(){
            cube([7,7,CxAltura-1.5]);
            //cylinder(r=2.5, h=CxAltura-3, center=false);
            translate([3,3,2]){
                cylinder(r=1.5, h=CxAltura-1, center=false);
            }
        }
    }
    translate([0,0,0]){
        difference(){
            cube([7,7,CxAltura-1.5]);
            //cylinder(r=2.5, h=CxAltura-3, center=false);
            translate([4,4,2]){
                cylinder(r=1.5, h=CxAltura-1, center=false);
            }
        }
    }

}

module tampa(){

    difference(){
        cube([CxLargura,CxComprimento,3]);
        //furos 
        
        translate([4,CxComprimento- 4,-.5]){
            cylinder(r=1.5, h=4, center=false);
        }

        translate([CxLargura-4,4,-.5]){
            cylinder(r=1.5, h=4, center=false);
        }

        //borda negativa
        
        translate([-1.15,-1.15,1.5]){
            difference(){
                cube([CxLargura+2,CxComprimento+2,2]);
                translate([2.15,2.15,-2]){
                    cube([CxLargura-2.30,CxComprimento-2.30,5]);
                }

            }

        }

        
    }
    
}