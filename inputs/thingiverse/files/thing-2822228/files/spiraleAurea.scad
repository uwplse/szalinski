
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;
height = 5;
line_fn = 4;
min_line_width = 1.0;
function min_line_mm(w) = max(min_line_width, w) * 90/25.4;


path4286_0_center = [4.460870,-216.646445];
path4286_0_points = [[-5.545955,-212.905725],[14.467695,-220.387165]];
module poly_path4286(h, w, s, res=line_fn)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    for (t = [0: len(path4286_0_points)-2]) {
      hull() {
        translate(path4286_0_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4286_0_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
  }
}

path4209_0_center = [51.659111,75.034640];
path4209_0_points = [[50.337655,68.514815],[49.321681,70.339201],[48.798986,72.267105],[48.743727,74.218991],[49.130061,76.115326],[49.932148,77.876575],[51.124144,79.423205],[52.680207,80.675679],[54.574495,81.554465]];
path4209_1_center = [61.407165,65.688942];
path4209_1_points = [[72.499345,68.514815],[70.198753,66.042177],[67.493201,64.276006],[64.517676,63.216304],[61.407165,62.863070],[58.296654,63.216304],[55.321130,64.276006],[52.615578,66.042177],[50.314985,68.514815]];
path4209_2_center = [69.038162,85.566485];
path4209_2_points = [[61.418495,102.618155],[63.999869,101.602263],[66.368730,100.316580],[68.516652,98.787047],[70.435205,97.039601],[73.550496,92.994727],[75.647179,88.389470],[76.657830,83.431340],[76.515024,78.327847],[75.990004,75.786436],[75.151337,73.286502],[73.990593,70.853982],[72.499345,68.514815]];
path4209_3_center = [37.948885,86.434366];
path4209_3_points = [[14.479275,68.514815],[14.751886,72.995087],[15.545917,77.283231],[16.825666,81.353309],[18.555431,85.179382],[20.699512,88.735512],[23.222206,91.995758],[26.087811,94.934184],[29.260626,97.524849],[32.704950,99.741815],[36.385079,101.559144],[40.265314,102.950896],[44.309951,103.891133],[48.483290,104.353917],[52.749628,104.313307],[57.073263,103.743366],[61.418495,102.618155]];
path4209_4_center = [52.453905,39.520367];
path4209_4_points = [[90.428535,13.334445],[83.397800,11.513813],[76.402008,10.591627],[69.498927,10.525919],[62.746322,11.274718],[56.201960,12.796054],[49.923608,15.047957],[43.969032,17.988458],[38.395999,21.575586],[33.262276,25.767372],[28.625629,30.521846],[24.543824,35.797037],[21.074629,41.550976],[18.275810,47.741694],[16.205134,54.327219],[14.920367,61.265583],[14.479275,68.514815]];
path4209_5_center = [122.869037,85.566480];
path4209_5_points = [[137.367755,157.798515],[140.703507,152.900378],[143.684786,147.889643],[146.316056,142.780046],[148.601779,137.585321],[150.546417,132.319203],[152.154434,126.995426],[153.430291,121.627726],[154.378453,116.229838],[155.003381,110.815495],[155.309538,105.398434],[155.301388,99.992388],[154.983392,94.611093],[154.360013,89.268284],[153.435715,83.977695],[152.214959,78.753060],[150.702209,73.608116],[148.901927,68.556597],[146.818576,63.612237],[144.456619,58.788771],[141.820518,54.099935],[138.914737,49.559462],[135.743737,45.181088],[132.311981,40.978548],[128.623933,36.965577],[124.684055,33.155908],[120.496810,29.563278],[116.066660,26.201421],[111.398068,23.084071],[106.495497,20.224964],[101.363409,17.637834],[96.006268,15.336416],[90.428535,13.334445]];
path4209_6_center = [14.479280,189.105915];
path4209_6_points = [[-108.409195,157.798515],[-102.853428,164.984279],[-96.917521,171.783074],[-90.622225,178.184324],[-83.988291,184.177459],[-77.036471,189.751903],[-69.787515,194.897085],[-62.262175,199.602430],[-54.481201,203.857365],[-46.465344,207.651318],[-38.235356,210.973714],[-29.811987,213.813982],[-21.215989,216.161546],[-12.468113,218.005835],[-3.589110,219.336275],[5.400270,220.142293],[14.479275,220.413315],[23.558282,220.142293],[32.547663,219.336275],[41.426668,218.005835],[50.174546,216.161546],[58.770545,213.813982],[67.193914,210.973714],[75.423903,207.651318],[83.439760,203.857365],[91.220735,199.602430],[98.746076,194.897085],[105.995032,189.751903],[112.946852,184.177459],[119.580786,178.184324],[125.876081,171.783074],[131.811988,164.984279],[137.367755,157.798515]];
path4209_7_center = [-80.425927,-27.547400];
path4209_7_points = [[-5.542315,-212.893315],[-17.631027,-207.409985],[-29.343253,-201.314791],[-40.660308,-194.627158],[-51.563505,-187.366512],[-62.034158,-179.552279],[-72.053582,-171.203885],[-81.603089,-162.340757],[-90.663995,-152.982319],[-99.217612,-143.147998],[-107.245255,-132.857220],[-114.728238,-122.129411],[-121.647874,-110.983996],[-127.985478,-99.440402],[-133.722363,-87.518055],[-138.839843,-75.236381],[-143.319233,-62.614805],[-147.441675,-48.508139],[-150.696032,-34.271896],[-153.088199,-19.943293],[-154.624069,-5.559550],[-155.309538,8.842114],[-155.150502,23.224479],[-154.152854,37.550327],[-152.322491,51.782439],[-149.665306,65.883594],[-146.187195,79.816575],[-141.894053,93.544162],[-136.791774,107.029135],[-130.886254,120.234277],[-124.183388,133.122366],[-116.689069,145.656186],[-108.409195,157.798515]];
module poly_path4209(h, w, s, res=line_fn)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    for (t = [0: len(path4209_0_points)-2]) {
      hull() {
        translate(path4209_0_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_0_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_1_points)-2]) {
      hull() {
        translate(path4209_1_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_1_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_2_points)-2]) {
      hull() {
        translate(path4209_2_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_2_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_3_points)-2]) {
      hull() {
        translate(path4209_3_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_3_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_4_points)-2]) {
      hull() {
        translate(path4209_4_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_4_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_5_points)-2]) {
      hull() {
        translate(path4209_5_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_5_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_6_points)-2]) {
      hull() {
        translate(path4209_6_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_6_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4209_7_points)-2]) {
      hull() {
        translate(path4209_7_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4209_7_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
  }
}

path4217_0_center = [5.599775,-159.305400];
path4217_0_points = [[-3.279725,-165.756735],[14.479275,-152.854065]];
path4217_1_center = [23.358780,-159.305400];
path4217_1_points = [[32.238285,-165.756735],[14.479275,-152.854065]];
path4217_2_center = [14.479280,-186.633695];
path4217_2_points = [[3.503615,-186.633695],[25.454945,-186.633695]];
path4217_3_center = [14.479280,157.798515];
path4217_3_points = [[-108.409195,157.798515],[137.367755,157.798515]];
path4217_4_center = [55.876735,77.519895];
path4217_4_points = [[54.570155,81.541125],[57.183315,73.498665]];
path4217_5_center = [55.872410,72.544285];
path4217_5_points = [[50.337655,68.514815],[61.407165,76.573755]];
path4217_6_center = [63.534750,75.027970];
path4217_6_points = [[72.499345,68.514815],[54.570155,81.541125]];
path4217_7_center = [55.878075,85.566485];
path4217_7_points = [[61.418495,102.618155],[50.337655,68.514815]];
path4217_8_center = [43.489310,68.514815];
path4217_8_points = [[14.479275,68.514815],[72.499345,68.514815]];
path4217_9_center = [75.923515,57.976300];
path4217_9_points = [[90.428535,13.334445],[61.418495,102.618155]];
path4217_10_center = [75.923515,113.156665];
path4217_10_points = [[14.479275,68.514815],[137.367755,157.798515]];
path4217_11_center = [-8.990330,85.566480];
path4217_11_points = [[-108.409195,157.798515],[90.428535,13.334445]];
path4217_12_center = [75.923515,-31.307400];
path4217_12_points = [[137.367755,157.798515],[14.479275,-220.413315]];
path4217_13_center = [-46.964960,-31.307400];
path4217_13_points = [[14.479275,-220.413315],[-108.409195,157.798515]];
module poly_path4217(h, w, s, res=line_fn)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    for (t = [0: len(path4217_0_points)-2]) {
      hull() {
        translate(path4217_0_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_0_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_1_points)-2]) {
      hull() {
        translate(path4217_1_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_1_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_2_points)-2]) {
      hull() {
        translate(path4217_2_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_2_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_3_points)-2]) {
      hull() {
        translate(path4217_3_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_3_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_4_points)-2]) {
      hull() {
        translate(path4217_4_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_4_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_5_points)-2]) {
      hull() {
        translate(path4217_5_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_5_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_6_points)-2]) {
      hull() {
        translate(path4217_6_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_6_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_7_points)-2]) {
      hull() {
        translate(path4217_7_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_7_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_8_points)-2]) {
      hull() {
        translate(path4217_8_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_8_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_9_points)-2]) {
      hull() {
        translate(path4217_9_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_9_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_10_points)-2]) {
      hull() {
        translate(path4217_10_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_10_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_11_points)-2]) {
      hull() {
        translate(path4217_11_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_11_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_12_points)-2]) {
      hull() {
        translate(path4217_12_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_12_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
    for (t = [0: len(path4217_13_points)-2]) {
      hull() {
        translate(path4217_13_points[t]) 
          cylinder(h=h, r=w/2, $fn=res);
        translate(path4217_13_points[t + 1]) 
          cylinder(h=h, r=w/2, $fn=res);
      }
    }
  }
}

module spiraleAurea(h)
{
  difference()
  {
    union()
    {
      translate ([0,0,1.5]) poly_path4286(3, min_line_mm(0.282222222222), 100.0);
      translate ([0,0,0]) poly_path4209(6, min_line_mm(1.0), 100.0);
      translate ([0,0,1.5]) poly_path4217(3, min_line_mm(1.0), 100.0);
    }
    union()
    {
    }
  }
}

spiraleAurea(height);
