module CatarseBraintree
  module Service
    module Backer

      class Base < CatarseBraintree::Service::Base
        attr_reader :project

        def self.perform(*opts)
          new(*opts).perform
        end

        def initialize(project)
          @project = project
        end

        def backers
          puts @project.class
          @project.contributions.where(state: 'confirmed')
        end

        def each_backer(&block)
          backers.find_in_batches do |batch|
            batch.each do |backer|
              yield backer
            end
          end
        end
      end

    end
  end
end
