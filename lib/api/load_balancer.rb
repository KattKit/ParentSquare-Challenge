require_relative "sms_provider_client"
require "securerandom"
module Api
  class LoadBalancer
    ScoreFirstException = StandardError.class.new do
      def message
        ":score_past_calls must be called before get_client"
      end
    end
    def self.init(**config)
      @@instance = LoadBalancer.new(**config)
    end
    def self.method_missing(method_name, *args, **kwargs)
      raise if method_name == :get_client
      if @@instance.respond_to?(method_name)
        @@instance.send(method_name, *args, **kwargs)
      end
    end

 

    def initialize(servers:, callback_url:)
      @callback_url = callback_url
      @servers = {}
      servers.each do |server|
        name = server[:name]
        name ||= :default
        @servers[name] = {
          instance: SmsProviderClient.new(callback_url:, base_url: server[:url], name:),
          config_score: server[:score],
          final_score: server[:score]
        }
      end
    end

    def get_client
      ordered_scores, ordered_instances = @servers
        .values
        .map do |values|
          values => {final_score:, instance:}
          [final_score, instance]
        end
        .transpose

      normalized_ordered_scores = ordered_scores.map do |s| 
        s / ordered_scores.sum.to_f
      end

      _pick_client(normalized_ordered_scores, ordered_instances)
    end

    def score_past_calls(times) #TODO: implement scoring
      return self 
    end

    private 

    def _pick_client(normalized_ordered_scores, ordered_instances)
      weighted_instances = ordered_instances.zip(normalized_ordered_scores).to_h
      weighted_instances.max_by do |_, weight|
        SecureRandom.rand ** (1.0 / weight)
      end.first 
    end
  end
end