//Used to generate binomial coeffecients.
function binom(n,k)=(n<=k ? 1 : (k==0 ? 1 : (n/k)*binom(n-1,k-1)));

//Used to generate a list of the binomial coeffecients used so it doesn't need to be calculated for every step.
function binoms(n,k=0)=(n<k ? [] : concat(binom(n,k),binoms(n,k+1)));

//Main function. After a few checks, calls function to generate points, passing the degree and a list of binomial coeffecients.
function bezier(points,dl=false,n=5)=(!(points) || len(points)<3 || n<2 ? [] : bezpoints(points,dl,n,len(points)-1,binoms(len(points)-1)));

//Function to generate list of points along path. Mainly calculates the t value to pass to the sum function and then goes to the next point
function bezpoints(points,dl,n,d,binoms,t=0)=(t>n || (dl && t==n) ? [] : concat([bezsum(points,d,t/n,binoms)],bezpoints(points,dl,n,d,binoms,t+1)));

//Funciton to calculate the individual point using a sum of each term.
function bezsum(points,d,t,binoms,i=0)=(i>d ? emptvect(len(points[0])) : binoms[i]*points[i]*pow((1-t),(d-i))*pow(t,i) + bezsum(points,d,t,binoms,i+1));

//Function to generate an empty vector so the beziers can work in any dimensional space.
function emptvect(n,k=0)=(n==k ? [] : concat(0,emptvect(n,k+1)));


function pointDistances(x1,x2,y1,y2) = sqrt(pow((x2-x1),2)+pow((y2-y1),2));

function quarterPointLow(x0,x1) = .75*x0+.25*x1; 

function quarterPointHigh(x0,x1) = .25*x0+.75*x1; 
function lineSectionPoint(size,x0,x1) = (size/100)*x0+((100-size)/100)*x1; 
function findSlope(x0,x1,y0,y1) = ((y1-y0)/(x1-x0));
function findouterpointY(slope,b,x) = slope*x+b;


function findIntersectingY(m0,x0,b0,m1,b1) = (m0*x0)+b0-b1;
function findXintercept(m0,x0,b0,m1,b1)=(m0*x0 + b0 - b1)/m1;
function findYIntercept(slope,b,x) = slope*x+b;
function findXfromYval(slope,b,y) = ((y-b)/slope);

// what type of processing do you want?
type = "angular"; //["angular","rounded"]

//How many points do you want to start wilh? 
itterations = 40;//[10:100]

//The size of the surface being generated
surfaceDimentsion = 20;//[10:100]

// The distance for nodes to connect
nodeScope = 9;//[4:100]



/* [Hidden] */
cubeDimentions = [.25,.25,2.1];
checko = true; //["true","false"]
xRands = rands(-surfaceDimentsion,surfaceDimentsion,itterations);
YRands = rands(-surfaceDimentsion,surfaceDimentsion,itterations);
echo(str("xRands = ",xRands,";"));
echo(str("YRands = ",YRands,";"));


if(type == "angular"){
	if(checko){
		nodeMatrixRounded();
	}else{
		difference(){
			cube([2*surfaceDimentsion,2*surfaceDimentsion,2],true);
			nodeMatrixRounded();
		}
	}
}else{
	if(checko){
		nodeMatrixAngular();
	}else{
		difference(){
			cube([2*surfaceDimentsion,2*surfaceDimentsion,2],true);
			nodeMatrixAngular();
		}
	}
}

module createBezierRounded(x0,y0,x1,y1){
        slopeOrigin = findSlope(x0,x1,y0,y1);
   
        bOrigin = -slopeOrigin * x0 + y0;
        recprical = -1/slopeOrigin;
        
        Xder0 = lineSectionPoint(0,x0,x1);
        Yder0 = lineSectionPoint(0,y0,y1);
        bTemp0 = -recprical * Xder0 + Yder0;
        xintercept0 = findXintercept(slopeOrigin
                    ,Xder0
                    ,bOrigin+.3
                    ,recprical
                    ,bTemp0);
        yintercept0 = findYIntercept(recprical,bTemp0,xintercept0);
        
        points0=[xintercept0,yintercept0];
        
        Xder1 = lineSectionPoint(25,x0,x1);
        Yder1 = lineSectionPoint(25,y0,y1);
        bTemp1 = -recprical * Xder1 + Yder1;
        xintercept1 = findXintercept(slopeOrigin
                    ,Xder1
                    ,bOrigin+.17
                    ,recprical
                    ,bTemp1);
        yintercept1 = findYIntercept(recprical,bTemp1,xintercept1);
        
        points1=[xintercept1,yintercept1];
        
        Xder2 = lineSectionPoint(50,x0,x1);
        Yder2 = lineSectionPoint(50,y0,y1);
        bTemp2 = -recprical * Xder2 + Yder2;
        xintercept2 = findXintercept(slopeOrigin
                    ,Xder2
                    ,bOrigin+.05
                    ,recprical
                    ,bTemp2);
        yintercept2 = findYIntercept(recprical,bTemp2,xintercept2);
        
        points2 = [xintercept2,yintercept2];
        
        Xder3 = lineSectionPoint(75,x0,x1);
        Yder3 = lineSectionPoint(75,y0,y1);
        bTemp3 = -recprical * Xder3 + Yder3;
        xintercept3 = findXintercept(slopeOrigin
                    ,Xder3
                    ,bOrigin+.17
                    ,recprical
                    ,bTemp3);
        yintercept3 = findYIntercept(recprical,bTemp3,xintercept3);
       
        points3 = [xintercept3,yintercept3];
        
        Xder4 = lineSectionPoint(100,x0,x1);
        Yder4 = lineSectionPoint(100,y0,y1);
        bTemp4 = -recprical * Xder4 + Yder4;
        xintercept4 = findXintercept(slopeOrigin
                    ,Xder4
                    ,bOrigin+.5
                    ,recprical
                    ,bTemp4);
        yintercept4 = findYIntercept(recprical,bTemp4,xintercept4);
        
        points4 = [xintercept4,yintercept4];
        
        points00 = [[x1,y1],[points0[0],points0[1]],[points1[0],points1[1]],[points2[0],points2[1]],[points3[0],points3[1]],[points4[0],points4[1]],[x0,y0],[x1,y1]];

        linear_extrude(height = 2.1, convexity = 10,center = true)
        polygon(points=concat(bezier(points00,n=50)));
}

module createBezierAngular(x0,y0,x1,y1){
        slopeOrigin = findSlope(x0,x1,y0,y1);
   
        bOrigin = -slopeOrigin * x0 + y0;
        recprical = -1/slopeOrigin;
        
        Xder0 = lineSectionPoint(0,x0,x1);
        Yder0 = lineSectionPoint(0,y0,y1);
        bTemp0 = -recprical * Xder0 + Yder0;
        xintercept0 = findXintercept(slopeOrigin
                    ,Xder0
                    ,bOrigin+.3
                    ,recprical
                    ,bTemp0);
        yintercept0 = findYIntercept(recprical,bTemp0,xintercept0);
        
        points0=[xintercept0,yintercept0];
        
        Xder1 = lineSectionPoint(25,x0,x1);
        Yder1 = lineSectionPoint(25,y0,y1);
        bTemp1 = -recprical * Xder1 + Yder1;
        xintercept1 = findXintercept(slopeOrigin
                    ,Xder1
                    ,bOrigin+.17
                    ,recprical
                    ,bTemp1);
        yintercept1 = findYIntercept(recprical,bTemp1,xintercept1);
        
        points1=[xintercept1,yintercept1];
        
        Xder2 = lineSectionPoint(50,x0,x1);
        Yder2 = lineSectionPoint(50,y0,y1);
        bTemp2 = -recprical * Xder2 + Yder2;
        xintercept2 = findXintercept(slopeOrigin
                    ,Xder2
                    ,bOrigin+.05
                    ,recprical
                    ,bTemp2);
        yintercept2 = findYIntercept(recprical,bTemp2,xintercept2);
        
        points2 = [xintercept2,yintercept2];
        
        Xder3 = lineSectionPoint(75,x0,x1);
        Yder3 = lineSectionPoint(75,y0,y1);
        bTemp3 = -recprical * Xder3 + Yder3;
        xintercept3 = findXintercept(slopeOrigin
                    ,Xder3
                    ,bOrigin+.17
                    ,recprical
                    ,bTemp3);
        yintercept3 = findYIntercept(recprical,bTemp3,xintercept3);
       
        points3 = [xintercept3,yintercept3];
        
        Xder4 = lineSectionPoint(100,x0,x1);
        Yder4 = lineSectionPoint(100,y0,y1);
        bTemp4 = -recprical * Xder4 + Yder4;
        xintercept4 = findXintercept(slopeOrigin
                    ,Xder4
                    ,bOrigin+.3
                    ,recprical
                    ,bTemp4);
        yintercept4 = findYIntercept(recprical,bTemp4,xintercept4);
        
        points4 = [xintercept4,yintercept4];
        
        points00 = [[points0[0],points0[1]],[points1[0],points1[1]],[points2[0],points2[1]],[points3[0],points3[1]],[points4[0],points4[1]]];
        
       
		linear_extrude(height = 2.1, convexity = 10,center = true)
			polygon(points=concat([[x1,y1]],bezier(points00,n=50),[[x0,y0]]));
}


module nodeMatrixAngular(){
    for(i=[0:1:itterations],j=[0:1:itterations]){
        if(xRands[i]!=xRands[j] &&YRands[i]!=YRands[j]){
            if(pointDistances(xRands[i],xRands[j],YRands[i],YRands[j])<(nodeScope) +1){
               
            check = abs(xRands[i] - xRands[j]);
                
                if(check>.5){
                    createBezierAngular(xRands[i]
                        ,YRands[i]
                        ,xRands[j]
                        ,YRands[j]);
                }else{
                    hull(){
                        translate([xRands[i],YRands[i],0])
                        cube(cubeDimentions,true);
                        translate([xRands[j],YRands[j],0])
                        cube(cubeDimentions,true);
                        }
                }
            }
        }
    }
}

module nodeMatrixRounded(){
    for(i=[0:1:itterations],j=[0:1:itterations]){
        if(xRands[i]!=xRands[j] &&YRands[i]!=YRands[j]){
            if(pointDistances(xRands[i],xRands[j],YRands[i],YRands[j])<(nodeScope) +1){
               
            check = abs(xRands[i] - xRands[j]);
                
                if(check>.5){
                    createBezierRounded(xRands[i]
                        ,YRands[i]
                        ,xRands[j]
                        ,YRands[j]);
                }else{
                    hull(){
                        translate([xRands[i],YRands[i],0])
                        cube(cubeDimentions,true);
                        translate([xRands[j],YRands[j],0])
                        cube(cubeDimentions,true);
                        }
                }
            }
        }
    }
}