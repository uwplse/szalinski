
//lower part to fit the lamp
rotate ([180,0,0])  //oops, lower part is designed the wrong way round to print
difference () {


union (){
	//hollow cylinder
	difference () {
		cylinder (h=17,r=12.5,$fn=100);
	
		translate ([0,0,-1])
		union(){
            cylinder (h=17,r=11,$fn=100);
            cylinder (h=22,r=4,$fn=100);
	}
}

	//fittings
/*	for (i=[0,60,120,180,240,300]) {
		rotate ([0,1,i])
		translate ([11.25,0,27/2])
		cube ([1,1,17],center=true);
	}
*/
}

//bevel
translate ([0,0,23])
cylinder (h=5,r1=10.5,r2=12);

}

wall=1;  //Thickness of wall of upper part


//diffusor
difference () {
	rotate_extrude($fn=100) polygon( points=[[0,0],[12.5,0],[11.5,10],[8.5,20],[4.5,29],[2.25,32],[0.5,33],[0,33]] );

//make hollow with above defined wall
rotate_extrude($fn=100) polygon( points=[[0,-1],[12.5-wall,-1],[11.5-wall,1],[11.5-wall,10],[8.5-wall,20],[4.5-wall,29],[2.25-wall,31.5],[0,31.5]] );

}
