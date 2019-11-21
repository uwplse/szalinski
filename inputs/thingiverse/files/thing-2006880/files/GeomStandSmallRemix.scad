$fn=100;

*translate(-[ 18.45, 25.08, 70 ])import("GeomStandBig.stl");



//configure     default Vals MacBook Retina 15"
//roundings = 5;  //  5 
//Wall thickness (mm)
wallThick = 5;  // [2:8]

//Angle (Deg)
angleDeg = 35;  // [15:50]

//Deepnes of the base(mm)
baseDeep = 220; // 

//Width of the Stand(mm)
standWidth = 10;// [2:20]

//Spacing of the Hook(mm)
hookSpace = 12; // [5:20]

// Length of the Hook(mm). Zero = No Hook
hookLen = 6;   // [30]

/* [Hidden] */
fudge = 0.1;    //0.1

subDivs = 6;

surfaceLen = cos(angleDeg) * baseDeep;
topXCord = pow(surfaceLen,2)/baseDeep;
topYCord = sqrt((baseDeep-topXCord)*topXCord);


fieldWdth = (surfaceLen-(subDivs-1)*wallThick)/subDivs;
echo(surfaceLen,fieldWdth);
echo(norm([ 144.02, 100.45, 5.00 ]));

// triangle calculations
// tan alpha = GK/AK
// cos alpha = AK/HYP
// sin alpha = GK/HYP
// b²=c*q
// a²+b²=c²
dFieldWdth = fieldWdth*2+wallThick; //double field width (adjactence side)
GK = tan(angleDeg)*fieldWdth; //opposite width of triangle to remove

dGK = tan(angleDeg)* dFieldWdth; //opposite width of the large triangle
dAK = dFieldWdth;
dHYP = dGK / sin(angleDeg); //hypotenuse width of large triangle

HYP1 = sqrt(pow(fieldWdth,2)+pow(GK,2)); //The hypotenuse of the triangle to remove
HYP2 = wallThick / cos(angleDeg);  //the hypotenuse of the small wall base, width to next triangle
GK2 = sqrt(pow(HYP2,2)-pow(wallThick,2)); //opposite width of the small tri at the base f the wall
GK3 = sin(angleDeg)*wallThick; //opposite width of small tri at the rightmost triangle
AK3 = cos(angleDeg)*wallThick;

GK4 = wallThick-AK3+fudge; //very small Tri at opener
HYP4 = GK4/sin(angleDeg);
AK4 = cos(angleDeg) * HYP4;

AK5 = GK4;
HYP5 = AK5/cos(angleDeg);

Hg = sin(angleDeg)*dFieldWdth;
q = Hg+wallThick/tan(angleDeg);
echo(GK3);
    

//base geometry
//big one
*difference(){
union(){
    hull(){
        cylinder(h=standWidth,r=wallThick, center=true);
        translate ([baseDeep,0,0]) 
            cylinder(h=standWidth,r=wallThick, center=true);
        translate ([topXCord,topYCord,0]) 
            cylinder(h=standWidth,r=wallThick, center=true);
    }

    //get translation for the hook in X dir
    AK=wallThick/tan(angleDeg);

    translate([-AK,-wallThick,-standWidth/2])
        rotate([0,0,angleDeg])       
            hook();
    translate([-AK,-wallThick,-standWidth/2]) 
        cube([AK,wallThick,standWidth]);
}


// now the recesses 
//polys
    //#1
    rotate([0,0,angleDeg]) linear_extrude(height=standWidth+fudge,center=true) polygon([[0,0],[fieldWdth,0],[fieldWdth,-GK]]);
    //#2 (tri+quad)
    translate ([HYP1+HYP2,0,0]) 
        rotate([0,0,angleDeg]) 
        linear_extrude(height=standWidth+fudge,center=true) 
            polygon([[0,0],[0,GK+GK2],[fieldWdth,GK+GK2],[fieldWdth,0],[fieldWdth,-GK]]);
    //#3 (double, opens at bottom)
    //#translate ([(HYP1+HYP2)*2+GK3,-AK3,0]) 
    translate ([(HYP1+HYP2)*2+GK3-AK4,-wallThick-fudge,0]) 
        rotate([0,0,angleDeg]) 
        linear_extrude(height=standWidth+fudge,center=true) 
            polygon([[0,0],[dFieldWdth+AK4,0],[dFieldWdth+AK4,-dGK-HYP5]]);

    //#4 (double)
    translate ([(HYP1+HYP2)*4,0,0]) rotate([0,0,angleDeg]) 
        linear_extrude(height=standWidth+fudge,center=true) 
            polygon([[0,0],[dFieldWdth,0],[dFieldWdth,-dGK]]);
            
//now the rectangles
    recDepth2=2*(GK+GK2);
    //#1
    translate([(HYP1+HYP2)*2,0,-(standWidth+fudge)/2])
        rotate([0,0,angleDeg]) cube([dFieldWdth,(recDepth2-wallThick)/2,standWidth+fudge]);
    //#2
    translate([(HYP1+HYP2)*2,0,-(standWidth+fudge)/2])
        rotate([0,0,angleDeg]) 
            translate([0,(recDepth2-wallThick)/2+wallThick,0])cube([dFieldWdth,(recDepth2-wallThick)/2,standWidth+fudge]);
    //#3
    translate([(HYP1+HYP2)*4,0,-(standWidth+fudge)/2])rotate([0,0,angleDeg]) 
        translate([0,dGK+GK2,0])cube([fieldWdth,recDepth2,standWidth+fudge]);
        
 
    //#4
    translate([(HYP1+HYP2)*5,0,-(standWidth+fudge)/2])rotate([0,0,angleDeg]) 
        translate([0,dGK+GK2+GK+GK2,0])cube([fieldWdth,recDepth2,standWidth+fudge,]);
        
    //#5
    translate([(HYP1+HYP2)*4-GK3,AK3,-(standWidth+fudge)/2]) rotate([0,0,angleDeg]) 
        translate([0,0,0])cube([fieldWdth*2+wallThick,2*GK-GK2,standWidth+fudge,]);
   
    
}
// the small one

    difference(){
        union(){
            hull(){
                cylinder(h=standWidth,r=wallThick, center=true);
                translate ([2*HYP1+HYP2,0,0]) 
                    cylinder(h=standWidth,r=wallThick, center=true);
                rotate([0,0,angleDeg])
                translate ([surfaceLen*(2/subDivs)-wallThick/2,0,0]) 
                    cylinder(h=standWidth,r=wallThick, center=true);
            }

            //get translation for the hook in X dir
            AK=wallThick/tan(angleDeg);

            translate([-AK,-wallThick,-standWidth/2])
                rotate([0,0,angleDeg])       
                    hook();
            translate([-AK,-wallThick,-standWidth/2]) 
                cube([AK,wallThick,standWidth]);
        }
        //#1
        rotate([0,0,angleDeg]) linear_extrude(height=standWidth+fudge,center=true) polygon([[0,0],[fieldWdth,0],[fieldWdth,-GK]]);
        
        //#2 (tri+quad)
        translate ([HYP1+HYP2,0,0]) 
            rotate([0,0,angleDeg]) 
            linear_extrude(height=standWidth+fudge,center=true) 
                polygon([[0,0],[0,GK+GK2],[fieldWdth,GK+GK2],[fieldWdth,0],[fieldWdth,-GK]]);
    }


module hook(){

    union(){
        cube([wallThick,hookSpace+wallThick,standWidth]);
        translate([wallThick,hookSpace+wallThick,0])
            intersection(){
                cylinder(h=standWidth,r=wallThick, center=false);
                translate([-wallThick-fudge,0,-fudge/2]) cube([wallThick+fudge,wallThick+fudge,standWidth+fudge]);
            }
        if (hookLen) translate([wallThick,hookSpace+wallThick,0]) cube([hookLen,wallThick,standWidth]);
        if (hookLen) translate([wallThick+hookLen,hookSpace+wallThick*2,0]) 
            intersection(){
            cylinder(h=standWidth,r=wallThick, center=false);
                translate([0,-wallThick-fudge,-fudge/2]) cube([wallThick+fudge,wallThick+fudge,standWidth+fudge]);
            }
        translate([wallThick*2,2*wallThick,0]) 
            difference(){
                translate([-wallThick-fudge,-2*wallThick,0]) cube([wallThick+fudge,2*wallThick+fudge,standWidth]);
                translate([0,0,-fudge/2]) cylinder(h=standWidth+fudge,r=wallThick, center=false);
            }
    }
}
