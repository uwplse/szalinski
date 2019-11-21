//-------------------------------
// wszystkie ywmiary w mm
//-------------------------------
//wysokosc calkowita
wymz=100;
//szerokosc telefony
telszer=77;
//grubosc telefonu
telgr=15.2;
//grubosc scianboki
grscianboki=4.5;
//grubosc podstawa
grscianpodstawa=grscianboki;
//grubosc scian gora
grsciangora=grscianboki;
//grubosc bazy pod wtyczke
grbaza=15.0;

//skos przy wejsciu telefonu:
skosdlugosc=16;
skospocylenie=7;

//szerokosc bokow trzymajacych 
otwmarg=14;

wymx=telszer+2*grscianboki;
wymy=telgr+grsciangora+grscianpodstawa;


module dziury(){
translate([wymx/2,wymy-grscianboki,wymz-25]) rotate([90,0,0]) wkret_stozek(3.0,h=10);
translate([wymx/2,wymy-grscianboki,grbaza+20]) rotate([90,0,0]) wkret_stozek(3.0,h=10);
}



module wkret_stozek(sred,h=20){
    d_2=(sred==2.9)?5.5:
        (sred==3.0)?5.5:
        (sred==2.2)?3.8:
        (sred==2.5)?4.7:
        (sred==3.5)?7.3:
        (sred==4.0)?8.2:
        (sred==3.9)?7.5:0;        
    dip=(sred==2.9)?1.65:
        (sred==3.0)?1.65:
        (sred==3.5)?2.35:
        (sred==2.2)?1.2:
        (sred==2.5)?1.5:
        (sred==4.0)?2.7:
        (sred==3.9)?2.7:0;        
    sreotw=sred;
    hleb=(d_2-sred)/2;
    rotate([0,180,0]) union(){
        translate([0,0,-0.02])
        cylinder(d=d_2,h=dip-hleb+0.04, $fn=50);
        translate([0,0,dip-hleb])
        cylinder(d1=d_2,d2=sred,h=hleb, $fn=50);
        cylinder(d=sreotw,h=h, $fn=50);
    }
}




module skos(){
    margin = 6;
    skwyx=telszer+margin;
    skwyy=telgr+margin;
    scale([1,1,-1])
    translate([wymx/2,wymy/2,-wymz-0.1])
    linear_extrude(skosdlugosc,scale=[(skwyx-skospocylenie)/skwyx,(skwyy-skospocylenie)/skwyy]) square([skwyx,skwyy],center = true);
}


module otworprzod(){    
    szerotw=telszer-2*otwmarg;
    translate([ (wymx-szerotw)/2,grsciangora+0.1,grbaza])
    rotate([90,0,0])
    linear_extrude(grsciangora+0.2)        
        square([szerotw,wymz]);         
 }



module main(){
cube([wymx,wymy,grbaza]);
translate([0,wymy-grscianpodstawa,0]) cube([wymx,grscianpodstawa,wymz]);
translate([wymx-grscianboki,0,0]) cube([grscianboki,wymy,wymz]);
cube([grscianboki,wymy,wymz]);
cube([wymx,grscianpodstawa,wymz]);
};


//miejsce na wtyczke
wtx=12;
wty=9;


difference(){
    main();
    skos();
    otworprzod();
    dziury();
    
    translate([wymx/2-wtx/2,wymy/2-wty/2,0])
    cube([wtx,wty,grbaza]);
    
    
    
}


    

