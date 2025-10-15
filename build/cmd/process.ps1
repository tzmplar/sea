darklua process source/client/run.lua build/out/client.lua -c build/configuration.json
darklua process source/server/run.lua build/out/server.lua -c build/configuration.json

lune build build/out/server.lua -o build/server.exe