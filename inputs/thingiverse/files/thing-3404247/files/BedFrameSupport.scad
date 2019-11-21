// Bed frame support
// plbarrio

// table dimensions
tableWidth  = 120.5;
tableHeight = 8.5;
tableDeep = 55;

// noch radius
notchRadius = 30;

// pin dimensions
pinDiam  = 9;
pinDiam2 = 11;
pinHeight = 2;
pinCount  = 5;
pinGape   =2;
pinIntercenter = 85;
pinCenter = 15;

// Wall thickness
wallThick=2;

// Box
difference (){
    cube ( [tableWidth + 2* wallThick, tableHeight +  2* wallThick, tableDeep + wallThick], center =true);
    translate ([0,0,wallThick])
    cube ( [tableWidth , tableHeight , tableDeep + wallThick ], center =true);
    translate ([0,0,tableDeep /2 ])
        rotate ([90,0,0])
            cylinder (d=notchRadius, h= 2*tableHeight, center = true);
}


//pins
translate([pinIntercenter/2,-(tableHeight/2+ wallThick),-tableDeep/2+pinCenter])
    rotate ([90,0,0])
        pin();
translate([-pinIntercenter/2,-(tableHeight/2+ wallThick),-tableDeep/2+pinCenter])
    rotate ([90,0,0])
        pin();

// modile for pins
module pin(){
    difference () {
        union () {
            for (i = [0:pinCount-1]){
                translate([0, 0, i*pinHeight])
                    cylinder (d1 = pinDiam2, d2 =pinDiam, h=pinHeight);

               
            }
            translate([0, 0, pinCount * pinHeight])
            cylinder (d1 = pinDiam, d2 =0, h=pinHeight*2);
            
        }
        translate([0, 0, pinCount * pinHeight])
            cube ([pinGape,pinDiam2+1,pinDiam2+1], center = true);
    }
}
