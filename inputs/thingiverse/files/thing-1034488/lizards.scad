
// Generated from inkscape drawing I made.
// Designed to be pressed into the Sand at the beach
//  - to annoy and intrigue others...
// Author Neon22 Aug 2015

use<scad-utils/morphology.scad>;

// Added customizer so user can get better prints for narrow edge

/* [Escher Sand Lizard] */
// Nose to Tail length (mm).
Length = 200;
// Top width of the walls.
Maximum_wall_width = 3;
// Bottom width of internal walls.
Minimum_wall_width = 1; 
// Height of the walls.
Wall_height = 10;
// Thickness of Base.
Base = 2.0;

/* [Cookie Mode] */
// Set to yes for different internal wall height. Ideal for impressing into cookies.
Cookie_mode = "yes"; // [yes, no]
// Inner wall height(from Base).
Inner_height = 5;

/* [Demo] */
// Show a sample tesselation (not for printing)
show_tesselated = "no"; // [yes, no]


/* [Hidden] */
Delta = 0.1;
profile_scale = 25.4/90; //made in inkscape in mm
s = Length / 97; // 97 is length of actual in mm
echo(s);
min_width = Minimum_wall_width / profile_scale / s /2; // div by 2 because cyl uses radius
max_width = Maximum_wall_width / profile_scale / s /2;
base_thick = Base;  // no scale in Z
wall = Wall_height; // no scale in Z
inner_walls = (Cookie_mode == "yes") ? Inner_height : wall;

//----------------------------------
path160667_0_points = [[-14.757721,-135.576404],[-1.242637,-136.877381]];

module poly_path160667(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160667_0_points)-2]) {
	hull() {
		translate(path160667_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160667_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160425_0_points = [[-39.592954,83.104360],[-42.442077,84.974252],[-46.978839,82.696328],[-52.591754,85.134578]];

module poly_path160425(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160425_0_points)-2]) {
	hull() {
		translate(path160425_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160425_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path1604089_0_points = [[-2.989029,120.425772],[-19.867162,112.978419]];

module poly_path1604089(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path1604089_0_points)-2]) {
	hull() {
		translate(path1604089_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path1604089_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160849_0_points = [[-50.463437,-99.834401],[-49.487217,-101.074993],[-48.843067,-102.377743],[-48.650019,-103.127400],[-48.607002,-103.915024],[-48.948715,-105.576327],[-49.720677,-107.233694],[-50.831135,-108.695631],[-52.188334,-109.770642],[-53.216425,-110.030843],[-54.390401,-110.155267],[-55.642467,-109.958234],[-56.904828,-109.254061]];

module poly_path160849(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160849_0_points)-2]) {
	hull() {
		translate(path160849_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160849_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path1604663_0_points = [[-7.292962,22.579327],[-0.092861,19.721129],[7.893046,17.918705]];

module poly_path1604663(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path1604663_0_points)-2]) {
	hull() {
		translate(path1604663_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path1604663_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160547_0_points = [[-170.937566,23.337573],[-165.221704,21.382910],[-162.028331,17.533342],[-158.347913,16.611957]];

module poly_path160547(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160547_0_points)-2]) {
	hull() {
		translate(path160547_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160547_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160625_0_points = [[13.294230,-95.653715],[31.769153,-97.765728]];

module poly_path160625(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160625_0_points)-2]) {
	hull() {
		translate(path160625_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160625_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160760_0_points = [[-81.014007,-79.788917],[-79.717153,-79.326967],[-76.448189,-77.825792],[-74.365540,-76.631437],[-72.139514,-75.112406],[-69.886660,-73.247076],[-67.723527,-71.013824],[-63.321245,-65.439583],[-58.609966,-58.728528],[-53.905926,-51.409236],[-49.525359,-44.010286],[-47.284507,-40.321182],[-44.818388,-36.738082],[-42.154250,-33.262752],[-39.319343,-29.896956],[-36.340913,-26.642459],[-33.246208,-23.501027],[-26.816968,-17.564415],[-20.249606,-12.101239],[-13.762104,-7.125620],[-7.572448,-2.651676],[-1.898620,1.306474],[2.942568,4.413461],[7.916319,7.213347],[13.007621,9.821527],[18.201465,12.353398],[28.836742,17.649792],[34.248154,20.645108],[39.702068,24.025698],[45.409511,28.000478],[52.796277,33.710399],[56.774214,37.088206],[60.757752,40.746403],[64.608815,44.633857],[68.189326,48.699436],[72.271675,53.889624],[75.554214,58.521579],[78.155916,62.699919],[80.195751,66.529262],[81.792688,70.114225],[83.065700,73.559426],[85.115825,80.449013],[86.068167,84.305250],[86.743962,87.894212],[87.172892,91.218448],[87.384637,94.280510],[87.408878,97.082949],[87.275295,99.628315],[86.653381,103.958032],[85.756340,107.290068],[84.821617,109.644828],[83.788905,111.504149],[85.213385,109.141160],[86.623441,106.396106],[88.169336,102.794174],[89.604040,98.474483],[90.202499,96.088954],[90.680524,93.576156],[91.007237,90.953479],[91.151759,88.238313],[91.083211,85.448048],[90.770715,82.600074],[90.171331,79.089844],[89.354529,75.304033],[88.220001,71.210245],[86.667435,66.776086],[84.596523,61.969161],[81.906955,56.757074],[78.498421,51.107431],[74.270611,44.987836],[70.510879,40.179018],[66.372118,35.422137],[61.980430,30.797180],[57.461919,26.384132],[52.942686,22.262981],[48.548835,18.513712],[44.406468,15.216312],[40.641687,12.450767],[29.500716,5.004711],[13.739479,-5.264977],[-1.353182,-15.093234],[-10.488425,-21.214998],[-17.773513,-26.699937],[-23.038923,-30.921924],[-28.901124,-35.908866],[-34.996274,-41.494720],[-40.960535,-47.513443],[-43.779882,-50.633241],[-46.430066,-53.798991],[-48.865607,-56.989937],[-51.041026,-60.185323],[-52.970045,-63.361164],[-54.703271,-66.492553],[-57.621716,-72.533422],[-59.875113,-78.130827],[-61.542210,-83.107663],[-62.701758,-87.286828],[-63.432507,-90.491216],[-63.922605,-93.267252]];

module poly_path160760(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160760_0_points)-2]) {
	hull() {
		translate(path160760_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160760_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160785_0_points = [[-92.648746,-69.531885],[-93.133751,-69.166013],[-94.547173,-68.492065],[-95.582545,-68.238159],[-96.826626,-68.145548],[-98.271619,-68.293670],[-99.909725,-68.761964],[-101.297051,-69.429082],[-102.579266,-70.336338],[-103.714365,-71.459882],[-104.660343,-72.775865],[-105.375195,-74.260439],[-105.816916,-75.889755],[-105.943501,-77.639963],[-105.712944,-79.487214],[-105.214741,-80.896345],[-104.473801,-82.057125],[-103.585416,-82.988193],[-102.644874,-83.708184],[-100.988482,-84.589483],[-100.266947,-84.850118]];

module poly_path160785(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160785_0_points)-2]) {
	hull() {
		translate(path160785_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160785_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160689_0_points = [[47.080797,-22.299485],[40.450495,-6.294261]];

module poly_path160689(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160689_0_points)-2]) {
	hull() {
		translate(path160689_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160689_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160863_0_points = [[165.575542,-47.632283],[151.860526,-47.147868]];

module poly_path160863(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160863_0_points)-2]) {
	hull() {
		translate(path160863_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160863_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160486_0_points = [[-62.311914,17.756211],[-70.686935,18.354789],[-82.736458,17.287999]];

module poly_path160486(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160486_0_points)-2]) {
	hull() {
		translate(path160486_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160486_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160566_0_points = [[-74.288234,-9.135780],[-66.791685,-16.590230],[-59.570458,-20.759407]];

module poly_path160566(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160566_0_points)-2]) {
	hull() {
		translate(path160566_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160566_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160584_0_points = [[-14.783953,-71.431303],[-22.082949,-65.270082],[-27.473920,-56.541075]];

module poly_path160584(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160584_0_points)-2]) {
	hull() {
		translate(path160584_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160584_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160748_0_points = [[-70.224929,-56.932508],[-75.445537,-58.331366],[-81.066340,-62.507980],[-91.837943,-66.920250],[-93.420102,-73.829807],[-100.495898,-85.390582],[-94.425876,-106.145834],[-94.560951,-112.286129],[-97.729823,-122.291390],[-97.858648,-127.031126]];

module poly_path160748(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160748_0_points)-2]) {
	hull() {
		translate(path160748_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160748_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160700_0_points = [[76.686029,17.411279],[68.025534,7.071385],[68.907813,-2.865706],[67.880872,-10.898186]];

module poly_path160700(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160700_0_points)-2]) {
	hull() {
		translate(path160700_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160700_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160644_0_points = [[-13.584421,-124.489895],[-2.650624,-124.029101],[2.957714,-122.653531]];

module poly_path160644(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160644_0_points)-2]) {
	hull() {
		translate(path160644_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160644_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160881_0_points = [[169.856490,-63.944572],[152.683767,-60.661528]];

module poly_path160881(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160881_0_points)-2]) {
	hull() {
		translate(path160881_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160881_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160505_0_points = [[-114.346566,22.274839],[-112.479155,30.046976]];

module poly_path160505(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160505_0_points)-2]) {
	hull() {
		translate(path160505_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160505_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160381_0_points = [[-3.779821,135.855627],[-20.400327,128.731661]];

module poly_path160381(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160381_0_points)-2]) {
	hull() {
		translate(path160381_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160381_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160725_0_points = [[-47.380980,-70.522653],[-48.449874,-83.144410],[-47.272964,-94.655772],[-59.183288,-112.853037],[-59.733949,-115.543969],[-76.442627,-117.732019],[-85.620038,-131.890603],[-88.560734,-134.204584]];

module poly_path160725(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160725_0_points)-2]) {
	hull() {
		translate(path160725_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160725_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160807_0_points = [[-93.402695,-73.324911],[-93.680866,-73.002527],[-94.503695,-72.299196],[-95.853659,-71.610654],[-96.720839,-71.395597],[-97.713231,-71.332636],[-99.240636,-71.577415],[-100.550014,-72.208641],[-101.635194,-73.272619],[-102.490000,-74.815652],[-102.863679,-76.399503],[-102.717102,-77.911385],[-102.107021,-79.265343],[-101.090191,-80.375426],[-99.950953,-81.071959],[-99.006278,-81.356958],[-98.123633,-81.378972]];

module poly_path160807(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160807_0_points)-2]) {
	hull() {
		translate(path160807_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160807_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}



path160608_0_points = [[16.632548,-52.636792],[11.390071,-67.746200]];

module poly_path160608(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160608_0_points)-2]) {
	hull() {
		translate(path160608_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160608_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path1608212_0_points = [[-49.085342,-97.621188],[-48.650143,-97.873836],[-47.627873,-98.750520],[-47.029397,-99.478533],[-46.443526,-100.429346],[-45.923385,-101.625221],[-45.522097,-103.088422],[-45.456710,-103.922464],[-45.541095,-104.934487],[-46.087339,-107.237763],[-47.017152,-109.488824],[-47.580999,-110.435578],[-48.186859,-111.178242],[-49.469318,-112.109988],[-51.263384,-112.952790],[-53.270056,-113.552320],[-55.190335,-113.754249],[-56.766585,-113.527853],[-57.954933,-113.091756],[-58.966145,-112.476936]];

module poly_path1608212(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path1608212_0_points)-2]) {
	hull() {
		translate(path1608212_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path1608212_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160441_0_points = [[45.556079,51.536720],[39.998848,47.122788],[26.080423,47.335577],[21.421269,46.214317],[17.336072,48.171769],[13.695929,48.468055]];

module poly_path160441(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160441_0_points)-2]) {
	hull() {
		translate(path160441_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160441_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}

path160526_0_points = [[-167.100850,41.181455],[-154.315026,31.935476],[-151.445814,27.871878]];

module poly_path160526(h,  res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
for (t = [0: len(path160526_0_points)-2]) {
	hull() {
		translate(path160526_0_points[t]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
		translate(path160526_0_points[t + 1]) 
			cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
	}
}	
  }
}


// Outline
path15774652_0_points = [[73.929753,144.696176],[82.254324,100.824174],[64.584299,63.335242],[45.876012,51.728670],[7.652166,67.539909],[-11.700688,62.139889],[-39.420330,82.963655],[-1.986793,107.231339],[-4.285313,151.538655],[-36.137957,137.980356],[-41.131459,118.500754],[-73.946350,93.377227],[-73.237702,71.360545],[-49.670200,37.340302],[-7.281206,22.531359],[-61.979987,17.776606],[-72.890270,24.941765],[-89.461283,40.258989],[-97.136542,44.644910],[-103.647537,56.028776],[-141.140084,38.446215],[-150.706291,52.340501],[-165.868063,53.906723],[-168.160798,32.653460],[-172.722750,17.868302],[-169.678835,7.908877],[-167.211480,3.101965],[-114.399747,22.077552],[-74.399851,-8.964877],[-74.367981,-16.086147],[-72.944257,-26.801416],[-119.353220,-72.473375],[-103.120677,-135.762388],[-93.199693,-139.801582],[-86.788906,-143.418291],[-40.014146,-124.221152],[-30.023778,-69.074319],[-24.543495,-69.467418],[-14.638294,-71.569683],[-3.937652,-83.108442],[13.299787,-95.647752],[4.349328,-107.982875],[-12.517766,-109.371858],[-16.096242,-151.023692],[15.899871,-151.538655],[33.642555,-126.560946],[57.079392,-103.668890],[24.786402,-64.718428],[16.750336,-52.621171],[47.180053,-22.406067],[59.102959,-50.989820],[95.318214,-84.489978],[142.274964,-70.084646],[172.722750,-74.220816],[161.871611,-32.778022],[147.912710,-33.579991],[97.410153,-42.134461],[89.375082,-10.766862],[76.729494,17.504579],[99.602678,55.929613],[99.687848,64.968734],[104.676039,87.061180],[105.320954,99.898474],[73.929753,144.696176]];

module poly_path15774652(h, res=4)  {
	height = h+base_thick;
	scale([profile_scale, -profile_scale, 1])
	union()  {
		translate([0,0,h-Delta]) {
		linear_extrude(height=base_thick+Delta)
			polygon(path15774652_0_points);
		}
		for (t = [0: len(path15774652_0_points)-2]) {
			hull() {
				translate(path15774652_0_points[t]) 
					cylinder(h=height, r1=min_width, r2=max_width, $fn=res);
				translate(path15774652_0_points[t + 1]) 
					cylinder(h=height, r1=min_width, r2=max_width, $fn=res);
			}
		}
	}
}

module lizard() {
	union() {
		z_offset = (Cookie_mode == "yes") ? wall - Inner_height : 0;
		translate([0,0,z_offset]) {
			poly_path160667(inner_walls);
			poly_path160425(inner_walls);
			poly_path1604089(inner_walls);
			poly_path160849(inner_walls);
			poly_path1604663(inner_walls);
			poly_path160547(inner_walls);
			poly_path160625(inner_walls);
			poly_path160760(inner_walls);
			poly_path160785(inner_walls);
			poly_path160689(inner_walls);
			poly_path160863(inner_walls);
			poly_path160486(inner_walls);
			poly_path160566(inner_walls);
			poly_path160584(inner_walls);
			poly_path160748(inner_walls);
			poly_path160700(inner_walls);
			poly_path160644(inner_walls);
			poly_path160881(inner_walls);
			poly_path160505(inner_walls);
			poly_path160381(inner_walls);
			poly_path160725(inner_walls);
			poly_path160807(inner_walls);
			poly_path160608(inner_walls);
			poly_path1608212(inner_walls);
			poly_path160441(inner_walls);
			poly_path160526(inner_walls);
		}
		poly_path15774652(wall); //outline
	}
}




if (show_tesselated == "no") {
	scale([s,s,1])
	rotate([180,0,25])
	translate([0,0,-wall-base_thick])
		lizard();
} else {
	// tessellate example
	col = [[1,0,0], [1,1,0], [0,1,1] ];
	move = [[-27,-45,0],
			[-68.5,1.5,0],
			[-88,-57.5,0]
			];
	translate([Length/2, 0, 0])
	rotate([180,0,25])
	scale([s,s,1])
	for (i=[1:3]) {
		translate(move[i-1])
		rotate([0,0,i*120])
		color(col[i-1])
		lizard();
	}
}
