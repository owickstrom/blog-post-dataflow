.PHONY: all
all: target/index.html target/my-diagram.png target/my-diagram-times.png target/my-diagram-seq.png target/my-diagram.json

gh-pages: all
	git checkout gh-pages
	cp target/* .

target/my-diagram.png: my-diagram.flow
	@mkdir -p target
	dataflow dfd $< | dot -Tpng -o $@

target/my-diagram-times.png: my-diagram.flow
	@mkdir -p target
	dataflow dfd $< | dot \
		-Tpng \
		-Gfontname="Times" \
		-Nfontname="Times" \
		-Efontname="Times" \
		-o $@

target/my-diagram-seq.png: my-diagram.flow
	@mkdir -p target
	dataflow seq $< | java \
		-Djava.awt.headless=true \
		-jar plantuml.jar \
		-tpng \
		-pipe > $@

target/my-diagram.json: my-diagram.flow
	@mkdir -p target
	dataflow json $< > $@

target/index.html: index.md
	@mkdir -p target
	grip --export $< $@

.PHONY: watch
watch: index.md
	grip $<
