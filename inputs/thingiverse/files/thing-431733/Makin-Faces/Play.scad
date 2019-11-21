// Play face
// TrevM 17/08/2014

/* [Global] */

// What quality?
$fn = 100;	// [20,40,60,80,100,120,140,160,180]

// main head diameter?
headDi = 30;
// neck diameter?
neckDi = 15;

// chin movement up/down (face tall narrow, short round)
chinZOff = 10;
// chin length
chinLen = 40;
// chin width
chinX = 22;
// chin thickness
chinY = 10;
// chin sharpness
chinZ = 30;
// chin angle (jut or sink)
chinYAng = 20;
// controls how upturned face is
chinYOff = 10;

// cheek bone position sideways
cheekX = 5;
// cheek bone position forward / back
cheekY = -10;
// cheek bone position up / down
cheekZ = -10;
// cheek bone width
cheekXs = 15;
// cheek bone depth
cheekYs = 10;
// cheek bone height
cheekZs = 10;

// eye socket position sideways
eyeSockX = 8;
// eye socket position forward / back
eyeSockY = -1;
// eye socket position up / down
eyeSockZ = -2;
// eye socket width
eyeSockXs = 13;
// eye socket depth
eyeSockYs = 5;
// eye socket height
eyeSockZs = 9;
// eye socket angle (0=flat, 10 = angle 10 degrees in to ears)
eyeSockXa = 10;
// eye socket angle (slant down)
eyeSockYa = -15;
// eye socket angle
eyeSockZa = 10;

// eye position sideways
eyeX = 7;
// eye position forward/back
eyeY = -2.5;
// eye position up/down
eyeZ = -2;
// eye size wide
eyeXs = 5.2;
// eye size depth
eyeYs = 2;
// eye size high
eyeZs = 3.2;
// eye angle outside edge inwards angle
eyeXa = 20;
// eye angle outside edge up / down (slant)
eyeYa = -20;
// eye angle
eyeZa = 10;

// nose tip width
noseTx = 5;
// nose tip length
noseTy = 7;
// nose tip height
noseTz = 5;
// nose width
noseSdx = 3;
// nose side lobe width
noseSx = 2;
// nose side lobe length
noseSy = 2;
// nose side lobe height
noseSz = 2;
// nose bridge height above tip
noseBdz = 5;
// nose bridge width
noseBx = 3;
// nose bridge depth (thickness)
noseBy = 2;
// nose bridge length
noseBz = 7;
// nose bridge angle into face
noseA = 5;
// nose position depth on face
noseMy = 0;
// nose position height on face
noseMz = 1;

// lips width
lipsW=6;
// lips Top Centre radius
lipsTCr = 0.9;
// lips Top Centre distance from middle
lipsTCx = 0.2;
// lips Top Middle radius
lipsTMr = 0.8;
// lips Top Middle distance from middle
lipsTMx = 2;
// lips Top Middle offset up from centre
lipsTMz = 0.5;
// lips Top Outside radius
lipsTOr = 0.2;
// lips Top outside corner distance above centre
lipsTH = 0.2;
// lips Bottom middle radius
lipsBMr = 0.5;
// lips Bottom middle distance from middle
lipsBMx = 4;
// lips Bottom middle depth below top
lipsBMz = 2;
// lips Bottom centre radius
lipsBCr = 1;
// lips Bottom centre distance from middle
lipsBCx = 1;
// lips Bottom centre depth below top
lipsBCz = 3;

// mouth distance out of face
mouthY = 1;
// mounth position down face
mouthZ = -5;

/* [Hidden] */

rotate([0,0,180])	head();
//nose();
//lips();

module head()
{
	eyeSY=(headDi/2)+eyeSockY;
	eyeSZ=chinZOff+eyeSockZ;

	difference()
	{
		hull()
		{
			// basic round head
			translate([0,0,chinZOff])		sphere(r=headDi/2);
			// chin
			translate([0,chinYOff,0])
				rotate([chinYAng,0,0])	
					resize([chinX,chinY,chinZ])	
						sphere(r=headDi/2);
			// neck / head junction
			translate([0,0,-chinZ/4])
				cylinder(r=neckDi/2,h=chinZ/2);
			// left cheek bone
			translate([-cheekX,-cheekY,chinZOff+cheekZ])
				resize([cheekXs,cheekYs,cheekZs])	sphere(r=cheekXs/2);
			// right cheek bone
			translate([cheekX,-cheekY,chinZOff+cheekZ])
				resize([cheekXs,cheekYs,cheekZs])	sphere(r=cheekXs/2);
		}
		// left eye socket
		translate([-eyeSockX,eyeSY,eyeSZ])
			rotate([0,0,eyeSockXa])
				rotate([0,eyeSockYa,eyeSockZa])
					resize([eyeSockXs,eyeSockYs,eyeSockZs])
						sphere(r=eyeSockXs);
		// right eye socket
		translate([eyeSockX,eyeSY,eyeSZ])
			rotate([0,0,-eyeSockXa])
				rotate([0,-eyeSockYa,-eyeSockZa])
					resize([eyeSockXs,eyeSockYs,eyeSockZs])
						sphere(r=eyeSockXs);
	}
	// left eye
	translate([-eyeX,eyeSY+eyeY,chinZOff+eyeZ])
		rotate([0,0,eyeXa])
			rotate([0,eyeYa,eyeZa])
				resize([eyeXs,eyeYs,eyeZs])
					sphere(r=eyeXs);
	// left eye
	translate([eyeX,eyeSY+eyeY,chinZOff+eyeZ])
		rotate([0,0,-eyeXa])
			rotate([0,-eyeYa,-eyeZa])
				resize([eyeXs,eyeYs,eyeZs])
					sphere(r=eyeXs);
	// neck
	translate([0,0,-chinZ/2])
		cylinder(r=neckDi/2,h=chinZ/2);
	// nose
	translate([0,(headDi/2)+noseMy,noseMz])
		rotate([noseA,0,0])
			nose();
	// lips
	translate([0,(headDi/2)+mouthY,mouthZ])	lips();
}

module nose()
{
	hull()
	{
		resize([noseTx,noseTy,noseTz])		sphere(noseTx);
		translate([-noseSdx,0,0])
			resize([noseSx,noseSy,noseSz])	sphere(noseSx);
		translate([noseSdx,0,0])
			resize([noseSx,noseSy,noseSz])	sphere(noseSx);
		translate([0,0,noseBdz])
			resize([noseBx,noseBy,noseBz])	sphere(noseBx);
	}
}

module lips()
{
	lip();
	mirror([-lipsBCz,0,0])	lip();
}

module lip()
{
	hull()
	{
		// top left centre
		translate([-lipsTMx,0,-lipsTMz])	sphere(lipsTMr);
		translate([-lipsTCx,0,0])			sphere(lipsTCr);
	}
	hull()
	{
		// top left outside
		translate([-lipsTMx,0,-lipsTMz])	sphere(lipsTMr);
		translate([-lipsW,0,lipsTH])		sphere(lipsTOr);
	}
	hull()
	{
		// bottom left outside
		translate([-lipsW,0,lipsTH])		sphere(lipsTOr);
		translate([-lipsBMx,0,lipsTMz-lipsBMz])	sphere(lipsBMr);
	}
	hull()
	{
		// bottom left inside
		translate([-lipsBMx,0,lipsTMz-lipsBMz])	sphere(lipsBMr);
		translate([-lipsBCx,0,lipsTMz-lipsBCz])	sphere(lipsBCr);
	}
	hull()
	{
		translate([-lipsBCx,0,lipsTMz-lipsBCz])	sphere(lipsBCr);
		translate([lipsBCx,0,lipsTMz-lipsBCz])	sphere(lipsBCr);
	}
}
