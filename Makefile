tgt=target/release
diff=git --no-pager diff --no-index --word-diff=color --ignore-space-at-eol

rust-src=$(shell find src/ -type f)

scads=$(shell find inputs -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/%.csg)
csexps=$(scads:inputs/%.scad=out/%.csexp)
jsons=$(scads:inputs/%.scad=out/%.json)

expected=$(shell find inputs -type f -name "*.expected")
checked=$(expected:inputs/%.expected=out/%.checked)

everything=$(jsons) $(checked)

.PHONY: all compile-csgs compile-csexps case-studies checked unit-tests

all: $(everything)

jsons: $(jsons)
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

out/%.checked: inputs/%.expected out/%
	$(diff) inputs/$*.expected out/$*
	touch $@

out/case-studies/report: $(filter out/case-studies/%, $(jsons))
	./scripts/report.py $^

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release
