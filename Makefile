
.PHONY: up down build ps

up:
	docker-compose up -d --build $(A)

down:
	docker-compose down $(A)

build:
	docker-compose build $(A)

ps:
	docker-compose ps $(A)

logs:
	docker-compose logs $(A)

shell:
	docker-compose exec $(A) /bin/sh


# run templ generation in watch mode to detect all .templ files and 
# re-create _templ.txt files on change, then send reload event to browser. 
# Default url: http://localhost:7331
live/templ:
	templ generate --watch --proxy="http://localhost:8080" --open-browser=false -v

# run air to detect any go file changes to re-build and re-run the server.
live/server:
	go run github.com/air-verse/air@latest \
	--build.cmd "go build -o tmp/bin/main" --build.bin "tmp/bin/main" --build.delay "100" \
	--build.exclude_dir "node_modules" \
	--build.include_ext "go" \
	--build.stop_on_error "false" \
	--misc.clean_on_exit true

# run tailwindcss to generate the styles.css bundle in watch mode.
live/tailwind:
	npx tailwindcss -i ./input.css -o ./assets/styles.css --minify --watch

# run esbuild to generate the index.js bundle in watch mode.
live/esbuild:
	npx esbuild js/index.ts --bundle --outdir=assets/ --watch

# watch for any js or css change in the assets/ folder, then reload the browser via templ proxy.
live/sync_assets:
	go run github.com/air-verse/air@latest \
	--build.cmd "templ generate --notify-proxy" \
	--build.bin "true" \
	--build.delay "100" \
	--build.exclude_dir "" \
	--build.include_dir "assets" \
	--build.include_ext "js,css"

# start all 5 watch processes in parallel.
live: 
	make -j3 live/templ live/server live/sync_assets