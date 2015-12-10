# coding: utf-8

puts 'Seeding the database...'

# if you change categories, please update on app/views/projects/new.html.slim page also
[
  { pt: 'Bundles', en: 'Bundles' },
  { pt: 'CSA',en: 'CSA' },
  { pt: 'Fruit & Vegetables',en: 'Fruit & Vegetables' },
  { pt: 'Eggs & Dairy',en: 'Eggs & Dairy' },
  { pt: 'Meat & Fish',en: 'Meat & Fish' },
  { pt: 'Bakery',en: 'Bakery' },
  { pt: 'Pantry',en: 'Pantry' },
  { pt: 'Snacks',en: 'Snacks' },
  { pt: 'Drinks',en: 'Drinks' },
  { pt: 'Floral & Home',en: 'Floral & Home' },
  { pt: 'Prepared Foods',en: 'Prepared Foods' },
  { pt: 'Misc',en: 'Misc' },

].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en]
   })
   puts name
 end

{
  company_name: 'ProduceRun',
  company_logo: 'http://www.producerun.com/wp-content/uploads/2014/11/rsz_producerun-green.png',
  host: 'producerun.com',
  base_url: "http://www.producerun.com",
  email_contact: 'info+contact@producerun.com',
  email_payments: 'info+finance@producerun.com',
  email_projects: 'info+projects@producerun.com',
  email_system: 'info+system@producerun.com',
  email_no_reply: 'info+no-reply@producerun.com',
  facebook_url: "https://www.facebook.com/producerun",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/producerun',
  twitter_username: "producerun",
  mailchimp_url: "http://producerun.us8.list-manage.com/subscribe/post?u=d7cada44d74cc8dec9c798429&amp;id=4538752d65",
  catarse_fee: '0.10',
  support_forum: 'http://support.producerun.com/',
  base_domain: 'producerun.com',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://support.producerun.com/',
  feedback_url: 'http://support.producerun.com/',
  terms_url: 'http://support.producerun.com/',
  privacy_url: 'http://support.producerun.com/',
  about_channel_url: 'http://blog.producerun.com',
  instagram_url: 'http://instagram.com/producerun',
  blog_url: "http://blog.producerun.com",
  farmers_blog_url: "http://farmers.producerun.com",
  github_url: 'http://github.com/producerun',
  managemymarket_url: "https://managemymarket.com/default.aspx",
  contato_url: 'http://support.producerun.com/',
  mixpanel_token: 'e0e80f9f416708ba621aaf3d6aff3b85',
  sendgrid_user_name: 'hackandgrow',
  minimum_goal_for_video: '5000',
  aws_bucket: 'producerun',

}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end

OauthProvider.find_or_create_by!(name: 'facebook') do |o|
  o.key = '39410167937'
  o.secret = 'e55126b947fccbff9a86d9716c179860'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

Rails.cache.clear

user = User.where( :name => 'Asd Name', :email => 'asd@asd.asd').first_or_initialize do |user|
  user.password = 'asdasd'
  user.admin = true
  puts "User #{user.email} created"
  user.save
end

user.projects.where(name: "Example project name", category: Category.first, goal: 100, about: "This is about text", video_url: 'https://www.youtube.com/watch?v=IexoJu3TMWM', online_days: 30, headline: 'Example headline').first_or_create do |p|
  puts  "example project created"
  #p.send_to_analysis!
  #p.approve!
end


puts '---------------------------------------------'
puts 'Done!'
