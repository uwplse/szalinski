//CUSTOMIZER VARIABLES



//CUSTOMIZER VARIABLES END



union() {
    difference () {
                cylinder (h = 20, r = 14, $fn = 64);
                translate([0,0,-0.5]);
                cylinder (h = 22, r = 13, $fn = 64);
        }
        union () {
            difference () {
                cylinder (h = 3, r = 14, $fn = 64);
                cylinder (h = 3, r = 9.5, $fn = 64);
            }
        }
           
                  
    }
