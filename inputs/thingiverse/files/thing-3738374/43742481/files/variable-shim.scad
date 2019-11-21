shim_thickness=6;

width=100;

groove=50;

length=90;

tab_lgth=20;

groovestart=40;

label=15;

difference() {
    forme();
    texte();
}

module forme() {
    a=width/2-groove/2;
    b=width/2+groove/2;
    c=width;
    d=length;
    f=tab_lgth;
    g=groovestart;
    
    linear_extrude(height = shim_thickness)
    polygon([[a,0], [a,f], [0,f], [0,d], [a,d], [a,g], [b,g], [b,d], [c,d], [c,f], [b,f], [b,0]]);
}

module texte() {
    e=width/2;
    h=label;
    color([1,0,0])
    translate([e,h,shim_thickness-1])
    linear_extrude(height = 1)
    text(str(shim_thickness, " mm"), font = "Consolas:style=Bold", halign="center");
}
