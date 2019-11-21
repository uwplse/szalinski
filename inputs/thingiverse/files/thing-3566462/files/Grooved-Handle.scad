//Correspond to the distance from the center of the peace to the inner groove
minRadius=50;

//Correspond to the distance from the center of the peace to the outer groove
maxRadius=65;

//It is the thickness of the peace
thick=5;

//The number of grooves on the edge
Grooves=12;


Handle(minRadius,maxRadius,thick,Grooves);

module Handle(inRadius=50, outRadius=55, Thickness=5, grooves=12){
	angle=360.0/grooves;
	halfAngle=angle/2.0 ;
	quaterAngle=halfAngle/2;
	GrooveA=(outRadius-inRadius)/2.0 ;
	tgRadius=inRadius+GrooveA;
	X0=pow(GrooveA,2)/tgRadius;
	Y0=(1-pow(GrooveA/tgRadius,2))*(tgRadius*tan(quaterAngle));
	GrooveB=Y0/sqrt(1-pow(X0/GrooveA,2));
	hRadius=sqrt(pow(tgRadius-X0,2)+pow(Y0,2))   ;
	difference(){ 
		union(){
			cylinder(h=Thickness, r=hRadius, center=true);
			for (i=[1:grooves]){
				rotate(i*angle) translate([tgRadius,0,0]) scale([GrooveA/GrooveB,1,1]) cylinder(h=Thickness, r=GrooveB, center=true);
			}
		}
		union(){
			for (i=[1:grooves]){
				rotate(i*angle+halfAngle) translate([tgRadius,0,0]) scale([GrooveA/GrooveB,1,1]) cylinder(h=Thickness*1.01, r=GrooveB, center=true);
				
			}
		}
	}
}
