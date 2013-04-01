file = File.join(File.expand_path(::Rails.root),"/config/redis.yml")
REDIS_CONFIG = YAML.load(ERB.new(File.read(file)).result).symbolize_keys
$redis = Redis.new(REDIS_CONFIG) 
