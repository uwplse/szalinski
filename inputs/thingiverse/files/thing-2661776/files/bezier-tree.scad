//Thingiverse Customizer Params
/* [Tree] */
//Base Length of Trunk
size = 800; //[100:1000]

//Depth of recursion
depth = 6; //[2:7]

//Thickness Fudge - use this to decrease thickness on low depth trees
distance = 1; //[0:15]

//Random Seed to grow Tree From
seed = 54; //[0:100]

//Maximum bend in each segment
bend = 180; //[0:500]

//Width at base of tree
widthBottom = 200; //[10:500]

//Width at top of first segment
widthTop = 175; //[10:500]

//Minimum Growth ratio for new segments
minGrowth = 0.8; //[0.5:0.1:1.2]

//Maximum Growth ratio for new segments
maxGrowth = 0.9; //[0.5:0.1:1.2]

//Decay Rate
decay = 0.95; //[0.5:0.05:1.2]

//Minimum Angle for new branches
minAngle = 35; //[10:170]

//Maximum Angle for new branches
maxAngle = 37; //[10:170]

//Branch Probability - chance of choosing a one, two or three branch joint (must add up to 100!)
oneBranch = 10; //[0:100]
twoBranch = 50; //[0:100]
threeBranch = 40; //[0:100]

//Step size for Bezier Curves - smaller yields smoother curves
step = 0.05; //[0.03:0.01:0.1]

// preview[view:south, tilt:top]

/*[Hidden]*/
branchProb = [oneBranch, twoBranch, 100-oneBranch-twoBranch];

trunk(size = size, 
      distance = distance, 
      depth = depth,
      seed = seed,
      bend = bend,
      widthBottom = widthBottom,
      widthTop = widthTop,
      minGrowth = minGrowth,
      maxGrowth = maxGrowth,
      decay = decay,
      minAngle = minAngle,
      maxAngle = maxAngle,
      branchProb = branchProb,
      step = step
      );


/*
#2D Fractal Tree Library#

This library creates 2D objects that can be exported as SVG objects
This does NOT produce a valid three dimensional object that can be printed. 


##tl;dr:## 
+`trunk();`
+F6 (render)
+Export as an SVG in OpenSCAD: `File > Export > Export as SVG`

##Thanks##
All Bezier Functions based on the excellent work of @caterpillar (Justin SDK)
https://openhome.cc/eGossip/OpenSCAD/BezierCurve.html

Thanks to SteveWeber314 for his fractal tree tutorials
https://www.thingiverse.com/steveweber314/about

##Licenses##
Releasted under GPL v3 - Share Alike
please see the included LICENSE file for the complete license text

##README##
This library uses psuedo-random bezier curves to generate a 2D vector drawing of a tree.
There are *many* paramaters that can be adjusted to produce different trees.

-Aaron Ciuffo (reach me at Gmail: aaron.ciuffo)

=======
To use this within another OpenSCAD design try:
`
use </Path/To/This/File/bezier_tree.scad>

trunk();
`

Here are three examples all grown from the same "seed" but with tweaks to the parameters
to produce three very different trees.

To produce a tree simliar to a birch tree (thin, tall, quickly diminishing,  
and straight) try the following settings:
`
trunk(size = 900, bend = 25, seed = 40, depth = 12, widthBottom = 100, widthTop = 90, 
      maxAngle = 45, minAngle = 35, branchProb = [40, 20, 10], 
      maxGrowth = .9, minGrowth = .9, decay = .85);
`

To produce a tree similar to a gnarled old oak (thick, branching horizontally, with
a bushy crown) try the following settings:
    trunk(size = 600, bend = 150, seed = 40, widthBottom = 300, widthTop = 280, 
          maxAngle = 75, minAngle = 55, branchProb = [20, 50], 
          maxGrowth = 1.0, decay = .93, depth = 6);

A reasonable poppler (tall, stright, fast growing and vertical) can be prodced with
these settings:

    trunk(size = 1500, bend = 100, seed = 40, widthBottom = 300, widthTop = 280,        maxAngle = 15, minAngle = 15, branchProb = [10, 50], 
        maxGrowth = 1.0, decay = .93, depth = 6);


To produce a tree of a particular dimension use:

    resize([0, 0, 500], auto = true) //resize to a height of 500
    trunk(size = 1500, bend = 100, seed = 40, widthBottom = 300, widthTop = 280, 
          maxAngle = 15, minAngle = 15, branchProb = [10, 50, 30], 
          maxGrowth = 1.0, decay = .93, depth = 6);

###Design Considerations###
To create more bent branches increase the bend/size ratio. size = 500, bend = 250 will 
make a VERY twisted tree

Setting depth above 9 can result in very long excution times as the recursion grows
exponentially with depth


###Paramaters###
module trunk()
paramaters:
  \* Denotes paramater that is used internally by recursion and is not intended to be
    used from the inital module call
  (suggested values in parentheses)

    size          [real]        size of first segment (linear from origin)
    seed          [real]        seed with which to generate a psuedo-random tree
    depth         [integer]     recusion level (1 to 8)
    widthBottom   [real]        maximum width at base of trunk
    widthTop      [real]        maximum width at top of first trunk segment
    minGrowth     [real]        minimum amount to grow the new branch (0.1 to 1.2)
    maxGrowth     [real]        maximum amount to grow the new branch (0.1 to 1.2)
    decay         [real]        base amount to diminish each branch by (0.5 to 1.2)
    minAngle      [real]        minimum angle to rotate each branch (0 to 180)
    maxAngle      [real]        maximum angle to rotate each branch (0 to 180)
    branchProb    [vector]      % chance of one, two or three branches occuring
                                [%one, %two] ([10, 40]) - %three is calculated as the 
                                remainder of 100-%one-%two. In this case, %50.
    step          [real]        step size to use when generating bezier curves
                                values approaching 0 are smoother, but take much longer
                                to render (0.05)
    \*depthMax     [integer]     records maximum depth on first call
    \*distance     [integer]     records distance from "trunk" - can be used to diminish
                                branches
    \*start        [vector]      records [x, y, z] vector at which to start 
    \*first        [boolean]     first run sets persistent variables for recursion
                                growing the branch
    debug         [boolean]     turn on debugging including control points
*/


/* 
calculate a coordinate along a bezier curve
paramaters:
  t             [real]        step along the curve
  coord         [vector]      x, y, z vector

returns:
  single coordinate value based on a vector point
*/
function bezierCoordinate(t, coord) = 
  coord[0] * pow((1 - t), 3) + 3 * coord[1] * t * pow((1 - t), 2) +
    3 * coord[2] * pow(t, 2) * (1 - t) + coord[3] * pow(t, 3);

/*
calculate single point along a bezier curve
paramaters:
  t               [real]        step along the curve
  controlPoints   [vector]      x, y, z vector

returns:
  vector of a point along a bezier curve
*/
function bezierPoint(t, controlPoints) = 
  [
    bezierCoordinate(t, [controlPoints[0][0], controlPoints[1][0], controlPoints[2][0],
                    controlPoints[3][0]]),
    bezierCoordinate(t, [controlPoints[0][1], controlPoints[1][1], controlPoints[2][1],
                    controlPoints[3][1]]),
    bezierCoordinate(t, [controlPoints[0][2], controlPoints[1][2], controlPoints[2][2],
                    controlPoints[3][2]])
  ];

/*
calculate the bezier curve for four control points
paramaters:
  t_step          [real]      step size (smaller steps give finer curves)
  controlPoints   [vector]    vector of x, y, z vectors [[0,0], [10,10], [-10,20], [0,50]]

returns:
  vector of length/t_step points along a bezier curve
*/
function bezierCurve(t_step, controlPoints) = 
  [for(t = [0:t_step:1+t_step]) bezierPoint(t, controlPoints)];


/*
generate a vector of four vector control points; first point is always [0, 0]
paramaters:
  seed            [real]      seed for random number generator
  bend            [real]      maximum/minimum deflection for curve
  size            [real]      length, from origin, of curve

returns:
  [[0, 0], [x1, y1], [x2, y2], [x3, y3]]
*/
function randControlPoints(seed, bend, size) = [ 
  // start at origin
  [0, 0], 
  // choose X points between max/min bend, Y points on interval 1/6:3/6 size
  [rands(-bend, bend, 1, seed+0)[0], rands(size/6, size/6*3, 1, seed+1)[0]], 
  // choose X points between max/min bend, Y points on interval 3/6:5/6 size
  [rands(-bend, bend, 1, seed+2)[0], rands(size/6*3, size/6*5, 1, seed+3)[0]],
  // choose X points between max/min bend, Y point at size
  [rands(-bend, bend, 1, seed+4)[0], size] 
  ];

/*
draw a line segment along a bezier curve
paramaters
  point1          [vector]      x, y, z vector of a single point along a bezier curve
  point2          [vector]      x, y, z vector of a single point adjacent to point1
*/
module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}


/*
draw a (tapered) line along a vector curve
paramaters:
  points        [vector]      vector of x, y, z vectors that describe a bezier curve
  startWidth    [real]        starting width of the poly line
  endWidth      [real]        ending width of the poly line
*/
module polyline(points, startWidth = 40, endWidth = 20) {
  module polyline_inner(points, index) {
   //change the width with respect to the start and end
   width = startWidth - (startWidth-endWidth)*(index-1)/len(points);

    if (index < len(points)) {
      line(points[index -1], points[index], width);
      polyline_inner(points, index + 1);
    }
  }
  polyline_inner(points, 1);

}

/*
draw between 1 and 3 poly lines rooted at the "start"
  -this module should be called by module trunk()
paramaters:
  * Denotes paramater that is used internally by recursion and is not intended to be
    used from the inital module call
  (suggested values in parentheses)

  size          [real]        size of first segment (linear from origin)
  depth         [integer]     recusion level (1 to 8)
  seed          [real]        seed with which to generate a psuedo-random tree
  widthBottom   [real]        maximum width at base of trunk
  widthTop      [real]        maximum width at top of first trunk segment
  minGrowth     [real]        minimum amount to grow the new branch (0.1 to 1.2)
  maxGrowth     [real]        maximum amount to grow the new branch (0.1 to 1.2)
  decay         [real]        base amount to diminish each branch by (0.5 to 1.2)
  minAngle      [real]        minimum angle to rotate each branch (0 to 180)
  maxAngle      [real]        maximum angle to rotate each branch (0 to 180)
  branchProb    [vector]      % chance of one, two or three branches occuring
                              [%one, %two, %three] ([10, 40, 50])
  step          [real]        step size to use when generating bezier curves
                              values approaching 0 are smoother, but take much longer
                              to render (0.05)
  *depthMax     [integer]     records maximum depth on first call
  *distance     [integer]     records distance from "trunk" - can be used to diminish
                              branches
  *start        [vector]      records [x, y, z] vector at which to start 
  *branchNum    [integer]     number of branches to draw at each joint (1-3)
*/
module branch(size, 
             depth,
             seed, 
             bend,
             widthBottom, 
             widthTop, 
             minGrowth, 
             maxGrowth, 
             decay, 
             minAngle,
             maxAngle,
             branchProb,
             step, 
             depthMax,
             distance, 
             start,
             branchNum,
             debug
             ) {


  sizemod = rands(minGrowth, maxGrowth, branchNum, seed+1)[0];

  mySize = size*sizemod;

  controlPoints = randControlPoints(seed = seed, bend = bend, size = mySize);
  
  bezierPoints = bezierCurve(step, controlPoints);

  // diminish the branch width by the depth and the distance from the "trunk"
  myWidthTop = widthTop*(depth+1)/(depthMax-2)/(distance+2);

  //draw the current branch
  polyline(bezierPoints, widthBottom, myWidthTop);

  



  if (debug) {
    for (j=[0:len(controlPoints)-1]) {
      color("red")
        translate(controlPoints[j])
        square(30, center = true);
    }
    translate([controlPoints[3][0]+widthBottom/2, controlPoints[3][1]]) {
      color("blue")
      text(str("seed:", seed,", bn:", branchNum), 
              halign = "left", size = myWidthTop*.5);
    
    }
  }


  // create vector of branchNum angles between 0 and maxAngle
  rotations = rands(minAngle, maxAngle, branchNum, seed+3);
  // create vector of branchNum negative and positive values
  direction = [ for (j=[0:branchNum-1]) rands(-1, 1, 1, seed-j)[0]>=0 ? 1 : -1];

  decayRands = rands(decay*decay, decay, branchNum, seed+5);

  tip = controlPoints[3];

  if (depth > 0 && myWidthTop > 10) { //stop if the depth or width gets too small 
    translate(tip) {
      for (i=[0:branchNum-1]) {
        //select rotation value from the vector
        myRot = i==0 ? rotations[i]/depth : rotations[i];
        //set the distance from the trunk
        myDist = (i==0 && distance == 0 )? 0 : distance+1;
        //rotate the starting position by myRot * direction (ccw, cw)
        rotate([0, 0, direction[i]*myRot]) {
          trunk(size = mySize*decay,  //change size by decay
                depth = depth-1, //decrease depth count
                seed = seed*(i+5)/(i+1), //add some variability in seed
                bend = bend*decay, //decrease the bend value
                widthBottom = myWidthTop, //new bottom equals this top
                widthTop = widthTop*decayRands[i], //decrease top value 
                minGrowth = minGrowth, //maintain minGrowth
                maxGrowth = maxGrowth, //maintain maxGrowth
                decay = decay, //maintain decay
                minAngle = minAngle, //maintain minAngle
                maxAngle = maxAngle, //maintain maxAngle
                branchProb = branchProb, //maintain branchProb
                step = step, //maintain step
                depthMax = depthMax, //maintain the maximum depth
                distance = myDist, //pass current distance from trunk 
                start = tip, //start of new banch is tip of this branch
                debug = debug,
                first = false //indicate that this is not the first run
                );
        } //end rotation
      } //end for loop
    } // end translate
  } // end if depth 

}



/*
paramaters:
  * Denotes paramater that is used internally by recursion and is not intended to be
    used from the inital module call
  (suggested values in parentheses)

  size          [real]        size of first segment (linear from origin)
  depth         [integer]     recusion level (1 to 8)
  widthBottom   [real]        maximum width at base of trunk
  widthTop      [real]        maximum width at top of first trunk segment
  minGrowth     [real]        minimum amount to grow the new branch (0.1 to 1.2)
  maxGrowth     [real]        maximum amount to grow the new branch (0.1 to 1.2)
  decay         [real]        base amount to diminish each branch by (0.5 to 1.2)
  minAngle      [real]        minimum angle to rotate each branch (0 to 180)
  maxAngle      [real]        maximum angle to rotate each branch (0 to 180)
  branchProb    [vector]      % chance of one, two or three branches occuring
                              [%one, %two, %three] ([10, 40, 50])
  step          [real]        step size to use when generating bezier curves
                              values approaching 0 are smoother, but take much longer
                              to render (0.05)
  *depthMax     [integer]     records maximum depth on first call
  *distance     [integer]     records distance from "trunk" - can be used to diminish
                              branches
  *start        [vector]      records [x, y, z] vector at which to start 
  *first        [boolean]     first run sets persistent variables for recursion
                              growing the branch
  debug         [boolean]     turn on debugging including control points

*/
module trunk(size = 1000, 
             depth = 6,
             depthMax = 1,
             seed = 22, 
             bend = 100,
             widthBottom = 300, 
             widthTop = 280, 
             minGrowth = 0.8, 
             maxGrowth = .9, 
             decay = 0.95, 
             minAngle = 35,
             maxAngle = 37,
             branchProb = [10, 50, 40],
             step = 0.05, 
             distance = 0, 
             start = [0, 0, 0],
             first = true,
	     debug = false
             ) {


  //set the limits for the probability function 
  brOne = branchProb[0];
  brTwo = branchProb[0]+branchProb[1];

  //select the type of branch
  branchRand = rands(0, 100, 1, seed+5)[0];

  //choose the type of branch
  branchNum = (branchRand < brOne) ? 1 : 
              (brOne < branchRand && branchRand < brTwo) ? 2 : 3;
  
  //check if this is the first run; record the depthMax for use later
  myDepthMax = first==true ? depth : depthMax;

  //call branch module
  branch(size = size, 
         depth = depth, 
         depthMax = myDepthMax,
         seed = seed+4, 
         bend = bend,         
         widthBottom = widthBottom, 
         widthTop = widthTop, 
         minGrowth = minGrowth, 
         maxGrowth = maxGrowth, 
         decay = decay, 
         minAngle = minAngle,
         maxAngle = maxAngle,
         branchProb = branchProb,
         step = step, 
         distance = distance,
         start = start, 
         branchNum = branchNum,
         debug = debug
         );

}

//help_bezier_tree();
module help_bezier_tree(modName = false) {
  //edit content below this line

  //add library name here
  LibraryName = "bezier_tree";

  //enter module and function information here
  modules =
            [["trunk",
              "module: trunk(size = <real>, depth = <integer>, depthMax = <integer internal>, seed = <real>, bend = <real>, widthBottom = <real>, widthTop = <real> minGrowth = <real>, maxGrowth = <real>, decay = <real>, branchProb = <vector>, step = <real>, distance = <integer internal>, start = <vector internal>, first = <boolean internal>, debug = <boolean>)",
              "returns: none (module)",
              "Description: draws psuedo random fractal tree using bezier curved segments",
              "Paramaters: params marked with 'internal' are used by the recursion and not meant to be called directly.",
              "   size        <real>              absolute linear length of first segment",
              "   depth       <integer>           number of recursions; higher values give more complexity",
              "   depthMax    <integer internal>  records maximum depth for internal calculations; not to be used in initial call",
              "   seed        <real>              seed for random number generator",
              "   bend        <real>              maximum deflection for control points along bezier curves",
              "   widthBottom <real>              width at base of tree",
              "   widthTop    <real>              width at top of first segment",
              "   minGrowth   <real>              0.1 <= minGrowth <= 1.2 - minimum percentage to grow each new segment by",
              "   maxGrowth   <real>              0.1 <= maxGrowth <= 1.2 - maximum percentage to grow each new segment by",
              "   decay       <real>              rate at which to decrease branch size, bend, length",
              "   minAngle    <real>              0 <= minAngle <= 180 - minimum angle to vertical of new branches",
              "   maxAngle    <real>              0 <= maxAngle <= 180 - maximum angle to vertical of new branches",
              "   branchProb  <vector>            [%one, %two] - percentage chance of choosing one, two or three branches (%three = 100 - %one - %two)",
              "   step        <real>              0.01 <= step <= 1 - size of steps used in calculating bezier curves; smaller values give smoother curves",
              "   distance    <integer internal>  distance from trunk for a branch segment; segments further from trunk diminish faster; use values > 3 for trees with depth < 5",
              "   start       <vector internal>   [x, y, z] - location of previous tip; used to draw next branch segment",
              "   first       <boolean internal>  true for first run, false there after; used to record 'static' persistent values through recursion",
              "   debug       <boolean>           true to show debug information for each segment"
	     ],

            ];
  //End editable content
  //DO NOT EDIT BELOW THIS POINT

  //convert string into a vector to make search work properly
  modVect = [modName];
  //use the vectorized string to search the modules vector
  index = search(modVect, modules)[0];

  //chcek if a name was passed
  if (modName==false || len(modules[index])==undef) {
      if (len(modules[index])==undef && modName != false) {
        echo(str("*****Module: ", modName, " not found*****"));
        echo("");
      }

      echo("Available Help Topics in this Library:");
      for (i=[0:len(modules)-1]) {
        echo(modules[i][0]);
      }
      echo(str("USE: help_",LibraryName,"(\"moduleName\")  "));
      //assert(modName);
    } else {
      //return the first matching entry
      //-possibly modify this to return all entries - allows partial match

      echo(str("Help for module or function: ", modName));
      //basic = modules[index[0]][1];
      //echo(basic);
      for (text=[1:len(modules[index])-1]) {
        echo(modules[index][text]);
      }
    }
}




