/// Configuration begins --->
// - Printer settings
margin=10;
bedShape="s"; // r: round, s: rectangular(kind of [s]quare-ish)
// -- Rectangular bed
XBed=300;
YBed=300;
// -- Round bed
RBed=100;

// - Test object
objSize=20;
objHeight=0.2; // Could also be layer thichness
objShape="s"; // r: rectangle, c: circle, s: star
createCenterObj=true; 

/// <--- Configuration ends

placeObjects();

module placeObjects() {
  if(bedShape == "r")
    placeObjectsRound();
  else if(bedShape == "s")
    placeObjectsRect();
  else
    warn();
}

module placeObjectsRound() {
  r=RBed-margin-objSize/2;
  if(createCenterObj)
    shape();
  
  aOffset = 0; // 360/6; // This might not make much sense to have... anyway I will keep it like this. The point is to be able to test the leveling/adhesion between the towers.
  for(a=[0: 360/3: 359])
    translate(r*[sin(a+aOffset), cos(a+aOffset)])
      shape();
}

module placeObjectsRect() {
  x=(XBed-objSize)/2-margin;
  y=(YBed-objSize)/2-margin;

  if(createCenterObj)
    shape();
  translate([x, y])
    shape();
  translate([-x, y])
    shape();
  translate([x, -y])
    shape();
  translate([-x, -y])
    shape();
}

module shape() {
  if(objShape == "r")
    cube([objSize, objSize, 0.2], center=true);
  else if(objShape == "c")
    cylinder(r=objSize/2, h=objHeight);
  else if(objShape == "s")
   star(); 
}

module star() {
  numberOfSpikes = 5;
  da=360/(2*numberOfSpikes);
  function r(i) = i%2 ? objSize/2 : 0.4*objSize/2;
  points = [ 
    for (i = [0 : 1 : 2*numberOfSpikes]) 
      r(i) * [ sin(i*da), cos(i*da) ]
  ];
   
  linear_extrude(height=objHeight)
    polygon(points);
}

module warn() {
  echo(str("<font style='background:yellow; font-weight:bold; font-size:x-large;'>CONFIGURATION IS INVALID!!!</font>"));
  
  // Since it is not possible to exit the program on error, the second best will be to fuck up the generated output
  cube([100000, 100000, 10000], center=true);
}
