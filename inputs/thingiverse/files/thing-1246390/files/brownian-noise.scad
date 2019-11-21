number=20; //[2:100]
size=1; //[1:30]
seed=0; //[-1000000000:1000000000]
density=0; //[-50:50]

function whiteRow(z,y) =
    rands(-1,1,number,y+z*number+seed);

function grid() =
    integrateAllZ([for(z=[0:number-1])
        integrateAllY(
        [for(y=[0:number-1])
            integrateX(whiteRow(z,y),number-1)
        ])
    ]);

function integrateX(vec,x)=
        (x==0)?[vec[0]]
        :let(rest=integrateX(vec,x-1))
            concat(vec[x]+rest[0],rest);

function integrateAllY(vec)=[
    for(x=[0:number*2])
        integrateY(vec,x,number-1)];

function integrateY(vec,x,y)=
        (y==0)?[vec[0][x]]
        :let(rest=integrateY(vec,x,y-1))
            concat(vec[y][x]+rest[0],rest);

function integrateAllZ(vec)=
    [for(x=[0:number*2])
        [for(y=[0:number*2])
            integrateZ(vec,x,y,number-1)]];

function integrateZ(vec,x,y,z)=
        (z==0)?[vec[0][x][y]]
        :let(rest=integrateZ(vec,x,y,z-1))
            concat(vec[z][x][y]+rest[0],rest);

function addAllPointsAndFaces(data,i)=(i==0)?data[0]:addPointsAndFaces(addAllPointsAndFaces(data,i-1),data[i]);

function addPointsAndFaces(old,new)=[concat(old[0],new[0]),addFaces(old[1],new[1],len(old[0]))];

function addFaces(oldFaces,newFaces,pointNum)=concat(oldFaces,addScalar(newFaces,pointNum));

function addScalar(vec,x)=[for(v=vec) [for(a=v) a+x]];

function addVector(vec,x)=[[for(v=vec[0]) v+x],vec[1]];

grid=grid();

function checkSurroundings(x,y,z)=
    ((x==0||grid[x-1][y][z]>=density)?1:0)+
    ((y==0||grid[x][y-1][z]>=density)?2:0)+
    ((z==0||grid[x][y][z-1]>=density)?4:0)+
    ((x==number-1||grid[x+1][y][z]>=density)?8:0)+
    ((y==number-1||grid[x][y+1][z]>=density)?16:0)+
    ((z==number-1||grid[x][y][z+1]>=density)?32:0);

h=size/2;

function bit(f,b)=floor(f/b)%2;

function draw(f)=addAllPointsAndFaces([
    bit(f,1)?[[[-h,-h,-h],[-h,h,-h],[-h,-h,h],[-h,h,h]],[[0,1,2],[1,3,2]]]:[[],[]],
    bit(f,2)?[[[-h,-h,h],[h,-h,h],[-h,-h,-h],[h,-h,-h]],[[0,1,2],[1,3,2]]]:[[],[]],
    bit(f,4)?[[[-h,-h,-h],[h,-h,-h],[-h,h,-h],[h,h,-h]],[[0,1,2],[1,3,2]]]:[[],[]],
    bit(f,8)?[[[h,-h,h],[h,h,h],[h,-h,-h],[h,h,-h]],[[0,1,2],[1,3,2]]]:[[],[]],
    bit(f,16)?[[[h,h,h],[-h,h,h],[h,h,-h],[-h,h,-h]],[[0,1,2],[1,3,2]]]:[[],[]],
    bit(f,32)?[[[-h,h,h],[h,h,h],[-h,-h,h],[h,-h,h]],[[0,1,2],[1,3,2]]]:[[],[]]
    ],5);

function drawPoint(x,y,z)=(grid[x][y][z]<density)?
        let(surroundings=checkSurroundings(x,y,z))
        ((surroundings>0)?addVector(draw(surroundings),[x*size,y*size,z*size]):[[],[]]):[[],[]];


result=addAllPointsAndFaces([for(x=[0:number-1])
    addAllPointsAndFaces([for(y=[0:number-1])
        addAllPointsAndFaces([for(z=[0:number-1]) drawPoint(x,y,z)],number-1)
    ],number-1)
],number-1);

translate([-(number*size)/2,-(number*size)/2,size/2])
polyhedron(result[0],result[1]);