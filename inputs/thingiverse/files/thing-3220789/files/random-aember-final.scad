
// How many parts do you want??
numberOfParts= 1; // [1:20]


//!OpenSCAD
module aember(x,y) {
   translate([x,y]){ 
        mirror([0,0,1]){
          linear_extrude( height=height, twist=0, scale=[scale1, scale2], center=false){
            hull(){
              square([square1, square1], center=true);
              translate([translate2, translate2, 0]){
                square([square2, square2], center=true);
              }
            }
          }
        }
        linear_extrude( height=height, twist=0, scale=[scale3, scale4], center=false){
          hull(){
            square([square1, square1], center=true);
            translate([translate2, translate2, 0]){
              square([square2, square2], center=true);
            }
          }
        }
    }
    square1 = round(rands(6,18,1)[0]);
    square2 = round(rands(6,18,1)[0]);
    height = 3;
    translate2 = round(rands(8,10,1)[0]);
    scale1 = rands(0.65,0.85,1)[0];
    scale2 = rands(0.65,0.85,1)[0];
    scale3 = rands(0.65,0.85,1)[0];
    scale4 = rands(0.65,0.85,1)[0];

}


if(numberOfParts%2==0){
    for(i = [1:(numberOfParts/2)]){
    aember(i*35, 1);
    aember(i*35,1);
    aember(i*35,1);
    for(x = [1:(numberOfParts/2)]){
        aember(i*35, 35);
        aember(i*35, 35);
        aember(i*35,35);
        }
    }
}
else if(numberOfParts!=1){
    for(i = [1:(numberOfParts/2)]){
    aember(i*35, 1);
    aember(i*35,1);
    aember(i*35,1);
    for(x = [1:((numberOfParts/2)+1)]){
        aember(x*35, 35);
        aember(x*35, 35);
        aember(x*35,35);
        }
    }
}
else if(numberOfParts==1){
    aember(35, 1);
    aember(35,1);
    aember(35,1);
}
    

