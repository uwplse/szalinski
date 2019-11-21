/* [Ring Maker] */
// this uses a lot of hull commands, and thus takes a while to load.

//bare in mind that printers often print weird, so it might scaled in your slicer or cleaned up

//BEGIN CUSTOMIZER VARIABLES  
/*[Sizing]*/
//in MM
wrist_width = 75;
//in MM
wrist_length = 50;
// Which one would you like to see?// Which one would you like to see?
part = 0; // [0:wholeRing,1:red strands, 2:blue strand 2, 3:green strand 3]
/* [Ring Options] */
//work in progress
braceletHeight=3;
//ditto
thickness=2;//[1:0.5:10]
periods = 8;
//odd numbers look far better.
numStrands = 3;//[1:7]
//higher step takes more time but looks less blocky.
step = 5;//[.5:.5:20]
$fn=9;
/*[Extras]*/
//END CUSTOMIZER VARIABLES

/* [Hidden] */
US_Countries=["US","United States","Canada","Mexico"];
UK_Countries=["UK","United Kingdom","Ireland","Australia","New Zealand","South Africa"];
Spain_Countries=["ES","Italy","Spain","Netherlands","Switzerland"];
India_Countries=["IN","India"];
China_Countries=["CI","China","South America"];
Japan_Countries=["JP","Japan"];
ISO_Countries=["EU","France","Germany","Austria","Belgium","Scandinavia"];
//https://en.wikipedia.org/wiki/Ring_size

//USSizes, USValues, UKValues, China_All, India_All, Spain_All, 
//source : https://www.kuberbox.com/blog/international-ring-size-conversion-chart/

ring(wrist_width, wrist_length);

//The fun logic is below, Just due to thingiverse standards can't leave all that alone in a seperate file.

module sweepAlongPath(step  = 3, end = 360, current = 0, rMaj, rMin, tweak = 0)
{
  //this makes a sweep using a method of paired hull commands.
  //planning on eventually replacing the spheres with small cylinders to decrease the time it takes to render, just more math than I have time to do at the moment.
  hull(){
    rotate([0,90+0,current])
      translate([braceletHeight*(numStrands-.5*(numStrands-1)/2)*cos(periods/2*(current+tweak))*cos(periods/2*(current+tweak)),
          sqrt(pow(sin(current)*rMaj,2) + pow(cos(current)*rMin,2))+(numStrands-1)/3*(thickness+thickness*sin(periods*2*(current+tweak)))])
        scale([braceletHeight,thickness,thickness])
           sphere();
    rotate([0,90,current+step])
      translate([braceletHeight*(numStrands-.5*(numStrands-1)/2)*cos(periods/2*(current+step+tweak))*cos(periods/2*(current+step+tweak)),
          sqrt(pow(sin(current+step)*rMaj,2) + pow(cos(current+step)*rMin,2)) +(numStrands-1)/3*(thickness+thickness*sin(periods*2*(current+step+tweak)))])
        scale([braceletHeight,thickness,thickness])
          sphere();
  }
  if(current+step < end)
    sweepAlongPath(step = step, end = end, current = current + step, rMaj = rMaj, rMin =  rMin, tweak = tweak);
}

module ring(majorAxis, minorAxis){
  if(part == 0){
    color([.9,0,0])
      sweepAlongPath(rMaj = majorAxis, rMin =  minorAxis, step = step); 
    for(i = [2:numStrands]){
      color([0,.9*floor((i+1)%4/2),.9*floor((i+3)%4/2)])
        sweepAlongPath(rMaj = majorAxis, rMin =  minorAxis, step = step, tweak = 360/numStrands/periods*floor(i/2)*(1-(i%2)*2));
    }
  }
  else if(part == 1)
  {
    color([.9,0,0])
      sweepAlongPath(rMaj = majorAxis, rMin =  minorAxis, step = step); 
  }
  else if(part == 2)
  {
    for(i = [2:2:numStrands]){
      color([0,.9*floor((i+1)%4/2),.9*floor((i+3)%4/2)])
        sweepAlongPath(rMaj = majorAxis, rMin =  minorAxis, step = step, tweak = 360/numStrands/periods*floor(i/2)*(1-(i%2)*2));
    }
  }
  else if(part == 3)
  {
    for(i = [3:2:numStrands]){
      color([0,.9*floor((i+1)%4/2),.9*floor((i+3)%4/2)])
        sweepAlongPath(rMaj = majorAxis, rMin =  minorAxis, step = step, tweak = 360/numStrands/periods*floor(i/2)*(1-(i%2)*2));
    }
  }
}
