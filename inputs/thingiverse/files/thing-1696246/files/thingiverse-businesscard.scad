/*

Business Card + Subdivision

Fernando Jerez

*/

/*
Random seed for testing in OpenSCAD
seed=round(rands(1,100000,1)[0]);
echo(seed);
*/

// preview[view:south, tilt:top]
//
//Upper text
title="Your name here";
// Footer text
description="thingiverse.com/user";
// Include the Thingiverse's logo?
logo = "Yes"; //[Yes:Yes. I'm proud to be on thingiverse, No:No. Better without logo]

// for random pattern generation (every seed has unique results)
seed= 123456789;


/* [Hidden] */
random = rands(0,1,3000,seed);

gr = 2;
stop = 8;
 
w = 85.60;
h = 54;

$fn = 50;



/*********************************/ 
 
 difference(){
    union(){
    linear_extrude(height=1){
    difference(){
        squareRounded(w,h,3);
        square([78,38],center=true);
    }
        difference(){
            squareRec(78,38,1);
            if(logo=="Yes"){ circle(8); }
        }
        if(logo=="Yes"){
            difference(){
                circle(8.1);
                translate([0,3]) square([7,2],center=true);
                translate([0,0]) square([2,8],center=true);
            }
        }
    }
    }
        
    

// Text
    union(){
        translate([0,0,0.4]){
            linear_extrude(height=0.8){
                translate([0,20,0])
                    text(text = str(title),size = 5, font="Montserrat:style=Regular",halign = "center");
                translate([0,-24,0])
                    text(text = str(description),size = 4, font="Montserrat:style=Regular",halign = "center");
    
                if(logo=="Yes") { ring(7,1);}
            }
        }
    }
}





module squareRounded(w,h,r){
    w1 = 0.5*w-r;
    h1 = 0.5*h-r;
    union(){
        translate([-w1,-h1,0]) circle(r);
        translate([-w1,h1,0]) circle(r);
        translate([w1,h1,0]) circle(r);
        translate([w1,-h1,0]) circle(r);
        square([w-2*r,h],center=true);
        square([w,h-2*r],center=true);
    }
}

/* Recursive modules */
module squareRec(w,h,ran){
    squarering(w,h,gr);
    if(w>=stop && h >=stop){
        opc = opcion(1,3,ran);
        if(opc==1){
            // Divide Horizontal
            translate([(w-gr)/4,0,0]) squareRec((w+gr)/2,h,ran+1);
            translate([-(w-gr)/4,0,0]) squareRec((w+gr)/2,h,ran+2);
        }else if(opc==2){
            translate([0,(h-gr)/4,0]) squareRec(w,(h+gr)/2,ran+3);
            translate([0,-(h-gr)/4,0]) squareRec(w,(h+gr)/2,ran+4);
        }else if(opc==3){
            // ring + 2 side rects
            r = min(w,h)*0.5;
            if(w>h){
                translate([r+ (w-h-gr)*0.25,0,0]) squareRec((w-h+gr)*0.5,h,ran+5);
                translate([-(r+(w-h-gr)*0.25),0,0]) squareRec((w-h+gr)*0.5,h,ran+6);
            }else{
                translate([0,r+ (h-w-gr)*0.25,0]) squareRec(w,(h-w+gr)*0.5,ran+7);
                translate([0,-(r+(h-w-gr)*0.25),0]) squareRec(w,(h-w+gr)*0.5,ran+8);
            }
            ringRec(r,ran+9);
            
        }
    }
}

module ringRec(r,ran){
    if(r*2>=stop){
        ring(r,gr);
        
        mgr = gr*0.5;
        opc = opcion(1,4,ran);
        if(opc==1){
            //Reduce
            ringRec((r+mgr)*0.6,ran+1);
            translate([(r)*0.6,-mgr,0]) square([(r)*0.4,gr]);
            translate([-(r),-mgr,0]) square([(r)*0.4,gr]);
            translate([-mgr,(r)*0.6,0]) square([gr,(r)*0.4]);
            translate([-mgr,-(r),0]) square([gr,(r)*0.4]);
            
            rotate([0,0,45]){
                translate([(r)*0.6,-mgr,0]) square([(r)*0.4,gr]);
                translate([-(r),-mgr,0]) square([(r)*0.4,gr]);
                translate([-mgr,(r)*0.6,0]) square([gr,(r)*0.4]);
                translate([-mgr,-(r),0]) square([gr,(r)*0.4]);
            }

        }else if(opc==2){
            // Rombo
            //poly(4,r,gr);
            squareRec(2*(r-mgr)*0.69, 2*(r-mgr)*0.69, ran+5);
        }else if(opc==3){
            // Triangulo
            poly(3,r,gr*1.5);
            ringRec((r-mgr)*0.48,ran+6);
            rotate([0,0,60]) translate([(r)*0.48,-mgr,0]) square([(r)*0.52,gr]);
            rotate([0,0,180]) translate([(r)*0.48,-mgr,0]) square([(r)*0.52,gr]);
            rotate([0,0,300]) translate([(r)*0.48,-mgr,0]) square([(r)*0.52,gr]);
        }else if(opc==4){
            // 6-star
            crossedPoly(3,r,gr*1.5);
            ringRec((r-mgr)*0.48,ran+7);
        }else if(opc==5){
            // 8-star
            crossedPoly(4,r,gr);
            ringRec((r-mgr)*0.7,ran+8);
        }

    }
}


/* FUNCTIONS */
function opcion(a,b,r) = a + floor(0.5+random[r]*(b-a));


/* BASIC FIGURES*/

module crossedPoly(v,r,g){
    union(){
        poly(v,r,g);
        rotate([0,0,360/(v*2)]) poly(v,r,g);
    }
}

module poly(v,r,g){
    difference(){
        circle(r,$fn = v);
        circle(r-g,$fn = v);
    }
}


module squarering(w,h,g){
    difference(){
        square([w,h],center=true);
        square([w-g*2,h-g*2],center=true);
    }
}

module ring(r,g){
    difference(){
        circle(r);
        circle(r-g);
    }
}
