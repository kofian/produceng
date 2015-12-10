module CatarseBraintree
  class Engine < ::Rails::Engine
    isolate_namespace CatarseBraintree

    config.before_initialize do
      config.active_record.observers << 'CatarseBraintree::ProjectObserver'
      config.active_record.observers << 'CatarseBraintree::BackerObserver'
    end
  end
end
