Here we provide instructions on how to install Szalinski, run it,
  and change the rules and features of the Caddy language.
If you are interested to use Szalinski, please reach out to us!

## Setup instructions

Following are the steps for setting up Szalinski
from scratch on a different machine that runs Ubuntu 19.10.

* Install rust. Type `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
  in the terminal and follow the subsequent instructions. The version we used is `1.41.0`.
  See`https://www.rust-lang.org/tools/install` for more information.

* Make sure you configure your current shell by typing: `source $HOME/.cargo/env`
  (the Rust installation will prompt you to do this).

* Install make by typing: `sudo apt-get install make`

* Install g++ by typing: `sudo apt-get install g++`

* Install jq by typing: `sudo apt-get install jq`

* Install [CGAL](https://www.cgal.org/download/linux.html) by typing
  `sudo apt-get install libcgal-dev`

* Install [OpenSCAD](https://www.openscad.org/) by typing
  `sudo apt-get install openscad`

* Install git by typing `sudo apt install git`

* Install pip by typing `sudo apt install python3-pip` and then
install `numpy` by typing `pip3 install numpy` and `matplotlib` by typing
`pip3 install matplotlib`


## Running the tools
- First compile Szalinski by running `cargo build --release`
- To optimize a 3D model (a `.csexp` file) with Szalinski, run `target/release/optimize path/to/foo.csexp path/to/out/foo.json`
- You can also navigate to the `Makefile` and learn more about how to convert an SCAD file to a `.csexp` file.


## Changing Caddy and modifying the rules

* The Caddy language is defined in `cad.rs` in the `src` directory.
A simple feature you can add is support for a new primitive or new
transformations. You can also change the costs of various language
constructs. The definition of the `cost` function starts at line `267`.

* As we described in the paper, to verify the correctness of Szalinski,
we evaluate Caddy programs to flat Core Caddy and pretty print to CSG. This
code is in `eval.rs`.

* `solve.rs` and `permute.rs` contains code that solves for first and second
degree polynomials in Cartesian and Spherical coordinates, and performs
partitioning and permutations of lists.

* The rewrites rules are in `rules.rs`. Syntactic rewrites are
written using the `rw!` macro. Each rewrite has a name, a left hand side,
and a right hand side. You can add / remove rules to see how that affects
the final Caddy output of Szalinski. For example, if you comment out the
rules for inverse transformations, they will not be propagated and
eliminated, and therefore the quality of Szalinski's output will not be
as good.

## Notes and remarks

Szalinski is implemented in [Rust](https://www.rust-lang.org/).
As mentioned in `Section 6` of the paper,
it uses [OpenSCAD](https://www.openscad.org/)
to compile CSG programs to triangular meshes, and
[CGAL](https://www.cgal.org/) to compute the
Hausdorff distance between two meshes.
