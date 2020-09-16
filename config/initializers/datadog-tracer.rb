# config/initializers/datadog-tracer.rb

Datadog.configure do |c|
    c.analytics_enabled = true
    c.use :rails, service_name: 'personal-budgeter'
end