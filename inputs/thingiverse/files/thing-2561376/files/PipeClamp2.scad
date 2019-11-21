D_internal=25;//[8:0.1:50]
thickness=3;//[3:0.5:10]
H_clamp=8;//[5:0.5:20]
angle=60;//[30:5:80]


/* [Hidden] */
R_internal=D_internal/2;

Rext=R_internal+thickness;
radius_cylinder=thickness/2 + thickness/10;

H_clamp=8;
//25,16,19,22
$fn=50;

difference()
{
    cylinder(r=Rext,h=H_clamp);
    translate ([0,0,-0.5])    cylinder(r=R_internal,H_clamp+1);
    hull()
    {
        rotate([0,0,0])translate ([0,0,-0.5]) cylinder(r=1,h=H_clamp+1);
        rotate([0,0,angle])translate ([(R_internal+thickness)*20,0,-0.5]) cylinder(r=1,h=H_clamp+1);
        rotate([0,0,-angle])translate ([(R_internal+thickness)*20,0,-0.5]) cylinder(r=1,h=H_clamp+1);
    }
}

rotate([0,0,-angle])translate ([R_internal+thickness/2,0,0]) cylinder(r=radius_cylinder,h=H_clamp);
rotate([0,0,+angle])translate ([R_internal+thickness/2,0,0]) cylinder(r=radius_cylinder,h=H_clamp);

