.PHONY: render clean publish

render: clean
	transom input output

clean:
	rm -rf output

publish: temp_dir := $(shell mktemp -d)
publish:
	chmod 755 ${temp_dir}
	transom input ${temp_dir} --site-url "http://people.apache.org/~jross"
	rsync -av ${temp_dir}/ jross@people.apache.org:public_html
	rm -rf ${temp_dir}
