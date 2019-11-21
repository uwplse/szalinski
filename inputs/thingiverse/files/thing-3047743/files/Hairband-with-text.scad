/*[General settings]*/
Hairband_length=400;
Hairband_radius=Hairband_length/(2*3.1415);
Hairband_width=15;
Hairband_thickness=3;
Twist=0;
Flare=2;
Text_heigth=17;
Text_x_scale=1;
Text_y_scale=1;
Text_x_rotation=-20;
Text_z_rotation=0;
Text_radius_offset=-2;
Text_z_offset=2;
Inner_side_flat=1;
Text="                             WHAT GOES AROUND COMES AROUND                            ";
Font="Dancing Script OT";
Font_size=Hairband_thickness;

$fn=72;

step=320/len(Text);

scale([0.9,1.1,1])
difference()
{
union()
{
translate([0,0,-Hairband_width/2])
rotate([0,0,-20])
for(a=[0:1:len(Text)])
    {
        rotate([0,0,-a*step])
            translate([0,Hairband_radius+Text_radius_offset-Hairband_thickness,Text_z_offset])
                rotate([Text_x_rotation,0,Text_z_rotation])
               linear_extrude(height=Text_heigth,Hairband_width,twist=Twist,scale=Flare)
               scale([Text_x_scale,Text_y_scale,1])
                text(Text[a],font=Font,valing="center",halign="center",size=Font_size);
    }
difference()
{
cylinder(r=Hairband_radius,h=Hairband_width,center=true);
translate([0,0,0])
cylinder(r=Hairband_radius-Hairband_thickness,h=Hairband_width*2,center=true);
translate([-Hairband_radius/4,0,-Hairband_width])
cube([Hairband_radius/2,Hairband_radius*2,Hairband_width*2]);
}
}
if(Inner_side_flat==1)
{
cylinder(r=Hairband_radius-Hairband_thickness,h=Hairband_width*4,center=true);
}
translate([0,0,-50-Hairband_width/2])
cylinder(r=Hairband_radius*2,h=100,center=true);
}