Sentry.init do |config|
  config.dsn = 'https://bed917b02374492e87123c0a7f795466@o4505560845451264.ingest.sentry.io/4505560854822912'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end