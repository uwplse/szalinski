//kite spar holder
//all units in mm
fiberglass_rod_diameter=8;
wooden_dowel_diameter=8;
tolerance=0.2;
resolution=200;
dowel_holder_length=26;
bevel=2;
dowel_holder_width=11-bevel;


fr=fiberglass_rod_diameter;
wd=wooden_dowel_diameter;
t=tolerance;
rez=resolution;
dhl=dowel_holder_length;
dhw=dowel_holder_width;


difference(){
    solids();
    holes();
}

module holes(){
//wooden dowel
rotate(a=90,v=[0,1,0])cylinder(d=wd+t,h=dhl+bevel+10,center=true,$fn=rez);
//fiber glass rod
rotate(a=-45,v=[0,0,1])translate([(dhl+20)/2,0,0])rotate(a=90,v=[0,1,0])cylinder(d=fr+t,h=dhl+20,$fn=rez,center=true);

}

module solids(){
minkowski(){
    union(){
    cube([dhl,dhw,dhw],center=true);
    rotate(a=-45,v=[0,0,1])translate([dhl/2,0,0])cube([dhl,dhw,dhw],center=true);
    }
sphere(r=bevel,$fn=rez);
}
}