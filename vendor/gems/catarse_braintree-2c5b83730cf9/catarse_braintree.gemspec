# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "catarse_braintree"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Hall", "Ant\u{f4}nio Roberto Silva", "Diogo Biazus", "Josemar Davi Luedke"]
  s.date = "2014-08-18"
  s.description = "Braintree integration with Catarse crowdfunding platform"
  s.email = ["matt@codebeef.com", "forevertonny@gmail.com", "diogob@gmail.com", "josemarluedke@gmail.com"]
  s.files = ["app/assets", "app/assets/images", "app/assets/images/catarse_braintree", "app/assets/javascripts", "app/assets/javascripts/catarse_braintree", "app/assets/javascripts/catarse_braintree/braintree_form.js", "app/assets/javascripts/catarse_braintree/user_document.js", "app/assets/javascripts/catarse_braintree.js", "app/controllers", "app/controllers/catarse_braintree", "app/controllers/catarse_braintree/braintree_controller.rb", "app/observers", "app/observers/catarse_braintree", "app/observers/catarse_braintree/backer_observer.rb", "app/observers/catarse_braintree/project_observer.rb", "app/views", "app/views/catarse_braintree", "app/views/catarse_braintree/braintree", "app/views/catarse_braintree/braintree/charge.html.erb", "app/views/catarse_braintree/braintree/review.html.slim", "app/workers", "app/workers/catarse_braintree", "app/workers/catarse_braintree/backer_check_worker.rb", "app/workers/catarse_braintree/payment_receiver_worker.rb", "app/workers/catarse_braintree/refund_worker.rb", "config/initializers", "config/initializers/register.rb", "config/initializers/stripe.rb", "config/locales", "config/locales/en.yml", "config/routes.rb", "db/migrate", "db/migrate/20140731103558_add_braintree_fields_to_backers.rb", "lib/catarse_braintree", "lib/catarse_braintree/contribution_actions.rb", "lib/catarse_braintree/engine.rb", "lib/catarse_braintree/gateway.rb", "lib/catarse_braintree/payment_engine.rb", "lib/catarse_braintree/request", "lib/catarse_braintree/request/base.rb", "lib/catarse_braintree/request/payment.rb", "lib/catarse_braintree/request/payment_method.rb", "lib/catarse_braintree/request/refund.rb", "lib/catarse_braintree/request/settle.rb", "lib/catarse_braintree/request/void.rb", "lib/catarse_braintree/service", "lib/catarse_braintree/service/backer", "lib/catarse_braintree/service/backer/base.rb", "lib/catarse_braintree/service/backer/check.rb", "lib/catarse_braintree/service/backer/pay.rb", "lib/catarse_braintree/service/backer/refund.rb", "lib/catarse_braintree/service/base.rb", "lib/catarse_braintree/version.rb", "lib/catarse_braintree.rb", "lib/tasks", "lib/tasks/cron.rake", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.homepage = "http://github.com/Codebeef/catarse_braintree"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Braintree integration with Catarse"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 4.0"])
      s.add_runtime_dependency(%q<slim-rails>, [">= 0"])
      s.add_runtime_dependency(%q<braintree>, [">= 0"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<catarse>, [">= 0"])
      s.add_development_dependency(%q<spree_core>, ["~> 2.3"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.14.0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 4.0"])
      s.add_dependency(%q<slim-rails>, [">= 0"])
      s.add_dependency(%q<braintree>, [">= 0"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<catarse>, [">= 0"])
      s.add_dependency(%q<spree_core>, ["~> 2.3"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.14.0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 4.0"])
    s.add_dependency(%q<slim-rails>, [">= 0"])
    s.add_dependency(%q<braintree>, [">= 0"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<catarse>, [">= 0"])
    s.add_dependency(%q<spree_core>, ["~> 2.3"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.14.0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
  end
end
