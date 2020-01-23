/*
 * Copyright © 2016 by Jarek Cora <jarek@stormdust.net>
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
 */

// Marker for non-configurable values
function const(x) = x;
// Minimum angle of a fragment - circle has no more fragments than 360 divided by this number
$fa = const(1);
// The minimum size of a fragment
$fs = const(0.1);
// Workaround for CSG operations
eps = const(0.1);

// Height of the vase in milimeters
height = 180; // [150:5:200]

rotate_extrude() {
    resize([0, height, 0], auto = true) polygon([
        [47.1811,4.732280000000003],
        [46.773189,5.587778999999983],
        [46.423926,6.748019999999997],
        [46.120569,8.477358999999979],
        [45.970201,10.836371999999983],
        [46.079907000000006,13.885638999999998],
        [46.55677,17.68573599999999],
        [47.507873000000004,22.297240999999985],
        [49.040299000000005,27.780731999999986],
        [51.261133,34.19678599999999],
        [54.277458,41.605980999999986],
        [58.196358000000004,50.06889499999998],
        [63.124915,59.64610499999999],
        [69.170214,70.39818999999999],
        [76.439338,82.385725],
        [85.03937,95.66928999999999],
        [88.842613,101.79630599999999],
        [90.37474700000001,104.65333899999999],
        [91.66177300000001,107.40222999999999],
        [92.704604,110.06510899999999],
        [93.504152,112.66410599999999],
        [94.06133,115.221353],
        [94.37705,117.75897799999998],
        [94.452225,120.29911399999999],
        [94.287767,122.86389],
        [93.88459,125.47543599999999],
        [93.243605,128.155883],
        [92.365726,130.927362],
        [91.25186400000001,133.812003],
        [88.319845,140.00929299999999],
        [84.454848,146.92479699999998],
        [79.664175,154.735557],
        [67.33500000000001,173.751024],
        [51.390727000000005,198.472042],
        [42.08118,213.414741],
        [31.889760000000003,230.314959],
        [29.745893000000002,234.387812],
        [28.077158000000004,238.51042999999999],
        [26.842993000000003,242.663346],
        [26.002839,246.827094],
        [25.516134000000005,250.982206],
        [25.342319000000003,255.109218],
        [25.440832000000004,259.188663],
        [25.771114000000004,263.201073],
        [26.292603000000003,267.126984],
        [26.964739,270.94692799999996],
        [28.598712000000003,278.191051],
        [31.889760000000003,290.551179],
        [32.136006,290.92715799999996],
        [32.604536,291.19571299999996],
        [33.87626,291.410558],
        [35.040562,291.19571299999996],
        [35.374813,290.92715799999996],
        [35.43307,290.551179],
        [32.362544,278.864965],
        [30.921529000000003,272.293563],
        [30.342426000000003,268.844433],
        [29.902484000000005,265.293453],
        [29.635373000000005,261.64594999999997],
        [29.574762000000003,257.90725199999997],
        [29.754320000000003,254.08268499999997],
        [30.207716000000005,250.177576],
        [30.968621000000002,246.197252],
        [32.070701,242.147042],
        [33.547628,238.03226999999998],
        [35.43307,233.858266],
        [38.793524000000005,227.337404],
        [42.219506,221.0553],
        [49.197987000000005,209.165843],
        [56.228372,198.10684999999998],
        [63.17052,187.79527199999998],
        [76.229544,169.082182],
        [82.06613899999999,160.51457599999998],
        [87.25393500000001,152.362202],
        [89.56073900000001,148.415774],
        [91.65279100000001,144.542013],
        [93.512573,140.730535],
        [95.122568,136.970962],
        [96.46525700000001,133.25291199999998],
        [97.523123,129.566004],
        [98.278649,125.899858],
        [98.714317,122.244092],
        [98.81261,118.588326],
        [98.55601,114.92218],
        [97.926999,111.23527199999998],
        [96.90806,107.51722099999999],
        [95.481675,103.75764799999999],
        [93.630327,99.94617],
        [91.336498,96.072408],
        [88.58267000000001,92.12598],
        [83.80480700000001,85.626745],
        [79.425956,79.41298199999999],
        [75.429896,73.47949999999999],
        [71.800407,67.821108],
        [68.521269,62.43261699999999],
        [65.57626300000001,57.308835999999985],
        [62.949169000000005,52.444574999999986],
        [60.623765000000006,47.834642999999986],
        [56.813153,39.35700399999999],
        [54.014667,31.834396999999996],
        [52.098548,25.225298999999993],
        [50.935035000000006,19.488186999999996],
        [50.394369000000005,14.581537999999995],
        [50.346790000000006,10.463827999999978],
        [50.662539,7.093533999999977],
        [51.211855,4.429132999999979],
        [51.864979000000005,2.429102999999998],
        [52.49215100000001,1.051918999999998],
        [53.14960000000001,0],
        [0,0],
        [0,4.732280000000003]
    ]);
}