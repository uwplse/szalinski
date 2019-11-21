outerDiammeter=68;
innerDiammeter=61;
conicVariation=3;
height=20;
difference ()
  {

		cylinder (d1=outerDiammeter,d2=outerDiammeter-conicVariation, h=height, $fn=200);
		cylinder (d=innerDiammeter, h=25, $fn=200);

  }