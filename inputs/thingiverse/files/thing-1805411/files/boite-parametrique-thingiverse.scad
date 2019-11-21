//**********************************************************************************************
// Laurent Le Goff
// GNU GPL v3
// http://www.thingiverse.com/thing:1805411
// member of TyFab fablab  http://tyfab.fr   
//**********************************************************************************************
//        dimension volume interieur
//     
//            _________________            \ \
//        ^  /                /|  ^         \ \
//     P /  /                / |  |          \_\___________
//      v  /________________/  |  |         | \_____________
//        |                 |  |  |          \|_
//        |                 | /|  | H       |\|_|T
//        |_________________|/ |  |          \|_
//     ^  |                 |  |  v         |\|_|
//   H1|  |                 | /              \|_
//     v  |_________________|/                |_|
//     
//        <----------------->     
//                 L
/*[Internal volume (mm)]*/
//Height - Hauteur
H = 150;   // hauteur du volume interieur en mm
//Length - Profondeur
P = 290;   // Profondeur du volume interieur en mm
//Width - Largeur
L = 360;   // Largeur du volume interieur en mm
//Low height - Hauteur de la partie basse
H1= 100;   // hauteur interieur de la partie basse en mm
//Board thickness - Epaisseur de la planche
Ep= 5;     // Epaisseur de la planche en mm
//Lug size
T = 15;  // Taille du tenon en mm
//--------------------------------------------------------------
/*[Options]*/
//Crate or Box - Caisse ou Boite
Boite = 1;  // [0:Crate,1:Box] 
//Close or Open - Fermee ou Ouverte
Ouvert = 1; // [0:Close,1:Open] 
//Foot 
Pied = 1;   // [0:without,1:with] 
//Handle
Poignee = 0;// [0:without,1:with(1*Ep),2:with(2*Ep),3:with(3*Ep)] 
//3D model or board profile
Dxf = 1;    // [0:3D,1:STL,2:DXF(OpenScad only)] 
// 0 -> 3D Model   1 -> board profile STL   2 -> board profil DXF
//--------------------------------------------------------------

/*[Hiden]*/
H2= H-H1;  // hauteur interieur de la partie haute


Lcenter = ((L-T-2*Ep)%(T*4))>=(2*T) ? 1 : 0; 
Pcenter = ((P-T-2*Ep)%(T*4))>=(2*T) ? 1 : 0; 

module fond()
{
    difference() {
        cube([L+2*Ep,P+2*Ep,Ep],center=true);  
        for (i=[Lcenter*T:2*T:L/2-Ep])
        {
           translate([i,P/2+Ep/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,P/2+Ep/2,0]) cube([T,Ep,Ep],center=true);
           translate([i,-P/2-Ep/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,-P/2-Ep/2,0]) cube([T,Ep,Ep],center=true);
        }
        for (i=[Pcenter*T:2*T:P/2-Ep])
        {
           translate([L/2+Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([L/2+Ep/2,-i,0]) cube([Ep,T,Ep],center=true);
           translate([-L/2-Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([-L/2-Ep/2,-i,0]) cube([Ep,T,Ep],center=true);
        }
    }
}

module coteb1()
{
    difference() {
        cube([L+2*Ep,H1+Ep+2*Ep*Pied,Ep],center=true);  
        for (i=[Lcenter*T-T:2*T:L/2+Ep])
        {
           translate([i,(H1-2*Ep*Pied)/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,(H1-2*Ep*Pied)/2,0]) cube([T,Ep,Ep],center=true);
        }
        translate([L/2,(H1-2*Ep*Pied)/2,0]) cube([2*Ep,Ep,Ep],center=true);
        translate([-L/2,(H1-2*Ep*Pied)/2,0]) cube([2*Ep,Ep,Ep],center=true);
        for (i=[(H1+Ep+2*Ep*Pied)/2-T/2:-2*T:-(H1+Ep+2*Ep*Pied)/2-T])
        {
           translate([L/2+Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([-L/2-Ep/2,i,0]) cube([Ep,T,Ep],center=true);
        }
        if (Pied==1)
        {
            translate([0,H1/2+Ep,0]) cube([L-8*Ep,Ep,Ep],center=true);
            translate([L/2-4*Ep,H1/2+3*Ep/2,0]) cylinder(r=Ep,h=Ep,center=true);
            translate([-L/2+4*Ep,H1/2+3*Ep/2,0]) cylinder(r=Ep,h=Ep,center=true);
        }
    }
}

module coteb2()
{
    difference() {
        cube([P+2*Ep,H1+Ep+2*Ep*Pied,Ep],center=true);  
        for (i=[Pcenter*T-T:2*T:P/2+Ep])
        {
           translate([i,(H1-2*Ep*Pied)/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,(H1-2*Ep*Pied)/2,0]) cube([T,Ep,Ep],center=true);
        }
        translate([P/2,(H1-2*Ep*Pied)/2,0]) cube([2*Ep,Ep,Ep],center=true);
        translate([-P/2,(H1-2*Ep*Pied)/2,0]) cube([2*Ep,Ep,Ep],center=true);
        for (i=[(H1+Ep+2*Ep*Pied)/2-3*T/2:-2*T:-(H1+Ep+2*Ep*Pied)/2-T])
        {
           translate([P/2+Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([-P/2-Ep/2,i,0]) cube([Ep,T,Ep],center=true);
        }
        if (Pied==1)
        {
            translate([0,H1/2+Ep,0]) cube([P-8*Ep,Ep,Ep],center=true);
            translate([P/2-4*Ep,H1/2+3*Ep/2,0]) cylinder(r=Ep,h=Ep,center=true);
            translate([-P/2+4*Ep,H1/2+3*Ep/2,0]) cylinder(r=Ep,h=Ep,center=true);
        }
        if (Poignee!=0)
        {
            translate([0,-(H1+Ep+2*Ep*Pied)/2+Poignee*Ep+15,0]) cube([90,20,Ep],center=true);
            translate([45,-(H1+Ep+2*Ep*Pied)/2+Poignee*Ep+15,0]) cylinder(r=10,h=Ep,center=true);
            translate([-45,-(H1+Ep+2*Ep*Pied)/2+Poignee*Ep+15,0]) cylinder(r=10,h=Ep,center=true);
        }
    }
}

module coteh1()
{
    difference() {
        cube([L+2*Ep,H2+Ep,Ep],center=true);  
        for (i=[Lcenter*T-T:2*T:L/2+Ep])
        {
           translate([i,H2/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,H2/2,0]) cube([T,Ep,Ep],center=true);
        }
        translate([L/2,H2/2,0]) cube([2*Ep,Ep,Ep],center=true);
        translate([-L/2,H2/2,0]) cube([2*Ep,Ep,Ep],center=true);
        for (i=[(H2+Ep)/2-3*T/2:-2*T:-H2/2-T])
        {
           translate([L/2+Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([-L/2-Ep/2,i,0]) cube([Ep,T,Ep],center=true);
        }
    }
}

module coteh2()
{
    difference() {
        cube([P+2*Ep,H2+Ep,Ep],center=true);  
        for (i=[Pcenter*T-T:2*T:P/2+Ep])
        {
           translate([i,H2/2,0]) cube([T,Ep,Ep],center=true);
           translate([-i,H2/2,0]) cube([T,Ep,Ep],center=true);
        }
        translate([P/2,H2/2,0]) cube([2*Ep,Ep,Ep],center=true);
        translate([-P/2,H2/2,0]) cube([2*Ep,Ep,Ep],center=true);
        for (i=[(H2+Ep)/2-T/2:-2*T:-(H2+Ep)/2])
        {
           translate([P/2+Ep/2,i,0]) cube([Ep,T,Ep],center=true);
           translate([-P/2-Ep/2,i,0]) cube([Ep,T,Ep],center=true);
        }
    }
}

module export_dxf() 
{
    fond();
    translate([0,-P/2-H1/2-3*Ep-T,0]) coteb1();
    rotate([0,0,-90]) translate([0,-L/2-H1/2-3*Ep-T,0]) coteb2();
    if (Boite==1) 
    {
        rotate([0,0,180]) translate([0,-P/2-H2/2-2*Ep-T,0]) coteh1();
        rotate([0,0,90]) translate([0,-L/2-H2/2-2*Ep-T,0]) coteh2();
    }
    else
    {
        rotate([0,0,180]) translate([0,-P/2-H1/2-3*Ep-T,0]) coteb1();
        rotate([0,0,90]) translate([0,-L/2-H1/2-3*Ep-T,0]) coteb2();   
    }
}

module bas()
{
    color("Khaki") translate([0,0,-H1-Ep/2]) fond();
    color("DarkKhaki") translate([0,-P/2-Ep/2,-H1/2-Ep/2-Ep*Pied]) rotate([-90,0,0]) coteb1();
    color("DarkKhaki") translate([0,+P/2+Ep/2,-H1/2-Ep/2-Ep*Pied]) rotate([-90,0,0]) coteb1();
    color("SandyBrown") translate([-L/2-Ep/2,0,-H1/2-Ep/2-Ep*Pied]) rotate([-90,0,90]) coteb2();
    color("SandyBrown") translate([+L/2+Ep/2,0,-H1/2-Ep/2-Ep*Pied]) rotate([-90,0,90]) coteb2();
}

module haut()
{
    color("Khaki") translate([0,0,H2+Ep/2]) fond();
    color("BurlyWood") translate([0,-P/2-Ep/2,H2/2+Ep/2]) rotate([90,0,0]) coteh1();
    color("BurlyWood") translate([0,+P/2+Ep/2,H2/2+Ep/2]) rotate([90,0,0]) coteh1();
    color("SaddleBrown") translate([-L/2-Ep/2,0,H2/2+Ep/2]) rotate([90,0,90]) coteh2();
    color("SaddleBrown") translate([+L/2+Ep/2,0,H2/2+Ep/2]) rotate([90,0,90]) coteh2();
}


if (Dxf==0)
{
    bas();
    if (Boite==1)
        if (Ouvert==0) haut();
        else translate([0,P/2+Ep+1,0]) rotate([-100,0,0]) translate([0,-P/2-Ep-1,0]) haut();
}
if (Dxf==1) export_dxf();
if (Dxf==2) projection(cut = false) export_dxf();

