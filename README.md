# Fluent::Plugin::Unique::Filter

Filter if same value of a specific key exists in event logs

## Requirements

`fluentd >= 0.12.2`

## Install

```ruby
gem install fluent-plugin-unique-filter
```

(In some cases use `fluent-gem` or `td-agent-gem` instead of gem command)

## Config


```
<filter exmaple>
  @type unique
  key   user_id
</filter>
```

Example: expire interval configuable

```
<filter exmaple>
  @type unique
  key   user_id
  expire_interval 10m
</filter>
```

Example: reset uniquness check in every hour

```
<filter exmaple>
  @type unique
  key   user_id
  expire_interval 1h
  expire_starts_on_day
</filter>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/holysugar/fluent-plugin-unique-filter .


