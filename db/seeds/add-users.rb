## Optional Seed file
## to be used during development

puts "Adding Uservoice.com settings..."

  Configuration.find_or_create_by(name: 'uservoice_subdomain').update_attribute('value', 'dummy_domain.uservoice.com')
  Configuration.find_or_create_by(name: 'uservoice_sso_key').update_attribute('value', 'dummy_uservoice_sso_key')


puts "Adding Admin user..."

  User.find_or_create_by!(name: "Admin") do |u|
    u.email = "admin@admin.com"
    u.password = "password"
    u.password_confirmation = "password"
    u.remember_me = false
    u.admin = true
  end

puts "Adding Funder user..."

  User.find_or_create_by!(name: "Funder") do |u|
    u.email = "funder@funder.com"
    u.password = "password"
    u.password_confirmation = "password"
    u.remember_me = false
  end

puts "Adding Test user..."

  User.find_or_create_by!(name: "Test") do |u|
    u.email = "test@test.com"
    u.password = "password"
    u.password_confirmation = "password"
    u.remember_me = false
  end

puts "Done!"
