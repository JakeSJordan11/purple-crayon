APP = PurpleCrayon
BUNDLE = $(APP).app

build:
	mkdir -p $(BUNDLE)/Contents/MacOS
	clang -framework AppKit -framework WebKit -framework CoreGraphics -framework CoreFoundation \
	-o $(BUNDLE)/Contents/MacOS/$(APP) main.c spring/register_event_tap.c spring/spring.c Bud/BUDPanel.m
	cp Info.plist $(BUNDLE)/Contents/Info.plist
	cd Bloom && ./node_modules/.bin/esbuild app.jsx --bundle --outfile=../$(BUNDLE)/Contents/Resources/Bloom/out.js
	cp Bloom/index.html $(BUNDLE)/Contents/Resources/Bloom/index.html

run: build
	./$(BUNDLE)/Contents/MacOS/$(APP)

clean:
	rm -rf $(BUNDLE)