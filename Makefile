CC_WITH_FLAGS ?= g++ -lCGAL -lgmp -lmpfr

tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

# use the second variation to limit things for testing
scads=$(shell find inputs -type f -name "*.scad")
# scads=$(wordlist 1,100, $(shell find inputs -type f -name "*.scad"))

csgs=$(scads:inputs/%.scad=out/%.fn.csg)

csexps=$(scads:inputs/%.scad=out/%.normal.csexp)
jsons=$(scads:inputs/%.scad=out/%.normal.json)
jsons-normal-nocad=$(scads:inputs/%.scad=out/%.normal-nocad.json)
jsons-normal-noinv=$(scads:inputs/%.scad=out/%.normal-noinv.json)
jsons-perturb=$(scads:inputs/%.scad=out/%.perturb.json)
jsons-perturb-nocad=$(scads:inputs/%.scad=out/%.perturb-nocad.json)
jsons-perturb-noinv=$(scads:inputs/%.scad=out/%.perturb-noinv.json)
diffs=$(scads:inputs/%.scad=out/%.normal.diff)

expected=$(shell find inputs -type f -name "*.expected")
checked=$(expected:inputs/%.expected=out/%.checked)

everything=$(diffs)

.PHONY: all compile-csgs compile-csexps case-studies checked unit-tests

all: $(everything)

jsons: $(jsons)
diffs: $(diffs)
csgs: $(csgs)
csexps: $(csexps)
checked: $(checked)
in_offs: $(scads:inputs/%.scad=out/%.in.off)

aec-table2-nocad: $(filter out/aec-table2/%, $(jsons-normal-nocad))
aec-table2-noinv: $(filter out/aec-table2/%, $(jsons-normal-noinv))
aec-fig15: $(filter out/aec-fig15/%, $(everything))
case-studies: $(filter out/case-studies/%, $(everything))
unit-tests: $(filter out/unit-tests/%, $(everything))
inverse-csg: $(filter out/inverse-csg/%, $(everything))

export OPENSCADPATH=.

# don't delete anything in the out directory please, Make
.SECONDARY:

## program compilation and utility stuff

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release

out/compare_mesh: scripts/compare_mesh.cpp
	mkdir -p out/
	g++ $< -O2 -o $@ $(CC_FLAGS)

print-%:
	@echo '$*=$($*)'


## first we compile .scads to .csgs, running them through reduce-fn.py
## then we parse them to csexps (cad s-expressions) for use in the tool

out/%.raw.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/%.fn.csg: ./scripts/reduce-fn.py out/%.raw.csg
	$^ $@

out/%.normal.csexp: out/%.fn.csg $(tgt)/parse-csg sz_params
	SZ_PARSE_SHUFFLE_RNG=0 $(tgt)/parse-csg $< $@
out/%.perturb.csexp: out/%.fn.csg $(tgt)/parse-csg sz_params
	SZ_PARSE_SHUFFLE_RNG=1 $(tgt)/parse-csg $< $@


## The actual running of the tool

out/%.normal.json: out/%.normal.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) && $(tgt)/optimize $< $@
out/%.normal-nocad.json: out/%.normal.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) SZ_CAD_IDENTS=false && $(tgt)/optimize $< $@
out/%.normal-noinv.json: out/%.normal.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) SZ_INV_TRANS=false && $(tgt)/optimize $< $@
out/%.perturb.json: out/%.perturb.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) && $(tgt)/optimize $< $@
out/%.perturb-nocad.json: out/%.perturb.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) SZ_CAD_IDENTS=false && $(tgt)/optimize $< $@
out/%.perturb-noinv.json: out/%.perturb.csexp $(tgt)/optimize sz_params
	export $$(cat sz_params | xargs) SZ_INV_TRANS=false && $(tgt)/optimize $< $@

## Checking of diffs

out/%.csexp.opt: out/%.json
	jq -r .final_expr $< > $@

out/%.opt.scad: out/%.json
	jq -r .final_scad $< > $@

out/%.in.off: out/%.fn.csg scripts/openscad-or-timeout.sh
	./scripts/openscad-or-timeout.sh $< $@

out/%.opt.off: out/%.opt.scad out/%.csexp.opt scripts/openscad-or-timeout.sh
	./scripts/openscad-or-timeout.sh $< $@

out/%.normal.diff: scripts/compare_mesh.sh out/compare_mesh out/%.in.off out/%.normal.opt.off
	./scripts/compare_mesh.sh out/$*.in.off out/$*.normal.opt.off $@

out/%.diff.scad: scripts/create-diff-scad.sh inputs/%.scad out/%.normal.opt.scad
	$^ $@

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

## report generation

out/case-studies/report.csv: ./scripts/report.py $(filter out/case-studies/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/case-studies/%, $(jsons))
out/inverse-csg/report.csv: ./scripts/report.py $(filter out/inverse-csg/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/inverse-csg/%, $(jsons))
out/reincarnate/report.csv: ./scripts/report.py $(filter out/reincarnate/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/reincarnate/%, $(jsons))
out/reincarnate-new/report.csv: ./scripts/report.py $(filter out/reincarnate-new/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/reincarnate-new/%, $(jsons))
out/latex-drawing/report.csv: ./scripts/report.py $(filter out/latex-drawing/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/latex-drawing/%, $(jsons))
out/thingiverse/report.csv: ./scripts/report.py $(filter out/thingiverse/%, $(jsons))
	./scripts/report.py --output $@ $(filter out/thingiverse/%, $(jsons))
out/report.csv: ./scripts/report.py $(jsons)
	./scripts/report.py --output $@ $(jsons)

thingiverse-normal: $(filter out/thingiverse/%, $(jsons))
thingiverse-perturb: $(filter out/thingiverse/%, $(jsons-perturb))
thingiverse-perturb-nocad: $(filter out/thingiverse/%, $(jsons-perturb-nocad))
thingiverse-perturb-noinv: $(filter out/thingiverse/%, $(jsons-perturb-noinv))
thingiverse-all: thingiverse-normal thingiverse-perturb thingiverse-perturb-nocad thingiverse-perturb-noinv

out/fig14.pdf: ./scripts/plot-boxes.py thingiverse-all
	python3 $< $@

# out/case-studies/report.csv: ./scripts/report.py $(filter out/case-studies/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/case-studies/%, $(jsons))
# out/inverse-csg/report.csv: ./scripts/report.py $(filter out/inverse-csg/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/inverse-csg/%, $(jsons))
# out/reincarnate/report.csv: ./scripts/report.py $(filter out/reincarnate/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/reincarnate/%, $(jsons))
# out/reincarnate-new/report.csv: ./scripts/report.py $(filter out/reincarnate-new/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/reincarnate-new/%, $(jsons))
# out/latex-drawing/report.csv: ./scripts/report.py $(filter out/latex-drawing/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/latex-drawing/%, $(jsons))
# out/thingiverse/report.csv: ./scripts/report.py $(filter out/thingiverse/%, $(jsons) $(diffs))
#	./scripts/report.py --output $@ $(filter out/thingiverse/%, $(jsons))
# out/report.csv: ./scripts/report.py $(jsons) $(diffs)
#	./scripts/report.py --output $@ $(jsons)
