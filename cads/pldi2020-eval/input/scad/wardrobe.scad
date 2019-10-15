//import("/Users/cnandi/research/reincarnate/src/ocaml/phase2/infer/benchmarks/finalbenches/wardrobe/stunning_kieran-amberis.stl");

union() {

difference() {
    translate([0, 11, 0]) {
    scale([50, 50, 1])
    cylinder($fn = 60);
    }

    translate([0, 11, 0]) {
    scale([33, 33, 1])
    cylinder($fn = 55);
    }
}

union () {
    translate([-35, 46, 0]) {
    scale([17, 0.5, 17])
    cube();
    }

    translate([-45, 29, 0]) {
    scale([16, 0.5, 17])
    cube();
    }
    
    translate([-50, 12, 0]) {
    scale([15, 0.5, 17])
    cube();
    }
    
    translate([-45, -5, 0]) {
    scale([16, 0.5, 17])
    cube();
    }
    
    translate([-35, -22, 0]) {
    scale([17, 0.5, 17])
    cube();
    }   
}



difference() {

    translate([-7, -39, 0]) {
    scale([60, 100, 30])
    cube();
    }
   
    translate([-6, -37, 5]) {
    scale([58, 12, 30])
    cube();
    }
    
    translate([-6, -23, 5]) {
    scale([58, 12, 30])
    cube();
    }
    
    translate([30, -9, 5]) {
    scale([22, 12, 30])
    cube();
    }
    
    translate([30, 5, 5]) {
    scale([22, 12, 30])
    cube();
    }

    translate([30, 19, 5]) {
    scale([22, 12, 30])
    cube();
    }

    translate([30, 33, 5]) {
    scale([22, 27, 30])
    cube();
    }
 
    translate([-6, -9, 5]) {
    scale([34, 69, 50])
    cube();
    }  
}

}

