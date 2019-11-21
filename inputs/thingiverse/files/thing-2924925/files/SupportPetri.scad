// Petri dish Support by Fabien GARAT
//All units are in mm

//Petri Dish diameter
DPetri=62;

//Height of a Petri Dish
HPetri=15.1;

//Numer of Petri Dish in Loader
NbPetri=7;

//Wall Width
Epp=3;

// Movement space between Parts
Jeu=0.3;

//Printing Socle (1 for Yes, 0 for No)
PrintAll=0;

//Printing Socle (1 for Yes, 0 for No)
PrintSocle=1;

//Printing Plateau (1 for Yes, 0 for No)
PrintPlateau=1;

//Printing Loader (1 for Yes, 0 for No)
PrintLoader=1;

//Printing stylet (1 for Yes, 0 for No)
PrintStylet=1;

//Printing Couvercle (1 for Yes, 0 for No, 2 for display under)
PrintCouvercle=1;

Alpha=0.5*1;
$fn=60*1;

module Petri(D,H){

    union() {
        difference(){
            cylinder(H-Epp,(D-Epp*2)/2,(D-(Epp*2))/2);
            translate([0,0,Epp]) cylinder(H-Epp,(D-Epp*4)/2,(D-Epp*4)/2);
        };
    };
}

module PetriBox(D,H) {
    union(){
    color ("blue",Alpha) Petri(D-2*Epp-Jeu,H-Epp-Jeu);
translate([0,0,H]) 
    color ("Green",Alpha) rotate([180,0,0]) Petri(D,H-Epp);
    };
};



module Stylet()
{
   cylinder(HPetri,DPetri/15,DPetri/15);
    translate ([0,0,HPetri]) cylinder(Epp+(NbPetri)*HPetri+Jeu,DPetri/20-2*Jeu,DPetri/20-2*Jeu);
}

//PetriBox(DPetri,HPetri);


module socle(){
    difference() {
        union(){
        translate([0,0,(HPetri+3*Epp+Jeu)/2]) cube([DPetri+2*Epp+Jeu,DPetri+2*Epp+Jeu,HPetri+3*Epp+Jeu],center=true);
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),HPetri+3*Epp+Jeu]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2-Jeu,Epp/2-Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2-Jeu,Epp/2-Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),HPetri+3*Epp+Jeu]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2-Jeu,Epp/2-Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2-Jeu,Epp/2-Jeu);
            }
        }
        translate([0,0,Epp]) cylinder(HPetri+2*Epp+Jeu,(DPetri+Jeu)/2,(DPetri+Jeu)/2);
        translate([0,DPetri/2,(HPetri+Epp+Jeu)/2+2*Epp]) 
        cube([DPetri+Jeu,DPetri+Jeu,HPetri+3*Epp+Jeu],center=true);
        translate([0,-(DPetri+2*Epp+Jeu)/2,(HPetri+2*Epp+Jeu)/2+Epp]) 
        cube([DPetri/5,(DPetri+2*Epp+Jeu),HPetri+4*Epp+Jeu],center=true);

        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([-(DPetri/20+3*Epp),0,0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,(DPetri/20+3*Epp),0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([(DPetri/20+3*Epp),0,0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,(DPetri/20+3*Epp),0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([-(DPetri/20+3*Epp),0,0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,-(DPetri/20+3*Epp),0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([(DPetri/20+3*Epp),0,0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,-(DPetri/20+3*Epp),0]) cylinder(Epp+Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        
    };       
}

module chargeur() {
    difference(){
        union(){
            translate([0,0,(Epp+(NbPetri-1)*HPetri+Jeu)/2]) cube([DPetri+2*Epp+Jeu,DPetri+2*Epp+Jeu,Epp+(NbPetri-1)*HPetri+Jeu],center=true);
          //  translate([0,0,Epp]) cylinder((NbPetri-1)*HPetri+Jeu,(DPetri+2*Epp+Jeu)/2,(DPetri+2*Epp+Jeu)/2);
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),Epp+(NbPetri-1)*HPetri+Jeu]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),Epp+(NbPetri-1)*HPetri+Jeu]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),Epp+(NbPetri-1)*HPetri+Jeu]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,-(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),Epp+(NbPetri-1)*HPetri+Jeu]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
             translate([0,-(DPetri/20+Epp),0]) cylinder(Epp-Jeu,Epp/2+Jeu,Epp/2+Jeu);
            }
        };
        cylinder((NbPetri-1)*HPetri+Jeu+2*Epp,(DPetri+Jeu)/2,(DPetri+Jeu)/2);
        translate([0,-(DPetri+2*Epp+Jeu)/2,Epp+((NbPetri-2)*HPetri+Jeu+2*Epp)/2]) rotate([0,0,90]) cube([(DPetri+2*Epp+Jeu)/2,DPetri/5,(NbPetri+1)*HPetri+Jeu+3*Epp],center=true);
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),0]) cylinder(1000,DPetri/20,DPetri/20);
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),0]) cylinder(1000,DPetri/20,DPetri/20);
        translate([(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),0]) cylinder(1000,DPetri/20,DPetri/20);
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),0]) cylinder(1000,DPetri/20,DPetri/20);
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2,Epp/2);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp,Epp/2,Epp/2);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),0]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2,Epp/2);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp,Epp/2,Epp/2);
            }

    }
}

module plateau(){
    difference() {
        union(){
            cylinder(Epp,(DPetri-2*Jeu-2*Epp)/2,(DPetri-2*Jeu-2*Epp)/2);
            translate([0,-DPetri/4-Jeu-Epp,-Epp/2]) cube([DPetri/5-2*Jeu,DPetri/2+2*Epp-Jeu,Epp],center=true);
            translate([0,-DPetri/2-Epp,((NbPetri+1)*HPetri-Epp)/2-Epp]) cube([DPetri/5-2*Jeu,Epp*2,(NbPetri+1)*HPetri-Epp],center=true);
                    }
            translate([0,0,DPetri/10+Epp]) rotate([90,0,0]) cylinder(DPetri*2,DPetri/20,DPetri/20);
        
    }   
}

module Couvercle(){
    difference(){
        union() {
            cube([DPetri+2*Epp+Jeu,DPetri+2*Epp+Jeu,Epp],center=true);
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),Epp/2]) 
            {
            translate([-(DPetri/20+3*Epp),0,0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
             translate([0,(DPetri/20+3*Epp),0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),Epp/2]) 
            {
            translate([(DPetri/20+3*Epp),0,0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
             translate([0,(DPetri/20+3*Epp),0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
            }
        translate([(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),Epp/2]) 
            {
            translate([-(DPetri/20+3*Epp),0,0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
             translate([0,-(DPetri/20+3*Epp),0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
            }
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),Epp/2]) 
            {
            translate([(DPetri/20+3*Epp),0,0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
             translate([0,-(DPetri/20+3*Epp),0]) cylinder(Epp-Jeu,Epp/2,Epp/2);
            }
        }

        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),-Epp/2]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),-Epp/2]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
             translate([0,(DPetri/20+Epp),0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
            }
        translate([DPetri/2-DPetri/40-Epp,(DPetri/2-DPetri/40-Epp),-Epp/2]) 
            {
            translate([-(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
             translate([0,-(DPetri/20+Epp),0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
            }
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),-Epp/2]) 
            {
            translate([(DPetri/20+Epp),0,0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
             translate([0,-(DPetri/20+Epp),0]) cylinder(Epp,Epp/2+3*Jeu,Epp/2+3*Jeu);
            }
        translate([DPetri/2-DPetri/40-Epp,-(DPetri/2-DPetri/40-Epp),-Epp/2]) cylinder(Epp,DPetri/20,DPetri/20);
        translate([-(DPetri/2-DPetri/40-Epp),-(DPetri/2-DPetri/40-Epp),-Epp/2]) cylinder(Epp,DPetri/20,DPetri/20);
        translate([(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),-Epp/2]) cylinder(Epp,DPetri/20,DPetri/20);
        translate([-(DPetri/2-DPetri/40-Epp),(DPetri/2-DPetri/40-Epp),-Epp/2]) cylinder(Epp,DPetri/20,DPetri/20);
    
            
    }
}

if(PrintAll==1){
color("Blue",Alpha) socle();
color("Red",Alpha) translate([DPetri+6*Epp,0,0]) chargeur();
color("White",Alpha) translate([0,-(DPetri+6*Epp),Epp/2]) Couvercle();
color("Green",Alpha) translate([(DPetri+6*Epp),-(DPetri+6*Epp),Epp]) plateau();
color("Yellow",Alpha) translate([(DPetri+6*Epp),0,0]) Stylet();
}
else
{
if(PrintSocle==1) color("Blue",Alpha) socle();
if(PrintLoader==1) color("Red",Alpha) translate([0,0,HPetri+3*Epp+Jeu]) chargeur();
if(PrintPlateau==1) color("Green",Alpha) translate([0,0,Epp+$t*100]) plateau();
if(PrintStylet==1) color("Yellow",Alpha) translate([0,-(DPetri+3*HPetri)/2,Epp+$t*100]) rotate([0,0,0]) Stylet();
//translate([0,$t*2*DPetri,Epp])PetriBox(DPetri,HPetri);
//translate([0,0,Epp+$t*2*DPetri])PetriBox(DPetri,HPetri);
if(PrintCouvercle>=1) color("White",Alpha) translate([0,0,HPetri+3*Epp+Jeu+Epp+(NbPetri-1)*HPetri+Jeu+Epp/2]) Couvercle();
if(PrintCouvercle==2) color("White",Alpha) translate([0,0,-Epp*1.5]) Couvercle();
}


