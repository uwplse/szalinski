/*

2D Subdivision
Fernando Jerez

*/


 
/*
// For OpenScad, (not good for thingiverse's customizer). 
Makes a new figure with F5 (inconsistent with render)
seed=round(rands(1,100000,1)[0]);
echo(seed);
*/

// preview[view:south, tilt:top]

// for random sequence. Every seed makes a different figure. 
seed=1234567890;
//initial shape of figure (every one has it's own parameters. See below)
shape = "Rectangle"; // [Circle:Circle, Rectangle:Rectangle, Polygon:Polygon]
// height of figure in mms
extrusion=1;

/* [Rectangle] */
// in mms
width = 80;
// in mms
height = 40;

/* [Circle] */
// in mms
radius = 50;

/* [Polygon] */
// number of sides
sides = 6;
// of every side in mms
sidelength = 40;

/* [Hidden] */
gr = 2; 
stop = 8; 
random = rands(0,1,5000,seed); 
$fn = 100;

linear_extrude(height=extrusion){
    union(){
        
        if(shape=="Polygon"){
            rad = radioOut(sides,sidelength);
            poly(sides,rad,gr);
            intersection(){    
                 squareRec(2*rad,2*rad,1);
                circle(r = rad-2,$fn = sides);
            }
        }else if(shape=="Rectangle") {
            squareRec(width,height,1);
        
        }else if(shape=="Circle") {
            ringRec(radius,1);
        
        }
    }
}

// radio de la circunferencia inscrita (apotema) a un poligono regular conociendo el numero y longitud de los lados
function radioIn(numlados,lado) = let(alfa = 180/numlados, ap = lado / (2*tan(alfa)) ) ap;
// radio de la circuferencia circunscritaa un poligono regular conociendo el numero y longitud de los lados
function radioOut(numlados,lado) = let(ap=radioIn(numlados,lado), r = ap / cos(180/numlados) ) r;


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
    ring(r,gr);
    if(r>=stop){
        
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
