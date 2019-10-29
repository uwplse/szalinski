// Death Star 3D Print Model
//Marcello 9/28/19

rad = 70; //main body radius
$fn = 50; 

//trench cutout
clen = 2*rad+1; 
cwid = clen;
chei = rad/15;

//bolt properties
dThru = rad+1;     //bolt extrusion length
bL1 = 8;           //bolt head depth
bD1 = 11;          //bolt hole dia
bD2 = 25;          //bolt head dia

rad2 = rad*0.9;   //trench fill
a = rad/sqrt(3)+rad/10; //cartesian conversion

//climbing hold
difference(){
    //half death star body
    difference(){
        union(){
            difference(){  
                difference(){ 
                    //main body and trench hole
                    sphere(rad, $fs = 0.01);
                    cube([clen,cwid,chei],center = true); 
                }
                //laser hole
                translate([a,-a,a]) sphere(rad/3,$fs = 0.01);
            }
            //fill trench
            cylinder(h = rad/10+1, r=rad-rad/10, center = true);
        }
        //half slice
        translate([0,rad,0]) cube([rad*2,rad*2,rad*2], center = true);
    }
    //rotate bolt hole
    rotate([90,0,0]){
        //bolt w/ fixed head size and dia.
        union(){
            translate([0,0,dThru-bL1])cylinder(h = bL1, r = bD2/2); //bolt head
            translate([0,0,-1]) cylinder(h = dThru, r = bD1/2); // bolt shaft
        }
    }
}


        