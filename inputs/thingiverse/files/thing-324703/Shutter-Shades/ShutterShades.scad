//	Customizable Shutter Shades
// Currently a wroking in progress

///////
// CUSTOMIZER VARIABLES
///////
/* [Global] */
// Weight of border around patterns
pattern_border = 2; // [0:25]

/* [Shutter] */
// Number of shutter bars
shutter_count = 7; // [0:25]
// Height of each bar
shutter_size = 9; // [2:25]

/* [Left Pattern] */
// Left lense pattern - Paste your Sencil-o-Matic code here (Use "default" for no pattern or "swag" for swag pattern)
left_input = "swag";
// Set automatic scaling for left pattern
autoscale_left = 1; // [0:False, 1:True]
// Horizontally resize left image
left_size_on_x = 150; // [1:500]
// Vertically resize left image
left_size_on_y = 150; // [1:500]
// Move left image left/right
left_move_x = 0; // [-250:250]
// Move left image up/down
left_move_y = 0; // [-250:250]

/* [Right Pattern] */
// Right lense pattern - Paste your Sencil-o-Matic code here (Use "default" for no pattern or "swag" for swag pattern)
right_input = "swag";
// Set automatic scaling for right pattern
autoscale_right = 1; // [0:False, 1:True]
// Horizontally resize right image 
right_size_on_x = 150; // [1:500]
// Vertically resize right image
right_size_on_y = 150; // [1:500]
// Move right image left/right
right_move_x = 0; // [-250:250]
// Move right image up/down
right_move_y = 0; // [-250:250]

// preview[view:south, tilt:bottom]

/* [Hidden] */

///////
// VARIABLES FOR FRAMES AND LENSES
///////
frame_points = [[383,146],[[198,75.6],[114.69,75.41],[78,75.56],[72.15,76.16],[63,77.05],[52.73,78.26],[44.17,79.6],[37.17,81.45],[30.63,83.87],[24.74,87.31],[19.38,91.72],[15.31,96.35],[12.61,100.42],[10.94,104.54],[9.4,109.29],[8.19,116.25],[7.33,125.65],[7.29,137.69],[8.48,151.65],[10.29,164.34],[12.18,174],[14.31,180.91],[16.69,187],[18.69,191.03],[19.89,193],[21.16,194.58],[23.34,197.68],[26.97,202.12],[31.71,206.93],[35.93,210.51],[38.29,212],[39.5,212.39],[40.92,213.32],[43.21,214.59],[46.5,215.79],[51.38,217.1],[57.5,218.66],[67.24,220.04],[85,220.35],[103.2,219.94],[113,218.21],[119.23,216.45],[123.67,215.15],[127.4,213.72],[131.92,211.64],[135.87,209.53],[138.25,208.05],[140.38,206.31],[143.76,203.58],[148.09,199.61],[152.51,194.88],[157.01,188.83],[161.5,181.67],[164.68,175.81],[166,172.86],[166.29,171.65],[167,169.99],[168,168],[168.99,166.03],[170.24,162.93],[171.86,158.28],[174.03,151.45],[176.61,143.17],[179.81,134.7],[184,129.01],[188.47,125.03],[192.85,123.49],[197.78,123.19],[203.52,123.47],[209.32,124.64],[213.32,127.53],[216.28,130.88],[218.48,134.21],[220.08,137.85],[221.58,142],[223.06,146.79],[224.63,152],[226.19,156.81],[227.63,160.65],[228.6,163.1],[229,164.55],[229.75,166.73],[231.56,170.9],[233.87,175.88],[235.81,180],[237.17,182.62],[238.05,184],[239.15,185.53],[241.02,188.5],[243.02,191.65],[244.46,193.59],[246.39,195.66],[249.56,199.09],[253.43,202.97],[257.06,206.09],[260.96,208.74],[265.5,211.46],[271.23,214.14],[278,216.67],[287.26,218.85],[299,220.69],[312.5,221.79],[326,221.07],[336.86,219.83],[344,218.55],[348.5,217.25],[353,215.95],[356.64,214.64],[359.08,213.32],[360.49,212.39],[361.68,212],[364.42,209.85],[369.6,204.69],[374.89,198.8],[377.92,194.94],[379.58,191.89],[381.58,188],[383.74,183.06],[385.78,177.5],[387.55,170.62],[389.1,162.5],[390.1,150.46],[390.49,133.5],[390.17,117],[389.09,108.5],[387.1,103.46],[384.31,98.36],[380.78,93.78],[376.99,89.99],[373.09,87.2],[369.26,85.01],[365.28,83.33],[361,81.74],[355.77,80.35],[349.5,79.14],[340.44,78.07],[328.5,77.04],[284.39,76.21],[198,75.6]],[[108.81,89.13],[69.15,89.51],[52,90.38],[46.72,91.73],[41.75,93.39],[38.4,94.97],[37,96.14],[36.65,96.75],[35.81,97],[33.84,98.21],[30.77,101.13],[27.57,104.96],[25.3,108.38],[23.76,112.64],[22.34,118.5],[21.4,125.44],[21,132.31],[21.3,139.96],[22.03,148.81],[23.22,157.86],[24.63,166],[26.2,172.47],[27.74,177.5],[29.54,181.81],[31.71,186.56],[34.67,191.51],[38.38,196.31],[41.73,199.62],[43.81,201],[44.65,201.24],[45,201.81],[46.25,202.9],[49.25,204.38],[53.28,206.01],[57,207.45],[61.23,208.91],[66.5,210.58],[74.52,212.01],[88.5,212.33],[102.84,211.87],[112.14,210.21],[118.08,208.47],[121.64,207.18],[124.75,205.65],[129.62,203.34],[135.47,200.01],[140.97,196.03],[145.96,191.2],[150.61,185.85],[154.48,180.25],[157.59,174.81],[159.79,170.18],[161.49,166.5],[162.86,163.21],[164.3,159.5],[165.66,155.5],[166.84,151.5],[168.04,146.77],[169.44,141],[170.79,133.03],[171.87,123],[172.25,112.21],[171.52,103],[170.45,96.51],[169.58,92.85],[167.79,91.36],[164.49,90.1],[148.47,89.31],[108.81,89.13]],[[288,89.14],[252.58,89.49],[236.12,90.36],[229.73,91.5],[227.89,98.5],[226.53,106.16],[226.03,115],[226.46,124.21],[227.54,133],[229.05,140.47],[230.52,146.5],[231.96,151.5],[233.39,156.5],[234.88,161.21],[236.46,165.5],[238.25,169.65],[240.27,174],[243.48,179.4],[248.14,186.08],[252.84,191.89],[256.16,195.22],[258.44,196.93],[260.64,198.83],[263.58,200.99],[267.64,203.32],[272.1,205.5],[276,207.3],[280.23,208.85],[285.5,210.42],[292.75,211.84],[301.77,213.05],[311.57,213.6],[320.27,212.98],[327.7,211.74],[334,210.33],[340.09,208.33],[347,205.67],[353.97,202.05],[359.67,197.26],[364.19,191.71],[367.75,185.74],[370.27,179.72],[372.26,174],[373.85,167.31],[375.43,158.94],[376.57,147.77],[377,133.94],[376.65,120.64],[375.25,113.5],[373.8,109.68],[372.77,107.5],[371.46,105.81],[369.35,103.16],[366.25,100.02],[362.58,97.18],[358.67,94.93],[355,93.19],[349.88,91.82],[342.5,90.45],[325.47,89.39],[288,89.14]]];
hingeB_points = [[34,71],[[195.5,108.67],[191.5,108.65],[187.5,109.91],[184.01,111.92],[181.23,114.21],[179.33,116.95],[177.98,120.08],[177.29,130.79],[177,151.74],[177,180],[184.37,180],[191.75,180],[193.42,169.26],[195.09,158.53],[201.25,148.01],[206.17,139.41],[209.36,133.5],[210.74,129.38],[211.1,125.03],[210.34,120.8],[208.82,116.9],[206.3,113.73],[203.13,111.25],[199.39,109.67],[195.5,108.67]],[[194.63,120],[192.51,120.54],[190.65,121.83],[189.49,123.71],[189,125.67],[189.56,127.61],[190.92,129.43],[192.95,130.55],[195.13,130.83],[197.19,129.82],[198.91,127.87],[199.86,125.23],[198.67,122.62],[196.79,120.72],[194.63,120]]];
armHinge_points = [[330,87],[[86.66,108.64],[75.43,106.35],[64.9,109.93],[54.38,113.5],[46.93,121.62],[39.49,129.75],[37.14,140.62],[34.8,151.5],[37.93,162],[41.07,172.5],[49.21,180],[57.34,187.5],[67.42,190.24],[77.5,192.98],[221.25,192.99],[340.79,192.75],[365,191.5],[361.39,190.27],[344.86,190],[324.72,190],[308.11,186.95],[288.74,182.57],[264.5,175.84],[237.5,167.36],[210.5,158.3],[180.97,147.13],[147.5,133.3],[120.08,121.32],[104.69,114.34],[96.74,111.21],[86.66,108.64]],[[79.34,137.37],[75.34,137.38],[72.5,137.9],[70.36,139.3],[68.04,141.43],[66.06,144.63],[65.57,149.5],[66.06,154.37],[68.04,157.59],[70.75,159.89],[73.8,161.66],[77.12,162.51],[80.44,162.44],[83.79,161.01],[87.14,158.35],[89.94,154.55],[90.45,149.41],[89.86,144.35],[87.29,140.83],[83.83,138.29],[79.34,137.37]]];
arm_points = [[400,115],[[387.5,91.09],[381.14,91.63],[375.7,92.85],[371.33,94.99],[367.59,97.77],[363.57,103.36],[358.55,112.25],[354.14,120.85],[351.57,125.74],[350.2,127.87],[348.66,129.82],[347.49,131.43],[347,132.72],[346.56,133.64],[345.5,134.36],[344.44,135.1],[344,136.07],[342.06,138.97],[337.38,144.35],[330.8,150.79],[324.28,156.23],[318.48,160.14],[313.64,162.87],[309.54,164.67],[305.5,166.31],[300.91,167.7],[295.5,168.91],[289.52,169.97],[283.57,170.99],[265.31,171.71],[228.07,171.99],[174.41,171.4],[115,170],[62.59,168.61],[25.75,168.02],[0,168],[0,186.83],[0.13,200.26],[0.44,206.1],[3.19,206.22],[9.19,205.88],[25.93,204.95],[54.5,203.63],[89.3,202.19],[121,200.95],[149.18,199.92],[175.5,198.98],[199.62,197.92],[222.5,196.58],[243.62,195.05],[263.5,193.5],[280.3,191.94],[294,190.37],[303.77,188.7],[311.1,186.9],[315.41,185.56],[317.91,185],[320.14,184.37],[323.8,182.86],[328.3,180.79],[332.5,178.83],[335.91,177.13],[338.5,175.7],[340.79,174.25],[343.5,172.5],[345.91,170.87],[347.5,169.75],[350.41,167.41],[356,162.86],[362.71,157.03],[368.29,151.62],[372.6,146.75],[376.21,142.25],[378.66,139.25],[380.17,138],[380.76,137.72],[381,137.04],[381.75,135.26],[383.56,132.32],[385.57,129.5],[386.81,128.02],[387.72,126.92],[388.94,125],[390.65,121.77],[392.74,117.5],[394.81,113.09],[396.46,109.5],[397.77,106.19],[399.01,102.45],[399.74,98.87],[399.85,95.97],[398.87,93.89],[397,92.29],[393.18,91.42],[387.5,91.09]]];

f_t = 9;
f_w = frame_points[0][0];
f_h= frame_points[0][1];
f_offX = (-f_w/2)-8;
f_offY = -f_h-3;
f_offZ = 0;

hA_t = f_t*1.75;
hA_w = f_t;
hA_h= f_t*3.5;
hB_t = hA_t*1.25;//**
hB_w = f_t*1.125;
hB_h= f_t;
h_offX = -f_w/2;
h_offY = -f_t*3.5;
h_offZ = f_t;
hB_offX = -f_w/2;
hB_offY = -f_t*3.5;
hB_offZ = f_t;

hB_scale_x = f_t*1.125/hingeB_points[0][0];
hB_scale_y = f_t/hingeB_points[0][1];
hB_scale_z = hB_scale_x;
a_scale_x = f_w*0.8625/arm_points[0][0];
a_scale_y = a_scale_x;
a_scale_z = 1;
ah_scale_x = f_t*1.125/armHinge_points[0][1];
ah_scale_y = f_t/hB_t;
ah_scale_z = f_t*1.125/armHinge_points[0][1];

///////
// VARIABLES FOR SHUTTERS AND PATTERNS
///////
//Constant size values
//Width
x_size = 383;
//Height
y_size = 146;
//Thickness
z_size = 9;

//Constant pattern postioning values
l_modX = -325;
l_modY = -150;
r_modX = -95;
r_modY = -150;

//Calculated shutter variables
//Spacing between each shutter INCULDING OVERLAP WITH INVERSE
s_spacing = ((2*shutter_count)-1)*shutter_size>=y_size? shutter_size: (y_size-(shutter_count*shutter_size))/(shutter_count-1);
//Height of each shutter excluding any overlap
s_size = (y_size-((shutter_count-1)*s_spacing))/shutter_count;
//Overlap of each shutter (should be calculated)
s_overlap = s_size>=shutter_size? 0: (s_spacing-s_size)/2;

//Pre-defined point arrays for patterns
d_points = [[0,0], []];
l_swag = [[185,72],[[139.54,113.07],[129.7,113.48],[122.95,114.36],[118.67,115.89],[114.77,117.83],[111.53,120.7],[108.94,124.61],[107.24,129.67],[107.22,136.45],[108.08,142.82],[109.79,147.16],[112.4,150.19],[115.7,152.66],[119.12,154.3],[122,155.32],[127.43,156.2],[136.97,157.51],[146.16,158.96],[150.72,160.18],[151.62,161.48],[152,163.12],[151.41,165.04],[150,167],[147.01,168.61],[140.93,169],[135.4,168.71],[132.02,168.01],[130.51,166.42],[129.5,164.01],[128.84,161],[117.92,161],[107,161],[107,166.77],[107.51,172.08],[109.44,176.12],[112.17,179.14],[115.3,181.34],[119.27,182.82],[124.02,184.1],[131.98,184.81],[144.41,184.8],[157.48,184.07],[164,182.33],[167.72,180.28],[170.35,178.21],[172.05,175.62],[173.55,172.32],[174.53,167.63],[174.96,161.72],[174.58,155.98],[173.63,151.72],[171.96,148.8],[169.87,146.3],[167.12,144.3],[163.88,142.59],[157.55,141.05],[147.39,139.46],[137.63,137.88],[132.25,136.39],[130.66,134.99],[130,133.63],[130.54,132.21],[131.83,130.65],[134.6,129.4],[139.37,129],[144.47,129.46],[147.55,131.45],[149.28,133.5],[150,134.95],[153,135.73],[161.5,136],[173,136],[173,131.9],[172.52,127.99],[171.36,124.34],[169.28,121.2],[166.57,118.49],[162.61,116.34],[157.5,114.54],[150.01,113.41],[139.54,113.07]],[[189.59,114],[178.26,114],[183.75,132.75],[189.01,150.69],[193.93,167.5],[198.61,183.5],[211.28,183.78],[223.95,184.06],[224.48,181.78],[226.29,174.15],[229.9,159],[233.51,144.96],[235.33,140],[236.92,146.2],[239.99,159],[243.19,172.47],[245.11,180.28],[246.09,184.06],[258.64,183.78],[271.2,183.5],[281.42,148.75],[291.65,114],[280.36,114],[269.08,114],[268.09,117.75],[266.14,125.39],[262.85,138.5],[258.6,155.5],[253.62,134.75],[248.63,114],[235.03,114],[221.43,114],[216.48,134.07],[212.59,148.67],[210.79,152.32],[209.21,146.77],[206.47,136],[203.66,124.66],[201.91,117.75],[200.92,114],[189.59,114]]];
r_swag = [[153,71],[[163.9,114],[147.27,114],[135.98,147.75],[127.86,171.96],[124.22,182.78],[126.39,183.74],[136.1,183.78],[148.43,183.5],[150.09,178],[151.74,172.5],[163.7,172.22],[175.67,171.94],[177.49,177.97],[179.32,184],[191.57,184],[203.83,184],[192.17,149],[180.52,114],[163.9,114]],[[241.55,114.02],[226,114.37],[219.4,115.91],[215.71,118.06],[212.61,120.64],[210.27,124.21],[208.39,128.79],[207.23,136.57],[207.17,151.32],[207.5,168.56],[210.06,173.53],[213.25,178.12],[218.49,181.5],[224.36,184.5],[241.43,184.5],[256.08,184.16],[263.08,182.73],[267.08,180.68],[270.28,178.23],[272.63,175.13],[274.62,171.5],[276.03,165.53],[276.79,155.25],[277.24,143],[259.62,143],[242,143],[242,151],[242,159],[247.5,159],[253,159],[253,161.43],[252.54,163.61],[251.43,165.43],[248.72,166.63],[243.49,167],[238.28,166.73],[234.69,166.07],[232.62,164.49],[231.12,161.92],[230.33,156.97],[230.01,149.6],[230.32,142.06],[231.07,136.7],[232.47,133.6],[234.63,131.95],[237.83,131.28],[242.02,131],[246.23,131.34],[249.48,132.17],[251.46,133.68],[252.63,135.67],[253.22,138],[264.75,138],[276.28,138],[275.7,132.39],[274.62,127.27],[272.63,123.01],[269.4,119.55],[264.87,116.62],[259.61,114],[241.55,114.02]],[[163.96,132.63],[162.75,135.26],[160.55,142.31],[158.38,149.87],[157.22,153.75],[158.44,154.72],[163.76,155],[170.74,155],[167.6,144.07],[165.24,136.2],[163.96,132.63]]];

//Pattern point arrays
l_points = (left_input=="default"? d_points: left_input=="swag"? l_swag: left_input);
r_points = (right_input=="default"? d_points: right_input=="swag"? r_swag: right_input);

//Scale values
l_scale_x = left_size_on_x/l_points[0][0];
l_scale_y = autoscale_left>0? l_scale_x: left_size_on_y/l_points[0][1];
r_scale_x = right_size_on_x/r_points[0][0];
r_scale_y = autoscale_right>0? r_scale_x: right_size_on_y/r_points[0][1];

///////
// MODULES FOR FRAMES AND LENSES
///////
//Gets glasses frame without hinges or arms
module frame(){
translate([f_offX,f_offY,f_offZ])
difference() {
	linear_extrude(height=f_t) polygon(frame_points[1]);
	union() {
			for (i = [2:len(frame_points) -1] ) {
				translate([0,0,-f_t])
				linear_extrude(height=f_t*3) {polygon(frame_points[i]);}
				}
			}
	}
}
//Gets lenses
module lenses(){
translate([f_offX,f_offY,f_offZ])
intersection() {
	linear_extrude(height=f_t) polygon(frame_points[1]);
	union() {
			for (i = [2:len(frame_points) -1] ){
				translate([0,0,-f_t])
				linear_extrude(height=f_t*3){
					polygon(frame_points[i]);
					}
				}
			}
	}
}
//Gets specified (left or right) hinge for glasses
module hinge(dir){
mirror([dir=="left"?0:1,0,0])
translate([h_offX,h_offY,h_offZ]){
	cube([hA_w,hA_h,hA_t], center=false);
	translate([hA_w,(hA_h/2)-(hB_h/2),0])
	//resize([hB_w,hB_h,0],auto=true)
	scale([hB_scale_x,hB_scale_y,hB_scale_z])
	rotate([270,0,0])
	translate([-177,-108.65-hingeB_points[0][1],0])
	difference() {
		linear_extrude(height=hB_t) polygon(hingeB_points[1]);
		union() {
				for (i = [2:len(hingeB_points) -1] ) {
					translate([0,0,-hB_t])
					linear_extrude(height=hB_t*3) {polygon(hingeB_points[i]);}
				}
			}
		}
	}
}
//Gets specified (left or right) arm for glasses
module arm(dir){
mirror([0,dir=="left"?0:1,0])translate([25,100,0]) union(){
	//resize([f_w*0.8625,0,f_t],auto=true)
	scale([a_scale_x,a_scale_y,a_scale_z])
	translate([0,-arm_points[0][1],0])
	translate([0,-91.09,0]){
			union() {
				for (i = [1:len(arm_points) -1] ){
					linear_extrude(height=f_t){
						polygon(arm_points[i]);
						}
					}
				}
			}
	translate([0,(-hB_h*2)-2.25,f_t])
	union(){
		translate([0,hB_h,0])
		//resize([0,hB_h,hB_w],auto=true)
		scale([ah_scale_x,ah_scale_y,ah_scale_z])
		rotate([270,0,0])
		translate([-34.8,-106.35-armHinge_points[0][1],0])
		difference() {
			linear_extrude(height=hB_t) polygon(armHinge_points[1]);
			union() {
					for (i = [2:len(armHinge_points) -1] ) {
						translate([0,0,-hB_t])
						linear_extrude(height=hB_t*3) {polygon(armHinge_points[i]);}
					}
				}
			}
		translate([0,-hB_h,0])
		//resize([0,hB_h,hB_w],auto=true)
		scale([ah_scale_x,ah_scale_y,ah_scale_z])
		rotate([270,0,0])
		translate([-34.8,-106.35-armHinge_points[0][1],0])
		difference() {
			linear_extrude(height=hB_t) polygon(armHinge_points[1]);
			union() {
					for (i = [2:len(armHinge_points) -1] ) {
						translate([0,0,-hB_t])
						linear_extrude(height=hB_t*3) {polygon(armHinge_points[i]);}
					}
				}
			}
		}
	}
}
//Gets shutterless glasses frames
module glasses(){
translate([-125,25,0]) arm("left");
translate([-125,-25,0]) arm("right");
frame();
hinge("left");
hinge("right");
}

///////
// MODULES FOR SHUTTERS AND PATTERNS
///////
//Create shutter bars
module shutters(){
intersection(){
	lenses();
	translate([-x_size/2,-y_size/2,0])union() {
		for (i = [0:shutter_count-1] ) {
			translate([0,i*(s_size+s_spacing),0])
			cube([x_size, s_size, z_size]);
			}
		}
	}
}
//Create inverse shutter bars
module ishutters(){
intersection(){
	lenses();
	translate([-x_size/2,-y_size/2,0])union() {
		for (i = [0:shutter_count-2] ) {
			translate([0,(i*(s_size+s_spacing))+s_size+s_overlap,0])
			cube([x_size, s_size, z_size]);
			}
		}
	}
}
//Create constant shutter bars (where normal and inverse shutters would otherwise overlap)
module soverlap(){
intersection(){
	lenses();
	translate([-x_size/2,-y_size/2,0])union() {
		for (i = [0:(2*(shutter_count-1))-1] ) {
			translate([0,(i*(s_size+s_overlap))+s_size,0])
			cube([x_size, s_overlap, z_size]);
			}
		}
	}
}
//Get pattern for left lense
module l_pattern(){
	scale([l_scale_x, l_scale_y, 1])
	translate([l_modX, l_modY, -z_size])union() {
			for (i = [1:len(l_points) -1] ) {
				linear_extrude(height=z_size*3) {polygon(l_points[i]);}
				}
			}
}
//Get border for pattern on left lense
module l_border(){
difference(){
	union() {
		translate([-pattern_border, 0, 0])l_pattern();
		translate([-pattern_border, -pattern_border, 0])l_pattern();
		translate([0, -pattern_border, 0])l_pattern();
		translate([pattern_border, -pattern_border, 0])l_pattern();
		translate([pattern_border, 0, 0])l_pattern();
		translate([pattern_border, pattern_border, 0])l_pattern();
		translate([0, pattern_border, 0])l_pattern();
		translate([0, 0, 0])l_pattern();
		}
	l_pattern();
	}
}
//Get pattern for right lense
module r_pattern(){
	scale([r_scale_x, r_scale_y, 1])
	translate([r_modX, r_modY, -z_size])union() {
			for (i = [1:len(r_points) -1] ) {
				linear_extrude(height=z_size*3) {polygon(r_points[i]);}
				}
			}
}
//Get border for pattern on right lense
module r_border(){
difference(){
	union() {
		translate([-pattern_border, 0, 0])r_pattern();
		translate([-pattern_border, -pattern_border, 0])r_pattern();
		translate([0, -pattern_border, 0])r_pattern();
		translate([pattern_border, -pattern_border, 0])r_pattern();
		translate([pattern_border, 0, 0])r_pattern();
		translate([pattern_border, pattern_border, 0])r_pattern();
		translate([0, pattern_border, 0])r_pattern();
		translate([0, 0, 0])r_pattern();
		}
	r_pattern();
	}
}
//Get lenses with patterns
module patternLenses(){
union(){
	intersection(){
		lenses();
		union(){
			translate([left_move_x,left_move_y,0])l_border();
			translate([right_move_x,right_move_y,0])r_border();
			}
		}
	difference(){
		shutters();
		union(){
			translate([left_move_x,left_move_y,0])l_pattern();
			translate([right_move_x,right_move_y,0])r_pattern();
			}
		}
	intersection(){
		ishutters();
		union(){
			translate([left_move_x,left_move_y,0])l_pattern();
			translate([right_move_x,right_move_y,0])r_pattern();
			}
		}
	soverlap();
	}
}
//Get shutter shades
module shutterShades(){
	union(){
		glasses();
		patternLenses();
	}
}

///////
// CREATING SHUTTER SHADES
///////
shutterShades();
