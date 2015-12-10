begin
  route_proc = ->(contribution) do
    CatarseBraintree::Engine.routes.url_helpers.review_braintree_path(contribution)
end

 PaymentEngines.register({
    name: 'braintree',
    review_path: route_proc,
    locale: 'en'
  })
puts "braintree registerd"
rescue Exception => e
  puts "Error while registering payment engine: #{e}"
end
