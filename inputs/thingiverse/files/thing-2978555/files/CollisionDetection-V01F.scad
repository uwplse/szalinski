

/* [Spheres] */
numberOfSpheres=15;
diaOfSpheres=3;

numberSphere(diaOfSpheres,0);
addObjects(objList);

/* [Hidden] */
$fn=20;

objList=[[0,0,0]]; //init with first Object at zero

module addObjects(objects,iter=1,count=15){
  
  if (iter<=count){
    pos=rands(-10,10,3);
    coll=collCheck(objects,pos,iter);
    //echo("Iteration",pos,iter);
    //collCheckTest(objects,pos,iter); //list of objects created, act. Pos, iteration step= count)
    
    objects=concat(objects,[pos]);
    addObjects(objects,iter+1,count);
    
    if (coll) {
      echo(coll,pos);
      color("red") translate(pos) numberSphere(3,iter+1);
    }
    else translate(pos) numberSphere(3,iter+1);
  }
  else
  echo("objList has",len(objects),"elements");
}


function collCheck(objects,pos,iter,maxDist=3,result=false)= (iter>=0) && !result ?
  collCheck(//recursion!
            objects, //list of objects [constant]
            pos,  //position to test [constant]
            iter-1, //next object if no result [decreasing to 0]
            maxDist,  //maximum allowed distance [constant]
            //result - calculate distance for current pos<->object and compare to maxDist
            ((norm(pos-objects[iter]))<maxDist) && !result ? 
              true : false
            ) 
            : result; //return result if iter<=0


module collCheckTest(objects,pos,iter,distance=3,result=0){
  if (iter && (result==0)){
    collCheckTest(objects,pos,iter-1,distance,(norm(pos-objects[iter]))<distance ? iter : 0);
    //echo("CollCheck",result,iter,pos,norm(pos-objects[iter]));
  }
  else echo("stopped checking at",iter,result);
}


module numberSphere(Dia,Number){
  xOffsetFact= Number < 10 ? 0.2 : 0.4 ;
  render(convexity=3)
  difference(){
    sphere(d=Dia);
    translate([-Dia*xOffsetFact,-Dia/4,Dia/2-0.7]) 
      linear_extrude(1)
        text(str(Number),Dia/2);
    rotate([180,0,0])
      translate([-Dia*xOffsetFact,-Dia/4,Dia/2-0.7]) 
        linear_extrude(1)
          text(str(Number),Dia/2);
  }
}