bearing_length=26;
inner_r=4;
outer_r=7.5;
line_width=1;
stretch=1;

smalld0=((outer_r-inner_r)-line_width*3)/2;        
scyld0=line_width*2+smalld0; 
echo("scyld0",scyld0);

echo("line_width",line_width);
pi=3.14159265359;
Cin=2*pi*(inner_r+scyld0/2);
angle_in0=(360/(Cin/(scyld0)))*stretch;
echo("angle_in0",angle_in0);
tooth_length=stupid_divider(angle_in0*2,360);
echo("tooth_length",tooth_length);
nteeth=360/tooth_length;
angle_in=360/(nteeth*4);
echo("angle_in",angle_in);
echo("nteeth",nteeth);
echo("angle_in",angle_in);
mod=angle_in/angle_in0;

//%color("green",.5) linear_extrude(height = 2, convexity = 10, scale=1) pie_slice(outer_r, -angle_in*2, angle_in*2,256);

function stupid_divider(x,Max) = (((Max%ceil(x))==0)||(ceil(x)>=Max))? ceil(x) : (stupid_divider(ceil(x)+1,Max)) ; 
echo("divider",stupid_divider(52.2,360));

 module pie_slice(r, start_angle, end_angle,FN) {

    R = r * sqrt(2) + 1;

    a0 = (4 * start_angle + 0 * end_angle) / 4;

    a1 = (3 * start_angle + 1 * end_angle) / 4;

    a2 = (2 * start_angle + 2 * end_angle) / 4;

    a3 = (1 * start_angle + 3 * end_angle) / 4;

    a4 = (0 * start_angle + 4 * end_angle) / 4;

    if(end_angle > start_angle)

        intersection() {

        circle(r,$fn=FN);

        polygon([

            [0,0],

            [R * cos(a0), R * sin(a0)],

            [R * cos(a1), R * sin(a1)],

            [R * cos(a2), R * sin(a2)],

            [R * cos(a3), R * sin(a3)],

            [R * cos(a4), R * sin(a4)],

            [0,0]

       ]);

    }

}

module S(height,thickness,line_width)
{
smalld=(thickness-line_width*3)/2;        
scyld=line_width*2+smalld;
  
difference()    
{
//translate([scyld/2,0,0]) cylinder(h=height,d=scyld,$fn=128);
translate([scyld/2,0,0]) linear_extrude(height, convexity = 10, scale=1)
pie_slice(scyld/2, 180, 360,256);    
translate([scyld/2,0,-1]) cylinder(h=height+2,d=smalld,$fn=256);
//translate([0,0,-1]) cube([scyld,scyld,height+2]);
}
difference()    
{
//translate([thickness-scyld/2,0,0]) cylinder(h=height,d=scyld,$fn=128);
translate([thickness-scyld/2,0,0]) linear_extrude(height, convexity = 10, scale=1) 
pie_slice(scyld/2, 0, 180,256);    
translate([scyld/2,0,-1]) cylinder(h=height+2,d=smalld,$fn=256);    
translate([thickness-scyld/2,0,-1]) cylinder(h=height+2,d=smalld,$fn=256);
//translate([thickness-scyld,-scyld,-1]) cube([scyld,scyld,height+2]);    
}



}

module tooth()
{
difference()
{
linear_extrude(height = bearing_length, convexity = 10, scale=1)
pie_slice((inner_r+line_width), -angle_in-1, angle_in+1,256); //bad stl fix   
translate([0,0,-1])  cylinder(r=inner_r,h=bearing_length+2,$fn=256);
}
difference()
{
linear_extrude(height = bearing_length, convexity = 10, scale=1)
pie_slice((outer_r), angle_in-1, angle_in*3+1,256); //bad stl fix   
translate([0,0,-1]) cylinder(r=outer_r-line_width,h=bearing_length+2,$fn=256);
}
rotate([0,0,-angle_in]) translate([inner_r,0,0]) S(bearing_length,outer_r-inner_r,line_width);
rotate([0,0,angle_in])  translate([outer_r,0,0]) mirror() S(bearing_length,outer_r-inner_r,line_width);
}




intersection()
{
{

union()
{
difference()
{
translate([0,0,0]) cylinder(r1=outer_r-line_width/2,r2=outer_r,$fn=256,h=line_width/2);       
translate([0,0,0]) cylinder(r1=inner_r+line_width/2,r2=inner_r,$fn=256,h=line_width/2);
}
difference()
{
translate([0,0,bearing_length-line_width/2]) cylinder(r2=outer_r-line_width/2,r1=outer_r,$fn=256,h=line_width/2);       
translate([0,0,bearing_length-line_width/2]) cylinder(r2=inner_r+line_width/2,r1=inner_r,$fn=256,h=line_width/2);
}

difference()
{
translate([0,0,line_width/2]) cylinder(r=outer_r,$fn=256,h=bearing_length-line_width);
translate([0,0,line_width/2]) cylinder(r=inner_r,$fn=256,h=bearing_length-line_width);     
}

}


}

//union()

for(i=[0:angle_in*4:360-angle_in])

rotate([0,0,i]) tooth();
}

