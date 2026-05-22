APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework AppKit -framework WebKit -framework CoreGraphics -framework CoreFoundation \
		-o $(BUNDLE)/Contents/MacOS/$(APP) main.c pc_event_tap.c pc_run_loop.c PCPanel.m PCClickablePanel.m PCClickableWebView.m
	cp Info.plist $(BUNDLE)/Contents/Info.plist
	cd ui && ./node_modules/.bin/esbuild app.jsx --bundle --outfile=../$(BUNDLE)/Contents/Resources/ui/out.js
	cp ui/index.html $(BUNDLE)/Contents/Resources/ui/index.html

run: build
	./$(BUNDLE)/Contents/MacOS/$(APP)

clean:
	rm -rf $(BUNDLE)