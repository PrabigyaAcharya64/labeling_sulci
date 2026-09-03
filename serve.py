#!/usr/bin/env python3
"""Dev server for the deck. Serves from the project root with caching disabled,
so slide edits show on a normal refresh (plain `http.server` caches the .md
fetches and serves stale slides).

Run from the project root:
    python3 serve.py
Then open: http://localhost:8000/knowledge/
"""
import http.server

PORT = 8000


class NoCacheHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store, must-revalidate")
        self.send_header("Expires", "0")
        super().end_headers()


class Server(http.server.ThreadingHTTPServer):
    # The deck serves a 55 MB .glb. On a single-threaded server one stalled
    # download blocks every later request, so the deck appears dead while the
    # port is still held. Threading keeps the rest of the deck reachable.
    daemon_threads = True
    allow_reuse_address = True


if __name__ == "__main__":
    with Server(("", PORT), NoCacheHandler) as httpd:
        print(f"Serving on http://localhost:{PORT}/knowledge/  (no-cache)")
        httpd.serve_forever()
