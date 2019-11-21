$fn = 75;   //"resolution" of part
//---------------------------------------------------
lay = 6;    //layers of portagyro
sT = 1.5;   //layer thickness
off = .4;   //offset
in =  24;   //diameter of inner hole
ang = 4;    //angle modifier between 1 and 10
            //(higher = flater)
//---------------------------------------------------
tS = (lay*((sT)+(off)))+(in); //calculates the diameter
thi=tS/(((ang*.8)/10)+1.4);   //calculates the thickness
module cone (){               //makes cones for the shape
        translate([0,0,5]){
            union(){
                cylinder(h=(thi/2)-5, r1=3, r2=tS/2, center=false);
                cylinder(  (thi/2)-5,    3,    tS/2, false);
                cylinder(  (thi/2)-5,    3,     tS/2);
                cylinder(  (thi/2)-5,    3,  d2=tS  );
                cylinder(  (thi/2)-5, d1=6,  d2=tS  );
                cylinder(  (thi/2)-5, d1=6,  r2=tS/2);
            }
        }    
}
module support (){            //makes a cone for support
    mirror([0,0,1]){
        translate([0,0,5+(.3)]){
            union(){
                cylinder(h=(thi/2)-5, r1=3, r2=tS/2, center=false);
                cylinder(  (thi/2)-5,    3,    tS/2, false);
                cylinder(  (thi/2)-5,    3,     tS/2);
                cylinder(  (thi/2)-5,    3,  d2=tS  );
                cylinder(  (thi/2)-5, d1=6,  d2=tS  );
                cylinder(  (thi/2)-5, d1=6,  r2=tS/2);
            }
        }
    }
}
module gyro (){               //makes the spheres
    for(i=[(in):(sT)+(off):(tS-((sT)+(off)))]){
        difference(){            
            sphere(d=i);
            sphere(d=i-sT);
        }
    }
}
module flat(){                //cuts the top and bottom
    intersection(){
        gyro();
        translate([-tS,-tS,-thi/2]){
            cube([tS*2,tS*2,thi]);
        }
    }
}
difference(){                 //removes unnessecary matieral
    union(){                       //combines final parts
        difference(){
            flat();
            cone();  
            mirror([0,0,1]) cone();
        translate([0,0,thi/2]) cube([tS,tS,1],center = true);    
        }
        support(); 
    }
    r = in/2;
    d = (thi/2)-2;
    cLeng = 2*(sqrt((r*r)-(d*d)));
    cylinder(d=cLeng,h=thi*5,center = true);
}
