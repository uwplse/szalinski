// Created in 2017 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:2392399


include <plot_function.scad>  // https://www.thingiverse.com/thing:2391851

perimeter = 2;
chalice_height = 150;
chalice_width = 70;
stem_width_factor = 0.7;
log_scaling_ratio = 10;
ripple_intensity = 0.12;
ripple_count = 8;
ripple_spin = 1600;
ripple_log_ratio = 100;
ripple_log_offset = 5;
function basechalice(z) =
  (chalice_width * (1 - ripple_intensity) * 0.192) *
  (cos(log(z/(chalice_height/log_scaling_ratio)+1)*360) + 1
	+ stem_width_factor);
function ripple(z, ang) =
  (chalice_width * ripple_intensity * 0.192) * 
  (cos(ripple_count*ang-ripple_spin*log(z/(chalice_height/ripple_log_ratio) + 1
  + ripple_log_offset))+1);
function ripplechalice(z, ang) = basechalice(z) + ripple(z, ang);
function outerlip(z, ang) = let(
  zstart = chalice_height - perimeter,
  zdiff = z - zstart,
  rstart = ripplechalice(zstart, ang),
  rend = (basechalice(zstart) - perimeter / 2),
  rrelstart = rstart - rend,
  rratio = rrelstart / perimeter)
  z < chalice_height ?
    rend + sqrt(rrelstart*rrelstart*1.0001 - zdiff*zdiff*rratio*rratio) :
    rend;

function innerlip(z, ang) = let(
  zstart = chalice_height - perimeter,
  zdiff = z - zstart,
  rstart = basechalice(zstart) - perimeter,
  rend = (basechalice(zstart) - perimeter / 2),
  rrelstart = rend - rstart,
  rratio = rrelstart / perimeter)
  z < chalice_height ?
    rend - sqrt(rrelstart*rrelstart*1.0001 - zdiff*zdiff*rratio*rratio) :
    rend;

function AxialFunc1(z, ang) = (z < chalice_height - perimeter) ?
  ripplechalice(z, ang) :
  outerlip(z, ang);
function AxialFunc2(z, ang) = (z < chalice_height - perimeter) ?
  basechalice(z) - perimeter :
  innerlip(z, ang);


module RippleChalice() {
	difference() {
  	PlotAxialFunction(1, [0, 0.4, chalice_height], 180);
  	PlotAxialFunction(2, [perimeter, 0.4, chalice_height+1], 180);
	}
}


RippleChalice();


