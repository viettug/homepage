default: all

build:
	@chruby-exec ruby -- nanoc prune --yes
	@chruby-exec ruby -- nanoc
	@mv output/htaccess.txt output/.htaccess -v
	@cp README output/README -v

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

github: build
	@cd output && \
	git add `git status -su|grep '^?? '| awk '{print $$NF}'` 2>/dev/null; \
	git ci -am'Page update (by nanoc)'; \
	git_push_to_all_remotes

all: build upload github
