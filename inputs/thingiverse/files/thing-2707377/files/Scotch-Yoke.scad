//Scotch Yoke Mechanism
//
//By: Matt from Artofrandomness.net
//
//Thingiverse #: 2707377  
//
//For more information visit the follorwing URL
//https://en.wikipedia.org/wiki/Scotch_yoke

//Input Parameters:

//Wheel Diameter
WD = 1.5;

//Nub Diameter
ND = .375;

//Thickness
t = .25;

//Clearance (.015625 is .4mm)
C = .015625;

//Yoke Arm Edge Thickness
YT = .1875;

//Bolt Diameter (these are for a #8 screw)
B = .178;

//Bolt Head Diameter
BH = .338;

//Nut Outer Diameter
Nutd = .360;

//Nut Thickness
Nutt = .131;

//Curved Yoke Radius Multiplier
F = tan(60);

//1: Straight Yoke, 2: Curved Yoke
Yoke = 1;

//1: Assembed View, 2: Printing View
View = 1;

//Calculated Parameters
R = WD*F;

delta = WD-ND;

TriY = sqrt(pow(R,2)-pow(delta/2,2));

TriX = delta;

Off = R-TriY;

echo("Min Bed Size");
echo("X Direction:");
echo(4.25*WD);
echo("Y Direction:");
echo(4*WD);

if(View==1){

//Assembled View

//Knob
translate([0,0,t/2]){
    union(){
    difference(){
    cylinder(t,WD/2,WD/2,center=true,$fn=100);
    union(){
    cylinder(2*t,B/2,B/2,center=true,$fn=100);
    translate([0,0,t/2]){
    cylinder(t,BH/2,BH/2,center=true,$fn=100);   
    }}}
    translate([((WD/2)-(ND/2)),0,t]){
    union(){
    cylinder(t,ND/2,ND/2,center=true,$fn=100);
    translate([0,0,t]){
    cylinder(t,ND/2,0,center=true,$fn=100);
    }
    translate([0,0,1.5*t]){
    sphere(ND/2,center=true,$fn=100);
    }}}}}
    
//Base            
translate([0,0,-t/2]){
    difference(){
    union(){
    cube([1.25*WD,4*WD,t],center=true);
    translate([0,2*delta,t]){
    cube([2*(B+YT),ND,t+(2*C)],center=true);
    }
    translate([0,-2*delta,t]){
    cube([2*(B+YT),ND,t+(2*C)],center=true);
    }}
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    translate([0,2*delta,0]){
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    }
    translate([0,-2*delta,0]){
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    }
    translate([0,0,-t/2]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    translate([0,2*delta,0]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    }
    translate([0,-2*delta,0]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    }}
    }}

//Yoke
translate([0,0,0]){
if(Yoke==1){
//Straight Yoke
translate([0,0,(1.5*t)+C]){
    difference(){
    union(){
    cube([B+(2*YT),5*delta,t],center=true);
    cube([WD-ND,ND+(2*YT),t],center=true);
    translate([delta/2,0,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([-delta/2,0,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }}
    cube([WD-ND,ND+(2*C),2*t],center=true); 
    translate([delta/2,0,0]){
    cylinder(2*t,(ND/2)+C,(ND/2)+C,center=true,$fn=100);
    }
    translate([-delta/2,0,0]){
    cylinder(2*t,(ND/2)+C,(ND/2)+C,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    translate([0,-2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    }}
}
else {
//Curved Yoke
translate([0,Off,(1.5*t)+C]){
    difference(){
    union(){
    cube([B+(2*YT),5*delta,t],center=true);
    translate([0,-R,0]){
    intersection(){
    difference(){
    cylinder(t,R+(ND/2)+YT,R+(ND/2)+YT,center=true,$fn=100);
    cylinder(2*t,R-(ND/2)-YT,R-(ND/2)-YT,center=true,$fn=100);
    }
    linear_extrude(2*t,center=true){
    polygon([[0,0],[1.5*TriX,3*TriY],[-1.5*TriX,3*TriY]]);
    }}}
    translate([delta/2,-Off,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([-delta/2,-Off,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }}
    translate([0,-R,0]){
    intersection(){
    difference(){
    cylinder(2*t,R+(ND/2)+(C/2),R+(ND/2)+(C/2),center=true,$fn=100);
    cylinder(2*t,R-(ND/2)-(C/2),R-(ND/2)-(C/2),center=true,$fn=100);
    }
    linear_extrude(2*t,center=true){
    polygon([[0,0],[1.5*TriX,3*TriY],[-1.5*TriX,3*TriY]]);
    }}}
    translate([delta/2,-Off,0]){
    cylinder(2*t,(ND/2)+(C/2),(ND/2)+(C/2),center=true,$fn=100);
    }
    translate([-delta/2,-Off,0]){
    cylinder(2*t,(ND/2)+(C/2),(ND/2)+(C/2),center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    translate([0,-2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    }}
}
}
}

else {
  //Printing View
    
  //Knob
translate([0,0,t/2]){
    union(){
    difference(){
    cylinder(t,WD/2,WD/2,center=true,$fn=100);
    union(){
    cylinder(2*t,B/2,B/2,center=true,$fn=100);
    translate([0,0,t/2]){
    cylinder(t,BH/2,BH/2,center=true,$fn=100);   
    }}}
    translate([((WD/2)-(ND/2)),0,t]){
    union(){
    cylinder(t,ND/2,ND/2,center=true,$fn=100);
    translate([0,0,t]){
    cylinder(t,ND/2,0,center=true,$fn=100);
    }
    translate([0,0,1.5*t]){
    sphere(ND/2,center=true,$fn=100);
    }}}}}
    
//Base            
translate([-1.5*WD,0,t/2]){
    difference(){
    union(){
    cube([1.25*WD,4*WD,t],center=true);
    translate([0,2*delta,t]){
    cube([2*(B+YT),ND,t+(2*C)],center=true);
    }
    translate([0,-2*delta,t]){
    cube([2*(B+YT),ND,t+(2*C)],center=true);
    }}
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    translate([0,2*delta,0]){
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    }
    translate([0,-2*delta,0]){
    cylinder(4*t,B/2,B/2,center=true,$fn=100);
    }
    translate([0,0,-t/2]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    translate([0,2*delta,0]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    }
    translate([0,-2*delta,0]){
    cylinder(2*Nutt,Nutd/2,Nutd/2,center=true,$fn=6);
    }}
    }}

//Yoke
translate([1.5*WD,0,0]){
if(Yoke==1){
//Straight Yoke
translate([0,0,t/2]){
    difference(){
    union(){
    cube([B+(2*YT),5*delta,t],center=true);
    cube([WD-ND,ND+(2*YT),t],center=true);
    translate([delta/2,0,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([-delta/2,0,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }}
    cube([WD-ND,ND+(2*C),2*t],center=true); 
    translate([delta/2,0,0]){
    cylinder(2*t,(ND/2)+C,(ND/2)+C,center=true,$fn=100);
    }
    translate([-delta/2,0,0]){
    cylinder(2*t,(ND/2)+C,(ND/2)+C,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    translate([0,-2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    }}
}
else {
//Curved Yoke
translate([0,Off,t/2]){
    difference(){
    union(){
    cube([B+(2*YT),5*delta,t],center=true);
    translate([0,-R,0]){
    intersection(){
    difference(){
    cylinder(t,R+(ND/2)+YT,R+(ND/2)+YT,center=true,$fn=100);
    cylinder(2*t,R-(ND/2)-YT,R-(ND/2)-YT,center=true,$fn=100);
    }
    linear_extrude(2*t,center=true){
    polygon([[0,0],[1.5*TriX,3*TriY],[-1.5*TriX,3*TriY]]);
    }}}
    translate([delta/2,-Off,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([-delta/2,-Off,0]){
    cylinder(t,(ND/2)+YT,(ND/2)+YT,center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(t,(B+(2*YT))/2,(B+(2*YT))/2,center=true,$fn=100);
    }}
    translate([0,-R,0]){
    intersection(){
    difference(){
    cylinder(2*t,R+(ND/2)+(C/2),R+(ND/2)+(C/2),center=true,$fn=100);
    cylinder(2*t,R-(ND/2)-(C/2),R-(ND/2)-(C/2),center=true,$fn=100);
    }
    linear_extrude(2*t,center=true){
    polygon([[0,0],[1.5*TriX,3*TriY],[-1.5*TriX,3*TriY]]);
    }}}
    translate([delta/2,-Off,0]){
    cylinder(2*t,(ND/2)+(C/2),(ND/2)+(C/2),center=true,$fn=100);
    }
    translate([-delta/2,-Off,0]){
    cylinder(2*t,(ND/2)+(C/2),(ND/2)+(C/2),center=true,$fn=100);
    }
    translate([0,2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-2.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,-1.5*delta,0]){
    cylinder(2*t,(B+C)/2,(B+C)/2,center=true,$fn=100);
    }
    translate([0,2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    translate([0,-2*delta,0]){
    cube([B+C,delta,2*t],center=true);
    }
    }}
}
}
}



