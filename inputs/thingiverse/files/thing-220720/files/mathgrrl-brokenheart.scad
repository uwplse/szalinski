// mathgrrl broken heart - OpenSCAD parametric graph example

/////////////////////////////////////////////////////////////
// EXTENSIONS ///////////////////////////////////////////////

// curriculum.makerbot.com/daily_tutorial/openscad/openscad_05.html
// include <EXTENSIONS/2dgraph.scad>

/////////////////////////////////////////////////////////////
// PARAMETERS ///////////////////////////////////////////////

// Set the diameter of the heart, in mm
heart_diameter = 20;

// Set the thickness of the line, in mm
line_thickness = 1;

// Set the height of the model, in mm
line_height = 3;

// Choose low numbers for jagged, high for smooth
number_of_steps = 48;

scalefactor = heart_diameter*1.15/20;

/////////////////////////////////////////////////////////////
// RENDERS //////////////////////////////////////////////////

// broken heart parametric curve
// equation from http://mathworld.wolfram.com/HeartCurve.html
function x(t) = scalefactor*16*pow(sin(t),3);
function y(t) = scalefactor*(13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t));

// make the graph and extrude it
linear_extrude(height=line_height)
	2dgraph(	[0, 350], 				// stop before 360 to make broken
				line_thickness, 		// set line thickness
				steps=number_of_steps,// choose low/high poly look
				parametric=true);		// use parametric grapher

/////////////////////////////////////////////////////////////
// MODULES //////////////////////////////////////////////////

// in Customizer we need to include these to use 2dgraph?
// curriculum.makerbot.com/daily_tutorial/openscad/openscad_05.html

// These functions are here to help get the slope of each segment, and use that to find points for a correctly oriented polygon
function diffx(x1, y1, x2, y2, th) = cos(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function diffy(x1, y1, x2, y2, th) = sin(atan((y2-y1)/(x2-x1)) + 90)*(th/2);
function point1(x1, y1, x2, y2, th) = [x1-diffx(x1, y1, x2, y2, th), y1-diffy(x1, y1, x2, y2, th)];
function point2(x1, y1, x2, y2, th) = [x2-diffx(x1, y1, x2, y2, th), y2-diffy(x1, y1, x2, y2, th)];
function point3(x1, y1, x2, y2, th) = [x2+diffx(x1, y1, x2, y2, th), y2+diffy(x1, y1, x2, y2, th)];
function point4(x1, y1, x2, y2, th) = [x1+diffx(x1, y1, x2, y2, th), y1+diffy(x1, y1, x2, y2, th)];
function polarX(theta) = cos(theta)*r(theta);
function polarY(theta) = sin(theta)*r(theta);

module nextPolygon(x1, y1, x2, y2, x3, y3, th) {
    if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th)))) {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                // This point connects this segment to the next
                point4(x2, y2, x3, y3, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3,4]]
        );
    }
    else if((x2 > x1 && x2-diffx(x2, y2, x3, y3, th) > x2-diffx(x1, y1, x2, y2, th) || (x2 <= x1 && x2-diffx(x2, y2, x3, y3, th) < x2-diffx(x1, y1, x2, y2, th)))) {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                // This point connects this segment to the next
                point1(x2, y2, x3, y3, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3,4]]
        );
    }
    else {
        polygon(
            points = [
                point1(x1, y1, x2, y2, th),
                point2(x1, y1, x2, y2, th),
                point3(x1, y1, x2, y2, th),
                point4(x1, y1, x2, y2, th)
            ],
            paths = [[0,1,2,3]]
        );
    }
}

module 2dgraph(bounds=[-10,10], th=2, steps=10, polar=false, parametric=false) {

    step = (bounds[1]-bounds[0])/steps;
    union() {
        for(i = [bounds[0]:step:bounds[1]-step]) {
            if(polar) {
                nextPolygon(polarX(i), polarY(i), polarX(i+step), polarY(i+step), polarX(i+2*step), polarY(i+2*step), th);
            }
            else if(parametric) {
                nextPolygon(x(i), y(i), x(i+step), y(i+step), x(i+2*step), y(i+2*step), th);
            }
            else {
                nextPolygon(i, f(i), i+step, f(i+step), i+2*step, f(i+2*step), th);
            }
        }
    }
}