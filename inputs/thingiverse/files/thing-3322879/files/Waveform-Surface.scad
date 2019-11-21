/*
    Waveform Surface
    https://www.thingiverse.com/apps/customizer/run?thing_id=3322879
*/

height = 10; // [1:30]
smooth = 20; // [4:200]
thickness = 2; // [0.2:0.1:4]

x_waveform = 5; // [0:None,1:Triangle,2:Sawtooth,3:Square,4:Circle,5:Sine,6:Fourier]
x_cycles = 2; // [1:8]
x_length = 30; // [1:60]

y_waveform = 5; // [0:None,1:Triangle,2:Sawtooth,3:Square,4:Circle,5:Sine,6:Fourier]
y_cycles = 2; // [1:8]
y_length = 30; // [1:60]


/* [x Fourier parameters] */
x_phase_shift_1=0; // [-90:90]
x_amplitude_1=1.0; // [-30:0.1:30]
x_frequency_multiplier_1=1; // [1:20]
x_frequency_divisor_1=1; // [1:20]

x_phase_shift_2=0; // [-90:90]
x_amplitude_2=-0.5; // [-30:0.1:30]
x_frequency_multiplier_2=3; // [1:20]
x_frequency_divisor_2=1; // [1:20]

x_phase_shift_3=0; // [-90:90]
x_amplitude_3=0.8; // [-30:0.1:30]
x_frequency_multiplier_3=1; // [1:20]
x_frequency_divisor_3=2; // [1:20]

x_phase_shift_4=0; // [-90:90]
x_amplitude_4=0; // [-30:0.1:30]
x_frequency_multiplier_4=1; // [1:20]
x_frequency_divisor_4=1; // [1:20]

/* [y Fourier parameters] */
y_phase_shift_1=0; // [-90:90]
y_amplitude_1=1.0; // [-30:0.1:30]
y_frequency_multiplier_1=1; // [1:20]
y_frequency_divisor_1=1; // [1:20]

y_phase_shift_2=0; // [-90:90]
y_amplitude_2=-0.5; // [-30:0.1:30]
y_frequency_multiplier_2=3; // [1:20]
y_frequency_divisor_2=1; // [1:20]

y_phase_shift_3=0; // [-90:90]
y_amplitude_3=2.0; // [-30:0.1:30]
y_frequency_multiplier_3=1; // [1:20]
y_frequency_divisor_3=2; // [1:20]

y_phase_shift_4=0; // [-90:90]
y_amplitude_4=0; // [-30:0.1:30]
y_frequency_multiplier_4=1; // [1:20]
y_frequency_divisor_4=1; // [1:20]

/* [Hidden] */

function calc_none(value) =
  1
;

function calc_triangle(value) =
  value < 0.25 ? 4*value :
  value < 0.75 ? 1-4*(value-0.25) :
  -1+4*(value-0.75)
;

function calc_sawtooth(value) =
  value < 0.5 ? 2*value : -2+2*value
;

function calc_square(value) =
  value < 0.5 ? +1 : -1
;

function calc_sine(value) =
  sin(value*360)
;

function calc_fourier_x(value) =
  x_amplitude_1*sin((value*360+x_phase_shift_1)*x_frequency_multiplier_1/x_frequency_divisor_1) +
  x_amplitude_2*sin((value*360+x_phase_shift_2)*x_frequency_multiplier_2/x_frequency_divisor_2) +
  x_amplitude_3*sin((value*360+x_phase_shift_3)*x_frequency_multiplier_3/x_frequency_divisor_3) +
  x_amplitude_4*sin((value*360+x_phase_shift_4)*x_frequency_multiplier_4/x_frequency_divisor_4)
;

function calc_fourier_y(value) =
  y_amplitude_1*sin((value*360+y_phase_shift_1)*y_frequency_multiplier_1/y_frequency_divisor_1) +
  y_amplitude_2*sin((value*360+y_phase_shift_2)*y_frequency_multiplier_2/y_frequency_divisor_2) +
  y_amplitude_3*sin((value*360+y_phase_shift_3)*y_frequency_multiplier_3/y_frequency_divisor_3) +
  y_amplitude_4*sin((value*360+y_phase_shift_4)*y_frequency_multiplier_4/y_frequency_divisor_4)
;

function calc_circle(value) =
  let (
    sgn = value < 0.5 ? +1 : -1,
    dist = value < 0.5 ?
      -1 + 4*value :
      -1 + 4*(value-0.5)
  )
  sgn*sqrt(1-dist*dist)
;

function calc_random(value) =
  0
;

function calc_waveform(waveform,value,is_x) =
  (waveform==0) ? calc_none(value) :
  (waveform==1) ? calc_triangle(value) :
  (waveform==2) ? calc_sawtooth(value) :
  (waveform==3) ? calc_square(value) :
  (waveform==4) ? calc_circle(value) :
  (waveform==5) ? calc_sine(value) :
  is_x          ? calc_fourier_x(value) :
                  calc_fourier_y(value)
;

function calc_z(x_value,y_value) =
   calc_waveform(x_waveform,x_value,true)*calc_waveform(y_waveform,y_value,false)
;

function calc_normal(x_value,y_value) =
   [0,0,1]
;

center_points =
[
  for (x_loop=[0:x_cycles])
    for (x_cycle=[0:smooth-1])
      if (x_loop<x_cycles || (x_loop==x_cycles && x_cycle == 0))
        let (x=(x_loop+x_cycle/smooth)*x_length)
        for (y_loop=[0:y_cycles])
          for (y_cycle=[0:smooth-1])
            if (y_loop<y_cycles || y_cycle == 0)
              let (y=(y_loop+y_cycle/smooth)*y_length,
                   z=height*calc_z(x_cycle/smooth,y_cycle/smooth))
              [x,y,z]
];

normals =
[
  for (x_loop=[0:x_cycles])
    for (x_cycle=[0:smooth-1])
      if (x_loop<x_cycles || (x_loop==x_cycles && x_cycle == 0))
        let (x=(x_loop+x_cycle/smooth)*x_length)
        for (y_loop=[0:y_cycles])
          for (y_cycle=[0:smooth-1])
            if (y_loop<y_cycles || y_cycle == 0)
              let (y=(y_loop+y_cycle/smooth)*y_length)
              calc_normal(x_cycle/smooth,y_cycle/smooth)
];

top_points =
[
   for (point_loop=[0:len(center_points)-1])
      center_points[point_loop] + normals[point_loop]*thickness/2
]
;

bottom_points =
[
   for (point_loop=[0:len(center_points)-1])
      center_points[point_loop] - normals[point_loop]*thickness/2
]
;

points=concat(top_points,bottom_points);

points_half=len(center_points);
y_end = points_half-(y_cycles*smooth+1);
x_inc = y_cycles*smooth+1;
faces = concat(
// top 1
    [
    for (x_index = [0:x_cycles*smooth-1])
        for (y_index = [0:y_cycles*smooth-1])
            let(
               index1=x_index*(y_cycles*smooth+1)+y_index,
               index2=x_index*(y_cycles*smooth+1)+y_index+1,
               index3=(x_index+1)*(y_cycles*smooth+1)+y_index,
               index4=(x_index+1)*(y_cycles*smooth+1)+y_index+1
            )
            [index1,index2,index3]
    ]
    ,
// top 2
    [
    for (x_index = [0:x_cycles*smooth-1])
        for (y_index = [0:y_cycles*smooth-1])
            let(
               index1=x_index*(y_cycles*smooth+1)+y_index,
               index2=x_index*(y_cycles*smooth+1)+y_index+1,
               index3=(x_index+1)*(y_cycles*smooth+1)+y_index,
               index4=(x_index+1)*(y_cycles*smooth+1)+y_index+1
            )
            [index2,index4,index3]
    ]
    ,
// bottom 1
    [
    for (x_index = [0:x_cycles*smooth-1])
        for (y_index = [0:y_cycles*smooth-1])
            let(
               index1=points_half+x_index*(y_cycles*smooth+1)+y_index,
               index2=points_half+x_index*(y_cycles*smooth+1)+y_index+1,
               index3=points_half+(x_index+1)*(y_cycles*smooth+1)+y_index,
               index4=points_half+(x_index+1)*(y_cycles*smooth+1)+y_index+1
            )
            [index1,index3,index2]
    ]
    ,
// bottom 2
    [
    for (x_index = [0:x_cycles*smooth-1])
        for (y_index = [0:y_cycles*smooth-1])
            let(
               index1=points_half+x_index*(y_cycles*smooth+1)+y_index,
               index2=points_half+x_index*(y_cycles*smooth+1)+y_index+1,
               index3=points_half+(x_index+1)*(y_cycles*smooth+1)+y_index,
               index4=points_half+(x_index+1)*(y_cycles*smooth+1)+y_index+1
            )
            [index2,index3,index4]
    ]
    ,
//    y low 1
    [
        for (y_index = [0:y_cycles*smooth-1])
        [y_index,y_index+points_half,y_index+1]
    ]
    ,
// y low 2
    [
        for (y_index = [0:y_cycles*smooth-1])
        [y_index+1,y_index+points_half,y_index+points_half+1]
    ]
    ,
// y high 1
    [
        for (y_index = [0:y_cycles*smooth-1])
        [y_end+y_index,y_end+y_index+1,y_end+y_index+points_half]
    ]
    ,
// y high 2
    [
        for (y_index = [0:y_cycles*smooth-1])
        [y_end+y_index+1,y_end+y_index+points_half+1,y_end+y_index+points_half]
    ]
    ,
// x low 1
    [
        for (x_index = [0:x_cycles*smooth-1])
        [x_index*x_inc,(x_index+1)*x_inc,x_index*x_inc+points_half]
    ]
    ,
// x low 2
    [
        for (x_index = [0:x_cycles*smooth-1])
        [(x_index+1)*x_inc,(x_index+1)*x_inc+points_half,x_index*x_inc+points_half]
    ]
    ,
// x high 1
    [
        for (x_index = [0:x_cycles*smooth-1])
        [(x_inc-1) + x_index*x_inc,(x_inc-1) + (x_index+1)*x_inc,(x_inc-1) + x_index*x_inc+points_half]
    ]
    ,
// x high 2
    [
        for (x_index = [0:x_cycles*smooth-1])
        [(x_inc-1) + (x_index+1)*x_inc,(x_inc-1) + (x_index+1)*x_inc+points_half,(x_inc-1) + x_index*x_inc+points_half]
    ]
);
//echo(points=points,faces=faces);
polyhedron (points=points,faces=faces);
//translate(points[(y_cycles*smooth)])
//sphere(r=0.2);
