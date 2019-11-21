Thickness=10; //desired thickness of grill plate
CupsPerRow=8; //desired number of cups along X
Rows=5; //desired number of rows along Y
Quality=20; //smoothness of cups
FrameWidth=2; //width of frame around grill
$fn=Quality;
z=Thickness;
b=CupsPerRow-1;
c=Rows-1;
r=(z*sqrt(3))/2;
y=(2*r)/3;


difference(){
cube([b*2*z+z,y+(c*2*r),z]);    
for(a=[0:b],d=[0:2:c]) translate([a*2*z+z, y+(d*2*r), z]) sphere(r=r);
for(a=[0:b],d=[1:2:c]) translate([a*2*z, y+(d*2*r), z]) sphere(r=r);
for(a=[0:b],d=[0:2:c]) translate([a*2*z, d*2*r, 0]) sphere(r=r);
for(a=[0:b],d=[1:2:c]) translate([a*2*z+z, d*2*r, 0]) sphere(r=r);
}

difference(){
translate([-FrameWidth, -FrameWidth, 0]) cube([b*2*z+z+FrameWidth*2,y+(c*2*r)+FrameWidth*2,z]);
translate([0,0,-0.1]) cube([b*2*z+z,y+(c*2*r),z+0.2]);
}