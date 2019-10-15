//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//CONFIGURABLE PARAMETERS:

//-> screw_distance_40mm_face :Screw distance in 40mm fan, value 32.2 mm is Ok for a   
//                             model: 
//                             "Xilence Fan XPF40 WhitBox - (40 x 40 x 1 cm, 12 V, 3P CE)"

//-> screw_distance_30mm_face :Screw distance in 30mm original printer fan, value 24 mm is Ok 
//                             for PRIMA CREATOR P120 and MonoPrice Select MINI V1 and maybe
//                             for MonoPrice Select MINI V2, Malyan M200, ProFab Mini

//-> total_height             :Total height of the adapter, 17 mm is a good value
//                             (reasonable values between 10 and 25)

screw_distance_40mm_face = 32.2;
screw_distance_30mm_face = 24;
total_height = 17;

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//NOTES:
//Screw holes are for M3 3mm. Holes in 30mm face are clearance holes. 
//                            Holes in 40mm face are intended to screw directly in plastic 
//                            and works ok, but obviously you can use nuts if you want.
//Screw length in 40mm face of 5mm to 15mm larger than fan height works ok 
//Screw length in 30mm face of 10mm to 15mm works ok. Or use the original screws.
//Or simply print before and look for screws after :-)
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

module voidvoid(){}
//low $fn to 100 if OpenScad rendering run too slow for you
$fn=250;

//bajatorpeq=4;
bajatorpeq = total_height / 3.0;

grosor=3;
//ladogext=38+2*grosor;
ladogext=37+2*grosor;
hg=3;
dg=40-1;

ladopext=30+2*grosor;
hp=3;
dp=30-1;

ht=total_height;
h=ht-hg-hp;

disttalg=screw_distance_40mm_face;
disttalp=screw_distance_30mm_face;

//dtrosca=2.6;
dtrosca=2.7;
dtroscaext=dtrosca+2*2.1;

dtpas=3.2;
cabdtpas=6*1;
hcabdtpas=2;

//>>>>>>>>>
difference(){
cuerpo();
huecos_torn_grande();
huecos_torn_peque();
}
//>>>>>>>>>


module cuerpo(){
    difference(){
        hull(){cylinder(d=ladogext, h=hg);translate([0,0,ht-hp]) cylinder(d=ladopext, h=hp);}
        translate([0,0,-0.001])
        hull(){cylinder(d=dg, h=hg);translate([0,0,ht-hp+0.002]) cylinder(d=dp, h=hp);}
    }
    bases_torn_grande();
}

module bases_torn_grande(){
translate([disttalg/2,disttalg/2,0]) tornillo_grande();
translate([-disttalg/2,disttalg/2,0]) tornillo_grande();
translate([-disttalg/2,-disttalg/2,0]) tornillo_grande();
translate([disttalg/2,-disttalg/2,0]) tornillo_grande();
}

module huecos_torn_grande(){
translate([disttalg/2,disttalg/2,-0.001]) cylinder(d=dtrosca,h=ht+0.02);
translate([-disttalg/2,disttalg/2,-0.001]) cylinder(d=dtrosca,h=ht+0.02);
translate([-disttalg/2,-disttalg/2,-0.001]) cylinder(d=dtrosca,h=ht+0.02);
translate([disttalg/2,-disttalg/2,-0.001]) cylinder(d=dtrosca,h=ht+0.02);
}

module huecos_torn_peque(){
subida=ht-2-bajatorpeq;    
translate([disttalp/2,disttalp/2,subida]) tornillo_peque();
translate([-disttalp/2,disttalp/2,subida]) tornillo_peque();
translate([disttalp/2,-disttalp/2,subida]) tornillo_peque();
translate([-disttalp/2,-disttalp/2,subida]) tornillo_peque();
}

module tornillo_peque(){
cylinder(d=dtpas,h=ht);
translate([0,0,-ht+0.001])cylinder(d=cabdtpas,h=ht);
}

module tornillo_grande(){
difference(){
cylinder(d=dtroscaext,h=ht-(bajatorpeq+1.5));
//translate([0,0,-0.001])cylinder(d=dtrosca,h=ht+0.02);
}
}