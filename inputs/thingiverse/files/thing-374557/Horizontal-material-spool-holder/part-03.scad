postDia = 9.6;
postHeight = 8;
shoulderDia = 16;
shoulderHeight = 3;
holeDia = 3.5;

difference() {
union() {
	cylinder($fn=36,r=postDia/2,h=postHeight);
	cylinder($fn=36,r=shoulderDia/2,h=shoulderHeight);
	//translate([-27,-17,0])
		//cube([54,34,2]);
}

cylinder($fn=36,r=holeDia/2,h=15);
}