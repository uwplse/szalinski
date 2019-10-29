$fn=50;

/* [Washer Diameter (OD)] */
outerdia = 5;  // [0:0.1:100]
/* [Washer hole Diameter (ID)] */
innerdia = 3;  // [0:0.1:100]
/* [Washer height] */
height = 2; // [0.1:0.1:20]
/* [Number washers across] */
across = 5; // [1:1:100]
/* [Number washers down] */
down = 4; // [1:1:100]


module washer (height)
{
difference() {
    cylinder (h=height,d=outerdia);
    translate([0,0,-.5]) cylinder (h=height+1,d=innerdia);
    }
}


for (a =[1:across]) {
    for (b =[0:down-1]) {    
        translate([(a-1)*1.1*outerdia+outerdia/2 ,b*1.1*outerdia+outerdia/2,0]) washer (height);
    }
}
