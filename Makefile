default: all

build:
	@chruby-exec ruby -- nanoc
	@mv output/htaccess.txt output/.htaccess -v

upload:
	@rsync -rapv -e "/usr/bin/ssh" --delete \
		./output/ l00s9r:/home/v/viettug.org.static/www/ \
		--exclude=Makefile \
		--exclude=".git*" \
		--delete-excluded \
		--delete

	@rsync -rapv -e "/usr/bin/ssh" --delete \
		./output/ tuxfamily:~/viettug/viettug.tuxfamily.org-web/htdocs/ \
		--exclude=Makefile \
		--exclude=".git*" \
		--delete-excluded \
		--delete

all: build upload
