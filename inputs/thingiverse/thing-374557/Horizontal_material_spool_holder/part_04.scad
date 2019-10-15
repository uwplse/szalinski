postDia = 9.6;
postHeight = 5;
shoulderDia = 14;
shoulderHeight = 4;
holeDia = 3.2;

difference() {
union() {
	cylinder($fn=36,r=postDia/2,h=postHeight);
	cylinder($fn=36,r=shoulderDia/2,h=shoulderHeight);	
}

cylinder($fn=36,r=holeDia/2,h=15);
}