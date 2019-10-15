/*
 All Plastic Yagi Uda Element Holder on
 http://www.thingiverse.com/thing:1997494
 by fpetrac
 
 
*/


/* [EleJoinMode] */
EleType=0; //[1:down, 2:mid, 3:up, 4:all_1, 5:all_2]



/* [Element options] */
//boom diameter
BD=20;
//element diameter
ED=8;
//boom element distance
BED=3;  
//width factor of the part
WidthFactor=1; //[0.7,1,1.2,1.5,2]
//size of the window on element (set to 0 to disable)
WinSpace=0;



/* [Text options] */
Label= "YUEHP"; //text

/* [Plastic Type] */
//Elongation at break factor
PT=1; //[1:PLA, 2:ABS, 3:PETG]

/* [Shape] */
//Shape of Boom (number of edge)
Boom_Shape=32; //[3,4,6,8,16,32,64,128]
//Shape of Element (number of edge)
Elem_Shape=64; //[3,4,6,8,16,32,64,128]
$fn=64; //num of polygons



/* [Main body] */
BEdistance=BD/2+ED/2+BED; //Boom Element distance
MbW=WidthFactor*BD*2; //width of the part
MbH=BD+ED; //heigth of the part
MbL=(BD+ED)+3*BEdistance; // lenght of the part




//Text size incrase of from 0 no text to 14 max size
LabelSize = MbW/12; 
//Spacing on text
LabelSpace = 1.2*1; 



BSnapH=BD/4;
BSnapL=(2*BEdistance+BD)/4;
ESnapH=ED/2;
ESnapL=(2*BEdistance+ED)/4;




module printEle(EleType){
    yB=Ysnap(BSnapL,BSnapH,1);
    if(EleType==1)
        rotate([0,0,-90])translate([-BEdistance/2,0,MbH/2])YUEdown();
    else if(EleType==2)
        rotate([0,0,-90])translate([-BEdistance/2,0,MbH/2-2*yB])YUEmid();
    else if(EleType==3)
       rotate([0,0,-90])translate([BEdistance/2,0,MbW/2])rotate([90,0,0]) YUEup();
    else if(EleType==4)
        Demo(1);
    else if(EleType==5)
        Demo(0);
}
printEle(EleType);
module Demo(type=1){
    if(type==1){
        translate([0,0,MbH]) YUEdown();YUEmid();translate([0,MbW]) YUEup();}
    else{
        color( "blue", 0.5 ) YUEdown(); 
        color( "red", 0.5 ) YUEmid();
        color( "green", 0.5 )YUEup();
        }
}
//Demo(1);

module BoomSnap(){   
    l=BSnapL;
    h=BSnapH;
    a=30;
    b=MbH;
    y=Ysnap(l,h,1);   
    for(f=[0,1]) mirror([0,f,0])translate([BEdistance/2,-MbW/2+h,-b/2])
        SnapY(l,h,a,b);

}
module BoomSnapHole(){
    l=BSnapL;
    h=BSnapH;
    a=30;
    b=2*MbH;
    y=Ysnap(l,h,1);
    for(f=[0,1]) mirror([0,f,0])translate([BEdistance/2,-MbW/2+h,-b/2]) 
        SnapHole(l,h,a,b,4);
    
    //union(){        translate([0,-MbW,0])cube([l,MbW,b],center=false);translate([l,-MbW,0])cube([MbL,MbW+y,b],center=false);          }
}

module ElementSnap(){
    l=ESnapL;
    h=ESnapH;
    a=30;
    b=MbW;
    y=Ysnap(l,h,1);
    for(f=[0,1])
        mirror([0,0,f])
            translate([-BEdistance/2,b/2,-MbH/2+h])
                rotate([90,0,0])SnapY(l,h,a,b);
}
module ElementSnapHole(){
    l=ESnapL;
    h=ESnapH;
    a=30;
    b=2*MbL;
    y=Ysnap(l,h,1);
    hmax=MbL;  //riporta le quote per la stampa
    for(f=[0,1])
            mirror([0,0,f])
                translate([-BEdistance/2,b/2,-MbH/2+h])
                    rotate([90,0,0])
                        SnapHoleQ(l,h,a,b,4,6);
}
//ElementSnap();

module YUEdown(){
    difference(){
        baseDOWN();
        union(){
            BoomSnapHole();//Snap hole
            translate([BEdistance/2,0,0]) rotate([0,0,45]) cylinder(2*MbH,d=BD,center=true, $fn=Boom_Shape); //boom hole
            translate([2*BSnapL-1,0,0])
                rotate([90,0,90])
                    linear_extrude(height = 3, center = true, convexity = 10, twist = 0) text(Label, size=LabelSize, font="Liberation Sans:style=Bold",halign="center", valign="center",spacing=LabelSpace );//label  
        }
   }
}


module YUEmid(){    
    
    difference(){
        union(){
        baseMID();
        BoomSnap();
        }
        union(){
             translate([BEdistance/2,0,0]) rotate([0,0,45]) cylinder(2*MbH,d=BD,center=true, $fn=Boom_Shape); //boom hole
             rotate([90,0,0]) translate([-BEdistance/2,0,0]) cylinder(2*MbW, d=ED, center=true,$fn=Elem_Shape); //el hole
            ElementSnapHole();
    
        }
    }
}
//YUEmid();

module YUEup(){
tollBhole=1.05; //5%    
    difference(){
        union(){
           ElementSnap();
           baseUP();
        }
         union(){
             translate([BEdistance/2,0,0]) rotate([0,0,45]) cylinder(2*MbH,d=BD*tollBhole,center=true, $fn=Boom_Shape); //boom hole
             union(){
                 rotate([90,0,0]) translate([-BEdistance/2,0,0]) cylinder(2*MbW, d=ED, center=true,$fn=Elem_Shape);//element hole            //translate([-BEdistance/2-MbL/2,0,0])cube([MbL,WinSpace,MbH+2],true);//window
                translate([-BEdistance/2-WinSpace/2,0,0])cylinder(d=WinSpace,h=MbH+2,center=true,$fn=Elem_Shape);//
                translate([-MbH-BEdistance-WinSpace,0,0]/2)cube([MbH,WinSpace,MbH+2],center=true);   
             }
                 }
    }
}
//YUEup();
module base(){
    minkowski(){
        cube([MbL-14,MbW-14,MbH],true); 
        cylinder(h=.01,d=14);
        }
}

module baseUP(){
    l=2*BEdistance+ED/2;    
    difference(){
        minkowski(){
            cube([l-14,MbW-14,MbH],true); 
            cylinder(h=.01,d=14);
        }
        union(){
            translate([MbL/2-BEdistance/2,0,0])cube([MbL,2*MbW,2*MbH],true);
        }
    }
}
//baseUP();

module baseMID(){
    difference(){
        minkowski(){
        cube([MbL-14,MbW-14,MbH],true); 
        cylinder(h=.01,d=14);
        }
        union(){
            translate([MbL/2+BEdistance/2,0,0])
                cube([MbL,2*MbW,2*MbH],true);
            translate([-MbL/2-BEdistance/2,0,0])
                cube([MbL,2*MbW,2*MbH],true);
        }
    }
}
module baseDOWN(){
    l=4*BSnapL; //2*BEdistance+BD;
    difference(){
        minkowski(){
        cube([l-14,MbW-14,MbH],true); 
        cylinder(h=.01,d=14);
        }
        translate([-MbL/2+BEdistance/2,0,0])
            cube([MbL,2*MbW,2*MbH],true);
    }
}

///lib start

eps= PT==1 ? 0.5*6/100 : PT==2 ? 0.5*12/100 : 0.5*18/100;
/*
//
eps=0.5*6/100;//Elongation at break of PLA=6%
eps=0.5*12/100;//Elongation at break of ABS=12%
eps=0.5*18/100;//Elongation at break of PETG=18%
*/

echo(eps);
function Hsnap(l,y,f)= (1.09/f)*(eps*pow(l,2))/(y);
function Ysnap(l,h,f)= (1.09/f)*(eps*pow(l,2))/(h);

//SnapH(l,y,a,b,f=1) Define y calculate h and divide the calculte h value to a factor f
module SnapH(l,y,a,b,f=1)   
{
    h=Hsnap(l,y,f);
    p=y;
    echo("h is",h);
linear_extrude(height = b, center = f, convexity = 10, twist = 0)
polygon([[0,0],[l,0],[l,y],[l+p,y],[l+p+(y+h/4)/tan(a),-h/4],[l,-h/2],[0,-h]]);
}
//SnapY(l,h,a,b,f=1) Define h calculate y and divide the calculte y value to a factor f
module SnapY(l,h,a,b,f=1)
{
    y=Ysnap(l,h,f);
    p=y;
    echo("y is", y);
linear_extrude(height = b, center = f, convexity = 10, twist = 0)
polygon([[0,0],[l,0],[l,y],[l+p,y],[l+p+(y+h/4)/tan(a),-h/4],[l,-h/2],[0,-h]]);
}

module SnapHole(l,h,a,b,Pr=2){
        //%SnapY(l,h,a,b);
        //hole    
        y=Ysnap(l,h,1);
        YY=Pr*h;//profondità Y;
        XX=1.1*(y+(y+h/4)/tan(a)); //Altezza totale +10%
        ZZ=0+b; //largezza piu tolleranza
        union(){
        translate([0,-YY,(b-ZZ)/2])cube([l,YY,ZZ],center=false); //gambo
        translate([l,-YY,(b-ZZ)/2])cube([XX,YY+y,ZZ],center=false);//testa
        }    
 }
 //SnapHole(15,5,25,5);        
module SnapHoleQ(l,h,a,b,Pr=2,Q=4){
        //%SnapY(l,h,a,b);
        //hole    
        y=Ysnap(l,h,1);
        YY=Pr*h;//profondità Y;
        XX=1.1*(y+(y+h/4)/tan(a)); //Altezza totale +10%
        ZZ=0+b; //largezza piu tolleranza
        union(){
            translate([0,-YY,(b-ZZ)/2])cube([Q*l,YY,ZZ],center=false); //gambo
            translate([l,-YY,(b-ZZ)/2])cube([XX,YY+y,ZZ],center=false);//testa
        }    
 }
//!SnapHoleQ(15,5,25,5);  
 //lib end