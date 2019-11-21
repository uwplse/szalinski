
/*[Coordinates]*/
point1x=80; 
point1z=0;
point2x=150;
point2z=80;
point3x=150;
point3z=120;
point4x=20;
point4z=200;
/*[Parameters]*/
Faces=4; 
wall_thickness=4;//[0.1:0.1:100]
bottom_thickness=5;
bottom_Z_offset=0;
bottom_rotation=360/Faces/2;
resolution=0.01; //[0.01:0.01:0.1]

show_origin_line=1;

$fn=Faces;

function curve_bezier_3(point1,point2,point3,point4)=
    [for(a=[0:resolution:1])
        point1*pow(1-a,3)+3*point2*a*pow(1-a,2)+3*point3*pow(a,2)*(1-a)+point4*pow(a,3)];

module line(point1,point2,width)
    {
        hull()
            {
            translate(point1)
                circle(d=width/2);
            translate(point2)
                circle(d=width/2);
            }
    }

module track(points,index,width)
{
    if(index<len(points))
        {
        line(points[index-1],points[index],width);
        track(points,index+1,width);
        }
}

point1=concat(point1x,point1z);
point2=concat(point2x,point2z);
point3=concat(point3x,point3z);
point4=concat(point4x,point4z);

points1=[point1,point2,point3,point4]; 

if(Faces%2==1)
{
rotate_extrude() track(curve_bezier_3(point1,point2,point3,point4),1,wall_thickness);
translate([0,0,bottom_Z_offset])
rotate([0,0,bottom_rotation])
cylinder(r=point1x,h=bottom_thickness);
echo(point1x);
}
else
{
rotate_extrude() track(curve_bezier_3(point1,point2,point3,point4),1,wall_thickness);
translate([0,0,bottom_Z_offset])
rotate([0,0,bottom_rotation*2])
cylinder(r=point1x,h=bottom_thickness);
}

if(show_origin_line==0)
rotate([90,0,0])
{
    line(point1,point2,wall_thickness);
line(point2,point3,wall_thickness);
line(point3,point4,wall_thickness);
track(curve_bezier_3(point1,point2,point3,point4),1,wall_thickness);
}