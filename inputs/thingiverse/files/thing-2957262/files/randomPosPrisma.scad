

/* [Prism] */
prismRadius=25; //outer radius of prism base
prismHeight=100; //Height of Prisma

/* [Objects] */
numObjects=100; //number of Objects
minSize=4;
maxSize=6;

/* [Hidden] */
$fn=50;

randTest(prismRadius,prismHeight,numObjects,minSize,maxSize);

module randTest(R,height,count,minSize,maxSize){
  
  r = R/2;//inner Radius
  a = (3/sqrt(3))*R; //side length
  seed = rands(0,1000,1);
  *linear_extrude(height)
    color("lightgrey") circle(R,$fn=3);
  
  echo("Seed:",seed); //one Million seeds
  gammas=rands(0,60,count,seed[0]);
  betas =rands(0,60,count,seed[0]+1);
  heights=rands(0,height,count,seed[0]+2);
  sizes =rands(minSize,maxSize,count,seed[0]+3);
  
  
  for (i=[0:count-1]){
    
    aCor=a-(sizes[i]/tan(30))*2; //calculate a corrected side length
    rCor=R-sizes[i]/sin(30); //and a corrected shift in X
    zCor=map(heights[i],0,height,0+sizes[i],height-sizes[i]); //map from 0..height to (0+size/2)..(height-size/2)
    
   
    alpha=180-gammas[i]-betas[i];
    alpha2=180-alpha;
    delta=180-alpha2-(30-gammas[i]);
     
    b=aCor*sin(betas[i])/sin(alpha);
    
    a2=b*sin(alpha2)/sin(delta);
    y=b*sin(30-gammas[i]);
    x=rCor-sqrt(pow(b,2)-pow(y,2));
  
    translate([x,y,zCor]) sphere(sizes[i]);
  }
}

function map(x, in_min, in_max, out_min, out_max)=
  (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
