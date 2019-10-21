CPP_FLAGS ?= -lCGAL -lgmp -lmpfr

tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

scads=$(shell find inputs -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/%.csg)
csexps=$(scads:inputs/%.scad=out/%.csexp)
jsons=$(scads:inputs/%.scad=out/%.json)
diffs=$(scads:inputs/%.scad=out/%.diff)

expected=$(shell find inputs -type f -name "*.expected")
checked=$(expected:inputs/%.expected=out/%.checked)

everything=$(diffs) $(checked)

.PHONY: all compile-csgs compile-csexps case-studies checked unit-tests

all: $(everything)

jsons: $(jsons)
diffs: $(diffs)
compile-csgs: $(csgs)
compile-csexps: $(csexps)
checked: $(checked)

case-studies: $(filter out/case-studies/%, $(everything))
unit-tests: $(filter out/unit-tests/%, $(everything))

print-%:
	@echo '$*=$($*)'

out/%.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/%.csexp: out/%.csg $(tgt)/parse-csg
	$(tgt)/parse-csg $< $@

out/%.json out/%.csexp.opt: out/%.csexp $(tgt)/optimize
	$(tgt)/optimize $< out/$*.json
	jq -r .final_expr out/$*.json > out/$*.csexp.opt

out/%.opt.scad: out/%.json
	jq -r .final_scad $< > $@

.PRECIOUS: out/%.in.off
out/%.in.off: inputs/%.scad
	openscad -o $@ $< 2>> out/openscad.log

out/%.opt.off: out/%.opt.scad
	openscad -o $@ $< 2>> out/openscad.log

out/%.diff: out/compare_mesh out/%.in.off out/%.opt.off
	out/compare_mesh out/$*.in.off out/$*.opt.off -v > $@ # -v for volume difference
	python3 -c 'assert float(input()) == 0.0' < $@

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

out/case-studies/report: $(filter out/case-studies/%, $(jsons))
	./scripts/report.py $^

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release

out/compare_mesh: scripts/compare_mesh.cpp
	g++ $(CPP_FLAGS) $< -O2 -o $@
