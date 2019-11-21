// Size in mm
L = 25; //[15:50]

// Diameter of the pin in mm
Dpin=1.0; //[0.5:0.1:5]

// Shape roundness (relative)
roundness=0.14;//[0.02:0.02:0.3]

// Gap at the contact in mm
gap     = 0.5;//[0:0.1:1]

// 6 modules combined
arrangement="combined"; //[combined:combined, single:single]

// Type of the body shape
type=2; //[1:Filled,2:Wireframe,3:Curved Surface]


//jointw=0.24;
H = L*sqrt(3);
Rpin=Dpin/2;
Rtetra = L*roundness;
Lp = Rtetra*2;
Rjoint= Rpin*5;
Wjoint = (L-Rtetra*(sqrt(3)+1/sqrt(3))-gap*2)/2.5; //L*jointw;


module cubicsphere(r=1){
    L = r*2/sqrt(3);
    rotate([(180-109.5)/2,0,0])
      rotate([0,0,45])
        cube(L, center=true);
}
    

module roundbond(p1=[0,0,0],p2=[1,1,1],r=1)
{
    hull(){
        translate(p1)
            cubicsphere(r);
        translate(p2)
            cubicsphere(r);
    }
}





module tetra(LL, HH, R, mode=3)
{
    render(){
        RR = R*(sqrt(3)+1/sqrt(3));
        HH0 = R*2; //axis offset at the open position
        v1 = [HH0,0,-(LL-RR)];
        v2 = [HH0,0,+(LL-RR)];
        v3 = [HH-HH0,+(LL-RR),0];
        v4 = [HH-HH0,-(LL-RR),0];
        if (mode==1){
            hull(){
                for(v=[v1,v2,v3,v4]){
                    translate(v)
                        cubicsphere(r=R);
                }
            }
        }
        else if(mode==2){
            for(v=[[v1,v2],[v1,v3],[v1,v4],[v2,v3],[v2,v4],[v3,v4]]){
                hull(){
                    translate(v[0])
                        cubicsphere(r=R);
                    translate(v[1])
                        cubicsphere(r=R);
                }
            }
        }
        else if(mode==3){
            for(a=[0.0:0.125:1-0.125]){
                b=a+0.125;
                hull(){
                    roundbond(v1*a+v3*(1-a), v2*a+v4*(1-a),R);
                    roundbond(v1*b+v3*(1-b), v2*b+v4*(1-b),R);
                }
            }
        }
    }
}

module female(Rpin, R1=Rjoint, R2=Rtetra, H=Wjoint, fn=6){
    difference(){
        hull(){
            rotate([0,0,30])
            cylinder(r=R1,h=H, center=true, $fn=fn);
            translate([Lp,0,0])
            rotate([0,0,30])
                cylinder(r=R2,h=H, center=true, $fn=fn);
        }
            cylinder(r=Rpin, h=Wjoint+0.01, $fn=40, center=true);
    }
}    


module body(mode){
    //tetrahedron
    difference(){
        tetra(L,H,Rtetra,mode=mode);
        for (z=[-1:2:1]){
            translate([0,0,z*(Wjoint+gap)])
                for(a=[-60,60]){
                    rotate([0,0,a])
                        female(Rpin, R1=Rjoint+gap, R2=Rtetra+gap, H=Wjoint+gap*2, fn=30);
                }
        }
        translate([H/2,0,0])
            rotate([90,0,180])
                translate([-H/2,0,0])
                    for (z=[-2:2:2]){
                        translate([0,0,z*(Wjoint+gap)])
                            for(a=[-60,60]){
                                rotate([0,0,a])
                                                            female(Rpin, R1=Rjoint+gap, R2=Rtetra+gap, H=Wjoint+gap*2, fn=30);
                            }
                        }

    }
    for (z=[-2:4:2]){
        translate([0,0,z*(Wjoint+gap)])
            female(Rpin);
    }
    for (z=[0]){
        translate([0,0,z*(Wjoint+gap)])
            female(Rpin*1.2);
    }
    translate([H/2,0,0])
    rotate([90,0,180])
    translate([-H/2,0,0])
    for (z=[-1:2:1]){
        translate([0,0,z*(Wjoint+gap)])
            female(Rpin*1.2);
    }
}




module body2(mode){
    L2 = H /sqrt(3);
    translate([0,L2,0])
    rotate([90,0,0])
        body(mode=mode);
    translate([-H,L2,0])
        body(mode=mode);
}



if(arrangement=="combined"){
    for(b=[0,120,240]){
        rotate([0,0,b])
            body2(type);
    }
}
else{
    translate([-H/2,0,0])
        rotate([45,0,0])
            body(type);
}
