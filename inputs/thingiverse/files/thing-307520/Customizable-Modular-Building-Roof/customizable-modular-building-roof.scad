//
//
//	Customizable Modular Building Roof
//	Steve Medwin
//	April 21, 2014
//
//

// preview[view:south, tilt:top]

//
// CUSTOMIZING
//
// Number of horizontal windows in front
horizontal_windows_front=3; //[1:10]
Nfront=horizontal_windows_front;
// Number of horizontal windows on sides
horizontal_windows_side=2; //[1:10]
Nside=horizontal_windows_side;

//
// REMAINING PARAMETERS
//
// windows
Xinit=5*1; // Distance from left edge to first window
Yinit=6*1; //5 Distance from bottom to first window row
Xspace=10*1; // Distance from left edge of window to next left edge of window
Yspace=15.5*1; // Distance from bottom of window row to next row
Zbase=2*1; // Thickness of wall
Xwin=6.4*1; // Width of window

Xfront=Xinit*2+Xspace*(Nfront-1)+Xwin-2*Zbase; // Width of front wall - side wall thicknesses
Xside=Xinit*2+Xspace*(Nside-1)+Xwin; // Width of front wall

// make roof insert
cube([Xfront,Xside,Zbase]);
echo(Xfront,Xside);