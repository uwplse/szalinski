CC_WITH_FLAGS ?= g++ -lgmp -lmpfr -lCGAL

tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

# use the second variation to limit things for testing
scads=$(shell find inputs -type f -name "*.scad")
# scads=$(wordlist 1,100, $(shell find inputs -type f -name "*.scad"))

csgs=$(scads:inputs/%.scad=out/%.fn.csg)

csexps=$(scads:inputs/%.scad=out/%.normal.csexp)
csexp-opts=$(scads:inputs/%.scad=out/%.normal.csexp.opt)
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

all: $(jsons)

jsons: $(jsons)
diffs: $(diffs)
csgs: $(csgs)
csexps: $(csexps)
checked: $(checked)
in_offs: $(scads:inputs/%.scad=out/%.in.off)

aec-table2-nocad: $(filter out/aec-table2/%, $(jsons-normal-nocad))
aec-table2-noinv: $(filter out/aec-table2/%, $(jsons-normal-noinv))
aec-table2: $(filter out/aec-table2/%, $(jsons))

export OPENSCADPATH=.

# don't delete anything in the out directory please, Make
.SECONDARY:

## program compilation and utility stuff

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release

out/compare_mesh: scripts/compare_mesh.cpp
	mkdir -p out/
	g++ $< -O2 -lgmp -lmpfr -lCGAL -o $@

print-%:
	@echo '$*=$($*)'


## first we compile .scads to .csgs, running them through reduce-fn.py
## then we parse them to csexps (cad s-expressions) for use in the tool

out/%.raw.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $(notdir $*).raw.csg $<
	mv inputs/$*.raw.csg out/$(dir $*)

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

.PRECIOUS:
out/aec-table2/table2.csv: ./scripts/table2.py aec-table2-nocad aec-table2-noinv aec-table2
	python3 $< $@
