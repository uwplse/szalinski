/*[Settings]*/

//Average radius of ring
r1=30;//[5:40]

// Variation from Average radius
r2=2;//[1:3]

//Height of ring
r3=5;//[5:10]

//Radius of strand
sphererad=2;//[1:3]

//Number of winding per revolution
windings = 7;

//Smoothness of plot
m=300;//[200:400]


n=windings+1/3;


for (i=[0:m-1])
{
    hull()
    {
        translate([(r1+r2*sin(6*n*360/m*i))*cos(3*360/m*i),
                   (r1+r2*sin(6*n*360/m*i))*sin(3*360/m*i),
                   r3*cos(n*3*360/m*i)]) scale([1,1,1.5])sphere(sphererad,$fn=20);
        translate([(r1+r2*sin(6*n*360/m*(i+1)))*cos(3*360/m*(i+1)),
                   (r1+r2*sin(6*n*360/m*(i+1)))*sin(3*360/m*(i+1)),
                   r3*cos(n*3*360/m*(i+1))]) scale([1,1,1.5])sphere(sphererad,$fn=20);
    }
    
}

