// griglia cucina

larghezza=100;


bordo=10;
bordointerno=2;
raggioterminale=40;
spessorebordo=1;
spessoreinterno=5;

ngriglia=5;
mgriglia=5;
altezzagriglia=4;
spessoregriglia=0.5;
echo (larghezza*raggioterminale+3.14*pow(raggioterminale/2,2));
translate([-larghezza/2,0,0])
difference(){
    union(){
        hull(){   
            cylinder(d=raggioterminale+bordo,h=spessorebordo);
            translate([larghezza,0,0])
            cylinder(d=raggioterminale+bordo,h=spessorebordo);
        }

        hull(){   
            cylinder(d=raggioterminale,h=spessoreinterno);
            translate([larghezza,0,0])
            cylinder(d=raggioterminale,h=spessoreinterno);
             }
         }
translate([0,0,-1])
hull(){   
cylinder(d=raggioterminale-bordointerno,h=spessoreinterno+2);
translate([larghezza,0,0])
cylinder(d=raggioterminale-bordointerno,h=spessoreinterno+2);
}

}

intersection(){
    translate([-larghezza/2,0,0])
    hull(){   
            cylinder(d=raggioterminale,h=spessoreinterno);
            translate([larghezza,0,0])
            cylinder(d=raggioterminale,h=spessoreinterno);
             }
union(){
for (a =[0:ngriglia:larghezza+raggioterminale])
{
    translate([a-larghezza/2-raggioterminale/2,-raggioterminale/2,0])
    cube([spessoregriglia,raggioterminale,altezzagriglia]);
}

for (a =[0:mgriglia:raggioterminale-1])
{
    translate([-larghezza/2-raggioterminale/2,a-raggioterminale/2,0])
    cube([larghezza+raggioterminale,spessoregriglia,altezzagriglia]);
}
}
}