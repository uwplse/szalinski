//Geneva Mechanism, Geneva Wheel, or Geneva Drive
//
//By: Matt from Artofrandomness.net
//
//Thingiverse #: 2052187 
//
//For more information visit the follorwing URL
//https://en.wikipedia.org/wiki/Geneva_drive

//Number of grooves on the cross
N = 6;

//Crank and cross radius
Ro = 1.5;

//Bottom cross radius
Ri = .625;

//Base thickness
t = .375;

//Peg and slot diameter
w = .25;

//Bolt diameter
b = .186;

//Nut width
nutw = .375;

//Nut thickness
nutt = .125;

//Tolerance (I generally use my nozzle diameter) [.4mm in english units is .01575]
tol = .01575;

//1 = Assembled view
//2 = Printing view
View = 1;

ang = 360/N;

D = Ro*sin((ang/2)*((N/2)-1))+(Ro+tol);

echo(D);

if (View == 1){
    //Assembled View
    
    //Base
    rotate([0,180,0]){
        translate([0,0,t/2]){
            difference(){
                difference(){
                    union(){
                        cylinder(t,Ro*1.25,Ro*1.25,center=true,$fn=50);
                        translate([0,D,0]){
                            cylinder(t,Ro*1.25,Ro*1.25,center=true,$fn=50);
                            }
                            translate([0,D/2,0]){
                                cube([Ro*2.5,D,t],center=true);
                                }
                                }
                                cylinder(t,b/2,b/2,center=true,$fn=50);
                                translate([0,D,0]){
                                    cylinder(t,b/2,b/2,center=true,$fn=50);
                                    }}
                                    translate([0,0,0]){
                                        cylinder(2*nutt,nutw/2,nutw/2,center=false,$fn=6);
                                        translate([0,D,0]){
                                            cylinder(2*nutt,nutw/2,nutw/2,center=false,$fn=6);
                                            }}}}}
                                            
    //Cross
    rotate([0,180,180]){
    translate([0,0,-t*1.5]){
    difference(){
    union(){
    difference(){
        cylinder(t,Ro,Ro,center=true,$fn=50);
        for (i=[0:N-1]){
            rotate([0,0,ang*i]){
        translate([0,Ro-D,0]){
            cylinder(t,(w/2)+tol,(w/2)+tol,center=true,$fn=50);
        }
        rotate([0,0,180]){
        translate([-((w/2)+tol),D-Ro,-t/2]){
            cube([w+(2*tol),Ro,t],center=false);
            }}}}
        for (i=[0:N-1]){
            rotate([0,0,(ang/2)+(ang*i)]){
                translate([0,-D,0]){
                    cylinder(t,Ro+tol,Ro+tol,center=true,$fn=50);
                    }}}}
                    translate([0,0,t]){
                        cylinder(t,Ri,Ri,center=true,$fn=50);
                    }}
                    cylinder(3*t,b/2,b/2,center=true,$fn=50);
            }}}
            
                //Rotor
                translate([0,D,t/2]){
                union(){
                    difference(){
                        translate([0,0,t/2]){
                    cylinder(2*t,Ro,Ro,center=true,$fn=50);
                        }
                        translate([0,-D,(1.5*t)-tol]){
                            cylinder(2*t,Ro+(2*tol),Ro+(2*tol),center=true,$fn=50);}
                            cylinder(4*t,b/2,b/2,center=true,$fn=50);
                            }
                    translate([0,-Ro,t/2]){
                        cylinder(2*t,w/2,w/2,center=true,$fn=50);
                    }
                translate([0,Ro-(t*(2/3)),2*t]){
                cylinder(2*t,t/2,t/2,center=true,$fn=50);
                }}}
            
            
}

else{
    //Printing View
    
    //Cross
    translate([0,0,t/2]){
    difference(){
    union(){
    difference(){
        cylinder(t,Ro,Ro,center=true,$fn=50);
        for (i=[0:N-1]){
            rotate([0,0,ang*i]){
        translate([0,Ro-D,0]){
            cylinder(t,(w/2)+tol,(w/2)+tol,center=true,$fn=50);
        }
        rotate([0,0,180]){
        translate([-((w/2)+tol),D-Ro,-t/2]){
            cube([w+(2*tol),Ro,t],center=false);
            }}
        }}
        for (i=[0:N-1]){
            rotate([0,0,(ang/2)+(ang*i)]){
                translate([0,-D,0]){
                    cylinder(t,Ro+tol,Ro+tol,center=true,$fn=50);
                    }}
                    }
                    }
                    translate([0,0,t]){
                        cylinder(t,Ri,Ri,center=true,$fn=50);
                    }
                }
                    cylinder(3*t,b/2,b/2,center=true,$fn=50);
            }
                }
    //Rotor
                translate([0,1.25*D,t/2]){
                  union(){
                    difference(){
                        translate([0,0,t/2]){
                    cylinder(2*t,Ro,Ro,center=true,$fn=50);
                        }
                        translate([0,-D,(1.5*t)-tol]){
                            cylinder(2*t,Ro+(2*tol),Ro+(2*tol),center=true,$fn=50);}
                            cylinder(4*t,b/2,b/2,center=true,$fn=50);
                            }
                    translate([0,-Ro,t/2]){
                        cylinder(2*t,w/2,w/2,center=true,$fn=50);
                    }
                translate([0,Ro-(t*(2/3)),2*t]){
                cylinder(2*t,t/2,t/2,center=true,$fn=50);
                }}}
                
    //Base
                translate([-(Ro*2.5),0,t/2]){
                    difference(){
                        difference(){
                            union(){
                                cylinder(t,Ro*1.25,Ro*1.25,center=true,$fn=50);
                                translate([0,D,0]){
                                    cylinder(t,Ro*1.25,Ro*1.25,center=true,$fn=50);
                                    }
                                    translate([0,D/2,0]){
                                        cube([Ro*2.5,D,t],center=true);
                                        }}
                                        cylinder(t,b/2,b/2,center=true,$fn=50);
                                        translate([0,D,0]){
                                            cylinder(t,b/2,b/2,center=true,$fn=50);
                                            }}
                                            translate([0,0,0]){
                                                cylinder(2*nutt,nutw/2,nutw/2,center=false,$fn=6);
                                                translate([0,D,0]){
                                                    cylinder(2*nutt,nutw/2,nutw/2,center=false,$fn=6);
                                                    }}}}}