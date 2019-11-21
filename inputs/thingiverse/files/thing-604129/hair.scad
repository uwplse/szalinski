hair_width=0.16;
width=4;
length=4;
height=4;

hw=hair_width;

hair(width,length,height);
scale([width,length,height]) cube();

module hair(w,l,h)
{
		for(x=[1:w-1],y=[1:l-1], z=[1:h])
		{
		translate([x,y,z]) scale([4, hw, hw]) translate([0,(z%2-0.5)*3,-0.5]) cube(center=true);
		translate([x,y,z]) scale([hw, 4, hw]) translate([(z%2-0.5)*3,0,-0.5]) cube(center=true);
		}
}