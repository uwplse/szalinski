/* 
Polygonal Base & frame
Fernando Jerez    

*/

// preview[view:south, tilt:top]



// Which one would you like to see?
part = "Base"; // [Base:Base,Frame:Frame,Both:Frame & Base]

// number of sides
sides = 6;
// of every side (in mms)
sidelength = 40;
// thickness (in mms)
groove = 1;

// Solid base or Subdivided-pattern base
basefill = "Subdivided"; // [Subdivided:Subdivision pattern, Filled:Solid base]
// Only for subdivided bases. Sets the random sequence for subdivision pattern
seed=1234567890;

/* [Hidden] */
lados = sides;
long_lado=sidelength;
ranura = groove;
borde = 1;
ext = 4;

//seed=round(rands(1,100000,1)[0]);
//echo(seed);
//seed= 92751;
random = rands(0,1,3000,seed);

$fn = 80;
gr = 2;
stop=8;

translate([0,0,0.01]){
     
    if(part=="Base"){
        filledBase(lados,long_lado+ranura,2);
        corners(lados,long_lado+ranura,ext);
    }else if(part=="Frame"){
        base(lados,long_lado+ranura,2);
        corners(lados,long_lado+ranura,ext);
    }else if(part=="Both"){
        sep = 5+ranura+borde*2;
        translate([-sep-radioOut(lados,long_lado),0,0]){
            base(lados,long_lado+ranura,2);
            corners(lados,long_lado+ranura,ext);
        }
    
        translate([sep+radioOut(lados,long_lado),0,0]){
            filledBase(lados,long_lado+ranura,2);
            corners(lados,long_lado+ranura,ext);
        }
    }
       
}



module corners(lados,long,ext){
    rout = radioOut(lados,long);
    difference(){
        base(lados,long,ext+1);
        angulo = 360/lados;
        for(i=[1:lados]){
            rotate([0,0,i*angulo+(180/lados)])
            translate([0,-(long-ext*2)*0.5,0])
            cube([rout,long-ext*2,ext*2]);
        }
    }
}

module arco(radio,ang1,ang2,altura){
    linear_extrude(altura){
        polygon([[0,0],[radio*cos(ang1),radio*sin(ang1)],[radio*cos(ang2),radio*sin(ang2)]]);
    }
}

module base(lados, long,altura){
    difference(){
    // Anillo para la base
    ringBase(lados,long,altura,borde*2+ranura);
    // Anillo para la ranura
    translate([0,0,1])
    ringBase(lados,long,altura,ranura);
    }
    
    
}

module filledBase(lados, long,altura){
    base(lados, long,altura);
    
    rin = radioIn(lados,long) - (borde*2+ranura)*0.5;
    lado1 = 2*(rin) * tan(180/lados);
    
    difference(){
        cylinder(r = radioOut(lados,lado1),h=1,$fn = lados);
        translate([0,0,-0.005])
            cylinder(r = radioOut(lados,lado1)-2,h=1.01,$fn = lados);
    }
    intersection(){    
        linear_extrude(height=1){
            if(basefill=="Subdivided"){
                union(){
                    rotate([0,0,180/lados])
                    squareRec(2*radioOut(lados,long),2*radioOut(lados,long),1);
                }
            }else{
                cylinder(r = radioOut(lados,lado1)-2,h=1.01,$fn = lados);
            }
        }
        translate([0,0,-0.005])
            cylinder(r = radioOut(lados,lado1)-2,h=1.01,$fn = lados);
    }
    
}

module ringBase(lados,long,altura,grosor){
    rin = radioIn(lados,long);
    lado1 = 2*(rin-grosor*0.5) * tan(180/lados);
    lado2 = 2*(rin+grosor*0.5) * tan(180/lados);
    difference(){
        cylinder(r = radioOut(lados,lado2),h=altura,$fn = lados);
        translate([0,0,-0.005])
            cylinder(r = radioOut(lados,lado1),h=altura+0.01,$fn = lados);
    }
}


// radio de la circunferencia inscrita (apotema) a un poligono regular conociendo el numero y longitud de los lados
function radioIn(numlados,lado) = let(alfa = 180/numlados, ap = lado / (2*tan(alfa)) ) ap;
// radio de la circuferencia circunscritaa un poligono regular conociendo el numero y longitud de los lados
function radioOut(numlados,lado) = let(ap=radioIn(numlados,lado), r = ap / cos(180/numlados) ) r;

/****************

Subdivision modules

****************/


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