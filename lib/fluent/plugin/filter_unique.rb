
class Fluent::UniqueFilter < Fluent::Filter

  Fluent::Plugin.register_filter('unique', self)

  config_param :key, :string

  # 0 means to never expire
  config_param :expire_interval, :time, default: 0

  # set interval start time to beginning of day
  config_param :expire_starts_on_day, :bool, default: false

  def configure(conf)
    super

    @uniqueness = Set.new
    init_expire_time(Time.now.to_i)
  end

  def filter(tag, time, record)
    clear_cache_if_expired(time)
    key = record[@key]

    if @uniqueness.member?(key)
      # delete message
      log.debug "Delete message of #{@key}: #{key}"
      nil
    else
      @uniqueness << key
      record
    end
  end

  private
  def beginning_of_day(time = Time.now.to_i)
    now = Time.at(time)
    Time.new(now.year, now.month, now.day).to_i
  end

  def init_expire_time(time)
    if @expire_interval == 0
      @expire_time = 0

    elsif @expire_starts_on_day
      start = time - (time - beginning_of_day(time)) % @expire_interval
      @expire_time = start + @expire_interval

    else
      @expire_time = time + @expire_interval
    end

    log.debug "Set expires #{Time.at @expire_time}"
  end

  def update_expire_time(time)
    unless @expire_time
      init_expire_time(time)
      return
    end

    @expire_time += @expire_interval until @expire_time > time
    log.debug "Set expires #{Time.at @expire_time}"
    #@expire_time = @expire_time + ((time - @expire_time) / @expire_interval + 1) * @expire_interval
  end

  def clear_cache_if_expired(time)
    if 0 < @expire_time && @expire_time <= time
      log.debug "Expire unique table"
      @uniqueness.clear
      update_expire_time(time)
    end
  end
end

