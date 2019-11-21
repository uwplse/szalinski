/* Modular pencil holder by Jose Manuel Rute, 2018-06-07. Thingiverse: vimamsa  */

/* [Pot] */
// inner width 
    d=40;
// wall thickness
    t=5;
// height
    h=70;
// corner rounding radius: 0 (squared)  <= r < d/2 (rounded)
    r=15;
/* [Tray] */
// number of horizontal modules
    nx=3;
// number of vertical modules
    ny=1;
// height
    hb=15;
// tolerance (clearance)
    tol=0.5;
/* [Display] */
// Number of pots to show
    num_cubiletes="all";//[one, all]
// Pot placement respect to the tray
    en_bandeja="inside";//[inside, outside]
/* [Export] */
// Pots
    exportar_cubiletes="Yes"; //[Yes,No]
// Bandeja
    exportar_bandeja="Yes"; //[Yes,No]
/* [Other] */
// $fn
    $fn=100;

// valores calculados
a= d+2*t; // ancho interno
rv=(r<d/2 ? r:d/2-0.01); // radio validado

if (exportar_cubiletes=="Yes") { colocar_cubiletes();}
if (exportar_bandeja=="Yes")
{
    color("Gray",0.7) {translate([-t,(en_bandeja =="inside" ? -t : -ny*a-3*t)]) bandeja(nx,ny,hb);}
}

// -------------------------------------------------------------------
module cubilete(x=d, y=d, h=h, r=rv)
{
    translate([r+t,r+t,0]) union()
    {
        linear_extrude(height=t) // base
        {
            offset(r=r+t) square([x-2*r,y-2*r], center=false);
        }
        
        linear_extrude(height=h) // tubo
        {
            difference()
            {
                offset(r=r+t) square([x-2*r,y-2*r], center=false);
                offset(r=r) square([x-2*r,y-2*r], center=false);
            }
        }
    }   
}

module bandeja(nx=3,ny=1,h=hb)
{
    cubilete(nx*a+(nx+1)*tol,ny*a+(ny+1)*tol,h,rv+t);
}

module colocar_cubiletes()
{
    if (num_cubiletes=="all") 
    {
        for (x=[0:nx-1]) 
        {
            for (y=[0:ny-1])
            {
                color(espar(x) ? (espar(y) ? "Gray":"Orange") : (espar(y) ? "Orange":"Gray")) {translate([x*a+(x+1)*(en_bandeja=="inside" ? tol:2*tol),y*a+(y+1)*(en_bandeja=="inside" ? tol:2*tol),(en_bandeja=="inside" ? t:0)]) cubilete();}
            }       
        }
    }
    else
    {
        color("Orange") {translate([tol,tol,(en_bandeja=="inside" ? t:0)]) cubilete();}
    }
}

function espar(x)= x/2-floor(x/2)==0 ? true:false;

