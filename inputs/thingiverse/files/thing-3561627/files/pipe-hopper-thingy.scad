sect1_length = 110;
sect2_length = 50;
sect3_length = 30;
outside_width = 34;
inside_width = 24;
hopper_outside_width = 90;
hopper_inside_width = 80;
hopper_offset = 0;
outside_radius = outside_width/2;
inside_radius = inside_width/2;

// The scripts below were borrowed from this file: https://www.thingiverse.com/thing:2845013 (Extrude Along Path Remix with 2D scale and morph by halfshavedyaks) which is under the Creative Commons - Attribution - Share Alike license

sect2_actual_length = sqrt(pow(sect2_length,2)/2); // use pythagorean theorem to get correct measurements
myPath = [[0,0,0],[0,sect1_length,0],[sect2_actual_length,sect2_actual_length+sect1_length,0],[sect2_actual_length+sect3_length,sect2_actual_length+sect1_length+hopper_offset,0]];

myPointsOutside = [for(t = [0:2.815:359]) [cos(t)*outside_radius,sin(t)*outside_radius]];
myPointsInside = [for(t = [0:2.815:359]) [cos(t)*inside_radius,sin(t)*inside_radius]];

// rotation matrix implementation
// OpenSCAD seems to do this slightly different from Wikipedia
// c.f. https://en.wikipedia.org/wiki/Rotation_matrix#Basic_rotations
function rot2Mat(rotVec, axis) =
    (len(rotVec) == 2) ?
        rot2Mat([rotVec[0], rotVec[1], 0], axis) :
    (axis == "x") ?
        [[1,              0,               0],
         [0, cos(rotVec[0]),  sin(rotVec[0])],
         [0, sin(rotVec[0]), -cos(rotVec[0])]] :
    (axis == "y") ?
        [[ cos(rotVec[1]), 0, sin(rotVec[1])],
         [              0, 1,              0],
         [-sin(rotVec[1]), 0, cos(rotVec[1])]] :
    (axis == "z") ?
        [[ cos(rotVec[2]), sin(rotVec[2]), 0],
         [-sin(rotVec[2]), cos(rotVec[2]), 0],
         [0,              0,               1]] : undef;

// convert point to 3D by setting Z to zero (if not present)
function c3D(tPoints) = 
    (len(tPoints[0]) < 3) ?
        tPoints * [[1,0,0],[0,1,0]] :
        tPoints;

// rotate [2D] points using a specificed XYZ rotation vector
function myRotate(rotation, points) =
    c3D(points) * rot2Mat(rotation, "x")
           * rot2Mat(rotation, "y")
           * rot2Mat(rotation, "z");    
    
// Determine spherical rotation for cartesian coordinates
function rToS(pt) = 
    [-acos((pt[2]) / norm(pt)), 
	 0, 
	 -atan2(pt[0],pt[1])];

// Generate a line between two points in 3D space
module line3D(p1,p2){
  translate((p1+p2)/2)
    rotate(rToS(p1-p2))
       cylinder(r=1, h=norm(p1-p2), center = true, $fn = 3);
}

// Flattens an array down one level (removing the enclosing array)
function flatten(pointArray, done=0, res=[]) =
    (done == len(pointArray)) ?
        res :
        flatten(pointArray=pointArray, done=done+1, 
            res=concat(res,pointArray[done]));

// Creates a polyhedron face
function phFace(pp, tp, base, add=0) =
    [base + add, (base+1) % pp + add,
     (((base+1) % pp) + pp + add) % tp, (base + pp + add) % tp];

function add(vecArg, scArg, res=[]) = 
    (len(res) >= len(vecArg)) ?
        res :
        add(vecArg, scArg, res=concat(res,[vecArg[len(res)]+scArg]));

// Generate an extruded polyhedron from an array of points
// boolean argument "closed" indicates whether to close up the 
// start and end polygon
module makeExtrudedPoly(ex, merge=false, trimEnds=false){
    //echo(ex);
    ps = flatten(ex);
    
    pp = len(ex[1]); // points in one polygon
    tp = len(ex[1]) * len(ex); // total number of points
    if(!merge && !trimEnds){
        polyhedron(points=ps, faces=concat(
            [[for (i = [pp-1  : -1 :    0]) i]],
            [[for (i = [tp-pp :  1 : tp-1]) i]],
            [for (pt=[0:(len(ex)-2)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)],
            [])
        );
    } else if(trimEnds) {
        polyhedron(points=ps, faces=concat(
            [[for (i = [pp*2-1  : -1 :    pp]) i]],
            [[for (i = [tp-pp*2 :  1 : tp-pp-1]) i]],
            [for (pt=[1:(len(ex)-3)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)]));
    } else {
        polyhedron(points=ps, faces=
            [for (pt=[0:(len(ex)-1)])
                for(i = [0:pp-1]) phFace(pp,tp,i,pt*pp)]);
    }
}

//these functions are HalfShavedYaks utility functions

function Xpoints(points) = [for (step=[0:len(points)-1]) points[step][0] ];
function Ypoints(points) = [for (step=[0:len(points)-1]) points[step][1] ];
    
function combineXYpoints(pointsX, pointsY) = [for (step=[0:len(pointsX)-1]) [pointsX[step][0],pointsY[step][0]] ];

function getsizeofpolygon(points) = [  max(Xpoints(points))-min(Xpoints(points)),max(Ypoints(points))-min(Ypoints(points))  ];

function offsetpoints2D(list,Xoffset,Yoffset) = [for (step=[0:len(list)-1]) ([list[step][0]-Xoffset,list[step][1]-Yoffset]) ];
    
function flipY2D(list) = [for (step=[0:len(list)-1]) ([list[step][0],list[step][1]*-1]) ];
    
function translateZ(list, Zup) = [for (step=[0:len(list)-1]) ([list[step][0],list[step][1], list[step][2]+Zup]) ];

//function scalepoints1D(list,fact) = [for (step=[0:len(list)-1]) list[step]*fact ];

//these functions are part of the HSY mod to the code to support 2D scaling and morph
    
function scalepoints2D(list,Xfact,Yfact) = [for (step=[0:len(list)-1]) ([list[step][0]*Xfact,list[step][1]*Yfact]) ];
    
function pdiff(start,end,prop) = (start-((start-end)*prop));

function maketween(start, end, prop)= [for (step=[0:len(start)-1]) ([pdiff(start[step][0],end[step][0], prop),pdiff(start[step][1],end[step][1], prop)]) ];
    
//morph one shape into another (point for point - doesn't interpolate if start and end have different number of points)

module lin_morph(length = 100, start=0, end=0, nsteps = 10){
    inc = length/nsteps;
    fullarray = [for (step=[0:inc:length]) ([translateZ(c3D(maketween(start,end,step/length)),step)]) ];
    makeExtrudedPoly(flatten(fullarray));
}

module lin_morph_scale(length = 100, start=0, end=0, nsteps = 10, scl=0){
    inc = length/nsteps;
    fullarray = [for (step=[0:nsteps-1]) ([translateZ(c3D(scalepoints2D(maketween(start,end,step*inc/length), scl[step][0],scl[step][1])),step*inc)]) ];
   
    makeExtrudedPoly(flatten(fullarray));
}

//FIX that the resulting object is not always the correct length why??

// Extrude polygon along a path
module path_extrude(points, endpoints=false, path, pos=0, merge=false, trimEnds=false, doRotate=true,
                    doScale=false, do2Dscale=false, extruded=[]){                      
    if((len(points) > 0) && (len(path) > 0) && (len(points[0]) > 1)){
        if(len(extruded) >= (len(path))){
            // extrusion is finished, so construct the object
            makeExtrudedPoly(extruded, merge=merge, trimEnds=trimEnds);
        } else {
           //morph - get next tween
            mPoints = (endpoints ? (maketween(points, endpoints, pos/(len(path)-1) ) ) : points);
            //1Dscale
            ssPoints = (doScale ? (mPoints*doScale[pos]) : mPoints );
            //2Dscale
            sPoints = (do2Dscale ? (scalepoints2D(ssPoints, do2Dscale[pos][0],do2Dscale[pos][1])) : ssPoints );
            // generate points from rotating polygon
            if(merge || (pos < (len(path) - 1))){
                if((pos == 0) && (!merge)) {
                    newPts = (doRotate?(myRotate(rToS(path[1] - path[0]),sPoints)):c3D(sPoints));
                    path_extrude(points=points, endpoints=endpoints, path=path, pos=pos+1, 
                        merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale, do2Dscale=do2Dscale,
                        extruded=concat(extruded, [add(newPts,path[pos])]));
                } else {
                    newPts = (doRotate?(myRotate(rToS(path[(pos+1) % len(path)] 
                        - path[(pos+len(path)-1) % len(path)]),
                        sPoints)):c3D(sPoints));
                    path_extrude(points=points, endpoints=endpoints, path=path, pos=pos+1,
                        merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale, do2Dscale=do2Dscale,
                        extruded=concat(extruded, [add(newPts,path[pos])]));
                }
            } else {
                newPts = (doRotate?(myRotate(rToS(path[pos] - path[pos-1]),sPoints)):c3D(sPoints));
                path_extrude(points=points, endpoints=endpoints, path=path, pos=pos+1,
                    merge=merge, trimEnds=trimEnds, doRotate=doRotate, doScale=doScale, do2Dscale=do2Dscale,
                    extruded=concat(extruded, [add(newPts,path[pos])]));
            }
        }
    }
}
inside_factor = hopper_inside_width/inside_width;
inside_scale = [[1,1],[1,1],[1,1],[inside_factor,inside_factor]];
outside_factor = hopper_outside_width/outside_width;
outside_scale = [[1,1],[1,1],[1,1],[outside_factor,outside_factor]];

render() {
    difference() {
        path_extrude(points=myPointsOutside, endpoints = myPointsOutside, path=myPath, do2Dscale = outside_scale);
        path_extrude(points=myPointsInside, endpoints = myPointsInside, path=myPath, do2Dscale = inside_scale);
    }
}