use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :kastlex, Kastlex.Endpoint,
  http: [port: 4000],
  debug_errors: false,
  code_reloader: true,
  reloadable_paths: ["web"],
  reloadable_compilers: [:gettext, :phoenix, :elixir],
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
config :kastlex, Kastlex.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$}
    ]
  ]

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

config :brod, :clients,
  kastlex: [
    endpoints: ["localhost": 9092],
    auto_start_producers: true
  ]

config :kastlex, Kastlex.MetadataCache,
  refresh_timeout_ms: 5000,
  zk_cluster: ["localhost": 2181],
  zk_chroot: "/",
  zk_session_timeout: 30000
