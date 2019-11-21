
//Corpo_(Body)
corpo_body="abobora_pumpkin"; //[fantasma_ghost, abobora_pumpkin, caveira_skull]

//Nariz_(Nose)
nariz_nose="redondo_round"; //[triangulo_triangle, redondo_round, cobra_snake, nenhum_none]

//Boca_(Mouth)
boca_mouth="dentes_teeth"; //[sorriso_smile, dentes_teeth, quadrados_squares, O]

//Olhos_eyes
olhos_eyes="bravo_angry"; //[bravo_angry, alegre_happy, triste_sad, curioso_curious]

//Quality
$fn=50; //[10:100]

render(){
scale ([0.45,0.45,0.7]){
union(){
//Fantasma contorno
if(corpo_body=="fantasma_ghost"){ 
        scale([0.8,0.9,1]){
        difference(){
            scale ([1.08,1.08,1]){
                hull(){
                    union(){
                        cylinder (10,r=90,center=false);
                        translate ([-90,-90,0]){
                            cube ([180,90,10]);
                        }
                        for (i=[0:1:8]){
                            translate ([20*i,0,0]){
                                translate ([-80,-90,0]){
                                    cylinder (10,r=10,center=false);
                                }
                            }
                        }
                    }
                }
            }
            union(){
                cylinder (10,r=90,center=false);
                translate ([-90,-90,0]){
                    cube ([180,90,10]);
                }
                for (i=[0:1:8]){
                    translate ([20*i,0,0]){
                        translate ([-80,-90,0]){
                            cylinder (10,r=10,center=false);
                        }
                    }
                }
            }
        }

    }
    hull(){
    scale([1,1,0.1]){
        translate([0,0,-10]){
                    scale([0.8,0.9,1]){
        difference(){
            scale ([1.08,1.08,1]){
                hull(){
                    union(){
                        cylinder (10,r=90,center=false);
                        translate ([-90,-90,0]){
                            cube ([180,90,10]);
                        }
                        for (i=[0:1:8]){
                            translate ([20*i,0,0]){
                                translate ([-80,-90,0]){
                                    cylinder (10,r=10,center=false);
                                }
                            }
                        }
                    }
                }
            }
            union(){
                cylinder (10,r=90,center=false);
                translate ([-90,-90,0]){
                    cube ([180,90,10]);
                }
                for (i=[0:1:8]){
                    translate ([20*i,0,0]){
                        translate ([-80,-90,0]){
                            cylinder (10,r=10,center=false);
                        }
                    }
                }
            }
        }

    }
            
    }
}
}
}









//abobora contorno
else if (corpo_body=="abobora_pumpkin"){
    union(){
        difference(){
            difference (){
                scale ([1.08,1.08,1]){
                    scale ([1,1.3,1]){
                        translate ([-62.5,0,0]){
                            union(){
                                for (i=[1:1:4]){
                                    translate ([25*i,0,0]){
                                        cylinder (10,r=50, center=false);
                                    }
                                }
                            }
                        }
                    }
                }
                scale ([1,1.3,1]){
                    translate ([-62.5,0,0]){
                        union(){
                            for (i=[1:1:4]){
                                translate ([25*i,0,0]){
                                    cylinder (10,r=50, center=false);
                                }
                            }
                        }
                    }
                }
            }
            difference (){
                difference(){
                    difference (){
                        translate ([92,70,0]){
                            difference (){
                                cylinder (10,r=100,center=false);
                                cylinder (10,r=90,center=false);
                            }
                        }
                        scale ([1,1.3,1]){
                            translate ([-62.5,0,0]){
                                union(){
                                    for (i=[1:1:4]){
                                        translate ([25*i,0,0]){
                                            cylinder (10,r=50, center=false);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    translate ([10,-100,0]){
                        cube ([400,300,10]);
                    }
                }
                translate ([25,105,0]){
                    cylinder (10, r=30, center=false);
                }
            }
        }
        difference(){ 
                translate ([2.5,0,0]){
                scale ([1.8,1.08,1]){
                    difference (){
                    difference(){
                        difference (){
                            translate ([92,70,0]){
                                difference (){
                                    cylinder (10,r=100,center=false);
                                    cylinder (10,r=90,center=false);
                                }
                            }
                            scale ([1,1.3,1]){
                                translate ([-62.5,0,0]){
                                    union(){
                                        for (i=[1:1:4]){
                                            translate ([25*i,0,0]){
                                                cylinder (10,r=50, center=false);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        translate ([10,-100,0]){
                            cube ([400,300,10]);
                        }
                    }
                    translate ([25,105,0]){
                        cylinder (10, r=30, center=false);
                    }
                }
            }
        }

        difference (){
            difference(){
                difference (){
                    translate ([92,70,0]){
                        difference (){
                            cylinder (10,r=100,center=false);
                                cylinder (10,r=90,center=false);
                        }
                    }
                    scale ([1,1.3,1]){
                        translate ([-62.5,0,0]){
                            union(){
                                for (i=[1:1:4]){
                                    translate ([25*i,0,0]){
                                        cylinder (10,r=50, center=false);
                                    }
                                }
                            }
                        }
                    }
                }
                translate ([10,-100,0]){
                    cube ([400,300,10]);
                }
            }
            translate ([25,105,0]){
                cylinder (10, r=30, center=false);
            }
        }
    }
}
hull(){
    scale([1,1,0.1]){
        translate([0,0,-10]){
                union(){
        difference(){
            difference (){
                scale ([1.08,1.08,1]){
                    scale ([1,1.3,1]){
                        translate ([-62.5,0,0]){
                            union(){
                                for (i=[1:1:4]){
                                    translate ([25*i,0,0]){
                                        cylinder (10,r=50, center=false);
                                    }
                                }
                            }
                        }
                    }
                }
                scale ([1,1.3,1]){
                    translate ([-62.5,0,0]){
                        union(){
                            for (i=[1:1:4]){
                                translate ([25*i,0,0]){
                                    cylinder (10,r=50, center=false);
                                }
                            }
                        }
                    }
                }
            }
            difference (){
                difference(){
                    difference (){
                        translate ([92,70,0]){
                            difference (){
                                cylinder (10,r=100,center=false);
                                cylinder (10,r=90,center=false);
                            }
                        }
                        scale ([1,1.3,1]){
                            translate ([-62.5,0,0]){
                                union(){
                                    for (i=[1:1:4]){
                                        translate ([25*i,0,0]){
                                            cylinder (10,r=50, center=false);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    translate ([10,-100,0]){
                        cube ([400,300,10]);
                    }
                }
                translate ([25,105,0]){
                    cylinder (10, r=30, center=false);
                }
            }
        }
        difference(){ 
                translate ([2.5,0,0]){
                scale ([1.8,1.08,1]){
                    difference (){
                    difference(){
                        difference (){
                            translate ([92,70,0]){
                                difference (){
                                    cylinder (10,r=100,center=false);
                                    cylinder (10,r=90,center=false);
                                }
                            }
                            scale ([1,1.3,1]){
                                translate ([-62.5,0,0]){
                                    union(){
                                        for (i=[1:1:4]){
                                            translate ([25*i,0,0]){
                                                cylinder (10,r=50, center=false);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        translate ([10,-100,0]){
                            cube ([400,300,10]);
                        }
                    }
                    translate ([25,105,0]){
                        cylinder (10, r=30, center=false);
                    }
                }
            }
        }

        difference (){
            difference(){
                difference (){
                    translate ([92,70,0]){
                        difference (){
                            cylinder (10,r=100,center=false);
                                cylinder (10,r=90,center=false);
                        }
                    }
                    scale ([1,1.3,1]){
                        translate ([-62.5,0,0]){
                            union(){
                                for (i=[1:1:4]){
                                    translate ([25*i,0,0]){
                                        cylinder (10,r=50, center=false);
                                    }
                                }
                            }
                        }
                    }
                }
                translate ([10,-100,0]){
                    cube ([400,300,10]);
                }
            }
            translate ([25,105,0]){
                cylinder (10, r=30, center=false);
            }
        }
    }
}
        }
    }
}
}


//Corpo Gato
else if (corpo_body=="gato"){
translate([0,25,0]){
scale([0.85,0.75,1]){
    difference(){
        translate([0,10,0]){
    scale ([1.08,1.12,1]){
    union(){
    difference() {
    cylinder (10,r=110, center=false);
    translate ([-110,0,0]){
    cube ([220,200,10], center=false);
    }
    }
    mirror(v=[1,0,0]){
   linear_extrude (10,center=false){
    polygon (points=[[65,0],[82.5,45],[105,0]], convexity=10);
    }   
}
   linear_extrude (10,center=false){
    polygon (points=[[65,0],[82.5,45],[105,0]], convexity=10);
    }
    }
}
}
  union(){
    difference() {
    cylinder (10,r=110, center=false);
    translate ([-110,0,0]){
    cube ([220,200,10], center=false);
    }
    }
    mirror(v=[1,0,0]){
   linear_extrude (10,center=false){
    polygon (points=[[70,0],[90,50],[110,0]], convexity=10);
    }   
}
   linear_extrude (10,center=false){
    polygon (points=[[70,0],[90,50],[110,0]], convexity=10);
    }
    }
}
}
}
}
    
 
//Corpo caveira
else if (corpo_body=="caveira_skull"){
difference(){
    translate([0,-1.5,0]){
scale([1.08,1.08,1]){
    union(){
    union(){
    difference(){
    cylinder (10,r=90, center=false);
    translate ([-90,-100,0]){
    cube([180,90,10], center=false);
        
}
}
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
mirror (1,0,0){
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
}
}
translate([-40,-80,0]){
cube([80,80,10],center=false);
}
}
}
}
    union(){
    union(){
    difference(){
    cylinder (10,r=90, center=false);
    translate ([-90,-100,0]){
    cube([180,90,10], center=false);
        
}
}
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
mirror (1,0,0){
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
}
}
translate([-40,-80,0]){
cube([80,80,10],center=false);
}
}
}
hull(){
    scale([1,1,0.1]){
        translate([0,0,-10]){
            difference(){
    translate([0,-1.5,0]){
scale([1.08,1.08,1]){
    union(){
    union(){
    difference(){
    cylinder (10,r=90, center=false);
    translate ([-90,-100,0]){
    cube([180,90,10], center=false);
        
}
}
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
mirror (1,0,0){
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
}
}
translate([-40,-80,0]){
cube([80,80,10],center=false);
}
}
}
}
    union(){
    union(){
    difference(){
    cylinder (10,r=90, center=false);
    translate ([-90,-100,0]){
    cube([180,90,10], center=false);
        
}
}
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
mirror (1,0,0){
translate ([-42,0,0]){
cylinder (10,r=50,center=false);
}
}
}
translate([-40,-80,0]){
cube([80,80,10],center=false);
}
}
}
        }
    }
}
}

scale([1,1,0.78]){
//Nariz triangulo
if (nariz_nose=="triangulo_triangle"){
    difference(){
   linear_extrude (10,center=false){
       offset(r=3){
    polygon (points=[[-10,-25],[0,-5],[10,-25]], convexity=10);
    }
}
   linear_extrude (10,center=false){
      
    polygon (points=[[-10,-25],[0,-5],[10,-25]], convexity=10);
   }
}
    }

//Nariz redondo
else if (nariz_nose=="redondo_round"){
    translate ([0,-20,0]){
        difference(){
            
            scale([1,1.3,1]){
            cylinder (10,r=10,center=false);
        }
        translate([2.5,2,0]){
        scale([0.8,0.8,1]){
        scale([1,1.3,1]){
            cylinder (10,r=10,center=false);
        }
    }
    }
    }
}
    
}

//Nariz retangulo
else if (nariz_nose=="retangulo"){
    difference(){
   linear_extrude (10,center=false){
       offset(r=3){
    polygon (points=[[-5,-25],[-5,-5],[5,-5],[5,-25]], convexity=10);
    }
}
   linear_extrude (10,center=false){
      
    polygon (points=[[-5,-25],[-5,-5],[5,-5],[5,-25]], convexity=10);
   }
}
    }

//Nariz fendas
    else if (nariz_nose=="cobra_snake"){
    mirror([1,0,0]){
   linear_extrude (10,center=false){
       offset(r=1){
    polygon (points=[[-7,-25],[-7,-5],[-5.5,-5],[-5.5,-25]], convexity=10);
    }
}
}
 linear_extrude (10,center=false){
       offset(r=1){
    polygon (points=[[-7,-25],[-7,-5],[-5.5,-5],[-5.5,-25]], convexity=10);
    }
}
}

//Boca sorriso
if (boca_mouth=="sorriso_smile"){
    scale([1.1,0.9,1]){
    difference(){
    translate ([0,-10,0]){
    cylinder (10,r=50, center=false);
    }        
    translate ([0,40,0]){
    cylinder (10,r=80, center=false);
    }
}

}
}

//boca dentuco
else if (boca_mouth=="dentes_teeth"){
    difference(){
    difference(){
    scale([1.1,0.9,1]){
    difference(){
    translate ([0,-10,0]){
    cylinder (10,r=50, center=false);
    }        
    translate ([0,40,0]){
    cylinder (10,r=80, center=false);
    }
}

}
translate ([0,-45,0]){
cube ([12,10,10],center=false);
}
}

translate ([-17.6,-40,0]){
    rotate([0,0,-25]){
cube ([12,20,10],center=false);
}
}
}
}


//boca reta
else if (boca_mouth=="quadrados_squares"){
    translate([-24,0,0]){
    for (i=[0:1:4]){
        translate([12*i,0,0]){
     linear_extrude (10,center=false){
       offset(r=1){
    polygon (points=[[-3,-58],[-3,-40],[3,-40],[3,-58]], convexity=10);
    }
}
}
}
}
}
//boca redonda
else if (boca_mouth=="O") {
translate ([10,-45,0]){
    difference(){
    scale ([0.6,0.9,1]){
        cylinder (10,r=15,center=false);
}
scale([0.7,0.7,1]){
    scale ([0.5,1,1]){
        cylinder (10,r=15,center=false);
}
}
    }
}
}
//olho bravo
if (olhos_eyes=="bravo_angry"){
    
    mirror([1,0,0]){
        scale([1.3,1.3,1]){
    translate ([30,10,0]){
    difference(){
    rotate ([0,0,40]){
    difference(){
            cylinder (10,r=20,center=false);
        translate ([-40,0,0]){
            cube ([80,40,10]);
        }

    }
}

    scale ([1,3,1]){
    cylinder (10,r=5,center=false);
    }
}
}
}
}
 scale([1.3,1.3,1]){
    translate ([30,10,0]){
    difference(){
    rotate ([0,0,40]){
    difference(){
            cylinder (10,r=20,center=false);
        translate ([-40,0,0]){
            cube ([80,40,10]);
        }

    }
}

    scale ([1,3,1]){
    cylinder (10,r=5,center=false);
    }
}
}
}
}
//olho alegre
else if (olhos_eyes=="alegre_happy"){
    translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){
    difference(){
    scale([0.7,1,1]){
    cylinder (10,r=20);
       }
       translate([0,-50,0]){
       cylinder(10,r=40);
}
}
translate([-3,-5,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
mirror([1,0,0]){
        translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){
    difference(){
    scale([0.7,1,1]){
    cylinder (10,r=20);
       }
       translate([0,-50,0]){
       cylinder(10,r=40);
}
}
translate([-3,-5,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
}
}

//olho triste
else if (olhos_eyes=="triste_sad"){
    translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){
    difference(){
    scale([0.7,1,1]){
    cylinder (10,r=20);
       }
       translate([0,50,0]){
       cylinder(10,r=40);
}
}
translate([-3,-15,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
mirror([1,0,0]){
        translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){
    difference(){
    scale([0.7,1,1]){
    cylinder (10,r=20);
       }
       translate([0,50,0]){
       cylinder(10,r=40);
}
}
translate([-3,-15,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
}
}

//olho curioso
else if (olhos_eyes=="curioso_curious"){
    translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){

    scale([0.7,1,1]){
    cylinder (10,r=20);
       }

translate([-10,-5,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
mirror([1,0,0]){
        translate([30,5,0]){
        scale([1.2,1.2,1]){
    difference(){
 
    scale([0.7,1,1]){
    cylinder (10,r=20);
       }
translate([10,-5,0]){
scale([0.5,1,1]){
    cylinder (10,r=10);
}
}
}
}
}
}
}
 }
 }
}
//end
}
