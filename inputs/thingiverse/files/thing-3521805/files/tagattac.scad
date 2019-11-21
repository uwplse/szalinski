//TAGATTAC genetic magnetic whiteboard invasion
//by thinkandhave 03/2019
//

//dna_sequence="GATAGTATGGA";  //DNA-sequence 11 chars ACGT

dna_sequence="GATAGTATGGA";  //DNA-sequence 11 chars ACGT

/*
ACGT

0-12    AA-TA         color
0-3     T-A           eyes
0-2     A-G           type
0-15    AA-TT         armlen
0-15    AA-TT         linkpairs
0-75    AA-TT         diameter/5
nix P H A-G           decoration 

*/

dna(dna_sequence);

//more globals
jdia=8;
fn=36; //FN quality
free=.10; //free play for ball links
jheight=4;
th=8;
th1=3;
magh=3; //height of magnet
magdia=16;   //diameter of magnet
hangdia=0; //optional center hole
pdia=50;//dia;
rast=.5;
cnt=3;

jlen=20;
font = "Liberation Sans:style=Bold";
fsize=10;
textx=-16.5;
texty=-5;
text="PAVI";

mcols=["red","yellow","blue",
       "lightblue","lightgreen","green",
       "blue", "pink", "purple",
       "white","grey","black",
       "brown"];

function get_dna_word(str) = 
    let(ret=get_dna_byte(str[0])*4+get_dna_byte(str[1]))
     ret;
function get_dna_byte(str) = 
    let(ret=search(str,"ACGT")[0])
    let(ret=defined(ret)?ret:0)
//    if(ret==undef){echo  "wrong nucleobase ")}
     ret;
function defined(a) = str(a) != "undef"; 

module dna(dnastring){
    coldna=str(dnastring[0],dnastring[1]);
    eyedna=dnastring[2];
    typedna=dnastring[3];
    alendna=str(dnastring[4],dnastring[5]);
    links=str(dnastring[6],dnastring[7]);
    diam=str(dnastring[8],dnastring[9]);  
    decoration=dnastring[10]; 
        
    echo (str("----------  generating coldna ",coldna,":",get_dna_word(coldna)));
    echo (str("----------  generating eyedna ",eyedna,":",get_dna_byte(eyedna)));
    echo (str("----------  generating typedna ",typedna,":",get_dna_byte(typedna)));
    echo (str("----------  generating alendna ",alendna,":",get_dna_word(alendna)));
    echo (str("----------  generating links ",links,":",get_dna_word(links)));
    echo (str("----------  generating diameter ",diam,":",get_dna_word(diam)*5));
    echo (str("----------  generating decoration ",decoration,":",get_dna_byte(decoration)));
        
    mk(
        get_dna_word(coldna),
       get_dna_byte(eyedna),
       get_dna_byte(typedna),
       get_dna_word(alendna)*3,   
       get_dna_word(links),   get_dna_word(diam)*5,
       get_dna_byte(decoration)
        );
}


module char (c,r,a,a2){

    
    rotate([0,fsize/2,a])
    translate([0,-r,th/2-1])
        rotate([0,0,-a2])
        translate([-fsize/2,-fsize/2,0])
    linear_extrude(height = 3) {
           text(c, font = font, size = fsize);
         }    
}

module HSV (){
    l0=30;
    l1=l0/sqrt(2);
    l2=3/5*l1;
    l3=1/5*l1;
    h=1.66;
    rotate([0,0,45])
    translate([0,0,th/2]){
    color("white")
       hull(){
       cube([l1,l1,2*h],center=true);
       translate([0,0,-h-3])
           cylinder(d=l0-5,h=.1,$fn=fn);
       }   
    color("black")
      difference(){  
       cube([l2,l2,3.5*h],center=true);     
       cube([l3,l3,4*h+1],center=true);    
    }
    }
}


module dtext (){
    translate([textx,texty,th/2-1.6])
        rotate([0,0,0])
    linear_extrude(height = 3) {
           text(text, font = font, 
        spacing= 1.1, size = fsize);
         }
}



module eyes2a(){
a=58;
r=6+4;    
    translate([-0,r,th/2])
      eye();


}

module eyes3(){
a=58;
r=6+4;    
    translate([0,r,th/2])
      eye();
translate([0,-2,0]){
   rotate([0,0, a])
    translate([0,r,th/2])
   rotate([0,0, -a/1.5])
      eye();
   rotate([0,0,-a])
    translate([0,r,th/2])
   rotate([0,0, a/1.5])
      eye();
}  
}

module eyes(){
a=55;
r=6+2;    
//    translate([0,r,th/2])
//      eye();
translate([0,-2,0]){
   rotate([0,0, a])
    translate([0,r,th/2])
   rotate([0,0, -a/1.5])
      eye();
   rotate([0,0,-a])
    translate([0,r,th/2])
   rotate([0,0, a/1.5])
      eye();
}    
//    translate([ 6,4,th/2])
//     rotate([0,0,-15])  eye();
    
}
module eye(){
    
  color("white")  
      rotate([0,10,0])
      resize([10,12,8])
       sphere(d=8,$fn=fn);    
  color("black")  
    translate([0,0,2])
       sphere(d=5,$fn=fn);    
  
}

module sixjoint(at,jl,cn, diam){
color(mcols[col])
difference(){sixjoint2(at,jl,cn,diam);fin();}    
}
module arm(at,jl){
    if (at==0){
        arm0(jl);}    
    if (at==1){
        arm1(jl);}    
    if (at==2){
        arm2(jl);}    
    }
module arm2(jl){
    hull(){
    sphere(d=jheight,$fn=fn);
    translate([0,-jl+4,-2])
    sphere(d=th1+6,$fn=fn);
    }
    }
module arm1(jl){
    rotate([90,0,0])
    cylinder(d1=jheight,d2=th,h=jl,$fn=fn);
    }
module arm0(jl){
    for(i=[0,1,2,3,4])
    translate([i*2,(-i-1)*(jdia-2),0])
      sphere(r=jdia/2+i/2,$fn=fn);
    }

module deko(dek){ 
    
  if(dek==2)  {color("white")dtext();}
  if(dek==1)  {HSV();}
}
module fin(){ 
    translate([0,0,-50-th/2+.15])
      cylinder(d=200,h=50);
    translate([0,0,-th/2-.01])
       cylinder(d=magdia,h=magh,$fn=fn*2);    
    translate([0,0,-th/2+magh+.5])
       cylinder(d=hangdia,h=50,$fn=fn,center=false);    
//  translate([0,0,th/2-1])  
//        cylinder(d=33,h=4,$fn=fn*2);    
}
module sixjoint2(at,jl,cn,diam){
  union(){
    hull(){
    cylinder(d=diam-jl-3,h=th,$fn=3*fn,center=true);
    cylinder(d=diam-jl,h=th-5,$fn=3*fn,center=true);
    }
    for(i=[0:cn-1])union(){
        rotate([0,0,i*360/cn])
            translate([0,diam/2,0])
               jointa1(at,jl);
        rotate([0,0,(i+.5)*360/cn])
            translate([0,diam/2,0])
               jointb1a(at,jl);
    }
}
}
module jointa1(at,jl){
    sphere(r=jdia/2,$fn=fn*2);
    arm(at,jl);
}


module jointb1a(at,jl){
   difference(){    
        union(){
        intersection(){
        sphere(r=jdia/2+th1,$fn=fn*4);
        translate([0,-2,0])
            cylinder(d=jdia+2*th1,h=jdia,$fn=fn*2,center=true);    
        translate([0,-2,0])
      sphere(d=jdia+2*th1,$fn=fn*2);    
        }
    arm(at,jl);
        }

    sphere(r=jdia/2+free,$fn=2*fn);
        rotate([-90,0,0])
    cylinder(d1=jdia-rast,d2=jdia,h=jdia,$fn=fn);
    cylinder(d=jdia-2,h=jl,$fn=fn,center=true);
       hull(){
        cylinder(d=jdia+2*free-rast,h=jl,$fn=fn,center=true);
        translate([0,jl,0])     
        cylinder(d=jdia+2*free-rast,h=jl,$fn=fn,center=true);
       }
    }
}
module jointc1(jl){
   difference(){    
        union(){
        intersection(){
        sphere(r=jdia/2+th1,$fn=fn*4);
        translate([0,-2,0])
            cylinder(d=jdia+2*th1,h=jdia,$fn=fn*2,center=true);    
        translate([0,-2,0])
      sphere(d=jdia+2*th1,$fn=fn*2);    
        }
        }

    sphere(r=jdia/2+free,$fn=2*fn);
        rotate([-90,0,0])
    cylinder(d1=jdia-rast,d2=jdia,h=jdia,$fn=fn);
    cylinder(d=jdia-2,h=jl,$fn=fn,center=true);
       hull(){
        cylinder(d=jdia+2*free-rast,h=jl,$fn=fn,center=true);
        translate([0,jl,0])     
        cylinder(d=jdia+2*free-rast,h=jl,$fn=fn,center=true);
       }
    }
}
module ey(e){
if(e==0) {}
else if(e==1)   {eyes2a();}
else if(e==2)   {eyes();}
else if(e==3)   {eyes3();}
else          {}
   

}


module mk(c,e,at,jl,cn,diam, dek){
  sixjoint(at, jl ,cn, diam, col=c);
    ey(e);
  deko(dek);
}
