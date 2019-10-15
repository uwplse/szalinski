tgt=target/release
rust-src=$(shell find src/ -type f)

scads=$(shell find inputs/ -type f -name "*.scad")
csgs=$(scads:inputs/%.scad=out/%.csg)
csexps=$(scads:inputs/%.scad=out/%.csexp)
case-studies-scads=$(shell find inputs/case-studies -type f -name "*.scad")

.PHONY: all compile-csgs compile-csexps case-studies

all: compile-csexps
compile-csgs: $(csgs)
compile-csexps: $(csexps)
case-studies: $(case-studies-scads:inputs/%.scad=out/%.json)

print-%:
	@echo '$*=$($*)'

out/%.csg: inputs/%.scad
	@mkdir -p $(dir $@)
	openscad -o $@ $<

out/%.csexp: out/%.csg $(tgt)/parse-csg
	$(tgt)/parse-csg $< $@

out/%.json: out/%.csexp $(tgt)/optimize
	$(tgt)/optimize $< $@
	jq . $@

# out/%.check: out/%.json data/expected/*.json
# 	$(tgt)/optimize < $< | sponge $@

$(tgt)/optimize $(tgt)/parse-csg: $(rust-src)
	cargo build --release
