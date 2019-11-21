// How many sides there are
sides = 5; // [3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
// star size
starSize = 80; // [10:100]
// Height
h = 400; // [10:500]
// Scale of top star (%)
s = 100; // [20:200]

ss = starSize*100;
//Define functions for a single point
function r(p, deg) = [(cos(deg)*p[0]) + (-sin(deg)*p[1]),(sin(deg)*p[0]) + (cos(deg)*p[1])];
function sc(p, factor) = [p[0]*factor,p[1]*factor];

//Define functions for a list
function combine(list1, list2) = [
    for (i = [1 : len(list1)*2])
        (i-1)%2==0 ? list1[i/2] : list2[(i-1)/2]
];
function rotateList(l, deg) = [
    for (i = [1:len(l)])
        r(l[i-1], deg)
];
function scaleList(l, x, y)  = [
    for (i = [1:len(l)])
        [
            l[i-1][0]*(x/100), //x value
            l[i-1][1]*(y/100) //y value
        ]
];
function translateList(l, x, y, z) = [
    for (i = [1:len(l)])
        [
            l[i-1][0]+x,
            l[i-1][1]+y,
            l[i-1][2]+z
        ]
];
function addZ(l, z) = [
    for (i = [1:len(l)])
        [
            l[i-1][0],
            l[i-1][1],
            z
        ]
];

//generate points list for bottom star
bottomPoints = addZ(scaleList([ for(i = [1:sides]) r([1,1],i * 360/sides)], ss, ss), 0);
//now add a z to that, rotate it accordingly, and scale it
topPoints = addZ(scaleList(rotateList(bottomPoints, 180/sides), s, s), h);





allPoints = concat([[0,0,0], [0,0,h]], combine(bottomPoints,topPoints));
echo("allPoints");
echo(allPoints);

topTriangles = [
    for (i = [0:2:(sides-1)*2]) 
        [
            1, 
            3+i <= sides*2 + 1 ? 3+i : 3+i - sides*2, 
            3+i+2 <= sides*2 + 1 ? 3+i+2 : 3+i+2 - sides*2
        ]
];
bottomTriangles = [
    for (i = [0:2:(sides-1)*2]) 
        [
            0, 
            4+i <= sides*2 + 1 ? 4+i : 4+i - sides*2, 
            4+i+2 <= sides*2 + 1 ? 4+i+2 : 4+i+2 - sides*2
        ]
];
echo("bottomTriangles");
echo(bottomTriangles);
echo("topTriangles");
echo(topTriangles);
baseTriangles = concat(bottomTriangles, topTriangles);

sideTriangles = [
    for (i = [0:(2*sides)-1])
        [
            (2+i), 
            (2+i+1) <= sides*2 +1 ? 2+i+1 : (2+i+1) - sides*2, 
            (2+i+2) <= sides*2 +1 ? 2+i+2 : (2+i+2) - sides*2
        ]
];
echo("sideTriangles");
echo(sideTriangles);


allTriangles = concat(baseTriangles, sideTriangles);
echo("allTriangles");
echo(allTriangles);
polyhedron(allPoints, allTriangles);
