Thickness=5; //desired thickness of grill plate
CupsPerRow=3; //desired number of cups along X
Rows=3; //desired number of rows along Y
Quality=20; //smoothness of cups
$fn=Quality;
z=Thickness;
b=CupsPerRow-1;
c=Rows-1;
r=(z*sqrt(3))/2;
y=(2*r)/3;


difference(){
translate([-2*z, -z, 0]) cube([b*2*z+2*z,y+(2*c*r)+2*z,z]);    
for(a=[0:b],d=[0:2:c]) translate([a*2*z-z, y+(d*2*r), z]) sphere(r=r);
for(a=[0:b-1],d=[1:2:c]) translate([a*2*z, y+(d*2*r), z]) sphere(r=r);
for(a=[0:b-1],d=[0:2:c]) translate([a*2*z, d*2*r, 0]) sphere(r=r);
for(a=[0:b],d=[1:2:c]) translate([a*2*z-z, d*2*r, 0]) sphere(r=r);
}