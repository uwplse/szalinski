

/* [Spheres] */
numberOfSpheres=15;
diaOfSpheres=3;

/* [Collision] */
minDistance=3;
maxDistance=5;

/* [Hidden] */
$fn=20;

objList=[]; //init with first Object at zero

/* Code */

if (len(objList)) numberSphere(diaOfSpheres,0);
//addObjects(objList);
addObjectsExpand(objList);


module addObjects(objects,iter=1,count=numberOfSpheres){
  
  if (iter<=count){
    pos=rands(-10,10,3);
    coll=distCheck(objects=objects,pos=pos,iter=iter);
    //echo("Iteration",pos,iter);
    //collCheckTest(objects,pos,iter); //list of objects created, act. Pos, iteration step= count)
    
    objects=concat(objects,[pos]);
    addObjects(objects,iter+1,count);
    
    if (coll) {
      echo("skipped",iter+1);
      //color("red") translate(pos) numberSphere(3,iter+1);
    }
    else translate(pos) numberSphere(3,iter+1);
  }
  else
  echo("objList has",len(objects),"elements");
}


//implement expanding room for random placement
module addObjectsExpand(objects,iter=1,count=numberOfSpheres){

  if (iter<=count){
    minVector=minValues(objects,iter=len(objects)-1,objects[0]) - [diaOfSpheres,diaOfSpheres,diaOfSpheres];
    maxVector=maxValues(objects,iter=len(objects)-1,objects[0]) + [diaOfSpheres,diaOfSpheres,diaOfSpheres];    
    
    echo(minVector,maxVector);
    
    pos=random3Axis(minVector,maxVector); //create a position inside the volume defined by values above
    echo(pos,iter);
    //pos=rands(-10,10,3); //this should be a function of already known objects
    coll=distCheck(objects=objects,pos=pos,iter=iter);
    //echo("Iteration",pos,iter);
    //collCheckTest(objects,pos,iter); //list of objects created, act. Pos, iteration step= count)
    
    objects=concat(objects,[pos]);
    addObjects(objects,iter+1,count);
    
    if (coll) {
      //echo("skipped",iter+1);
      //color("red") translate(pos) numberSphere(3,iter+1);
    }
    else translate(pos) numberSphere(3,iter+1);
  }
  else
  echo("objList has",len(objects),"elements");
}

function collCheck(objects,pos,iter,minDist=3,result=false)= (iter>=0) && !result ? //if iteration and no result so far
  collCheck(//recursion!
            objects, //list of objects [constant]
            pos,  //position to test [constant]
            iter-1, //next object if no result [decreasing to 0]
            minDist,  //minimum allowed distance [constant]
            //result - calculate distance for current pos<->object and compare to maxDist
            ((norm(pos-objects[iter]))<minDist) && !result ? 
              true : false
            ) 
            : result; //return result if iter<=0 or result=true

function distCheck(objects,pos,iter,minDist=2,maxDist=20,result=false)= (iter>=0) && !result ? //if iteration and no result so far
  distCheck(//recursion!
            objects, //list of objects [constant]
            pos,  //position to test [constant]
            iter-1, //next object if no result [decreasing to 0]
            minDist,  //minimum allowed distance [constant]
            maxDist,
            //result - calculate distance for current pos<->object and compare to maxDist
            ( ((norm(pos-objects[iter]))<minDist) || ((norm(pos-objects[iter]))>maxDist) ) && !result ? 
              true : false
            ) 
            : result; //return result if iter<=0 or result=true

*echo("random3",random3Axis());
function random3Axis(minVect=[-5,-5,-5],maxVect=[5,5,5]) =
  [rands(minVect[0],maxVect[0],1)[0],
   rands(minVect[1],maxVect[1],1)[0],
   rands(minVect[2],maxVect[2],1)[0]];

function maxValues(objList=[[7,5,5],[-5,-5,-5],[3,2,1],[6,-4,6]],iter,result=[0,-3,0])= (iter>=0) ?
  maxValues(   objList, iter-1, 
                 [objList[iter][0]>result[0] ? objList[iter][0] : result[0],
                  objList[iter][1]>result[1] ? objList[iter][1] : result[1],
                  objList[iter][2]>result[2] ? objList[iter][2] : result[2]])
                 : result;

function minValues(objList=[[7,5,5],[-5,-6,-7],[3,2,1],[6,-4,6]],iter,result=[0,0,0])= (iter>=0) ?
  minValues(   objList, iter-1, 
                 [objList[iter][0]<result[0] ? objList[iter][0] : result[0],
                  objList[iter][1]<result[1] ? objList[iter][1] : result[1],
                  objList[iter][2]<result[2] ? objList[iter][2] : result[2]])
                 : result;



*numberSphere(7,12);
module numberSphere(Dia,Number){
  xOffsetFact= Number < 10 ? 0.2 : (Number < 100 ? 0.25 : 0.3 );
  yOffsetFact= Number < 10 ? 0.2 : (Number < 100 ? 0.15 : 0.12 );
  sizeFact= Number < 10 ? 0.5 : (Number < 100 ? 0.33 : 0.25 );
  
  render(convexity=3)
  difference(){
    sphere(d=Dia);
    translate([-Dia*xOffsetFact,-Dia*yOffsetFact,Dia/2-0.9]) 
      linear_extrude(1)
        text(str(Number),sizeFact*Dia);
    rotate([180,0,0])
      translate([-Dia*xOffsetFact,-Dia*yOffsetFact,Dia/2-0.9]) 
        linear_extrude(1)
          text(str(Number),sizeFact*Dia);
  }
}


