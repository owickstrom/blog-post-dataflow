index.html: post.md header.html footer.html
	cat header.html > $@
	markdown $< >> $@
	cat footer.html >> $@

.PHONY: watch
watch:
	nodemon -w . -e md,css,html -x 'make'
