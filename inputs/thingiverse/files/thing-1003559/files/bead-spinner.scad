// Bead spinner to help putting seed beads on a thread.


// preview[view:north east, tilt:top diagonal]

// 1mm thick walls at 50mm wide. Ideal size is 80-100
Width = 80; //[50:5:120]
// How smooth is the outer circle
Faceted = 180;
// Spread out for printing
Disassembled = "no";   // [yes,no]
// See X-Section to see how its made.
Show_x_section = "no"; // [yes,no]


/* [Hidden] */
s_width  = Width;
s_height = 0.89 * s_width;
b_height = 0.45 * s_height;
b_width  = 0.84 * s_width;

Delta = 0.1;
profile_scale = 25.4/90; //made in inkscape in mm
spinner_points = [[-27.217585,-50.615660],[-26.668782,-50.434829],[-26.100305,-50.064898],[-25.440246,-49.380719],[-24.766955,-48.286362],[-24.158784,-46.685899],[-23.694084,-44.483401],[-23.451205,-41.582941],[-23.597079,-34.107066],[-23.692058,-27.736848],[-23.656730,-20.168156],[-23.382343,-11.818274],[-22.760145,-3.104490],[-21.681386,5.555913],[-20.936812,9.735695],[-20.037315,13.745649],[-19.678322,17.354608],[-19.771159,20.629165],[-20.419801,26.676646],[-20.529348,29.700355],[-20.198205,32.891236],[-19.797647,34.588550],[-19.203244,36.374679],[-18.387103,38.265298],[-17.321335,40.276079],[-16.259421,41.449300],[-14.780340,42.698989],[-12.903631,43.795746],[-11.822273,44.215087],[-10.648835,44.510169],[-8.598610,44.773719],[-6.086997,44.928640],[-0.342413,44.979253],[5.259297,44.795325],[9.392515,44.510169],[12.592352,44.136365],[14.193641,43.836312],[15.773059,43.401648],[17.313516,42.787993],[18.797922,41.950965],[20.209188,40.846181],[21.530225,39.429260],[22.670983,37.776647],[23.561259,36.018819],[24.213734,34.192443],[24.641090,32.334185],[24.856009,30.480709],[24.871172,28.668682],[24.699260,26.934771],[24.352955,25.315640],[23.150059,21.854120],[21.699850,18.876867],[20.235399,16.649115],[18.989775,15.436100],[18.146393,14.854357],[17.619105,14.309727],[17.345144,13.814675],[17.261744,13.381673],[17.415559,12.751691],[17.578415,12.519530],[17.870706,12.280967],[18.699587,12.034306],[19.292753,12.127794],[19.993072,12.483084],[20.791545,13.188118],[21.679175,14.330839],[22.907532,16.272695],[24.367832,18.906919],[25.757940,21.989434],[26.775725,25.276160],[27.217585,28.550138],[27.111422,31.573455],[26.559334,34.328427],[25.663418,36.797375],[24.525770,38.962615],[23.248488,40.806467],[21.933667,42.311249],[20.683405,43.459280],[19.169663,44.521104],[17.618075,45.334908],[16.102515,45.933499],[14.696855,46.349686],[12.510733,46.766078],[11.650695,46.846550],[-12.357365,46.846550],[-15.137266,45.717361],[-17.299812,44.623542],[-18.191470,44.036980],[-18.810905,43.459280],[-20.481583,41.132005],[-21.833535,38.946916],[-23.068825,36.692180],[-23.068825,13.460190],[-27.217585,4.066249]];
base_points = [[-27.217585,7.382710],[-26.549637,7.465681],[-26.030800,7.622153],[-25.669695,7.902180],[-24.661427,10.727528],[-23.865155,13.199350],[-23.865155,39.468640],[-22.896600,41.154241],[-21.710032,42.861152],[-20.076715,44.788500],[-19.039493,45.701965],[-17.840755,46.493691],[-15.328363,47.711858],[-13.278802,48.442861],[-12.431335,48.686560],[11.576725,48.686560],[18.082045,50.615660],[-27.217585,50.615660]];

//--------------
// helper functions to determine the X,Y dimensions of the profiles
function min_x(shape_points) = min([ for (x = shape_points) min(x[0])]);
function max_x(shape_points) = max([ for (x = shape_points) max(x[0])]);
function min_y(shape_points) = min([ for (x = shape_points) min(x[1])]);
function max_y(shape_points) = max([ for (x = shape_points) max(x[1])]);



module build_rotated(profile_list, new_height, new_width, res=4)  {
	minx = min_x(profile_list)* profile_scale;
	maxx = max_x(profile_list)* profile_scale;
	p_width = (maxx - minx);
	miny = min_y(profile_list) * profile_scale;
	maxy = max_y(profile_list) * profile_scale;
	p_height = maxy-miny;
	y_scale = new_height/p_height;
	x_scale = new_width /(p_width*2);
	rotate_extrude($fn=Faceted, convexity = 12) {
		scale([x_scale,y_scale])
		// add 0.1 so there is tiny hole in middle so F6 works
		translate([-minx+Delta, maxy]) // scale profile
		scale([profile_scale, -profile_scale])
			polygon(profile_list);
		
	}
	// fill in tiny offset hole to ensure F6 works
	fix_start = profile_list[0][1] * profile_scale;
	fix_end = profile_list[len(profile_list)-1][1] * profile_scale;
	echo(profile_list[0],fix_start, fix_end);
	translate([0,0,y_scale*(-fix_end+maxy)])
		cylinder(h=y_scale*(fix_end-fix_start), r=0.2+Delta*y_scale, $fn=Faceted); // 
}




// The shapes
difference() {
	// positioning for disassembly
	x_offset = (Disassembled=="yes") ? s_width : 0;
	z_offset = (Disassembled=="yes") ? 0 : s_width*0.04;
	union() {
	// build spinner and base
		translate([x_offset,0,z_offset])
			build_rotated(spinner_points, s_height, s_width);
		build_rotated(base_points, b_height, b_width);
	}
	// cutting X-section
	if( Show_x_section=="yes") {
		translate([0,0,-Delta])
			cube(size=max(s_width, s_height+4+Delta*2));
	}
}