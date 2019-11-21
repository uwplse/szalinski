dhum_width=90-0.4;
dhum_length=35-0.8;
dhum_height=95-0.5;
dhum_tk=3.2;
rack_od=210+10;
rack_center_h=122.5-8;

no_hole_x=20;
no_hole_y=10;
no_hole_z=10;
intr_hole_x=dhum_width/(no_hole_x+1);
intr_hole_y=dhum_length/(no_hole_y+1);
intr_hole_z=dhum_height/(no_hole_z+1);
echo(intr_hole_x,intr_hole_y,intr_hole_z);
scaleFactor=(dhum_width-2*dhum_tk)/dhum_width;
scaleFactor_y=(dhum_length-3*dhum_tk)/dhum_length;
scaleFactor_z=(dhum_height-1*dhum_tk)/dhum_height;
echo(scaleFactor);
difference()
{
    rdhum();
    #translate([dhum_tk,dhum_tk/1.6,dhum_tk*2+0])
    scale([scaleFactor,scaleFactor_y,(scaleFactor_z)])
    rdhum();
    for(i=[1:1:no_hole_x])
    {
        for(j=[1:1:no_hole_z])
        {
            translate([intr_hole_x*(i),0,intr_hole_z*j])
            rotate([90,8,4])
           # cylinder(r=3/2-0.3,h=2*dhum_length+0.2,$fn=12,center=true);
        }
    }
    // 1/2 pitch
        for(i=[1:1:no_hole_x-1])
    {
        for(j=[1:1:no_hole_z-1])
        {
            translate([intr_hole_x*(i+0.5),0,intr_hole_z*(j+0.5)])
            rotate([90,8,4])
           # cylinder(r=3/2-0.75,h=2*dhum_length+0.2,$fn=12,center=true);
        }
    }
}



module rdhum(){
difference()
{
    cube([dhum_width,dhum_length,dhum_height]);
    translate([0,dhum_length/2+rack_od/2,rack_center_h-30])
    rotate([0,90,0])
       cylinder(r=rack_od/2+2.6,h=dhum_width,$fn=360);
    }
}