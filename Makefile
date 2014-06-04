default: all

build:
	@chruby-exec ruby -- nanoc

upload:
	@rsync -rapv --delete \
		./output/ l00s9r:/home/v/viettug.org.static/www/ \
		--exclude=Makefile \
		--exclude=".git*" \
		--delete-excluded

all: build upload
