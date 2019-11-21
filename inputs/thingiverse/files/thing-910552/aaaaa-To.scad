//u123d;colour;colour;Colour;Red
//u123d;font;font;Font;Times New Roman
//u123d;text;text;Text;Sample;10
//u123d;numeric;height;Height (mm);5;2;10
//u123d;numeric;width;Width (mm);50;20;100
Font="Times New Roman";
Offset=1;
Spacing=1;
Text="Sample";
TextSize=10;
X=20;
Z=2;

for(i=[1:10]){
	color([i%2,i%2,i%2])translate([(i-1)*10,-1,-1])cube([10,1,1]);
	color([i%2,i%2,i%2])translate([-1,(i-1)*10,-1])cube([1,10,1]);
	color([i%2,i%2,i%2])translate([-1,-1,(i-1)*10])cube([1,1,10]);
}

color(
	[0,0,1]
)
translate(
	[-X/2,0,-Z/2]
)
resize(
	[X,0,Z],
	auto=true
)
union(){
	linear_extrude(
		height=2
	)
	offset(r=Offset){
		text(
			Text,
			font=Font,
			size=TextSize,
			spacing=Spacing
		);
	}
	linear_extrude(
		height=Z
	)
	text(
		Text,
		font=Font,
		size=TextSize,
		spacing=Spacing
	);
}
