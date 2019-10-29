$fn=50;

/* [Washer Diameter (OD)] */
outerdia = 5;  // [0:0.1:100]
/* [Washer hole Diameter (ID)] */
innerdia = 3;  // [0:0.1:100]

module washer (height)
{
difference() {
    cylinder (h=height,d=outerdia);
    translate([0,0,-.5]) cylinder (h=height+1,d=innerdia);
    }
}


for (a =[0.1:0.1:0.5]) {
    for (b =[0:3]) {    
        translate([(a-0.1)*11*outerdia+outerdia/2,b*1.1*outerdia+outerdia/2,0]) washer (a+(b*0.5));
    }
}
