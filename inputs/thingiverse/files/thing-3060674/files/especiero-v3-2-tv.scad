/* Customizable modular spice holder by José Manuel Rute, thingiverse: vimamsa. 2018/08/21 
*/

/*[General]*/
//Wall Thickness
    t=2.1;
//Corner Rounding Radius
    r=3;
//Tolerance
    tol=0.5;
//$fn
    $fn=180;
/*[Pot]*/
//Diameter
    bd=45;
//Height
    bh=116;
/*[Pot Holder]*/
//Beam Size
    av=15;
//Angle
    ang=45;
/*[Rack]*/
//Mounting Type
    rack_type="Wall"; //["Wall", "Countertop"]
//Wall Mount Connecting Flaps
    flaps="Left & Right"; //["Left & Right", "Left", "Right", "None"]
//Number of Modules
    n=3;
// Separation Between Adjacent Modules
    sep=5.5;
// Connector Rounding Radius External corners
    rro=1;
// Connector Rounding Radius Internal corners
    rri=2;
/*[Joint Notches]*/
//Width
    am=2.1;
//Depth
    fm=4.5;
//Distance from Beam End
    dm=4;
/*[Display]*/
//Pot(s)
    mb="No"; //["Yes", "No"]
//Back Connector(s)
    mcon="Detached"; //["Attached", "Detached"]
// Front Connector(s)
    mconf="Detached"; //["Attached", "Detached"]
/*[Export]*/
// Pot Holder
    exp_soporte="Yes"; //["Yes", "No"]
// Back Connector
    exp_con="Yes"; //["Yes", "No"]
// Front Connector
    exp_con_f="Yes"; //["Yes", "No"]
    
/* Valores calculados */
// Longitud viga
    lv=(bh+t)*cos(ang);
// Radio arco
//    ar=sqrt(pow(lv,2)+pow(av/2,2))-1.23*t;
//    ar=0.6*bh;
    ar=lv-2*dm-am-1.5*t;
/* Soporte pared */
sb=0.5*bd-0.5*av-t-tol;
fw=0.5*(bd-av+sep);
asp=flaps=="None" ? n*bd-2*sb+(n-1)*sep:flaps=="Left & Right" ? n*bd-2*sb+(n-1)*sep+2*fw:n*bd-2*sb+(n-1)*sep+fw;echo("Wall mount width (mm):",asp+2);
fsp=2*dm+am+t+tol;
amd=av+2*t+2*tol;
dem=2*sb+sep;
/* Soporte encimera */
ase=bd-av+sep;

//use <jmutils.scad>
//use <arc.scad>

if (mb=="Yes") 
    {for (i=[0:n-1])   
    {translate([-0.5*bd+i*(bd+sep), -(bd+2*tol)*cos(ang)+t*cos(ang), (bd+2*tol)*sin(ang)+t*sin(ang)]) rotate([-47,0,0]) %bote();}}


if (exp_soporte=="Yes")
{  
//    intersection()  
//    {
        for (i=[0:n-1])
        {translate([i*(bd+sep),0,0]) soporte();}
//        translate([0,lv,0]) cube([80,20,80], center=true);
//    }
}

if (exp_con=="Yes")
    {if (rack_type=="Wall")
        {translate([-av/2-t-tol,mcon=="Attached" ? lv+tol:lv+tol+fsp+5,mcon=="Attached" ? -av/2-t:-av/2]) color("RoyalBlue", 0.8) s_pared();}
    else if (n>1) 
    {{for (i=[0:n-2])
        {translate([i*(bd+sep)+0.5*av, mcon=="Attached" ? lv-dm-am:lv-dm-am+0.5*tol+am+dm+5, -0.5*av]) color("RoyalBlue") s_enc();}}}
    }

if (exp_con_f=="Yes")
{for (i=[0:n-2])
{translate([mconf=="Attached" ? i*(bd+sep)+0.5*av:i*(bd+sep)+0.5*bd+0.5*sep+tol, mconf=="Attached" ? 0.5*av/sin(ang)+dm-am:0.5*av/sin(ang)+dm-am+0.25*tol, mconf=="Attached" ? -0.5*av+t:-0.5*av]) rotate([0,0,mconf=="Attached" ? 0:90]) color("RoyalBlue") f_con();}}
// --------------------------------------------------------------------
module s_enc()
{
    linear_extrude(height=av) union()
    {
        translate([ase+av/2,am]) muesca_izq_enc();
        translate([-av/2,am]) muesca_dcha_enc();
        square([ase,am]);
    }
    
}

module f_con()
{
    linear_extrude(height=av-t) union()
    {
        translate([ase+av/2,am]) muesca_izq_enc();
        translate([-av/2,am]) muesca_dcha_enc();
        square([ase,am]);
    }
    
}

module s_pared()
{
    difference()
    {
        union()
        {
            linear_extrude(height=av+t) union()
            {
                difference()
                {
                    rd(rri, "int") union()
                    {
                        translate([flaps=="Left & Right" ? -fw:flaps=="None" ? 0:flaps=="Left" ? -fw:0,0,0])
                        square([asp,t]);    
                        for (i=[0:n-1])
                        {
                            translate([i*(amd+dem),0])
                            {translate([0,-fsp+t]) square([t,fsp]);
                            translate([t+av+2*tol,-fsp+t]) square([t,fsp]);}
                        }
                    }
                        for (i=[0:n-1])
                            {translate([i*(amd+dem)+t,-fsp+t]) square([amd-2*t,fsp-t]);} 
                    }
                
                for (i=[0:n-1])
                {
                    translate([i*(amd+dem),0])    
                    {translate([av/2+t,-dm-tol]) {muesca_izq_pared(am,fm+tol); translate([2*tol,0]) muesca_dcha_pared(am,fm+tol);}}
                }  
            }
            
            linear_extrude(height=t)
            {
                for (i=[0:n-1])
                {translate([i*(amd+dem),-fsp+t]) rd(rro) square([amd,fsp]);} 
            }
            if (flaps=="Right" || flaps=="Left & Right") translate([flaps=="Right" ? asp:asp-fw,t,0.25*(av+t)]) dove_tail();
        }
        
        for (i=[0:n-1])
        {translate([i*(amd+dem)+0.5*amd,1.5*t,0.5*av+t]) rotate([90,0,0]) cylinder(d=3,h=2*t);}
        
        if (flaps=="Left" || flaps=="Left & Right") translate([-fw,1.5*t,0.25*(av+t)]) dove_tail(2*t);
    }
}
 
module dove_tail(t=t, a=2,h=0.5*(av+t))
{
    translate([0,0,0.5*h]) rotate([90,0,0]) linear_extrude(height=t) difference() {
    translate([0,-0.5*h]) square([a,h]);
    translate([0,-0.5*h]) rotate(-45)square(a/cos(45));
    mirror([0,1]) translate([0,-0.5*h]) rotate(-45)square(a/cos(45));    
    }
}

module soporte()
{
    difference()
    {
        union()
        {
            viga();
            translate([0,0,0]) rotate([-45,0,0]) base_rd();
            translate([av/2,0,av/2]) rotate([90,0,-90]) arco(); 
        }
        
        translate([0,0,-0.5*av/cos(ang)]) rotate([45,0,0]) cube([av+10,av,av],center=true);
//        #translate([0, -0.5*(bd+2*tol)*cos(ang)+t*cos(ang), t/sin(ang)+av*sin(ang)]) rotate([-45,0,0]) cylinder(d=bd+2*tol, h=bh);
        translate([0, -0.5*(bd+2*tol)*cos(ang)+t*cos(ang), 0.5*(bd+2*tol)*sin(ang)+t*sin(ang)]) rotate([-45,0,0]) cylinder(d=bd+2*tol, h=bh);
        translate([0,0.5*av/sin(ang)+dm+tol,-av/2+t]) muescas_enc(am+1.5*tol, fm+tol, 0.5*am+1.5*tol );
        if (rack_type=="Wall")
        {translate([0,lv-dm+tol,-av/2]) muescas_pared_corte(am+2*tol, fm+tol);}
        else
        {translate([0,lv-dm+tol,-av/2]) muescas_enc(am+1.5*tol, fm+tol, 0.5*am+1.5*tol );}        
//        translate([0,lv-1,-0.5*av-1]) linear_extrude(heigth=av+2) {rd(1) square([5,3],center=true);}
        *textura();
        *translate([0,0.5*lv-5.7,0.5*av]) logo();
    }    
}


module textura(a=av+0.1, l=lv-2*dm+am+2*t, d=0.5, aa=1, n=7)
{    
    for (i=[1:n])       
    {
        sep=i;
        translate([0,i*sep+15,0])
        rotate([-90,0,0]) linear_extrude(height=aa) difference()
        {
            rd(r) square(a, center=true);
            rd(r) square(a-d, center=true);
        }
    }
}

module viga(a=av, l=lv, r=r)
{
    rotate([-90,0,0])
    linear_extrude(height=l) rd(r) square(a, center=true);
}

module base_rd(od=bd+2*t+2*tol, id=bd+2*tol)
{
    h=0.5*av/cos(ang);
    translate([0,-id/2,0]) difference()
    {
        cylinder(d=od, h=h);
        translate([0,0,t]) cylinder(d=id, h=h);
        translate([0,0,-1]) cylinder(d=id-1.5*h, h=h);
        translate([0,-0.5*id,-1]) cube([od+10, bd, 2*id], center=true);
    }  
}

module arco(r=ar, ang=ang+5, h=av)
{
    linear_extrude(height=h)
    rotate(157.5) arc(r,1.5*t,ang);    
}

module muesca_izq_pared(a=am, f=fm)
{
    translate([-t-0.5*av,0]) union()
    {
        translate([t,-a]) square([f,a]);
//        translate([t+f,-0.5*a]) circle(d=a+1);   
    }
}

module muesca_izq_enc(a=am, f=fm, at=0.5*am)
{
    translate([-t-0.5*av,0]) union()
    {
        translate([t,-a]) square([f,a]);
        translate([t+f-at,-1.5*a]) square([at,2*a]);   
    }
}


module corte_tornillo(t=2, a=6, h=0.5*av+t+1.5)
{
    lc=0.5*a/cos(45);
    translate([0,0,h]) rotate([90,0,0]) linear_extrude(height=t) difference() {
    translate([-0.5*a,-h]) square([a,h]);
    translate([-0.5*a,-0.5*lc/cos(45)]) rotate(45)square(lc);
    mirror([1,0]) translate([-0.5*a,-0.5*lc/cos(45)]) rotate(45)square(lc);    
    }
}

module muesca_dcha_pared(a=am, f=fm)
{
    mirror([1,0,0]) muesca_izq_pared(a,f);
}

module muesca_dcha_enc(a=am, f=fm, at=0.5*am)
{
    mirror([1,0,0]) muesca_izq_enc(a,f,at);
}


module muescas_pared_corte(a=am, f=fm, h=av+t)
{    
    translate([0,0,0])
    union()
    {
    linear_extrude(height=av+t) union()
    {
        muesca_izq_pared(a,f);
        muesca_dcha_pared(a,f);
    }
    translate([0,dm,-0.1]) corte_tornillo();
}
}

module muescas_pared(a=am, f=fm, h=av+t)
{    
    translate([0,0,0])
    linear_extrude(height=av+t) union()
    {
        muesca_izq_pared(a,f);
        muesca_dcha_pared(a,f);
    }
}

module muescas_enc(a=am, f=fm, at=0.5*am, h=av+t)
{
    translate([0,0,0])
    linear_extrude(height=h) union()
    {
        muesca_izq_enc(a,f,at);
        muesca_dcha_enc(a,f,at);
    }
}

module bote(d=bd,h=bh) {
    
    translate([d/2,d/2,0])
    union()
    {
        color("white", 0.4) cylinder(d1=bd, d2=0.9*bd , h=h-25);
        translate([0,0,h-25]) color("white", 0.4) rotate_extrude() 
        {translate([0.45*bd,0]) translate([0,2.5])circle(d=5);}
        translate([0,0,h-20]) color("green", 0.7) cylinder(d=bd-1, h=20);
        translate([0,0,h]) color("green", 0.7) cylinder(d=0.67*bd, h=1.5);
    }
}

// Utils
module arc(radius, thick, angle){
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick);
			circle(radius);
		}
	}
}

module rdint(r=1) {
   offset(r = -r) {
     offset(delta = r) {
       children();
     }
   }
}

module rdext(r=1) {
   offset(r = r) {
     offset(delta = -r) {
       children();
     }
   }
}

module chafint(r=1) {
   offset(delta = -r, chamfer=true) {
     offset(delta = r) {
       children();
     }
   }
}

module chafext(r=1) {
   offset(delta = r, chamfer=true) {
     offset(delta = -r) {
       children();
     }
   }
}

// redondear polígonos (2D)
// r = radio [1] 
// esq = esquinas {["all"], "int", "ext"}
// chaf = chaflán {"true", ["false"]}
module rd(r=1, esq="all", chaf=false) {
    if (chaf == false) {
        if (esq == "all" ) {rdint(r) rdext(r) children();}
            else if (esq == "ext") {rdext(r) children();}
        else {rdint(r) children();}}
    else {
        if (esq == "all" ) {chafint(r) chafext(r) children();}
        else if (esq == "ext") {chafext(r) children();}
        else {chafint(r) children();}}
}

// redondear 3D
// r = radio [1]
// flat = caras superior e inferior planas {[true], false}
// aumenta en +r las 3 dimensiones 
// para mantener dimensiones se puede hacer un resize antes de llamar
// a este módulo, p.ej.:
// resize([x], auto=true)
//
module rd3d(r=1,flat=true) {
    if (flat == true) {        
//        resize([x, y, z])
        translate([r,r])
        minkowski() {
            children(0);
            cylinder(r=r,h=2*r);}}
    else {
//        resize([x,y,z])
        translate([r,r,r])
        minkowski() {
            children(0);
            sphere(r=r);}}   
}

function centrar(a,b) = a/2-b/2;
