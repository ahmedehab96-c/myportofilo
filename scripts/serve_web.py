#!/usr/bin/env python3
"""Local static server for Flutter web (correct MIME for canvaskit .wasm)."""
import http.server
import socketserver
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080


class FlutterWebHandler(http.server.SimpleHTTPRequestHandler):
    extensions_map = {
        **http.server.SimpleHTTPRequestHandler.extensions_map,
        ".wasm": "application/wasm",
        ".mjs": "text/javascript",
        ".js": "application/javascript",
    }


class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True


with ReusableTCPServer(("127.0.0.1", PORT), FlutterWebHandler) as httpd:
    print(f"==> http://127.0.0.1:{PORT}", flush=True)
    httpd.serve_forever()
