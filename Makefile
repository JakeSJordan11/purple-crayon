APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework AppKit -framework WebKit -framework CoreGraphics -framework CoreFoundation \
		-o $(BUNDLE)/Contents/MacOS/$(APP) spring/event_tap_callback.c spring/main.c spring/register_event_tap.c spring/request_mach_port_rights.c spring/run_loop.c Bud/ClickablePanel.m Bud/ClickableWebView.m Bud/Panel.m
	cp Info.plist $(BUNDLE)/Contents/Info.plist
	cd Bloom && ./node_modules/.bin/esbuild app.jsx --bundle --outfile=../$(BUNDLE)/Contents/Resources/Bloom/out.js
	cp Bloom/index.html $(BUNDLE)/Contents/Resources/Bloom/index.html

run: build
	./$(BUNDLE)/Contents/MacOS/$(APP)

clean:
	rm -rf $(BUNDLE)